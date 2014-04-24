<?php
header('Content-Type: text/html; charset=utf-8'); 
session_start();

// installation folder
$INSTALL_FOLDER = join( strstr(__FILE__, "/") ? "/" : "\\", array_slice( preg_split("/[\/\\\]+/", __FILE__), 0, -1 ) ).( strstr(__FILE__, "/") ? "/" : "\\" );
// main Floxim folder
$FLOXIM_FOLDER = fx_standardize_path_to_folder( realpath($INSTALL_FOLDER.'../') );
// custom installation folder
$CUSTOM_FOLDER = str_replace( rtrim($_SERVER['DOCUMENT_ROOT'], '/').'/', '', $FLOXIM_FOLDER);

define('FX_CONFIG_FILE', $_SERVER['DOCUMENT_ROOT'].'/config.php');

if (file_exists(FX_CONFIG_FILE) && $_POST['action'] != 4) {
    echo "Floxim is already installed";
    die();
}

// normalize path
if ($CUSTOM_FOLDER) $CUSTOM_FOLDER = '/'.trim($CUSTOM_FOLDER, '/').'/';

define('FX_FILES_DIR', $_SERVER['DOCUMENT_ROOT'].'/floxim_files/');
define('FX_FILES_HTTP', '/floxim_files/');

if (isset($_REQUEST['pwd'])) {
  $_SESSION['pwd'] = $_REQUEST['pwd'];
}

// unlimit time
@set_time_limit(0);
header("Content-type: text/html; charset=utf-8");

error_reporting(E_ALL);
$action = fx_post_get('action');
$ajax = false;

