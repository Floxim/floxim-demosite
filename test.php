<?php

use Floxim\Floxim\System\Fx as fx;

require_once 'boot.php';

$ibs = fx::data('infoblock')->all();

$ibs->apply(function($ib) {
    $ctr = $ib['controller'];
    $ctr = preg_replace("~^component_~", '', $ctr);
    $ib['controller'] = $ctr;
    $ib->save();
});