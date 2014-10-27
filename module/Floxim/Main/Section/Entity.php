<?php
namespace Floxim\Main\Section;

use Floxim\Floxim\System\Fx as fx;

class Entity extends \Floxim\Main\Page\Entity
{
    public function getAvailParentsFinder()
    {
        $f = parent::getAvailParentsFinder();
        $our_infoblock = fx::data('infoblock', $this['infoblock_id']);
        $f->whereOr(
            array('infoblock_id', $this['infoblock_id']),
            array('id', $our_infoblock['page_id'])
        );
        return $f;
    }

    public function getFormFieldParentId($field)
    {
        $ib = fx::data('infoblock', $this['infoblock_id']);
        if (!$ib['params']['submenu'] || $ib['params']['submenu'] == 'none') {
            return;
        }
        return parent::getFormFieldParentId($field);
    }
}