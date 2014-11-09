<?php

use Floxim\Floxim\System\Fx as fx;

return array(
    'actions' => array(
        '*list*' => array(
            'defaults' => array(
            	'sorting' => 'publish_date',
                'sorting_dir' => 'desc'
            ),
        ),
        '*list_by_tag' => array(
            'name' => $component['name'].fx::alang(' by tag'),
            'icon_extra' => 'tag',
            'check_context' => function($page) {
                return $page->isInstanceof('tag');
            }
        ),
        '*calendar' => array(
            'icon_extra' => 'cal',
            'icon' => self::getAbbr($component['name']),
        ),
        'calendar*' => array(
            'icon' => 'Pub',
        ),
    )
);