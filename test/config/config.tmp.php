<?php
include_once("version.php");

/////////////////////////////////////////////////
// Server:                                     //
/////////////////////////////////////////////////
$server_address = "<server_address>";
$email = "<email>";
// page pointed to by home on index page (may be itself or another page)
$web_home = "/index.php";

/////////////////////////////////////////////////
// Database:                                   //
/////////////////////////////////////////////////
$db_name = "music";
$db_address = "localhost";
$db_user_name = "web";
$db_password = "<db_password>";

/////////////////////////////////////////////////
// Admin Database:                             //
/////////////////////////////////////////////////
$admin_db_name = $db_name;
$admin_db_address = $db_address;
$admin_db_user_name = $db_user_name;
$admin_db_password = $db_password;

/////////////////////////////////////////////////
// Customization:                              //
/////////////////////////////////////////////////
$site_name = "Music Web";
$style = "style.css";

////  Directory Locations ///////////////////////
//    art location, relative to document root
$art_location = "./.album_art";
// music location, relative to document root
$music_location = "/music";

////////////////////////////////////////////////////
// Informational Stings:                          //
// Server admin information, these do not affect  //
// actual functionality but they are disaplyed.   //
////////////////////////////////////////////////////
$mail_message = "for further information please email us @";
// global version
$version_date = "Sunday July 20 4:37 AM CDT 2008";
$index_title = "Music Database";
$search_title = "Search Database";
$advanced_title = "Advanced Search";
$results_title = "Search Results";
$details_title = "Song Details";

///////////////////////////////////////////////////
// Options:                                      //
///////////////////////////////////////////////////
$enable_advanced = true;
$enable_statistics = true;
$enable_quick_search = true;
$enable_playlist = false;
$enable_logging = false;
// this features are not implemented and should remain off (false)
$enable_browse = false;
$enable_security = false;
// 0 or less = umlimited
$page_result_limit = 0;
$default_order = "artist ASC,album ASC,track ASC,title ASC";

?>