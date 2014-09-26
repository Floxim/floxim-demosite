<?php
namespace Floxim\Main\Page;

use Floxim\Floxim\Component;
use Floxim\Floxim\System\Fx as fx;

class Finder extends Component\Content\Finder {
    
    public function getById($id) {
        if (!is_numeric($id)) {
            return $this->getByUrl($id);
        }
        return parent::getById($id);
    }
    
    public function getTree($children_key = 'children') {
        $data = $this->all();
        $tree = $this->makeTree($data, $children_key);
        return $tree;
    }

    public function getByUrl($url, $site_id = null) {
        $url_variants = array($url);
        if ($site_id === null){
            $site_id = fx::env('site')->get('id');
        }
        $url_with_no_params = preg_replace("~\?.+$~", '', $url);

        $url_variants []=
            preg_match("~/$~", $url_with_no_params) ?
            preg_replace("~/$~", '', $url_with_no_params) :
            $url_with_no_params . '/';

        if ($url_with_no_params != $url) {
            $url_variants []= $url_with_no_params;
        }

        $page = fx::data('page')->
            where('url', $url_variants)->
            where('site_id', $site_id)->
            one();
        return $page;
    }
    
    public function makeTree($data, $children_key = 'children', $extra_root_ids = array()) {
        $index_by_parent = array();
        
        foreach ($data as $item) {
            if (in_array($item['id'], $extra_root_ids)) {
                continue;
            }
            $pid = $item['parent_id'];
            if (!isset($index_by_parent[$pid])) {
                $index_by_parent[$pid] = fx::collection();
                $index_by_parent[$pid]->is_sortable = $data->is_sortable;
                $index_by_parent[$pid]->addFilter('parent_id', $pid);
            }
            $index_by_parent[$pid] []= $item;
        }
        
        foreach ($data as $item) {
            if (isset($index_by_parent[$item['id']])) {
                $item[$children_key] = $index_by_parent[$item['id']];
                $data->findRemove(
                    'id',
                    $index_by_parent[$item['id']]->getValues('id')
                );
            } else {
                $item[$children_key] = null;
            }
        }
        return $data;
    }
    
    public function named($name) {
        $this->where('name', '%'.$name.'%', 'like');
        return $this;
    }
}