<?php

define('SMARTY_DIR', '/var/www/html/music_web_super_lite/smarty/');
define('PROJECT_DIR', '/var/www/html/music_web_super_lite/'); 

$smarty_compile_check = true;
$smarty_debugging = true;

/////////////////////////////////////////////////
// Server:                                     //
/////////////////////////////////////////////////
$server_address = "127.0.0.0";
$admin_email = "brian8181@gmail.com";
// page pointed to by home on index page (may be itself or another page)
$web_home = "/index.php";

////  Database //////////////////////////////////
$db_name = "music";
$db_address = "localhost";
$db_user_name = "web";
$db_password = "";

////  Customization /////////////////////////////
$site_name = "Music Web";
$style = "blue.css";

// 0 or less = umlimited
$page_result_limit = 0;
$default_order = "artist ASC,album ASC,track ASC,title ASC";
	
	?>