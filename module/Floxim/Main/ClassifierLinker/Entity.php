<?php
namespace Floxim\Main\ClassifierLinker;

use Floxim\Floxim\System\Fx as fx;

class Entity extends \Floxim\Main\Content\Entity {
    
    protected function afterInsert() {
        parent::afterInsert();
        $classifier = $this['classifier'];
        if (!$classifier) {
            return;
        }
        $classifier['counter'] = $classifier['counter']+1;
        $classifier->save();
    }
    
    protected function afterDelete() {
        parent::afterDelete();
        if (! ($classifier = $this['classifier']) ) {
            return;
        }
        $classifier['counter'] = $classifier['counter']-1;
        if ($classifier['counter'] < 0) {
            $classifier['counter'] = 0;
        }
        $classifier->save();
    }
}