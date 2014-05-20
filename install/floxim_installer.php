<?php

fx_run_remote();

function fx_run_remote() {
    $get_floxim_path = 'http://floxim.org/getfloxim/';
    $file = 'floxim.zip';
    
    $errors = fx_check_env();
    if (!empty($errors)) {
        if (isset($errors['warnings'])){
            foreach ($errors['warnings'] as $value) {
                echo $value.'<br/>';
            }
        }
        if (isset($errors['errors'])){
            foreach ($errors['errors'] as $value) {
                echo $value.'<br/>';
            }
            die();
        }
    }

    if (!file_exists($file)) {
        $file_data = file_get_contents($get_floxim_path.$file);
        $fh = fopen($file, 'w');
        fputs($fh, $file_data);
        fclose($fh);
    }
    fx_unzip($file, '.');
    header("Location: /install/");
    die();
}

function fx_check_env() {
    $errors = array();
    $dir = realpath(dirname(__FILE__));
    if (!fx_check_docroot()) {
        $errors['errors']['docroot'] = "Please, put installer file into your document root directory (<b>".$dir.'</b>)';
    }
    if (fx_check_writable() === false) {
        $errors['errors']['unwritable'] = "Target directory <code>".$dir."</code> is not writable by the script. Please change permissions and try again.";
    }

    if (!fx_zip_exists()) {
        $errors['errors']['zip'] = "zip_open function doesn't exist.";
    }

    if (!fx_check_version()) {
        $errors['errors']['version'] = "Floxim requires PHP <code>5.3</code> or greater (your server runs <code>".phpversion().'</code>)';
    }

    if (!fx_curl_exists()) {
        $errors['errors']['curl'] = '<code>cURL</code> extension doesn\'t exist';
    }

    if (!fx_check_pdo()) {
        $errors['errors']['pdo'] = 'PDO & pdo_mysql extensions are required.';
    }

    if (!fx_check_gd()){
        $errors['errors']['gd'] = 'GD doesn\'t exist or GD version is lower than 2.0';
    }

    try {
        if (!in_array('mod_rewrite', apache_get_modules())) {
            $errors['warnings']['rewrite'] = '<code>mod_rewrite</code> is not enabled.';    
        }
    } catch (Exeption $e) {
        $errors['warnings']['apache']= 'We recommend to use Apache server.';
    }
    return $errors;
}

function fx_check_docroot() {
    $c_dir = preg_replace('~[/\\\]~', '/', realpath(dirname(__FILE__)));
    return $_SERVER['DOCUMENT_ROOT'] === $c_dir;
}

function fx_check_writable() {
    $test_name = 'test'.md5(time().rand(0,100000)).'.txt';
    @ $test_f = fopen($test_name, 'w');
    if (!$test_f) {
        return false;
    }
    fclose($test_f);
    $test_name.' created';
    unlink($test_name);
}

function fx_check_pdo () {
    if (extension_loaded('pdo') && extension_loaded('pdo_mysql')) {
        return true;
    }
    return false;
}

function fx_check_gd () {
    if (function_exists('gd_info')) {
        $gd = gd_info();
        preg_match('/\d/', $gd['GD Version'], $match);
        $gd = $match[0];
        if ($gd < 2) {
            return false;
        }
    } else {
        return false;
    }
    return true;
}

function fx_check_version() {
    $v_str = phpversion();
    preg_match('~^\d+.\d~', $v_str, $matches);
    return (float)$matches[0]>=5.3;
}

function fx_zip_exists () {
    return function_exists('zip_open');
}

function fx_curl_exists () {
    return function_exists('curl_version');
}

function fx_unzip($file) {
    if (!file_exists($file)) {
        return false;
    }
    $dir = realpath(dirname($file)).DIRECTORY_SEPARATOR;
    $zip_handle = zip_open($file);
    if (!is_resource($zip_handle)) {
        die("Problems while reading zip archive");
    }
    while ($zip_entry = zip_read($zip_handle)) {
        $zip_name = zip_entry_name($zip_entry);
        $zip_dir = dirname( zip_entry_name($zip_entry) );
        $zip_size = zip_entry_filesize($zip_entry);
        if (preg_match("~/$~", $zip_name)) {
            $new_dir_name = preg_replace("~/$~", '', $dir . $zip_name);
            fx_installer_safe_mkdir($new_dir_name);
            chmod($new_dir_name, 0777);
        }
        else {
            zip_entry_open($zip_handle, $zip_entry, 'r');
            if (is_writable($dir . $zip_dir)) {
                $fp = @fopen($dir . $zip_name, 'w');
                if (is_resource($fp)) {
                    @fwrite($fp, zip_entry_read($zip_entry, $zip_size));
                    @fclose($fp);
                    chmod($dir.$zip_name, 0666);
                }
            }
            zip_entry_close($zip_entry);
        }
    }
    zip_close($zip_handle);
    return true;
}

function fx_installer_safe_mkdir($dir, $chmod = 0755) {
    $slash = "/";
    if (substr(php_uname(), 0, 7) == "Windows") {
        $slash = "\\";
        $dir = str_replace("/", $slash, $dir);
    }
    
    $tree = explode($slash, $dir);
    
    $path = $slash;
    // win path begin from C:\
    if (substr(php_uname(), 0, 7) == "Windows") $path = "";
    
    foreach($tree as $row) {
        
        if($row === false) continue;
        
        if( !@is_dir($path . $row) ) {
            @mkdir( strval($path . $row), $chmod );
        }
        
        $path .= $row . $slash;
    }
}