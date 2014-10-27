<?php

use Floxim\Floxim\System\Fx as fx;

$result = fx::router()->route();

if ($result) {
    $result = $result instanceof \Floxim\Floxim\System\Controller ? $result->process() : $result;
    if (fx::env('ajax')) {
        fx::page()->addAssetsAjax();
    }
    echo $result;
    fx::complete();
}

fx::listen('unlink', function ($e) {
    if (fx::path()->isInside($e->file, fx::path('@thumbs'))) {
        return;
    }
    $thumbs = Floxim\Floxim\System\Thumb::findThumbs($e->file);
    foreach ($thumbs as $thumb) {
        fx::files()->rm($thumb);
    }
});