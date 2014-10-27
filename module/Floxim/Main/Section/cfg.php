<?php

use Floxim\Floxim\System\Fx as fx;

$source_ibs = fx::data('infoblock')
    ->getContentInfoblocks('section')
    ->find('site_id', fx::env('site')->get('id'))
    ->getValues('name', 'id');
return array(
    'actions' => array(
        '*list*' => array(
            'icon' => 'Nav',
            'defaults' => array(
            	'!parent_type' => 'mount_page_id',
                '!limit' => 0,
                '!create_record_ib' => false,
                '!sorting' => 'manual',
                '!sorting_dir' => 'asc',
                '!pagination' => false
            ),
            'settings' => array(
            	'submenu' => array(
                    'name' => 'submenu',
                    'label' => fx::alang('Subsections','component_section'),
                    'type' => 'select',
                    'values' => array(
                        'none' => fx::alang('Don\'t show','component_section'),
                        'active' => fx::alang('Show for the active item','component_section'),
                        'all' => fx::alang('Show for all items','component_section')
                    )
                ),
                'extra_infoblocks' => array(
                    'name' => 'extra_infoblocks',
                    'label' => 'Add items from',
                    'type' => 'livesearch',
                    'is_multiple' => true, 
                    'ajax_preload' => true,
                    'params' => array(
                        'content_type' => 'infoblock',
                        'conditions' => array(
                            'controller' => array(
                                fx::data('component', 'page')->getAllVariants()->getValues(function($ch) {
                                    return $ch['keyword'];
                                }),
                                'IN'
                            ),
                            'id' => array(
                                $this->getParam('infoblock_id'),
                                '!='
                            ),
                            'site_id' => fx::env('site_id'),
                            'action' => 'list_infoblock'
                        )
                    ),
                )
            ),
        ),
        '*list_submenu*' => array(
            'name' => 'Submenu',
            'icon_extra' => 'sub',
            'settings' => array(
                'source_infoblock_id' => array(
                    'label' => fx::alang('Source infoblock','component_section'),
                    'type' => 'select',
                    'values' => $source_ibs,
                ),
            ),
            'check_context' => function() {
                return count(fx::env('page')->getParentIds()) > 0;
            }
        ),
        'list_infoblock' => array(
            'name' => fx::alang('Menu', 'component_section')
        ),
        'breadcrumbs' => array(
            'icon' => 'Nav',
            'icon_extra' => 'bre',
            'name' => fx::alang('Breadcrumbs', 'component_section'),
            'settings' => array(
                'header_only' => array(
                    'name' => 'header_only',
                    'type' => 'checkbox',
                    'label' => fx::alang('Show only header?', 'component_section'),
                )
            )
        ),
    )
);