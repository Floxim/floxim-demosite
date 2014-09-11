<?php
namespace Floxim\Main\Component\Page;

use fx;

class Essence extends \Floxim\Floxim\Component\Content\Essence {
    protected $parent_ids = null;
    protected $path = null;
    /**
     * Get the id of the page-parents
     * @return array
     */
    public function get_parent_ids() {
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
    
    public function get_path() {
        if ($this->path) {
            return $this->path;
        }
        $path_ids = $this->get_parent_ids();
        $path_ids []= $this['id'];
        $this->path = fx::data('page')->where('id', $path_ids)->all();
        return $this->path;
    }
    
    protected $_active;
    
    public function _get_is_active() {
        return $this->is_active();
    }

    public function is_active () {
        if ($this->_active) {
            return $this->_active;
        }
        $c_page_id  = fx::env('page_id');
        if (!$c_page_id) {
            return false;
        }
        $path = fx::env('page')->get_parent_ids();
        $path []= $c_page_id;

        return $this->_active = in_array($this['id'], $path);
    }
    
    public function is_current() {
        return $this['id'] == fx::env('page_id');
    }
    
    public function _get_is_current() {
        return $this->is_current();
    }
    
    protected function _before_save() {
        parent::_before_save();
        if (empty($this['url']) && !empty($this['name'])) {
            $url = fx::util()->str_to_latin($this['name']);
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
    
    protected function _after_insert() {
        parent::_after_insert();
        if (empty($this['url'])) {
            $this['url'] = '/page-'.$this['id'].'.html';
            $this->save();
        }
    }
    
    protected function _after_delete() {
        parent::_after_delete();
        if (!$this->_skip_cascade_delete_children) {
            $nested_ibs = $this->get_nested_infoblocks(true);
            foreach ($nested_ibs as $ib) {
                $ib->delete();
            }
            /*
            fx::data('infoblock')->where('page_id', $this['id'])->all()->apply(function($n) {
                $n->delete();
            });
             * 
             */
        }
    }
    
    public function delete_children() {
        $nested_ibs = $this->get_nested_infoblocks(false);
        foreach ($nested_ibs as $ib) {
            $ib->delete();
        }
        parent::delete_children();
    }
    
    /**
     * Get list of infoblocks bound to this page or one of it's descendants
     * @param bool $with_own include page's own infoblocks
     * @return fx_collection Found infoblocks
     */
    public function get_nested_infoblocks($with_own = true) {
        $q = fx::data('page')->descendants_of($this, $with_own);
        $q->join('{{infoblock}}', '{{infoblock}}.page_id = {{content}}.id');
        $q->select('{{infoblock}}.id');
        $ids = $q->get_data()->get_values('id');
        if (count($ids) === 0) {
            return fx::collection();
        }
        $infoblocks = fx::data('infoblock', $ids);
        return $infoblocks;
    }
    
    public function _get_external_host() {
        $url = $this['url'];
        if (!preg_match('~^https?~', $url)) {
            return '';
        }
        $url = parse_url($url);
        return isset($url['host']) ? $url['host'] : '';
    }
    
    
    public function get_page_infoblocks() {
        // cache page ibs
        if (!isset($this->data['page_infoblocks'])) {
            $this->data['page_infoblocks'] = fx::data('infoblock')->get_for_page($this);
        }
        return $this->data['page_infoblocks'];
    }
    
    
    public function get_layout_infoblock() {
        if (isset($this->data['layout_infoblock'])) {
            return $this->data['layout_infoblock'];
        }
        $layout_ibs = $this->get_page_infoblocks()->find(function($ib) {
            return $ib->is_layout();
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
            $layout_ibs = fx::data('infoblock')->sort_infoblocks($layout_ibs);
            $lay_ib = $layout_ibs->first();
        }
        $this->data['layout_infoblock'] = $lay_ib;
        return $lay_ib;
    }
}