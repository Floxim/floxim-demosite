<?php

namespace Floxim\Cache\Storage;

use ReflectionObject;

/**
 * Abstract cache storage
 *
 * @package Floxim\Cache\Storage
 */
abstract class AbstractStorage implements \ArrayAccess {
    /**
     * Flush all data
     */
    const FLUSH_TYPE_ALL = 1;
    /**
     * Flush only oldest data
     */
    const FLUSH_TYPE_ONLY_OLD = 2;
    /**
     * Flush by tags
     */
    const FLUSH_TYPE_TAGS = 3;

    /**
     * Prefix for keys
     *
     * @var string
     */
    public $keyPrefix = '';
    /**
     * Used serializer before save data
     *
     * @var bool
     */
    public $useSerializer = true;

    /**
     * Constructor
     *
     * @param array $params
     */
    public function __construct($params = array()) {
        if ($params) {
            $reflect = new ReflectionObject($this);
            foreach ($params as $name => $value) {
                if ($reflect->hasProperty($name) and $property = $reflect->getProperty($name) and $property->isPublic()) {
                    $this->$name = $value;
                }
            }
        }
    }


    /**
     * Init storage
     *
     */
    public function init() {

    }

    /**
     * Set prefix for keys
     *
     * @param $prefix
     */
    public function setKeyPrefix($prefix) {
        $this->keyPrefix = $prefix;
    }

    /**
     * Get prefix for keys
     *
     * @return string
     */
    public function getKeyPrefix() {
        return $this->keyPrefix;
    }

    /**
     * Make key for save
     *
     * @param mixed $key
     *
     * @return string
     */
    public function buildKey($key) {
        if (is_string($key)) {
            $key = md5($this->keyPrefix . $key);
        } else {
            $key = md5($this->keyPrefix . json_encode($key));
        }
        return $key;
    }

    /**
     * Get data from cache
     *
     * @param $key
     *
     * @return mixed
     */
    public function get($key) {
        $key = $this->buildKey($key);
        $value = $this->getValue($key);
        if ($value === false || !$this->useSerializer) {
            return $value;
        }
        return @unserialize($value);
    }

    /**
     * Check exists data in cache
     *
     * @param $key
     *
     * @return bool
     */
    public function exists($key) {
        $key = $this->buildKey($key);
        $value = $this->getValue($key);
        return $value !== false;
    }

    /**
     * Stored data in cache
     *
     * @param       $key
     * @param       $value
     * @param int   $time Expiration time in seconds
     * @param array $tags Tags list
     *
     * @return mixed
     */
    public function set($key, $value, $time = 0, $tags = array()) {
        if ($this->useSerializer) {
            $value = serialize($value);
        }
        $key = $this->buildKey($key);
        return $this->setValue($key, $value, $time, $tags);
    }

    /**
     * Remove data from cache
     *
     * @param $key
     *
     * @return mixed
     */
    public function delete($key) {
        $key = $this->buildKey($key);
        return $this->deleteValue($key);
    }

    /**
     * Clear data in cache
     *
     * @param int   $type self::FLUSH_TYPE_ALL | self::FLUSH_TYPE_ONLY_OLD | self::FLUSH_TYPE_TAGS
     * @param array $tags
     *
     * @return mixed
     */
    public function flush($type = self::FLUSH_TYPE_ALL, $tags = array()) {
        return $this->flushValues($type, $tags);
    }

    /**
     * Check and save (if not exists) data in cache
     *
     * @param          $key
     * @param          $time
     * @param callable $callback
     * @param array    $tags
     *
     * @return mixed
     */
    public function remember($key, $time, \Closure $callback, $tags = array()) {
        if (false !== ($value = $this->get($key))) {
            return $value;
        }
        $this->set($key, $value = $callback(), $time, $tags);
        return $value;
    }

    /**
     * Implementation ArrayAccess interface
     *
     * @param mixed $key
     *
     * @return bool
     */
    public function offsetExists($key) {
        return $this->exists($key);
    }

    /**
     * Implementation ArrayAccess interface
     *
     * @param mixed $key
     *
     * @return mixed
     */
    public function offsetGet($key) {
        return $this->get($key);
    }

    /**
     * Implementation ArrayAccess interface
     *
     * @param mixed $key
     * @param mixed $value
     */
    public function offsetSet($key, $value) {
        $this->set($key, $value);
    }

    /**
     * Implementation ArrayAccess interface
     *
     * @param mixed $key
     */
    public function offsetUnset($key) {
        $this->delete($key);
    }

    /**
     * Get raw value from cache
     *
     * @param $key
     *
     * @return mixed
     */
    abstract protected function getValue($key);

    /**
     * Save value in cache
     *
     * @param       $key
     * @param       $value
     * @param int   $time
     * @param array $tags
     *
     * @return mixed
     */
    abstract protected function setValue($key, $value, $time = 0, $tags = array());

    /**
     * Remove value from cache
     *
     * @param $key
     *
     * @return mixed
     */
    abstract protected function deleteValue($key);

    /**
     * Clear values in cache
     *
     * @param int   $type
     * @param array $tags
     *
     * @return mixed
     */
    abstract protected function flushValues($type = self::FLUSH_TYPE_ALL, $tags = array());
}