switch ($action) {
    case 0:
        fx_html_beg();
        echo fx_html_status_bar(array("'color': '#444', 'opacity': 1", "You may start now"));
        echo "Hello, Floxim installer's here. I'm going to test your web server on compatibility, it's going to take just a couple of seconds Then I'll download the system and you can start working. I'm also going to need access to  MySQL database.";
        echo fx_html_form(1, 'Start checking');
    break;
    case 1:
        if (!$ajax)
            fx_html_beg();
        $php_version = phpversion();
        $logHeader =
                '--------------------------------------------------' . PHP_EOL .
                'Date ' . date("d.m.Y") . PHP_EOL .
                '--------------------------------------------------' . PHP_EOL .
                'Installing Floxim ' . PHP_EOL .
                '--------------------------------------------------';
        fx_write_log($logHeader, false);

        fx_write_log("Step number " . $action . ": Starting checking your hosting.");
        fx_write_log("Current PHP version: " . $php_version);

        $errors = array();
        $notices = array();

        if (version_compare($php_version, "5.3.0") == '-1') {
            $errors['phpversion'] = "PHP version 5.3.0 or greater required";
            fx_write_log("Error: " . $errors['phpversion']);
        }

        $arr_ini = array(
			'allow_url_fopen' => 1,
            'safe_mode' => 0,
            'short_open_tag' => 1,
            'zend.ze1_compatibility_mode' => 0
		);
        foreach ($arr_ini as $key => $value) {
            if (intval(ini_get($key)) != $value)
                if (strtolower(ini_get($key)) != ($value ? 'on' : 'off')) {
                    echo $key . " - " . $value;
                    $errors[$key] = "You need to " . ($value ? "turn on " : "turn off ") . $key. "parameter.";
                    fx_write_log("Error: " . $errors[$key]);
                }
        }
        if (intval(ini_get('memory_limit')) < 24) {
            $errors['memory_limit'] = "Your need to increase memory_limit parameter.";
            fx_write_log("Error: " . $errors['memory_limit']);
        }

        if (intval(ini_get('mbstring.func_overload')) != 0) {
            $notices['mbstring.func_overload'] = "Turn off mbstring.func_overload parameter.";
            fx_write_log("Warning: " . $notices['mbstring.func_overload']);
        }
		
		$extensions_name = array(
			'mysql' => 'MySQL',
			'session' => 'Session',
			'mbstring' => 'MBstring'
		);
		
        $arr_ext = array('session', 'mysql');
        foreach ($arr_ext as $ext) {
            if (!extension_loaded($ext)) {
                $errors[$ext] = "there is no " . ( isset($extensions_name[$ext]) ? $extensions_name[$ext] : $ext ) . " extension.";
                fx_write_log("Error: " . $errors[$ext]);
            }
        }

        $arr_ext_opt = array('mbstring', 'iconv');
        foreach ($arr_ext_opt as $ext) {
            if (!extension_loaded($ext)) {
                $notices[$ext] = "There is no  " . ( isset($extensions_name[$ext]) ? $extensions_name[$ext] : $ext ) . " extension.";
                fx_write_log("Warning: " . $notices[$ext]);
            } else if ($ext == 'gd') {
                if (function_exists('gd_info')) {
                    $gd = gd_info();
                    preg_match('/\d/', $gd['GD Version'], $match);
                    $gd = $match[0];
                    if ($gd < 2) {
                        $notices['gd'] = "gd extension version is lower than 2.0.0";
                        fx_write_log("Warning: " . $notices['gd']);
                    }
                } else {
                    $notices['gd'] = "Can't get gd version.";
                    fx_write_log("Warning: " . $notices['gd']);
                }
            }
        }

        $dir = dirname($_SERVER['PHP_SELF']);
        $test_dir = FX_FILES_DIR."testdirtestdir";
        if (!@mkdir($test_dir)) {
            $errors['mkdir'] = "The script has no permission to create directory.";
            fx_write_log("Error: " . $errors['mkdir']);
        }
        if (!is_writable($test_dir)) {
            $errors['is_writable'] = "The script has no permission to change directory.";
            fx_write_log("Error: " . $errors['is_writable']);
        }
        if (!@rmdir($test_dir)) {
            $errors['rmdir'] = "The script has no permission to delete directories.";
            fx_write_log("Error: " . $errors['rmdir']);
        }
        $config_file = FX_CONFIG_FILE;
        if (file_exists($config_file) && !@is_writable($config_file)) {
            $errors['config_not_writable'] = "The script has no permission to write into /config.php file.";
            fx_write_log("Error: " . $errors['config_not_writable']);
        }

        if (empty($errors)) {
            if (empty($notices))
                fx_write_log("Step 1: Parameters checking complete. All parameters match.");
            if (!empty($notices))
                fx_write_log("Step 1: Parameters checking complete.");
            $result = fx_html_status_bar(array("'color': 'green', 'opacity': 1", "Everything is working fine!"), array("'color': '#444', 'opacity': 1", "you can start now"), false, array(1, 0));
            $result .= "Your hosting suits " . ( empty($notices) ? " perfectly" : "" ) ."  for  Floxim. Now I'm going to check MySQL database. Specify database connection parameters. If you don't know them ask your system asministrator or support service. If you are using common hosting you may find the parameters in an email you got after registrating on hosting provider's site.";
            
        	if ( !empty($notices) ) {
				$result .= "<br /><br />To ensure correct work of the system, you should consider these:<br /><div style='margin: 7px 0; font-style: italic; color: orange;'>" . join("<br />", $notices) . "</div>";
				$result .= "System can be installed but its functonality might be limited.";
			}
            
            $result .= "<div class='db'>";
            $default_mysql_host = preg_match("~wind~i", php_uname()) ? '127.0.0.1' : 'localhost';
            $opt_html = "
            <div class='cell'>
                <span class='item'>Host</span><br />
                <input type='text' name='host' id='host' value='" . (fx_post_get('host') ? fx_post_get('host') : $default_mysql_host) . "' />
            </div>
                    <div class='cell'>
                <span class='item'>Database name</span><br />
                <input type='text' name='dbname' id='dbname' value='" . fx_post_get('dbname') . "' />
            </div>
            <div class='cell'>
                <span class='item'>Database user</span><br />
                <input type='text' name='user' id='user' value='" . fx_post_get('user') . "' />
            </div>
            <div class='cell'>
                <span class='item'>Password</span><br />
                <input type='password' name='pass' id='pass' value='" . fx_post_get('pass') . "' />
            </div>";
            $result .= fx_html_form(2, 'Check database', $opt_html);
            $result .= "</div>";
        }
        else {
            $result = fx_html_status_bar(array("'color': 'red', 'opacity': 1", "There are some  problems!"));
            $result .= "<span style='font-style: italic; padding: 10pt; color: red;'>" . join(" ", $errors) . "</span><br /><br />There are some issues that make using Floxim on your hosting impossible. If you can't solve them yourself describe the problems to system administrator or to support service. I hope you can solve the problems so we can complete the installation.";
        }

        echo $result;
    break;
    case 2:
        if (!$ajax)
            fx_html_beg();
        fx_write_log("Step #" . $action . ": Starting to check database.");
        $error = "";
        $LinkID = fx_connect_db();
        if (!$LinkID) {
            $error = "No connection with the indicated database. MySQL error: " . mysql_error();
            fx_write_log($error);
            echo fx_html_status_bar(array("'color': 'green', 'opacity': 1", "it's going just fine!"), array("'color': 'red', 'opacity': 1", "There are some problems!"), false, array(1, 0));
            echo "Can't connect to database. Check if all the access parameters are there and try again. ".
                    "Read more about error <a href='".FX_FILES_HTTP."install_log.txt' target='_blank'>in log</a>.";
            echo fx_html_form(1, "Go back and try again");
            break;
        }
        else
            fx_write_log("Connected to database.");

        if (version_compare(mysql_get_server_info(), "4.1.0") == '-1') {
            $error = "MySQL version is lower than required. Contact your system administrator or hosting provider to solve the problem.";
            fx_write_log($error);
            echo fx_html_status_bar(array("'color': 'green', 'opacity': 1", "All's working fine!"), array("'color': 'red', 'opacity': 1", "There are some problems!"), false, array(1, 0));
            echo $error;
            break;
        }

        if (!fx_check_user_grants()) {
            echo fx_html_status_bar(array("'color': 'green', 'opacity': 1", "All's working fine!"), array("'color': 'red', 'opacity': 1", "There are some problems!"), false, array(1, 0));
            echo "Indicated user haven't got permission to write to database. Is there any other user you can log in?  Contact your system administrator or hosting provider to solve the problem.";
            echo fx_html_form(1, 'Go back');
            break;
        }

        $deltables = fx_post_get('deltables');
        if ($deltables) {
            $repeatTables = fx_repeat_tables();
            foreach ($repeatTables as $d_t) {
                $query = "DROP TABLE `" . $d_t . "`";
                fx_query($query);
            }
        }

        if (fx_repeat_tables()) {
            $error = "There are Floxim tables in the indicated database.";
            fx_write_log($error);
            echo fx_html_status_bar(array("'color': 'green', 'opacity': 1", "All's working fine!"), array("'color': 'red', 'opacity': 1", "attention!"), false, array(1, 0));
            echo "Indicated database already has the tables that installer is about to create. Do you want to delete them and continue installing?";
            echo fx_html_form(2, 'Delete and install', "<input type='hidden' id='deltables' name='deltables' value='1' />");
            break;
        }

        fx_write_log("Step #" . $action . ": Database parameter checking complete");
        echo fx_html_status_bar(array("'color': 'green', 'opacity': 1", "All's working fine!"), array("'color': 'green', 'opacity': 1", "Going well…"), array("'color': '#444', 'opacity': 1", "Just one steps to go!"), array(1, 1));
        echo "<div id='settings'>" . fx_html_settings() . "</div>";
    break;
    case 3:
        if (!$ajax)
            fx_html_beg();
        fx_write_log("Step #" . $action . ": Installing distributive.");
        $errors = array();
        
        if ( !( fx_post_get('pwd') && fx_post_get('email') ) ) {
            fx_write_log('System administrator\'s data are not entered');
            echo fx_html_status_bar(array("'color': 'green', 'opacity': 1", "So far so good!"), array("'color': 'green', 'opacity': 1", "All's working fine!"), array("'color': 'red', 'opacity': 1", "There is a problem!"), array(1, 1));
            echo "System administrator's data were not entered. Go back and put them in.";
            echo fx_html_form(2, 'Go back');
            break;
        }
        
        echo "Installing may take from a few seconds up to several minutes depending on your server's capacity.<br />
        <ul>";
        @ob_flush();
        @flush();
        $notify['success0'] = "<script>$('#timer0').html('<span style=\'color: green;\'>All's done!</span>');</script>";
        $notify['error0'] = "<script>$('#timer0').html('<span style=\'color: red;\'>Error!</span>');</script>";
        $notify['success1'] = "<script>$('#timer1').html('<span style=\'color: green;\'>All's done!</span>');</script>";
        $notify['error1'] = "<script>$('#timer1').html('<span style=\'color: red;\'>Error!</span>');</script>";
        $notify['success2'] = "<script>$('#timer2').html('<span style=\'color: green;\'>All's done!</span>');</script>";
        $notify['error2'] = "<script>$('#timer2').html('<span style=\'color: red;\'>Error!</span>');</script>";

        echo "<li>Unpacking database… <span id='timer2'></span></li>";
        @ob_flush();
        @flush();
        if ( !fx_install_db() ) {
            echo fx_html_status_bar(array("'color': 'green', 'opacity': 1", "All's going great!"), array("'color': 'green', 'opacity': 1", "Everything is fine!"), array("'color': 'red', 'opacity': 1", "Oops! There is a problem."), array(1, 1));
            $errors['db'] = "A problem occurred when setting up databse.";
            fx_write_log($errors['db']);
            echo $notify['error2'];
            $message['db'] = $errors['db'];
            echo "</ul>";
            echo $message['db'];
            echo fx_html_form(4, 'Try again');
            break;
        }
        echo $notify['success2'];
        @ob_flush();
        @flush();
        $errors['db'] = "Database unpacked.";
        fx_write_log($errors['db']);

        echo "</ul>";
        @ob_flush();
        @flush();
        
        // create config.php
        fx_write_config($FLOXIM_FOLDER, $CUSTOM_FOLDER);
        // update .htaccess
        fx_change_htaccess($FLOXIM_FOLDER, $CUSTOM_FOLDER);
        
        echo fx_html_form('4', 'Complete installing');
    break;
    case 4:
        if (!$ajax) fx_html_beg();
        
        $dir = $_SERVER['HTTP_HOST'].$CUSTOM_FOLDER;
        
        $result = fx_html_status_bar(
          array("'color': 'green', 'opacity': 1", "Everything is fine!"),
          array("'color': 'green', 'opacity': 1", "All's great!"),
          array("'color': 'green', 'opacity': 1", "All's done!"),
          array(1, 1)
        );
        $result.= "Hurray! Floxim installed, you can start working. Here are:<br />".
          "<ul>".
          "<li>site address: <a href='http://".$dir."' target='_blank'>http://".$dir."</a></li>".
          "<li>Login for the <a href='http://".$dir."/floxim/'>back office</a>: <strong>".fx_post_get('email')."</strong></li>".
          "<li>Password: the one you've entered ".( fx_post_get('email') ? "(and it's also in an email we've sent to <a href='mailto:".fx_post_get('email')."'>".fx_post_get('email')."</a>)" : "" )."</li>".
          "</ul>".
          "<br />".
          "<em style='color: red;'>Make sure you've deleted install folder from server!</em>";
        echo $result;
        fx_mail_to_user($dir);
    break;
}
fx_html_end();

