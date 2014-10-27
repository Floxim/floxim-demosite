<?php

namespace Floxim\Cache\Storage;

/**
 * Cache with storage array
 *
 * @package Floxim\Cache\Storage
 */
class ArrayKeys extends AbstractStorage
{
    /**
     * Storage array
     *
     * @var array
     */
    protected $storage = array();

    /**
     * Get value from cache
     *
     * @param $key
     *
     * @return bool|mixed
     */
    protected function getValue($key)
    {
        if (array_key_exists($key, $this->storage)) {
            return $this->storage[$key];
        }
        return false;
    }

    /**
     * Save value in cache
     *
     * @param       $key
     * @param       $value
     * @param int $time
     * @param array $tags
     *
     * @return mixed|void
     */
    protected function setValue($key, $value, $time = 0, $tags = array())
    {
        $this->storage[$key] = $value;
    }

    /**
     * Remove value from cache
     *
     * @param $key
     *
     * @return mixed|void
     */
    protected function deleteValue($key)
    {
        unset($this->storage[$key]);
    }

    /**
     * Clear data from cache
     *
     * @param int $type
     * @param array $tags
     *
     * @return mixed|void
     * @throws \Exception
     */
    protected function flushValues($type = self::FLUSH_TYPE_ALL, $tags = array())
    {
        if ($type == self::FLUSH_TYPE_ALL) {
            $this->storage = array();
        } else {
            throw new \Exception('Cache ArrayKey support only flush all data');
        }
    }
}