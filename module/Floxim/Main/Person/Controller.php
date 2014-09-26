<?php
namespace Floxim\Main\Person;

class Controller extends \Floxim\Main\Page\Controller {
    public function doListInfoblock() {
        $this->withContacts();
        return parent::doListInfoblock();
    }
    public function doRecord() {
        $this->withContacts();
        return parent::doRecord();
    }
   
    protected function withContacts () {
        $this->listen('query_ready', function (\Floxim\Floxim\System\Data $query) {
            $query->with('contacts');
        });
    }
    
}