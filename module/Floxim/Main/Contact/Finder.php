<?php
namespace Floxim\Main\Contact;

class Finder extends \Floxim\Main\Content\Finder
{

    public function livesearch($term = null, $limit = null)
    {
        if (!isset($term)) {
            return;
        }
        $terms = explode(" ", $term);
        if (count($terms) > 0) {
            foreach ($terms as $tp) {
                $this->whereOr(array('value', '%' . $tp . '%', 'LIKE'), array('contact_type', '%' . $tp . '%', 'LIKE'));
            }
        }
        if ($limit) {
            $this->limit($limit);
        }
        $this->calcFoundRows(true);
        $items = $this->all();
        $count = $this->getFoundRows();
        $res = array('meta' => array('total' => $count), 'results' => array());
        foreach ($items as $i) {
            $res['results'][] = array(
                'name' => $i['contact_type'] . ': ' . $i['value'],
                'id'   => $i['id']
            );
        }
        return $res;
    }

}