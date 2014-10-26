<?php

namespace Floxim\Cache\Storage;

/**
 * No cache storage
 *
 * @package Floxim\Cache\Storage
 */
class Dummy extends AbstractStorage {

    /**
     * Get value from cache
     *
     * @param $key
     *
     * @return bool
     */
    protected function getValue($key) {
        return false;
    }

    /**
     * Save value in cache
     *
     * @param       $key
     * @param       $value
     * @param int   $time
     * @param array $tags
     *
     * @return void
     */
    protected function setValue($key, $value, $time = 0, $tags = array()) {

    }

    /**
     * Remove value from cache
     *
     * @param $key
     *
     * @return mixed|void
     */
    protected function deleteValue($key) {

    }

    /**
     * Clear data from cache
     *
     * @param int   $type
     * @param array $tags
     *
     * @return mixed|void
     * @throws \Exception
     */
    protected function flushValues($type = self::FLUSH_TYPE_ALL, $tags = array()) {

    }
}