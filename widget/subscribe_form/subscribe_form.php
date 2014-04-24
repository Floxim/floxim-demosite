<?php
class fx_controller_widget_subscribe_form extends fx_controller_widget {
    
    //uncomment this to create widget action logic
    public function do_show() {
        $res = parent::do_show();
        $mail = null;
        if (isset($_POST['subscribe_email'])) {
            $mail = $_POST['subscribe_email'];
        }
        $res['subscribe_mail'] = $mail;
        if (!is_null($mail)) {
            if (!fx::util()->validate_email($mail)) {
                $res['errors'] = array(
                    'Invalid email'
                );
            } else {
                $res['done'] = true;
            }
        }
        return $res;
    }
}