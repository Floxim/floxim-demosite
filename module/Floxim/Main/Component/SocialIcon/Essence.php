<?php
namespace Floxim\Main\Component\Page;

class Essence extends \Floxim\Floxim\Component\Content\Essence {
    protected function _before_save() {
        parent::_before_save();
        if(preg_match('~^(https?:\/\/)?(www\.)?((?P<url>[\w\.]+))\.([a-z]{2,6}\.?)(\/[\w\-\?\=\.]*)*\/?$~', $this['url'], $match)!=0) {
        	$types = array('facebook', 'twitter', 'plus.google', 'myspace', 'linkedin');
        	if (in_array($match['url'], $types)) {
        		$this['soc_type'] = $match['url'];
        	} else 
        		$this['soc_type'] = 'unknown';
        }
    }
}