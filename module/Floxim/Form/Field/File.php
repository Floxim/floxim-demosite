<?php

namespace Floxim\Form\Field;

use Floxim\Floxim\System\Fx as fx;

class File extends Field {
    
    public function getInputs() {
        $switcher_name = $this['name'].'[input_type]';
        return array(
            array('type' => 'url', 'label' => 'URL', 'name' => $switcher_name, 'checked' => true),
            array('type' => 'file', 'label' => 'File', 'name' => $switcher_name)
        );
    }
    
    public function setValue($v) {
        return parent::setValue($v);
    }
    
    public function getValue() {
        $val = parent::getValue();
        $c_type = $val['input_type'];
        $c_val = $val[$c_type];
        if (!$c_val) {
            return null;
        }
        $saved_val = fx::files()->saveFile($c_val, 'forms');
        return $saved_val['fullpath'];
    }
}