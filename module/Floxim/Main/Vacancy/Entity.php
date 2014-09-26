<?php
namespace Floxim\Main\Vacancy;

use Floxim\Floxim\System\Fx as fx;

class Entity extends \Floxim\Main\Page\Entity {
    public function get_form_fields() {
        $fields = fx::collection(parent::get_form_fields());
        $fields->apply(function($f) {
            if (in_array($f['name'], array('salary_from', 'salary_to', 'currency', 'image'))) {
                $f['tab'] = 3;
            } elseif ($f['name'] === 'description') {
                $f['tab'] = 1;
            }
        });
        return $fields;
    }
}