function fx_html_beg() {
    echo <<<HEREDOC
<!doctype html>
<html>
<head>
    <title>Floxim installing</title>
    <meta http-equiv="Content-Language" content="en" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link rel="stylesheet" type="text/css" href="style.css" />
    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>
    <div class='main'>       
            <div class='top'>Floxim installer</div>
            <div class='status_bar'>
                <div class='pair'>
                    <span id='item0'>Checking the hosting</span><br />
                    <span id='status0'>You may start now</span>
                </div>
                <div id='arrow0'>&rarr;</div>
                <div class='pair'>
                    <span id='item1'>Checking database</span><br />
                    <span id='status1' >is not executed </span>
                </div>
                <div id='arrow1'>&rarr;</div>
                <div class='pair'>
                    <span id='item2' >Floxim installing</span><br />
                    <span id='status2'>Checking everything first</span>
                </div>
                <div style='clear:both;'></div>
            </div>
            <div id='content'>
HEREDOC;
}

function fx_html_end() {
    $html = "</div>
    </div>
<script type='text/javascript'>
    $(document).ready(function() {
      $('#main_form').submit(function() {
        var ajax = $('#ajax').val();
        if (ajax) {
            var q = $('#main_form').serialize();
            var request = $.ajax({
              type: 'POST',
              data: q,
              dataType: 'html',
              cache: false,
              success: function(data) {
                    $('#content').html(data);
                }
            });
            return false;
        }
      });
      
	$('#show_block1').click(function(){        
		if ($('#show_block1').is('.nonselected_tab')) {
			$('#show_block1').removeClass('nonselected_tab'); 
			$('#show_block1').addClass('selected_tab'); 

			$('#show_block2').removeClass('selected_tab'); 
			$('#show_block2').addClass('nonselected_tab');

			$('#block1').removeClass('hidden');    
			$('#block2').addClass('hidden');

			$('#code').val('');
			$('#code_valid').html('');
			$('#regnum').val('');
			$('#regnum_valid').html('');
		}
		
		return false;
	});
            
	$('#show_block2').click(function() {        
		if ($('#show_block2').is('.nonselected_tab')) {
			$('#show_block2').removeClass('nonselected_tab'); 
			$('#show_block2').addClass('selected_tab'); 

			$('#show_block1').removeClass('selected_tab'); 
			$('#show_block1').addClass('nonselected_tab'); 

			$('#block2').removeClass('hidden');
			$('#block1').addClass('hidden');

			for(var i = 1; i < 6; i++) {
			$('#db' + i).attr('checked', null);
			}
		}
		
		return false;
	});
        
	$('#pwd_gen').click( function() {
		var sign = ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', 'a', 's', 'd', 'f', 
		'g', 'h', 'j', 'k', 'l', 'z', 'x', 'c', 'v', 'b', 'n', 'm', 'Q', 'W',
		'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', 'A', 'S', 'D', 'F', 'G', 'H', 
		'J', 'K', 'L', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', '1', '2', '3', '4', 
		'5', '6', '7', '8', '9', '0'];            
		var result = '';
		var end = sign.length - 1;
		for(var i = 0; i < 10; i++) {
		result += sign[Math.floor(Math.random()*end)];
		}
		$('#pwd_field').val(result);
		return false;
	});
                
        $('#pwd_show').change( function() {
          fx_show_hide_pwd('#pwd_field', this.checked);
        }); 
        
        $('#email_field').focusout(function(){
          fx_check_email($('#email_field').val(), '#email_field');
        });
    });
    
    function fx_show_hide_pwd(id, checked) {
        checked ? fx_show_pwd(id) : fx_hide_pwd(id);
    }
            
    function fx_show_pwd(id) {
        var id_clear = id+'_clear';
        $(id_clear).removeClass('hidden'); 
        $(id).addClass('hidden');
        $(id_clear).val($(id).val());
    }
            
    function fx_hide_pwd(id) {
      var id_clear = id+'_clear';
      $(id).removeClass('hidden'); 
      $(id_clear).addClass('hidden');
      $(id).val($(id_clear).val());
    }
    
    function fx_check_email(value, id) {
        var email = value;
        if(email != '') {
          if (fx_is_valid_email_address(email) == false) {
            $('#email_valid').html('<span style=\'color: red;\'>Doesn\'t look like real email</span>');
          } 
          else {
            $('#email_valid').html('');
          }
        } 
        else {
          $('#email_valid').html('');
        }
    }
    
    function fx_is_valid_email_address(emailAddress) {
        var pattern=/[0-9a-z_]+@[0-9a-z_]+\.[a-z]{2,5}/i;
        return pattern.test(emailAddress);
    }
