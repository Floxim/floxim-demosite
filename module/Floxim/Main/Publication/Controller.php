<?php
namespace Floxim\Main\Publication;

use Floxim\Floxim\System\Fx as fx;
use Floxim\Floxim\System;

class Controller extends \Floxim\Main\Page\Controller {
    
    public function doList () {
        $this->listen('query_ready', function (System\Data $query) {
            $query->with('tags');
        });
        return parent::doList();
    }
    public function doListByTag() {
        $this->listen('query_ready', function($query) {
            $ids = fx::data('classifier_linker')->
                    where('classifier_id', fx::env('page')->get('id'))->
                    select('content_id')->
                    getData()->getValues('content_id');
            $query->where('id', $ids);
        });
        return $this->doList();
    }

    protected function getPublicationPage() {
        $infoblock_id=$this->getParam('source_infoblock_id');
        if (!$infoblock_id) {
            $infoblock = fx::data('infoblock')->getContentInfoblocks($this->getContentType())->first();
        } else {
            $infoblock = fx::data('infoblock', $infoblock_id);
        }
        if (!$infoblock) {
            return;
        }
        return fx::data(
            'page',
            $infoblock->get('page_id')
        );
    }
    public function settingsCalendar() {
        $ib_values=fx::data('infoblock')->
                    where('site_id', fx::env('site')->get('id'))->
                    getContentInfoblocks($this->getContentType())
                    ->getValues('name', 'id');
        $fields ['source_infoblock_id']= array(
            'type' => 'select',
            'values' => $ib_values,
            'name' => 'source_infoblock_id',
            'label' => 
                fx::alang('Infoblock for the field', 'controller_component')
        );
        return $fields;
    }
    public function doCalendar() {
        $months = $this->getFinder()->
            select('DATE_FORMAT(`publish_date`, "%m") as month')->
            select('DATE_FORMAT(`publish_date`, "%Y") as year')->
            select('COUNT(DISTINCT({{content}}.id)) as `count`')->
            where('site_id', fx::env('site')->get('id'))->
            order('publish_date', 'DESC')->
            group('month')->group('year')->
            getData();
        $base_url = '';
        $pub_page = $this->getPublicationPage();
        if ($pub_page) {
            $base_url = $pub_page->get('url');
        }
        
        $years = new System\Collection();
        $c_full_month = isset($_GET['month']) ? $_GET['month'] : null;
        $c_year = $c_full_month ? preg_replace("~\d+\.~", '', $c_full_month) : date('Y');
        foreach ($months as $m) {
            if (!isset($years[$m['year']])) {
                $years[$m['year']] = array(
                    'year' => $m['year'],
                    'months' => new System\Collection(),
                    'active' => $c_year == $m['year']
                );
            }
            
            $full_month = $m['month'].'.'.$m['year'];
            $m['active'] = $full_month == $c_full_month;
            $m['url'] = $base_url .'?month='.$full_month;
            $years[$m['year']]['months'][] = $m;
        }
        return array('items' => $years);
    }
    public function doListInfoblock() {
        if ( isset($_GET['month']) ) {
            $this->listen('query_ready', function (System\Data $query) {
                list($month, $year) = explode(".", $_GET['month']);
                $start = $year.'-'.$month.'-01, 00:00:00';
                $end = $year.'-'.$month.'-'.date('t', strtotime($start)).', 23:59:59';
                $query->where('publish_date', $start, '>=');
                $query->where('publish_date', $end, '<=');
            });
        }
        $res = parent::doListInfoblock();
        return $res;
    }

    /**
     * Return allow parent pages for current component
     *
     * @return fx_collection
     */
    protected function getAllowedParents() {
        $infoblocks = fx::data('infoblock')
                        ->where('site_id', fx::env('site_id'))
                        ->getContentInfoblocks($this->getContentType());
        $pages_id=array();
        foreach($infoblocks as $infoblock) {
            if (isset($infoblock['params']['parent_type']) and $infoblock['params']['parent_type']=='current_page_id') {
                // Retrieve all pages
                $pages_id=array_merge($pages_id,$infoblock->getPages());
            } else {
                // Retrieve self page
                $pages_id[]=$infoblock['page_id'];
            }
        }
        $pages_id=array_unique($pages_id);
        if (!$pages_id) {
            return fx::collection();
        }
        /**
         * Retrieve pages object
         */
        $pages=fx::data('page')->where('id',$pages_id)->all();
        return $pages;
    }
}