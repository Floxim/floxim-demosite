<?php

namespace Floxim\Cache;

/**
 * Cache manager
 *
 * @package Floxim\Cache
 */
class Manager
{
    /**
     * Storage repository
     *
     * @var array
     */
    protected $storages = array();
    /**
     * Default prefix for keys
     *
     * @var string
     */
    protected $keyPrefix = '';

    /**
     * Get storage use repository
     *
     * @param string $name
     * @param array $params
     *
     * @return Storage\AbstractStorage|null
     * @throws \Exception
     */
    public function getStorage($name, $params = array())
    {
        /**
         * Check repository
         */
        if (isset($this->storages[strtolower($name)])) {
            return $this->storages[strtolower($name)];
        }
        /**
         * Create new storage
         */
        if (isset($params['class'])) {
            $class = $params['class'];
            unset($params['class']);
        } else {
            $class = '\\Floxim\\Cache\\Storage\\' . ucfirst($name);
        }
        if ($storage = $this->createStorage($class, $params)) {
            return $this->storages[strtolower($name)] = $storage;
        }
        throw new \Exception('Not found storage - ' . $class);
    }

    /**
     * Create storage
     *
     * @param string $class
     * @param array $params
     *
     * @return Storage\AbstractStorage|null
     */
    public function createStorage($class, $params = array())
    {
        if (!$class) {
            return null;
        }

        if (class_exists($class)) {
            $storage = new $class($params);
            $storage->init();
            if (!$storage->getKeyPrefix() and $this->getKeyPrefix()) {
                $storage->setKeyPrefix($this->getKeyPrefix());
            }
            return $storage;
        }
        return null;
    }

    /**
     * Set key prefix
     *
     * @param string $prefix
     */
    public function setKeyPrefix($prefix)
    {
        $this->keyPrefix = $prefix;
    }

    /**
     * Get key prefix
     *
     * @return string
     */
    public function getKeyPrefix()
    {
        return $this->keyPrefix;
    }
}