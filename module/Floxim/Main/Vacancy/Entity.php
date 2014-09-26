<?php
namespace Floxim\Main\Vacancy;

use Floxim\Floxim\System\Fx as fx;

class Entity extends \Floxim\Main\Page\Entity {
    public function getFormFields() {
        $fields = fx::collection(parent::getFormFields());
        $fields->apply(function($f) {
            if (inArray($f['name'], array('salary_from', 'salary_to', 'currency', 'image'))) {
                $f['tab'] = 3;
            } elseif ($f['name'] === 'description') {
                $f['tab'] = 1;
            }
        });
        return $fields;
    }
}