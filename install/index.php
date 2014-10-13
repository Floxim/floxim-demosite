<?php
// set headers
header('Content-Type: text/html; charset=utf-8'); 
// start session
session_start();
// error reporting
error_reporting(E_ALL);
// set unlimited time
@set_time_limit(0);

// set consts
define('FX_DOC_ROOT', fx_fix_path($_SERVER['DOCUMENT_ROOT']));
define('FX_FOLDER', FX_DOC_ROOT . '/floxim');
define('FX_CONFIG_FILE', FX_DOC_ROOT . '/config.php');
define('FX_FILES_DIR', FX_DOC_ROOT . '/floxim_files/');
define('FX_FILES_HTTP', '/floxim_files/');

$action = fx_post_get('action');

// check already installed floxim copy
if (file_exists(FX_CONFIG_FILE) && $action != 4) {
    $c_config = include(FX_CONFIG_FILE);
    if ($c_config) {
        die("Floxim is already installed");
    }
}

if (isset($_REQUEST['pwd'])) {
  $_SESSION['pwd'] = $_REQUEST['pwd'];
}

switch ($action) {
    case 0:
    case 1:
        fx_html_beg();
        $php_version = phpversion();
        $logHeader =
			'--------------------------------------------------' . PHP_EOL .
			'Date ' . date("d.m.Y H:i:s") . PHP_EOL .
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
        $test_dir = FX_FILES_DIR . "testdirtestdir";
        if (!mkdir($test_dir)) {
            $errors['mkdir'] = "The script has no permission to create directory. ".$test_dir;
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
            if (empty($notices)) {
                fx_write_log("Success: Parameters checking complete. All parameters match.");
            }
            if (!empty($notices)) {
                fx_write_log("Parameters checking complete.");
            }
            $result = fx_html_status_bar(array("'color': 'green', 'opacity': 1", "Everything is working fine!"), array("'color': '#444', 'opacity': 1", "you can start now"), false);
            $result .= "Your hosting suits " . ( empty($notices) ? " perfectly" : "" ) ."  for  Floxim. Specify database connection parameters. If you don't know them ask your system asministrator or support service. If you are using common hosting you may find the parameters in an email you got after registrating on hosting provider's site.";
            
        	if ( !empty($notices) ) {
				$result .= "<br /><br />To ensure correct work of the system, you should consider these:<br /><div style='margin: 7px 0; font-style: italic; color: orange;'>" . join("<br />", $notices) . "</div>";
				$result .= "System can be installed but its functonality might be limited.";
			}
            
            $default_mysql_host = preg_match("~wind~i", php_uname()) ? '127.0.0.1' : 'localhost';
            $opt_html = "
            <div class='db'>
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
				</div>
            </div>
            <br style='clear: both;' />
            <br />
            Please provide desired access settings:<br />
            <br />
            <div id='settings'>
				<div class='email_form'>
					Administrator's email:<br />
					<input class='email' type='text' name='email' id='email_field' value='" . fx_post_get('email') . "' />
					<span id='email_valid' class='valid'></span>
				</div>
				<div class='pwd_create'>
					Enter user's password to access the administration system:<br />
					<input type='password' name='pwd' id='pwd_field' value='" . fx_post_get('pwd') . "' />
					<a href='#' id='pwd_gen' class='selected_tab'>generate password</a>
					<div>
						<input type='checkbox' name='show_pwd' value='1' id='show_pwd' onclick='document.getElementById(\"pwd_field\").type = (this.checked ? \"text\" : \"password\");' />
						<label for='show_pwd'>Show password</label>
					</div>
				</div>
			</div>";
            $result .= fx_html_form(2, 'Install Floxim', $opt_html);
        }
        else {
            $result = fx_html_status_bar(array("'color': 'red', 'opacity': 1", "There are some  problems!"), false, false);
            $result .= "<span style='font-style: italic; color: red;'><ul><li>" . join("</li><li>", $errors) . "</li></ul></span><br /><br />There are some issues that make using Floxim on your hosting impossible. If you can't solve them yourself describe the problems to system administrator or to support service. I hope you can solve the problems so we can complete the installation.";
            $result .= fx_html_form(1, 'Try again');
        }
        echo $result;
    break;
    case 2:
        fx_html_beg();
        fx_write_log("Installing distributive.");
        
        $errors = array();
        
        // Start checking DB params
        if (fx_post_get('host')):
			$LinkID = fx_connect_db();
			if (!$LinkID) {
				$errors['db_not_connected'] = "No connection with the indicated database. Check if all the access parameters are there and try again. MySQL error: " . mysql_error();
				fx_write_log("Error: " . $errors['db_not_connected']);
			}
			else {
				fx_write_log("Success: Connected to the database.");
				// get MySQL version from phpinfo()
				ob_start();
				phpinfo(INFO_MODULES);
				$info = ob_get_contents();
				ob_end_clean();
				$info = stristr($info, 'Client API version');
				preg_match('/[1-9].[0-9].[1-9][0-9]/', $info, $match);
				$mysql_ver = $match[0]; 
				// compare MySQL versions
				$mysql_traget_ver = "4.1.0";
				if (version_compare($mysql_ver, $mysql_traget_ver) == '-1') {
				    $errors['db_wrong_version'] = "MySQL version " . $mysql_ver . " is lower than required " . $mysql_traget_ver . ". Contact your system administrator or hosting provider to solve the problem.";
				    fx_write_log("Error: " . $errors['db_wrong_version']);
				}
				// check MySQL user permissions
				if (!fx_check_user_grants()) {
					$errors['db_wrong_user'] = "Indicated user haven't got permission to write to database. Is there any other user you can log in? Contact your system administrator or hosting provider to solve the problem.";
					fx_write_log("Error: " . $errors['db_wrong_user']);
				}
				// delete tables from the database
				$deltables = fx_post_get('deltables');
				if ($deltables) {
					$repeatTables = fx_repeat_tables();
					foreach ($repeatTables as $d_t) {
						$query = "DROP TABLE `" . $d_t . "`";
						fx_query($query);
					}
				}
				// check already installed tables into the database
				if (fx_repeat_tables()) {
					$errors['db_already_installed'] = "There are Floxim tables in the indicated database.";
					fx_write_log("Error: " . $errors['db_already_installed']);
					$result = fx_html_status_bar(array("'color': 'green', 'opacity': 1", "Everything is working fine!"), array("'color': 'red', 'opacity': 1", "There are some  problems!"), false);
					$result .= "<span style='font-style: italic; padding: 10pt; color: red;'>" . join("<br />", $errors) . "</span><br /><br />Indicated database already has the tables that installer is about to create. Do you want to delete them and continue installing?";
					$result .= fx_html_form(2, 'Delete and install', "<input type='hidden' id='deltables' name='deltables' value='1' />");
					echo $result;
					break;
				}
			}
		endif;
        
        if ( !( fx_post_get('pwd') && fx_post_get('email') ) ) {
            $errors['db_wrong_access_data'] = "System administrator's data were not entered. Go back and put them in.";
            fx_write_log("Error: " . $errors['db_wrong_access_data']);
        }
        
        if (!empty($errors)) {
			$result = fx_html_status_bar(array("'color': 'green', 'opacity': 1", "Everything is working fine!"), array("'color': 'red', 'opacity': 1", "There are some  problems!"), false);
			$result .= "<span style='font-style: italic; color: red;'><ul><li>" . join("</li><li>", $errors) . "</li></ul></span><br /><br />There are some issues that make using Floxim on your hosting impossible. If you can't solve them yourself describe the problems to system administrator or to support service. I hope you can solve the problems so we can complete the installation.";
			$result .= fx_html_form(1, 'Go back');
			echo $result;
			break;
		}
        
        echo fx_html_status_bar(array("'color': 'green', 'opacity': 1", "Everything is working fine!"), array("'color': 'green', 'opacity': 1", "All's going great!"), array("'color': '#444', 'opacity': 1", "Installing..."));
        
        echo "Installing may take from a few seconds up to several minutes depending on your server's capacity.<br />";
        echo "<ul>";
        echo "<li>Unpacking database...</li>";
        
        if ( !fx_install_db() ) {
            $errors['db_error'] = "A problem occurred when setting up databse.";
            fx_write_log("Error: " . $errors['db_error']);
            echo "</ul>";
            echo "<br />" . $errors['db_error'];
            echo fx_html_form(2, 'Try again');
            break;
        }
        
        fx_write_log("Success: Database unpacked.");
        
        echo "</ul>";

        // create config.php
        fx_write_config();
        
        // send email
        fx_mail_to_user($_SERVER['HTTP_HOST']);
        
        echo "<br />Hurray! Floxim installed, you can start working. Here are:<br />".
          "<ul>" .
          "<li>site address: <a href='http://" . $_SERVER['HTTP_HOST'] . "' target='_blank'>http://" . $_SERVER['HTTP_HOST'] . "</a></li>".
          "<li>Login for the <a href='http://" . $_SERVER['HTTP_HOST'] . "/floxim/'>back office</a>: <strong>" . fx_post_get('email') . "</strong></li>".
          "<li>Password: the one you've entered " . ( fx_post_get('email') ? "(and it's also in an email we've sent to <a href='mailto:" . fx_post_get('email') . "'>" . fx_post_get('email') . "</a>)" : "" ) . "</li>" .
          "</ul>" .
          "<br />" .
          "<em style='color: red;'>Make sure you've deleted install folder from server!</em>";
        
        #header("Location: /");
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
				<span id='item1'>Database and access</span><br />
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
    echo <<<HEREDOC
		</div>
    </div>
	<script>
		$(document).ready(function() {
			$(':input:visible').first().focus();
				
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
</html>
HEREDOC;
}

function fx_html_status_bar($array0 = array(), $array1 = array(), $array2 = array()) {
    $html = "<script>";
    for ($i = 0; $i < 3; $i++) {
		$html .=  (!empty(${"array" . $i}) && ${"array" . $i}[0] ? "$('#item" . $i . ", #status" . $i . "').css({" . ${"array" . $i}[0] . "});" : "")
			. (!empty(${"array" . $i}) && ${"array" . $i}[1] ? "$('#status" . $i . "').html('" . ${"array" . $i}[1] . "');" : "");
	}
    $html .= "</script>";
    
    return $html;
}

function fx_html_form($action, $button, $opt = '') {
    $html = "<form method='post' action='" . $_SERVER['SCRIPT_NAME'] . "' name='main_form' id='main_form' >";
    $html .= "<input type='hidden' name='action' id='action' value='" . $action . "' />";
    $params = array("host", "user", "dbname", "pass", "pwd", "email");
    foreach ($params as $param) {
        $html .= "<input type='hidden' name='" . $param . "' value='" . fx_post_get($param) . "' />";
    }
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
    else {
        return array_merge($_POST, $_GET);
    }
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
    if (!(fx_query($sql_create) && fx_query($sql_drop))) {
        $error = true;
    }
    if ($error) {
        return false;
    }
    else {
        return true;
    }
}

function fx_install_db() {
    fx_connect_db();
   
	$file_name = 'floxim.sql';
	$file = fx_fix_path( dirname(__FILE__) . '/' . $file_name );
	if ( file_exists($file) ) {
		if ( !fx_exec_sql($file) ) {
			fx_write_log('The system could be already installed: ' . $file);
			return false;
		}
	}
    
	fx_update_db();
	fx_write_log('Unpacking database finished.');

    return true;
}

function fx_update_db() {
	// update data
    $sql = array(
		"UPDATE `fx_site` SET `domain` = '" . mysql_real_escape_string($_SERVER['HTTP_HOST']) . "' WHERE `id` = 18",
		"UPDATE `fx_site` SET `domain` = '" . mysql_real_escape_string('alt.'.$_SERVER['HTTP_HOST']) . "' WHERE `id` = 1",
		"UPDATE `fx_content_user` SET `password` = '" 
                    .crypt($_SESSION['pwd'],  uniqid(mt_rand(), true))
                    . "', `email` = '" . mysql_real_escape_string( fx_post_get('email') ). "'",
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
        'fx_component', 
        'fx_content', 
        'fx_content_classifier', 
        'fx_content_classifier_linker', 
        'fx_content_comment', 
        'fx_content_contact', 
        'fx_content_linker', 
        'fx_content_mail_template', 
        'fx_content_message_template', 
        'fx_content_news', 
        'fx_content_page', 
        'fx_content_person', 
        'fx_content_photo', 
        'fx_content_product', 
        'fx_content_project', 
        'fx_content_publication', 
        'fx_content_section', 
        'fx_content_tag', 
        'fx_content_text', 
        'fx_content_user', 
        'fx_content_vacancy', 
        'fx_content_video', 
        'fx_datatype', 
        'fx_field', 
        'fx_filetable', 
        'fx_infoblock', 
        'fx_infoblock_visual', 
        'fx_lang', 
        'fx_lang_string', 
        'fx_layout', 
        'fx_module', 
        'fx_option', 
        'fx_patch', 
        'fx_patch_migration', 
        'fx_session', 
        'fx_settings', 
        'fx_site', 
        'fx_widget'
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
You\'ve installed Floxim on http://' . $path . '
Your authorised data to access the site: 
    - site address: http://' . $path . '
    - back-office: http://' . $path . '/floxim/
    - login: ' . $mail . '
    - password: ' . $pwd . '

Thank you for choosing Floxim! 

Best regards, 
Floxim Install Script';

    $headers = "Content-type: text/plain; charset=UTF-8 \r\n";
    $headers .= "From: info@{$_SERVER['SERVER_NAME']}\r\n";
    @mail($mail, $subject, $message, $headers);
}

function fx_write_log($message, $time = true) {
    $message_time = "";
    if ($time) {
        $message_time = date("H:i:s d.m.Y") . ' ';
        if (substr($message, -1) != '.') {
            $message = $message . '.';
        }
    }
    $result_str = PHP_EOL . $message_time . $message;
    $log_file = FX_FILES_DIR . "install_log.txt";
    if ( is_writable($log_file) ) {
		file_put_contents($log_file, $result_str, FILE_APPEND);
	}
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
$config = array(
    'dev' =>  array(
        'db.name' => '<?= $MYSQL_DB_NAME; ?>',
        'db.host' => '<?= $MYSQL_HOST; ?>',
        'db.user' => '<?= $MYSQL_USER; ?>',
        'db.password' => '<?= $MYSQL_PASSWORD; ?>',
        'dev.on' => true,
        'templates.ttl' => 0
    )
);
return $config['dev'];
<?
    return '<?' . PHP_EOL . PHP_EOL . ob_get_clean();
}

function fx_write_config() {
    $config_path = FX_CONFIG_FILE;
    // get config
    $cfg_file = fx_get_config( fx_post_get('host'), fx_post_get('user'), fx_post_get('pass'), fx_post_get('dbname') );
    // renew config data
    if (!file_exists($config_path) ||  is_writable($config_path) ) {
      file_put_contents($config_path, $cfg_file);
    } else {
		fx_write_log('Configuration file config.php unaccessible for recording. Add the required permissions on this file and repeat the installation.');
	}
}

function fx_fix_path($path) {
    $path = preg_replace('~[/\\\]~', '/', realpath($path));
    $path = rtrim($path, '/');
    return $path;
}