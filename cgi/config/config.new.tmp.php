<?php

define('SMARTY_DIR', 'C:\\<SMARTY EXAMPLE PATH>\\');
define('PROJECT_DIR', 'C:\\<PROJECT EXAMPLE PATH>\\'); 

$smarty_compile_check = true;
$smarty_debugging = true;

/////////////////////////////////////////////////
// Server:                                     //
/////////////////////////////////////////////////
$server_address = "<server_address>";
$admin_email = "<email>";
// page pointed to by home on index page (may be itself or another page)
$web_home = "/index.php";

////  Database //////////////////////////////////
$db_name = "music";
$db_address = "localhost";
$db_user_name = web;
$db_password = "<db_password>";

////  Customization /////////////////////////////
$site_name = "Music Web";
$style = "blue.css";

// 0 or less = umlimited
$page_result_limit = 0;
$default_order = "artist ASC,album ASC,track ASC,title ASC";
	
	?>