<?php
namespace Floxim\Main\Component\Person;

class Controller extends \Floxim\Main\Component\Page\Controller {
    public function do_list_infoblock() {
        $this->_with_contacts();
        return parent::do_list_infoblock();
    }
    public function do_record() {
        $this->_with_contacts();
        return parent::do_record();
    }
   
    protected function _with_contacts () {
        $this->listen('query_ready', function (\Floxim\Floxim\System\Data $query) {
            $query->with('contacts');
        });
    }
    
}