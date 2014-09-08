<?php
/**
 * Debug stuff usefule while we are moving to PSR and nothing works fine
 */
require_once 'debug.php';

/**
 * Register Class Auto Load
 */
require_once __DIR__.'/bootstrap/autoload.php';

/**
 * Load Floxim Core
 */
if (!isset($_SERVER['REQUEST_TIME_FLOAT'])) {
    $_SERVER['REQUEST_TIME_FLOAT'] = microtime(true);
}
define("DOCUMENT_ROOT", dirname(__FILE__));

$config_res = include_once( DOCUMENT_ROOT. '/config.php');
if (!$config_res) {
    header("Location: /install/");
    die();
}

/**
 * Register global short alias
 */
class_alias('\\Floxim\\Floxim\\System\\Fx','fx');
/**
 * Load config
 */
fx::load($config_res);