</script>   
</body>         
</html>";
    echo $html;
}

function fx_html_status_bar($array1 = array(), $array2 = array(), $array3 = array(), $array4 = array()) {
    return "<script type='text/javascript'>
    " . (!empty($array1) && $array1[0] ? "$('#item0, #status0').css({" . $array1[0] . "});" : "") . "
    " . (!empty($array1) && $array1[1] ? "$('#status0').html('" . $array1[1] . "');" : "") . "
    " . (!empty($array4) && $array4[0] ? "$('#arrow0').css({'color': '#444', 'opacity': 1});" : "") . "
    " . (!empty($array2) && $array2[0] ? "$('#item1, #status1').css({" . $array2[0] . "});" : "") . "
    " . (!empty($array2) && $array2[1] ? "$('#status1').html('" . $array2[1] . "');" : "") . "
    " . (!empty($array4) && $array4[1] ? "$('#arrow1').css({'color': '#444', 'opacity': 1});" : "") . "
    " . (!empty($array3) && $array3[0] ? "$('#item2, #status2').css({" . $array3[0] . "});" : "") . "
    " . (!empty($array3) && $array3[1] ? "$('#status2').html('" . $array3[1] . "');" : "") . "
    </script>";
}

function fx_html_form($action, $button, $opt = '') {
    global $ajax;
    $html = "<form method='post' action='" . $_SERVER['SCRIPT_NAME'] . "' name='main_form' id='main_form' >";
    $html .= "<input type='hidden' name='action' id='action' value='" . $action . "' />";
    $params = array("host", "user", "dbname", "pass", "pwd", "email", "template", "color_var", "demodistr", "regnum", "code");
    foreach ($params as $param) {
        $html .= "<input type='hidden' name='" . $param . "' value='" . fx_post_get($param) . "' />";
    }
    $html .= "<input type='hidden' name='ajax' id='ajax' value='" . $ajax . "' />";
    $html .= $opt . "<input type='submit' name='submit_button' id='submit_button' value='" . $button . "' /></form>";

    return $html;
}

