<?php
namespace Floxim\Main\Component\Vacancy;

use fx;

class Essence extends \Floxim\Main\Component\Page\Essence {
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