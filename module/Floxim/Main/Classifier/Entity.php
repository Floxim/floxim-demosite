<?php
namespace Floxim\Main\Classifier;

use Floxim\Floxim\System\Fx as fx;

class Entity extends \Floxim\Main\Page\Entity {
    protected function _after_delete() {
        parent::_after_delete();
        $linkers = fx::data('classifier_linker')->where('classifier_id', $this['id'])->all();
        $linkers->apply(function($tp) {
            $tp['classifier_id'] = null;
            $tp->delete(); 
        });
    }
}