function fx_query($query) {
    global $LinkID;
    $res = mysql_query($query, $LinkID);
    fx_write_log($query);
    if (mysql_error()) {
        print mysql_error() . "\n<br /><strong>Query:</strong> <pre>$query</pre>\n";
        return false;
    } else {
        return $res;
    }
}

function fx_post_get($param) {
    if (empty($_GET) && empty($_POST))
        return false;
    if ($param) {
        return array_key_exists($param, $_GET) ? $_GET[$param] : (array_key_exists($param, $_POST) ? $_POST[$param] : "");
    }
    else
        return array_merge($_POST, $_GET);
}

function fx_connect_db() {
    global $LinkID;
    $host = fx_post_get('host');
    $user = fx_post_get('user');
    $pass = fx_post_get('pass');
    $dbname = fx_post_get('dbname');

    $LinkID = @mysql_connect($host, $user, $pass);
    if (!$LinkID)
        return false;

    if (!mysql_select_db($dbname, $LinkID)) {
        fx_write_log('Can\'t connect to indicated database');
        return false;
    }
    mysql_query("SET NAMES 'utf8'");
    mysql_query("ALTER DATABASE `" . $dbname . "` DEFAULT CHARACTER SET 'utf8'");

    return $LinkID;
}

function fx_check_user_grants() {
    $sql_create = "CREATE TABLE test_table (ID int(11) NOT NULL, FIO varchar(128) NOT NULL)";
    $sql_drop = "DROP TABLE `test_table`";
    $error = false;
    if (!(fx_query($sql_create) && fx_query($sql_drop)))
        $error = true;
    if ($error)
        return false;
    else
        return true;
}

