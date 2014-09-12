<?php
namespace Floxim\Main\Component\Comment;

use Floxim\Floxim\System\Fx as fx;

class Essence extends \Floxim\Floxim\Component\Content\Essence {
    
    protected function _get_page () {
        if (!isset($this['parent_id'])) {
            return;  
        } 
        
        return fx::data('page', $this['parent_id']);
    }
    
    protected function _after_insert() {
        parent::_after_insert();
        $page = $this->_get_page();
        if (!$page) {
            return;
        }
        $page['comments_counter'] = $page['comments_counter']+1;
        $page->save(); 
    }
    
    protected function _after_delete() {
        parent::_after_delete();
        $page = $this->_get_page();
        
        if (!$page) {
            return;
        }
        $page['comments_counter'] = ($page['comments_counter'] > 0 ? $page['comments_counter']-1 : 0);
        $page->save(); 
    }
}