<?php
namespace Floxim\Main\Page;

use Floxim\Floxim\System\Fx as fx;

class Entity extends \Floxim\Main\Content\Entity
{
    

    protected $_active;

    public function _getIsActive()
    {
        return $this->isActive();
    }

    public function isActive()
    {
        if ($this->_active) {
            return $this->_active;
        }
        $c_page_id = fx::env('page_id');
        if (!$c_page_id) {
            return false;
        }
        $path = fx::env('page')->getParentIds();
        $path [] = $c_page_id;

        return $this->_active = in_array($this['id'], $path);
    }

    public function isCurrent()
    {
        return $this['id'] == fx::env('page_id');
    }

    public function _getIsCurrent()
    {
        return $this->isCurrent();
    }

    protected function beforeSave()
    {
        parent::beforeSave();
        if (empty($this['url']) && !empty($this['name'])) {
            $url = fx::util()->strToLatin($this['name']);
            $url = preg_replace("~[^a-z0-9_-]+~i", '-', $url);
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
                $url = '/' . $url;
            }
            $index = 1;
            // check already used page url
            while ($page = fx::data('page')->getByUrl($url)) {
                if ($page['id'] != $this['id']) {
                    $index++;
                    $url = preg_replace("~\-" . ($index - 1) . "$~", '', $url) . '-' . $index;
                } else {
                    // update the same urlAlias of the same page, see afterUpdate()
                    break;
                }
            }

            $this['url'] = $url;
        }
    }

    protected function afterInsert()
    {
        parent::afterInsert();
        if (empty($this['url'])) {
            $this['url'] = '/page-' . $this['id'] . '.html';
            $this->save();
        }
        if (!empty($this['url'])) {
            // create new urlAlias if it is not set
            fx::data('urlAlias')->create(
                array(
                    'site_id'     => $this['site_id'],
                    'page_id'     => $this['id'],
                    'url'         => $this['url'],
                    'is_original' => true
                )
            )->save();
        }
    }

    protected function afterUpdate()
    {
        parent::afterUpdate();

        // urlAlias update
        if (in_array('url', $this->modified)) {
            // prev alias
            $modified_alias = fx::data('urlAlias')->
            where('url', $this->modified_data['url'])->
            where('page_id', $this['id'])->
            one();
            if (
                !empty($modified_alias) &&
                $this['url']
            ) {
                // check urlAlias history
                if ($modified_alias['page_id'] == $this['id']) {
                    // get already exist old alias
                    $existed_alias = fx::data('urlAlias')->
                    where('url', $this['url'])->
                    where('page_id', $this['id'])->
                    one();
                }
                if (!(isset($existed_alias) && $existed_alias)) {
                    // create new alias
                    fx::data('urlAlias')->create(
                        array(
                            'site_id' => $this['site_id'],
                            'page_id' => $this['id'],
                            'url'     => $this['url']
                        )
                    )->save();
                }
            }
        }
    }

    protected function afterDelete()
    {
        parent::afterDelete();

        $killer = function ($cv) {
            $cv->delete();
        };
        // drop all urlAlias
        fx::data('urlAlias')->
        where('page_id', $this['id'])->
        all()->
        apply($killer);
        // @TODO: save for history
        if (!$this->_skip_cascade_delete_children) {
            $nested_ibs = $this->getNestedInfoblocks(true);
            foreach ($nested_ibs as $ib) {
                $ib->delete();
            }
        }
    }

    public function deleteChildren()
    {
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
    public function getNestedInfoblocks($with_own = true)
    {
        $q = fx::data('page')->descendantsOf($this, $with_own);
        $q->join('{{infoblock}}', '{{infoblock}}.page_id = {{floxim_main_content}}.id');
        $q->select('{{infoblock}}.id');
        $ids = $q->getData()->getValues('id');
        if (count($ids) === 0) {
            return fx::collection();
        }
        $infoblocks = fx::data('infoblock', $ids);
        return $infoblocks;
    }

    public function getExternalHost()
    {
        $url = $this['url'];
        if (!preg_match('~^https?~', $url)) {
            return '';
        }
        $url = parse_url($url);
        return isset($url['host']) ? $url['host'] : '';
    }


    public function getPageInfoblocks()
    {
        // cache page ibs
        if (!isset($this->data['page_infoblocks'])) {
            $this->data['page_infoblocks'] = fx::data('infoblock')->getForPage($this);
        }
        return $this->data['page_infoblocks'];
    }


    public function getLayoutInfoblock()
    {
        if (isset($this->data['layout_infoblock'])) {
            return $this->data['layout_infoblock'];
        }
        $layout_ibs = $this->getPageInfoblocks()->find(function ($ib) {
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
                        'site_id'    => fx::env('site_id'),
                        'controller' => 'layout',
                        'action'     => 'show',
                        'page_id'    => fx::env('site')->get('index_page_id')
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