<?php

use Floxim\Floxim\System\Fx as fx;

$result = fx::router()->route();

if ($result) {
    $result = $result instanceof \Floxim\Floxim\System\Controller ? $result->process() : $result;
    if (fx::env('ajax')) {
        fx::page()->addAssetsAjax();
    }
    echo $result;
    fx::complete();
}