function fx_html_settings() {
    return fx_html_form(3, 'Install Floxim', fx_html_config());
}

function fx_html_config() {
    $html = "
    <div class='email_form'>
		Administrator's email:<br />
		<input class='email' type='text' name='email' id='email_field' />
		<span id='email_valid' class='valid'></span>
	</div>
    <div class='pwd_create'>
		Enter user's password to access the administration system:<br />
		<input type='password' name='pwd' id='pwd_field' />
		<a href='#' id='pwd_gen' class='selected_tab'>generate password</a>
		<div>
			<input type='checkbox' name='show_pwd' value='1' id='show_pwd' onclick='document.getElementById(\"pwd_field\").type = (this.checked ? \"text\" : \"password\");' />
			<label for='show_pwd'>Show password</label>
		</div>
	</div>
	";

    return $html;
}

function fx_standardize_path_to_file($path) {
    return rtrim(fx_standardize_path_to_folder($path), '/');
}

function fx_standardize_path_to_folder($path) {
    $path = str_replace('\\', '/', $path);
    while (!(strpos($path, '//') === false)) {
        $path = str_replace('//', '/', $path);
    }
    return rtrim($path, '/') . '/';
}

function fx_install_db($dir = '', $level = 0) {
    
    if (!$level) fx_connect_db();
    
    $content = false;
    $v4 = false;
    $all = false;
    
    $install_type = 0;
    
    $system_arr = array();
    $module_arr = array();
    
    // clear system
    $system_arr[0] = array('floxim');

	for ($i = 0; $i <= $install_type; $i++):
		foreach ($system_arr[$i] as $row):    
			$file_name = $row . '.sql';
			$file = fx_standardize_path_to_file( dirname(__FILE__) . '/' . $dir . $file_name );
			if ( file_exists($file) ) {
				if ( !fx_exec_sql($file) ) {
					fx_write_log('The system could be already installed: ' . $file);
					return false;
				}
			}
		endforeach;
    endfor;
    
	if (!$level) {
		fx_update_db();
		fx_write_log('Unpacking database finished.');
	}

    return true;
}

function fx_update_db() {
	// update data
    $sql = array(
		"UPDATE `fx_site` SET `domain` = '" . mysql_real_escape_string($_SERVER['HTTP_HOST']) . "' WHERE `id` = 18",
		"UPDATE `fx_site` SET `domain` = '" . mysql_real_escape_string('alt.'.$_SERVER['HTTP_HOST']) . "' WHERE `id` = 1",
		"UPDATE `fx_content_user` SET `password` = '" 
                    //. md5($_SESSION['pwd']) 
                    .crypt($_SESSION['pwd'],  uniqid(mt_rand(), true))
                    . "', `email` = '" . mysql_real_escape_string( fx_post_get('email') ) 
                    . "' WHERE `email` = 'admin@floxim.loc'",
		"UPDATE `fx_settings` SET `value` = '" . mysql_real_escape_string( fx_post_get('email') ) . "' WHERE `key` = 'spam_from_email'"
	);
	
    foreach ($sql as $query) {
        fx_query($query);
    }
}

