<?php
namespace Floxim\Main\Page;

use Floxim\Floxim\System\Fx as fx;

class Entity extends \Floxim\Floxim\Component\Content\Entity {
    protected $parent_ids = null;
    protected $path = null;
    /**
     * Get the id of the page-parents
     * @return array
     */
    public function getParentIds() {
        if (!is_null($this->parent_ids)) {
            return $this->parent_ids;
        }
        
        $path = $this['materialized_path'];
        if (!empty($path)) {
            $path = explode(".", trim($path, '.'));
            $this->parent_ids = $path;
            return $this->parent_ids;
        }
        
        $c_pid = $this->get('parent_id');
        // if page has null parent, hold it as if it was nested to index
        if ($c_pid === null && ($site = fx::env('site')) && ($index_id = $site['index_page_id'])) {
            return $index_id != $this['id'] ? array($index_id) : array();
        }
        $ids = array();
        while ($c_pid != 0) {
            array_unshift($ids, $c_pid);
            $c_pid = fx::data('page', $ids[0])->get('parent_id');
        }
        $this->parent_ids = $ids;
        return $ids;
    }
    
    public function getPath() {
        if ($this->path) {
            return $this->path;
        }
        $path_ids = $this->getParentIds();
        $path_ids []= $this['id'];
        $this->path = fx::data('page')->where('id', $path_ids)->all();
        return $this->path;
    }
    
    protected $_active;
    
    public function _getIsActive() {
        return $this->isActive();
    }

    public function isActive () {
        if ($this->_active) {
            return $this->_active;
        }
        $c_page_id  = fx::env('page_id');
        if (!$c_page_id) {
            return false;
        }
        $path = fx::env('page')->getParentIds();
        $path []= $c_page_id;

        return $this->_active = in_array($this['id'], $path);
    }
    
    public function isCurrent() {
        return $this['id'] == fx::env('page_id');
    }
    
    public function _getIsCurrent() {
        return $this->isCurrent();
    }
    
    protected function beforeSave() {
        parent::beforeSave();
        if (empty($this['url']) && !empty($this['name'])) {
            $url = fx::util()->strToLatin($this['name']);
            $url  = preg_replace("~[^a-z0-9_-]+~i", '-', $url);
            $url = trim($url, '-');
            $url = preg_replace("~\-+~", '-', $url);
            $this['url'] = $url;
        }
        if (
                in_array('url', $this->modified) && 
                !empty($this['url']) && 
                !preg_match("~^https?://~", $this['url'])
            ) {
            $url = $this['url'];
            if (!preg_match("~^/~", $url)) {
                $url = '/'.$url;
            }
            $index = 1;
            while ( fx::data('page')->
                    where('url', $url)->
                    where('site_id', $this['site_id'])->
                    where('id', $this['id'], '!=')->
                    one()) {
                $index++;
                $url = preg_replace("~\-".($index-1)."$~", '', $url).'-'.$index;
            }
            $this['url'] = $url;
        }
    }
    
    protected function afterInsert() {
        parent::afterInsert();
        if (empty($this['url'])) {
            $this['url'] = '/page-'.$this['id'].'.html';
            $this->save();
        }
    }
    
    protected function afterDelete() {
        parent::afterDelete();
        if (!$this->_skip_cascade_delete_children) {
            $nested_ibs = $this->getNestedInfoblocks(true);
            foreach ($nested_ibs as $ib) {
                $ib->delete();
            }
        }
    }
    
    public function deleteChildren() {
        $nested_ibs = $this->getNestedInfoblocks(false);
        foreach ($nested_ibs as $ib) {
            $ib->delete();
        }
        parent::deleteChildren();
    }
    
    /**
     * Get list of infoblocks bound to this page or one of it's descendants
     * @param bool $with_own include page's own infoblocks
     * @return fx_collection Found infoblocks
     */
    public function getNestedInfoblocks($with_own = true) {
        $q = fx::data('page')->descendantsOf($this, $with_own);
        $q->join('{{infoblock}}', '{{infoblock}}.page_id = {{content}}.id');
        $q->select('{{infoblock}}.id');
        $ids = $q->getData()->getValues('id');
        if (count($ids) === 0) {
            return fx::collection();
        }
        $infoblocks = fx::data('infoblock', $ids);
        return $infoblocks;
    }
    
    public function getExternalHost() {
        $url = $this['url'];
        if (!preg_match('~^https?~', $url)) {
            return '';
        }
        $url = parse_url($url);
        return isset($url['host']) ? $url['host'] : '';
    }
    
    
    public function getPageInfoblocks() {
        // cache page ibs
        if (!isset($this->data['page_infoblocks'])) {
            $this->data['page_infoblocks'] = fx::data('infoblock')->getForPage($this);
        }
        return $this->data['page_infoblocks'];
    }
    
    
    public function getLayoutInfoblock() {
        if (isset($this->data['layout_infoblock'])) {
            return $this->data['layout_infoblock'];
        }
        $layout_ibs = $this->getPageInfoblocks()->find(function($ib) {
            return $ib->isLayout();
        });
        if (count($layout_ibs) == 0) {
            // force root layout infoblock
            $lay_ib = fx::data('infoblock')
                        ->where('controller', 'layout')
                        ->where('site_id', fx::env('site_id'))
                        ->where('parent_infoblock_id', 0)
                        ->one();
            if (!$lay_ib) {
                $lay_ib = fx::data('infoblock')->create(
                        array(
                            'site_id' => fx::env('site_id'),
                            'controller' => 'layout',
                            'action' => 'show',
                            'page_id' => fx::env('site')->get('index_page_id')
                        ));
                $lay_ib->save();
            }
        } else {
            $layout_ibs = fx::data('infoblock')->sortInfoblocks($layout_ibs);
            $lay_ib = $layout_ibs->first();
        }
        $this->data['layout_infoblock'] = $lay_ib;
        return $lay_ib;
    }
}