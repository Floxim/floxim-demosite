<?php
/**
 * Register Composer Auto Loader
 */
require_once __DIR__ . '/../vendor/autoload.php';
require_once __DIR__ . '/../vendor/psr0.php';

/**
 * Register Floxim Auto Loader
 */
Floxim\Floxim\System\ClassLoader::register();
Floxim\Floxim\System\ClassLoader::addDirectories(array(__DIR__ . '/../module'));