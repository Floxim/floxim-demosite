<?php
namespace Floxim\Main\Comment;

use Floxim\Floxim\System\Fx as fx;

class Controller extends \Floxim\Main\Content\Controller
{
    
    protected function getTargetInfoblock()
    {
        $target_ibs = fx::data('infoblock')->where('controller', 'component_comment')->where('action', 'listing')->all();
        $field      = array(
            'type' => 'select',
            'name' => 'target_infoblock_id',
            'label' => 'Target infoblock',
            'values' => array()
            
        );
        foreach ($target_ibs as $ib) {
            $field['values'][] = array(
                $ib['id'],
                $ib['name']
            );
        }
        return $field;
    }
    public function getFinder()
    {
        $finder = parent::getFinder();
        
        if (!fx::isAdmin()) {
            if ($own_comments = $this->getOwnComments()) {
                $finder->whereOr(array(
                    'is_moderated',
                    1
                ), array(
                    'id',
                    $own_comments
                ));
            } else {
                $finder->where('is_moderated', 1);
            }
        }
        return $finder;
    }
    
    public function doAdd()
    {
        if (isset($_POST["addcomment"]) && isset($_POST["user_name"]) && !empty($_POST["user_name"]) && isset($_POST["comment_text"]) && !empty($_POST["comment_text"])) {
            
            $comments = fx::data('comment')->create(array(
                'user_name' => $_POST["user_name"],
                'comment_text' => $_POST["comment_text"],
                'publish_date' => date("Y-m-d H:i:s"),
                'parent_id' => $this->getParentId(),
                'infoblock_id' => $this->getParam('target_infoblock_id')
            ));
            $comments->save();
            if (!isset($_COOKIE["own_comments"])) {
                setcookie('own_comments', $comments["id"], time() + 60 * 60 * 24 * 30);
            } else {
                setcookie('own_comments', $_COOKIE["own_comments"] . ',' . $comments["id"], time() + 60 * 60 * 24 * 30);
            }
            fx::http()->refresh();
        }
    }
    
    protected function getOwnComments()
    {
        if (isset($_COOKIE["own_comments"])) {
            return explode(',', $_COOKIE["own_comments"]);
        }
        return;
        
    }
    
}