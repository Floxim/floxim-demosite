<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

function say() {
    static $said = false;
    if (!$said) {
        ?>
        <style type="text/css">
            .debug {
                font-family: courier;
                font-size:11px;
                border:1px solid #CCC;
            }
            .debug pre {
                margin:0;
                padding:3px;
                border-bottom:1px dotted #DDD;
            }
            .debug pre:first-child {
                background:#EEE;
            }
            .debug pre:last-child {
                border-bottom:none;
            }
        </style>
        <?php
        $said = true;
    }
    $args = func_get_args();
    $bt = debug_backtrace();
    $path = $bt[0]['file'];
    $path = str_replace("\\", "/", $path);
    $path = str_replace($_SERVER['DOCUMENT_ROOT'], '', $path);
    $path .= " @ ".$bt[0]['line'];
    ?><div class="debug"><?php
    echo "<pre>".$path."</pre>";
    foreach ($args as $arg) {
        echo "<pre>".htmlspecialchars(print_r($arg, 1))."</pre>";
    }
    ?></div><?php
}