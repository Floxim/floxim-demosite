<?php
/**
 * Register PSR-0 Auto Loader
 */
require_once __DIR__.'/../vendor/autoload.php';

/**
 * Register Floxim Auto Loader
 */
Floxim\Floxim\System\ClassLoader::register();
Floxim\Floxim\System\ClassLoader::addDirectories(array(__DIR__.'/../module'));