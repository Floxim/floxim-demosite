<?php
// start microtime for debugger/profiler
define('FX_START_MICROTIME', microtime(true));
define("DOCUMENT_ROOT", dirname(__FILE__));

// read config
$config_file = DOCUMENT_ROOT.'/config.php';
if (!file_exists($config_file) || !($config_res = include_once ($config_file))) {
    header("Location: /install/");
    die();
}

// Register Composer Auto Loader
$loader = require_once(DOCUMENT_ROOT.'/vendor/autoload.php');
$loader->add('Floxim', DOCUMENT_ROOT.'/vendor');

Floxim\Floxim\System\Fx::load($config_res);