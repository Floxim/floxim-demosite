<?php
namespace Floxim\Main\Section;

use Floxim\Floxim\System\Fx as fx;
use Floxim\Floxim\System;

class Controller extends \Floxim\Main\Page\Controller {

   public function doListInfoblock() {
        $c_page_id  = fx::env('page')->get('id');
        $path = fx::env('page')->getParentIds();
        $path []= $c_page_id;
        $submenu_type = $this->getParam('submenu');
        switch ($submenu_type) {
            case 'none':
                break;
            case 'active':
                $this->setParam('parent_id', $path);
                break;
            case 'all': default:
                $this->setParam('parent_id', false);
                break;
        }
        if ($submenu_type !== 'none') {
            $this->onItemsReady(function($items, $ctr) {
                foreach ($items as $item) {
                    $ctr->acceptContent(array(
                        'title' => fx::alang('Add subsection','component_section'),
                        'parent_id' => $item['id']
                    ), $item);
                }
            });
        }
        $res = parent::doListInfoblock();
        return $res;
    }
    
    public function doList() {
        $this->onItemsReady(function($items, $ctr) {
            $extra_ibs =  $ctr->getParam('extra_infoblocks', array());
            if (is_array($extra_ibs) && count($extra_ibs) > 0) {
                foreach ($extra_ibs as $extra_ib_id) {
                    if (is_numeric($extra_ib_id)) {
                        $extra_ib = fx::data('infoblock', $extra_ib_id);
                        if ($extra_ib) {
                            $extra_q = $extra_ib
                                ->initController()
                                ->getFinder()
                                ->where('infoblock_id', $extra_ib_id);
                            $extra_items = $extra_q->all();
                            $items->concat($extra_items);
                        }
                    }
                }
            }
            $items->unique();
            $extra_roots = $ctr->getParam('extra_root_ids');
            if (!$extra_roots) {
                $extra_roots = array();
            }
            if (count($items) > 0) {
                fx::data('page')
                    ->makeTree($items, 'submenu', $extra_roots)
                    ->addFilter('parent_id', $items->first()->get('parent_id'));
            }
        });
        return parent::doList();
    }
    
    protected function addSubmenuItems($items) {
        $submenu_type = $this->getParam('submenu');
        if ($submenu_type === 'none') {
            return;
        }
        $finder = fx::content($this->getComponent()->get('keyword'));
        switch ($submenu_type) {
            case 'all':
                $finder->descendantsOf($items);
                break;
            case 'active':
                $path = fx::env('page')->getPath();
                $finder->where('parent_id', $path->getValues('id'));
                break;
        }
        $items->concat($finder->all());
    }

    public function doListSelected () {
        $this->onItemsReady(function($items, $ctr) {
            $ctr->setParam('extra_root_ids', $items->getValues('id'));
        });
        $this->onItemsReady(array($this, 'addSubmenuItems'));
        return parent::doListSelected();
    }
    
    public function doListFiltered() {
        $this->onItemsReady(array($this, 'addSubmenuItems'));
        return parent::doListFiltered();
    }

    public function doListSubmenu() {
        $source = $this->getParam('source_infoblock_id');
        $path = fx::env('page')->getPath();
        if (count($path) < 2) {
            return;
        }
        if (isset($path[1])) {
            $this->listen('query_ready', function($q) use ($path, $source){
                $q->where('parent_id', $path[1]->get('id'))->where('infoblock_id', $source);
            });
        }
        return $this->doList();
    }
    
    public function doBreadcrumbs() {
        if ( !($page_id = $this->getParam('page_id'))) {
            $page_id = fx::env('page_id');
        }
        $entity_page = fx::data('page',$page_id);
        $entity_page['active'] = true;
        if ($this->getParam('header_only')) {
            $pages = new System\Collection(array($entity_page));
        } else {
            $pages = $entity_page->getPath();
        }
        return array('items' => $pages);
    }

    /**
     * Return allow parent pages for current component
     *
     * @return fx_collection
     */
    protected function getAllowedParents() {
        /**
         * Retrieve pages object
         */
        $pages=fx::data('section')->where('site_id',fx::env('site_id'))->all();
        $additional_parent_ids=array_diff($pages->getValues('parent_id'),$pages->getValues('id'));
        $additional_parent_ids=array_unique($additional_parent_ids);
        $pages_add=fx::data('content')->where('id',$additional_parent_ids)->all();

        return $pages_add->concat($pages);
    }
}