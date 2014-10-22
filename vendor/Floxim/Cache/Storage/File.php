<?php

namespace Floxim\Cache\Storage;

/**
 * Cache with file storage
 *
 * @package Floxim\Cache\Storage
 */
class File extends AbstractStorage {

    /**
     * Init storage
     *
     * @param $params
     */
    public function init($params) {
        parent::init($params);
    }

    protected function getValue($key) {

    }

    protected function setValue($key, $value, $time = 0, $tags = array()) {

    }

    protected function deleteValue($key) {

    }

    protected function flushValues($type = self::FLUSH_TYPE_ALL, $tags = array()) {

    }

}