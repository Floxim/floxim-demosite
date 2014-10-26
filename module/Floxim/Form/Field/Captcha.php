<?php

namespace Floxim\Form\Field;

use Floxim\Floxim\System\Fx as fx;

class Captcha extends Field
{
    public function __construct($params = array())
    {
        if (!session_id()) {
            session_start();
        }

        if (!isset($params['label'])) {
            $params['label'] = 'Aren\'t you a robot?';
        }
        if (!isset($params['valid_for'])) {
            $params['valid_for'] = 6 * 5; // 3 min
        }

        parent::__construct($params);
        // todo: psr0 need fix path
        $url = fx::path()->toHttp(dirname(realpath(__FILE__)));
        $url .= '/captcha.php?fx_field_name=' . urlencode($this->getId());
        $url .= '&rand=' . rand(0, 1000000);
        $this['captcha_url'] = $url;

        if (!$this->wasValid()) {
            $this['required'] = true;
            $this->addValidator('captcha');
        }
        $field = $this;
        $this->getForm()->onFinish(function ($f) use ($field) {
            $field->wasValid(false);
        });
    }

    public function validateCaptcha()
    {
        if ($this->wasValid()) {
            return;
        }
        if ($_SESSION['captcha_code_' . $this->getId()] != $this->getValue()) {
            return 'Invalid code';
        }
        $this->wasValid(true);
    }

    public function wasValid($set = null)
    {
        $prop = 'captcha_was_valid_' . $this->getId();
        if ($set === null) {
            $was = isset($_SESSION[$prop]) && $_SESSION[$prop] + $this['valid_for'] > time();
            if ($was) {
                $this['was_valid'] = true;
                $this['was_valid_time_left'] = $_SESSION[$prop] + $this['valid_for'] - time();
            }
            return $was;
        }
        if ($set === true) {
            $this['was_valid'] = true;
            $_SESSION[$prop] = time();
        } else {
            unset($_SESSION[$prop]);
        }
        return $this;
    }
}