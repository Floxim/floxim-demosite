<?
class fx_controller_widget_authform extends fx_controller_widget {
    public function do_show() {
        if (fx::user()) {
            return array('_meta' => array('hidden' => true));
        }
    }
}
?>