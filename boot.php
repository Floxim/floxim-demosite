<?php
/**
 * Load Floxim Core
 */
if (!isset($_SERVER['REQUEST_TIME_FLOAT'])) {
    $_SERVER['REQUEST_TIME_FLOAT'] = microtime(true);
}
define("DOCUMENT_ROOT", dirname(__FILE__));

$config_res = @ include_once(DOCUMENT_ROOT . '/config.php');
if (!$config_res) {
    header("Location: /install/");
    die();
}

/**
 * Register Class Auto Load
 */
require_once __DIR__ . '/bootstrap/autoload.php';

/**
 * Register global short alias
 */
class_alias('\\Floxim\\Floxim\\System\\Fx', 'fx');
/**
 * Load config
 */
fx::load($config_res);