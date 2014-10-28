<?php

namespace Floxim\Form;

use Floxim\Floxim\System\Fx as fx;

class Form implements \ArrayAccess
{

    protected $params = array();

    public function __construct($params = array())
    {
        $params = array_merge(array(
            'method' => 'POST'
        ), $params);
        $fields = new Fields();
        $fields->form = $this;
        $params['fields'] = $fields;
        $this->params = $params;
        $this->addField(array('name' => 'default_submit', 'type' => 'submit', 'label' => 'Submit'));
    }

    public function addFields($fields)
    {
        foreach ($fields as $name => $props) {
            $props['name'] = $name;
            $this->addField($props);
        }
    }

    /**
     * @todo we need $_POST + $_FILES merge here
     */
    protected function getInput()
    {
        return strtolower($this['method']) == 'post' ? $_POST : $_GET;
    }

    public function getId()
    {
        if (!isset($this['id'])) {
            $this['id'] = md5(join(",", $this->params['fields']->keys()));
        }
        return $this['id'];
    }

    protected $_listeners = array();

    public function __call($name, $args)
    {
        if (preg_match("~^on[A-Z]~", $name) && count($args) == 1) {
            $event_name = preg_replace("~^on~", '', $name);
            $event_name = fx::util()->camelToUnderscore($event_name);
            $this->on($event_name, $args[0]);
            return $this;
        }
    }

    public function on($event, $callback)
    {
        if (!isset($this->_listeners[$event])) {
            $this->_listeners[$event] = array();
        }
        $this->_listeners[$event] [] = $callback;
    }

    public function trigger($event)
    {
        if (is_string($event) && isset($this->_listeners[$event])) {
            foreach ($this->_listeners[$event] as $listener) {
                if (is_callable($listener)) {
                    call_user_func($listener, $this);
                }
            }
        }
    }

    protected $is_sent = null;

    public function isSent()
    {
        if (is_null($this->is_sent)) {
            $input = $this->getInput();
            $this->is_sent = isset($input[$this->getId() . '_sent']);
            if ($this->is_sent) {
                $this->loadValues();
                $this->validate();
                $this->trigger('sent');
            }
        }
        return $this->is_sent;
    }

    public function validate()
    {
        return $this->params['fields']->validate();
    }

    public function loadValues($source = null)
    {
        if (is_null($source)) {
            $source = $this->getInput();
        }
        foreach ($this->params['fields'] as $name => $field) {
            $field->setValue(isset($source[$name]) ? $source[$name] : null);
        }
    }

    public function setValue($field, $value)
    {
        $this->params['fields']->setValue($field, $value);
    }

    public function getValue($field = null)
    {
        return $this->params['fields']->getValue($field);
    }

    /**
     * Magic getter returns field value
     * @param type $name
     */
    public function __get($name)
    {
        return $this->getValue($name);
    }

    public function getValues()
    {
        return $this->params['fields']->getValues();
    }

    public function addField($params)
    {
        if ($params['type'] == 'submit') {
            $this->params['fields']->findRemove('name', 'default_submit');
        }
        return $this->params['fields']->addField($params);
    }

    public function addMessage($message, $after_finish = false)
    {
        if (!isset($this['messages'])) {
            $this['messages'] = fx::collection();
        }
        $this['messages'][] = array('message' => $message, 'after_finish' => (bool)$after_finish);
    }

    public function finish($message = null)
    {
        $this['is_finished'] = true;
        if ($message) {
            $this->addMessage($message, true);
        }
        $this->trigger('finish');
    }

    public function hasErrors()
    {
        return count($this->getErrors()) > 0;
    }

    public function getErrors()
    {
        $errors = isset($this['errors']) ? $this['errors'] : fx::collection();
        $errors->concat($this->params['fields']->getErrors());
        return $errors;
    }

    public function addError($error, $field_name = false)
    {
        $field = $field_name ? $this->getField($field_name) : false;
        if ($field) {
            $field->addError($error);
            return;
        }
        if (!isset($this->params['errors'])) {
            $this->params['errors'] = fx::collection();
        }
        $this->params['errors'][] = array('error' => $error);
    }

    public function getField($name)
    {
        return $this->params['fields']->getField($name);
    }

    public function get($offset = null)
    {
        if (is_null($offset)) {
            return $this->params;
        }
        return $this->offsetGet($offset);
    }

    /* ArrayAccess methods */

    public function offsetExists($offset)
    {
        return array_key_exists($offset, $this->params) || in_array($offset, array('is_sent'));
    }

    public function offsetGet($offset)
    {
        if ($offset === 'is_sent') {
            return $this->isSent();
        }
        return array_key_exists($offset, $this->params) ? $this->params[$offset] : null;
    }

    public function offsetSet($offset, $value)
    {
        $this->params[$offset] = $value;
    }

    public function offsetUnset($offset)
    {
        unset($this->params[$offset]);
    }
}