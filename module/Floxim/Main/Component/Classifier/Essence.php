<?php
namespace Floxim\Main\Component\Classifier;

use fx;

class Essence extends \Floxim\Main\Component\Page\Essence {
    protected function _after_delete() {
        parent::_after_delete();
        $linkers = fx::data('classifier_linker')->where('classifier_id', $this['id'])->all();
        $linkers->apply(function($tp) {
            $tp['classifier_id'] = null;
            $tp->delete(); 
        });
    }
}