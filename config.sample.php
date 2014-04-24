<?php
define("FX_JQUERY_PATH", '/floxim/lib/js/jquery-1.9.1.min.js');
$config = array(
    'local' =>  array(
        'DB_DSN' => 'mysql:dbname=floxim_loc;host=localhost',
        'DB_USER' => 'root',
        'DB_PASSWORD' => '',
        'IS_DEV_MODE' => true,
        'COMPILED_TEMPLATES_TTL' => 120
    )
);

return $config['local'];
?>