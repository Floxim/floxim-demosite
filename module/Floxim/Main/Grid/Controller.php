<?php

namespace Floxim\Main\Grid;

class Controller extends \Floxim\Floxim\Controller\Widget {
    
    public function process() {
        $res = parent::process();
        if (isset($res['areas'])) {
            foreach ($res['areas'] as $i => &$area) {
                if (!isset($area['id'])) {
                    //$area['id'] = (isset($area['keyword']) ? $area['keyword'] : $i).'_'.$this->getParam('infoblock_id');
                    $area['id'] = 'grid_'.(isset($area['keyword']) ? $area['keyword'] : $i).'_'.$this->getParam('infoblock_id');
                }
            }
        }
        return $res;
    }
    
    public function doTwoColumns() {
        return array(
            'areas' => array(
                array('name' => 'Sidebar', 'keyword' => 'sidebar'),
                array('name' => 'Data', 'keyword' => 'content')
            )
        );
    }
}