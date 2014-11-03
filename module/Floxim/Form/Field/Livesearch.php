<?php

namespace Floxim\Form\Field;

use Floxim\Floxim\System\Fx as fx;

class Livesearch extends Options
{
    public function __construct($params = array()) {
        fx::page()->addJsFile('@floxim/Admin/js/livesearch.js');
        return parent::__construct($params);
    }
    
    public function setValue($value) 
    {
        if (is_array($value) && count($value) > 0) {
            $first_val = current($value);
            // we have values from $_POST
            if (!isset($first_val['value_id'])) {
                $value_ids = array();
                $value_prop = $this['name_postfix'];
                foreach ($value as $c_val) {
                    $value_ids []= $c_val[$value_prop];
                }
                $this['params'] = array_merge(
                    $this['params'], 
                    array(
                        'ajax_preload' => true,
                        'plain_values' => $value_ids
                    )
                );
            }
        }
        fx::log($this);
        return parent::setValue($value);
    }
}