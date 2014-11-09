<?php
namespace Floxim\Nav\Classifier;

use Floxim\Floxim\System\Fx as fx;

class Entity extends \Floxim\Main\Page\Entity
{
    protected function afterDelete()
    {
        parent::afterDelete();
        $linkers = fx::data('linker')->where('linked_id', $this['id'])->all();
        $linkers->apply(function ($tp) {
            $tp['classifier_id'] = null;
            $tp->delete();
        });
    }
}