function fx_get_cattables_for_lower_case() {
    return array_map('strtolower', fx_get_cattables());
}

function fx_get_cattables() {
    $cattables = array (
        0 => 'fx_auth_external',
        1 => 'fx_classificator',
        2 => 'fx_classificator_cities',
        3 => 'fx_classificator_country',
        4 => 'fx_classificator_region',
        5 => 'fx_component',
        6 => 'fx_content',
        7 => 'fx_content_award',
        8 => 'fx_content_classifier',
        9 => 'fx_content_classifier_linker',
        10 => 'fx_content_comment',
        11 => 'fx_content_company',
        12 => 'fx_content_complex_photo',
        13 => 'fx_content_complex_video',
        14 => 'fx_content_contact',
        15 => 'fx_content_faq',
        16 => 'fx_content_gallery',
        17 => 'fx_content_news',
        18 => 'fx_content_page',
        19 => 'fx_content_person',
        20 => 'fx_content_photo',
        21 => 'fx_content_product',
        22 => 'fx_content_product_category',
        23 => 'fx_content_project',
        24 => 'fx_content_publication',
        25 => 'fx_content_section',
        26 => 'fx_content_select_linker',
        27 => 'fx_content_social_icon',
        28 => 'fx_content_tag',
        29 => 'fx_content_text',
        30 => 'fx_content_travel_route',
        31 => 'fx_content_user',
        32 => 'fx_content_vacancy',
        33 => 'fx_content_video',
        34 => 'fx_controller',
        35 => 'fx_crontask',
        36 => 'fx_datatype',
        37 => 'fx_field',
        38 => 'fx_filetable',
        39 => 'fx_group',
        40 => 'fx_history',
        41 => 'fx_history_item',
        42 => 'fx_infoblock',
        43 => 'fx_infoblock_visual',
        44 => 'fx_lang',
        45 => 'fx_lang_string',
        46 => 'fx_layout',
        47 => 'fx_mail_template',
        48 => 'fx_module',
        49 => 'fx_multiselect',
        50 => 'fx_patch',
        51 => 'fx_redirect',
        52 => 'fx_session',
        53 => 'fx_settings',
        54 => 'fx_site',
        55 => 'fx_template',
        56 => 'fx_user_group',
        57 => 'fx_widget',
      );
    return $cattables;
}

function fx_get_users_tables() {
    $tables = array();
    $showt = mysql_query("SHOW TABLES");
    while ($row = mysql_fetch_array($showt)) {
        $tables[] = $row[0];
    }

    return $tables;
}

function fx_is_lower_case_table_names() {
    $res = fx_query("SHOW VARIABLES LIKE 'lower_case_table_names'");
    $var = mysql_fetch_row($res);
    return ($var[1] == 1 ? TRUE : FALSE);
}

function fx_repeat_tables() {
    $tables = array();
    $user_tables = fx_get_users_tables();
    if (fx_is_lower_case_table_names()) {
        $tables = array_intersect(fx_get_cattables_for_lower_case(), $user_tables);
    }
    else {
        $tables = array_intersect(fx_get_cattables() , $user_tables);
    }
    
    return $tables;
}

function fx_mail_to_user($path) {
    $mail = fx_post_get('email');
    $pwd = fx_post_get('pwd');

    $subject = 'Floxim installed successfully.';
    $message = 'Congratulations! 
You\'ve installed Floxim on http://'.$path.'
Your authorised data to access the site: 
    - address: http://'.$path.'/floxim/
    - login: '.$mail.'
    - password: '.$pwd .'

Thank you for choosing Floxim! 

Best regards, 
Floxim Install Script';

    $headers = "Content-type: text/plain; charset=UTF-8 \r\n";
    $headers .= "From: info@{$_SERVER['SERVER_NAME']}\r\n";
    @mail($mail, $subject, $message, $headers);
}

