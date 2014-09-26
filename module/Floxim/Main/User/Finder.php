<?php
namespace Floxim\Main\User;

use Floxim\Floxim\System\Fx as fx;

class Finder extends \Floxim\Floxim\Component\Content\Finder {
    public function getById($id) {
        if (!is_numeric($id)) {
            return $this->getByLogin($id);
        }
        return parent::getById($id);
    }
    
    public function getByLogin($login) {
        $this->where(fx::config('auth.login_field'), $login);
        return $this->one();
    }
}