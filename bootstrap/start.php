<?php
$result = fx::router()->route();

if ( $result ) {
    $result = $result instanceof \Floxim\Floxim\System\Controller ? $result->process() : $result;
    if (fx::env('ajax')) {
        fx::page()->add_assets_ajax();
    }
    echo $result;
    fx::env()->set('complete_ok', true);
}

fx::listen('unlink', function($e) {
    if (fx::path()->is_inside($e->file, fx::path('thumbs'))) {
        return;
    }
    $thumbs = Floxim\Floxim\System\Thumb::find_thumbs($e->file);
    foreach ($thumbs as $thumb) {
        fx::files()->rm($thumb);
    }
});