function fx_write_log($message, $time = true) {
    #return null;
    $message_time = "";
    if ($time) {
        $message_time = date("H:i:s d.m.Y") . ' ';
        if (substr($message, -1) != '.')
            $message = $message . '.';
    }
    $result_str = PHP_EOL . $message_time . $message;
    $log_file = FX_FILES_DIR."install_log.txt";
    if (is_writable($log_file)) {
        file_put_contents($log_file, $result_str, FILE_APPEND);
    }
}

function fx_func_enabled($function) {
    $function = strtolower(trim($function));
    if ($function == '')
        return false;
    $dis_functions = array();
    $dis_functions = explode(",", @ini_get("disable_functions"));
    if (!empty($dis_functions))
        $dis_functions = array_map('trim', array_map('strtolower', $dis_functions));
    if (function_exists($function) && is_callable($function) && !in_array($function, $dis_functions))
        return true;
    else
        return false;
}

function fx_exec_sql($file) {
    $fp = fopen($file, "r");
    if (!$fp) {
        fx_write_log('Can\'t open sql-file: ' . $file);
        return false;
    }
    $i = 0;
    while (!feof($fp)) {
        $statement = chop(fgets($fp, 65536));
        if (strlen($statement)) {
            while (substr($statement, strlen($statement) - 1, 1) <> ";" && substr($statement, 0, 1) <> "#" && substr($statement, 0, 2) <> "--")
                $statement .= chop(fgets($fp, 65536));
            if (substr($statement, 0, 1) <> "#" && substr($statement, 0, 2) <> "--") {
                if (!fx_query($statement)) {
                    fx_write_log('Execution of request failed in file ' . $file . ' MySQL error: ' . mysql_error());
                }
            }
        }
    }

    fclose($fp);
    return true;
}

function fx_get_config($MYSQL_HOST, $MYSQL_USER, $MYSQL_PASSWORD, $MYSQL_DB_NAME) {
    ob_start();
    ?>
ini_set('apc.cache_by_default', 0);
define("FX_JQUERY_PATH", '/floxim/lib/js/jquery-1.9.1.min.js');
define("FX_JQUERY_UI_PATH", '/floxim/lib/js/jquery-ui-1.10.3.custom.min.js');
$db_config = array(
    'default' =>  array(
        'DB_DSN' => 'mysql:dbname=<?=$MYSQL_DB_NAME?>;host=<?=$MYSQL_HOST?>',
        'DB_USER' => '<?=$MYSQL_USER?>',
        'DB_PASSWORD' => '<?=$MYSQL_PASSWORD?>',
        'IS_DEV_MODE' => false,
        'COMPILED_TEMPLATES_TTL' => 0
    )
);

return $db_config['default'];
<?php
    $cfg_file = ob_get_clean();
	
	$cfg_file = '<?php'.PHP_EOL.PHP_EOL.$cfg_file;
	$cfg_file = $cfg_file.'?>';
	
    return $cfg_file;
}

function fx_write_config($distr_dir, $custom_dir) {
    
    //$config_path = $distr_dir . 'config.php';
    $config_path = FX_CONFIG_FILE;
    
    $cfg_file = fx_get_config( fx_post_get('host'), fx_post_get('user'), fx_post_get('pass'), fx_post_get('dbname') );
    
    if (!file_exists($config_path) ||  is_writable($config_path) ) {
      file_put_contents($config_path, $cfg_file);
    } else {
		fx_write_log('Configuration file config.php unaccessible for recording. Add the required permissions on this file and repeat the installation. ');
	}
}

function fx_change_htaccess($distr_dir, $custom_dir) {
    // nothing else changed
    if (!$custom_dir) return false;
    
    // path to the .htaccess
    $htaccess_path = $distr_dir . '.htaccess';
    // file not exist
    if ( !is_file($htaccess_path) ) {
      return false;
    }
    
    // file content
    $htaccess = file($htaccess_path);
    
    // walk
    foreach ($htaccess as $num => $str) {
      if (strpos($str, 'ErrorDocument 404') === 0) {
        $htaccess[$num] = "ErrorDocument 404 ".rtrim($custom_dir, '/')."/floxim/require/e404.php\n\r";
      }
      if (strpos($str, 'RewriteRule ^(.+)$') === 0) {
        $htaccess[$num] = "RewriteRule ^(.+)$ ".rtrim($custom_dir, '/')."/floxim/require/e404.php?REQUEST_URI=$1 [L,QSA]\n\r";
      }
    }
    
    // update file content
    if ( is_writable($htaccess_path) ) {
      file_put_contents( $htaccess_path, join('', $htaccess) );
    }
}

?>