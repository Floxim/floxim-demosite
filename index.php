<?php
require_once 'boot.php';

$result = fx::router()->route();

if (fx::env('ajax')) {
    fx::page()->addAssetsAjax();
}

echo $result;

fx::complete();