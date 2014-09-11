<?php
/**
 * Register PSR-0 Auto Loader
 * @todo Will be replaced later
 */

spl_autoload_register(function($class_name){
    $class_name = ltrim($class_name, '\\');
    $file_name  = '';
    $namespace = '';
    $last_ns_pos = strrpos($class_name, '\\');
    if ($last_ns_pos) {
        $namespace = substr($class_name, 0, $last_ns_pos);
        $class_name = substr($class_name, $last_ns_pos + 1);
        $file_name  = str_replace('\\', DIRECTORY_SEPARATOR, $namespace) . DIRECTORY_SEPARATOR;
    }
    $file_name .= str_replace('_', DIRECTORY_SEPARATOR, $class_name) . '.php';
    $file_name = __DIR__.DIRECTORY_SEPARATOR.$file_name;

    if (file_exists($file_name)) {
        require_once $file_name;
        return true;
    }
    return false;
});