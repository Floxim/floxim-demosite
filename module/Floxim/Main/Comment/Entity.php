<?php
namespace Floxim\Main\Comment;

use Floxim\Floxim\System\Fx as fx;

class Entity extends \Floxim\Main\Content\Entity
{

    protected function getPage()
    {
        if (!isset($this['parent_id'])) {
            return;
        }

        return fx::data('page', $this['parent_id']);
    }

    protected function afterInsert()
    {
        parent::afterInsert();
        $page = $this->getPage();
        if (!$page) {
            return;
        }
        $page['comments_counter'] = $page['comments_counter'] + 1;
        $page->save();
    }

    protected function afterDelete()
    {
        parent::afterDelete();
        $page = $this->getPage();

        if (!$page) {
            return;
        }
        $page['comments_counter'] = ($page['comments_counter'] > 0 ? $page['comments_counter'] - 1 : 0);
        $page->save();
    }
}