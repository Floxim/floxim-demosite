<?php
namespace Floxim\Main\Page;

use Floxim\Floxim\System\Fx as fx;

class Controller extends \Floxim\Main\Content\Controller
{
    public function doNeighbours()
    {
        $item = fx::env('page');

        $q = $this->getFinder()->order(null)->limit(1)->where('site_id', fx::env('site_id'));

        $q_next = clone $q;
        $q_prev = clone $q;

        if ($this->getParam('sorting') === 'auto' && $item['infoblock_id']) {
            $item_ib_params = fx::data('infoblock', $item['infoblock_id'])->get('params');
            $ib_sorting = $item_ib_params['sorting'];
            $this->setParam('sorting', $ib_sorting == 'manual' ? 'priority' : $ib_sorting);
            $this->setParam('sorting_dir', $item_ib_params['sorting_dir']);
        }

        $sort_field = $this->getParam('sorting', 'priority');
        $dir = strtolower($this->getParam('sorting_dir', 'asc'));

        $where_prev = array(array($sort_field, $item[$sort_field], $dir == 'asc' ? '<' : '>'));
        $where_next = array(array($sort_field, $item[$sort_field], $dir == 'asc' ? '>' : '<'));

        $group_by_parent = $this->getParam('group_by_parent');

        if ($group_by_parent) {
            $c_parent = fx::content($item['parent_id']); // todo: psr0 need verify
            $q_prev->order('parent.priority', 'desc')->where('parent.priority', $c_parent['priority'], '<=');
            $q_next->order('parent.priority', 'asc')->where('parent.priority', $c_parent['priority'], '>=');
            $where_prev [] = array('parent_id', $item['parent_id'], '!=');
            $where_next [] = array('parent_id', $item['parent_id'], '!=');
        }


        $q_prev->order($sort_field, $dir == 'asc' ? 'desc' : 'asc')
            ->where($where_prev, null, 'or');

        $prev = $q_prev->all();

        $q_next->order($sort_field, $dir)
            ->where($where_next, null, 'or');

        $next = $q_next->all();

        return array(
            'prev'    => $prev,
            'current' => $item,
            'next'    => $next
        );
    }
}