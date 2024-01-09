<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<title>{$page_title|default:'Default'}</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="shortcut icon" href="./favicon.png" />
	<link rel="stylesheet" type="text/css" href="./css/blue.css" />
	<script src="./script/functions.js" type="text/javascript"></script>
{* extra headers *}
{if isset($headers)}
{$headers}
{/if}
</head>
<body>
<div class="text_area">
<div class="box" style="text-align: center">
<h1>{$page_title|default:'Default'}</h1>
</div>

{$headers}
{#testing#}
{$page_title}
{$foo[3] + 3}
{$x <= $y}
{$x >= $y}
{$x != $y}
{$x % $y}
{$x % 3}
{$z > 3.5}
{$x == 5.2 0.1 .3}
{$a == 0x20, $b == 0x3aaFF, $c == 0xFF}
{/if}
{*TEWST*}
BB 
testing
{$body} test 
{$admin_email}
CCCC
VERSION ->{$version}
WWWW
**{$version_date}**
{* extra headers *}
{if isset($headers)}
<HTML>Testing{* Wrong *}</HTML>
<HTML>{* Right *}</HTML?
{8 Right 8}
<BODY>{$foo}</BODY>
{$boo.}
{$boo->}
{$citys[3]}
<H1>{#static#}</H1>
{include file="text.txt"}
{config_load file="text.txt"}
{insert file="test.txt"}
{$foo.foo == true}
{$foo->foo}
{$foo.foo()}
{$foo->foo()}
{$foo.$boo}
{$foo->$boo}
{$boo } 
{$hoo $doo}
{insert file="test.html"}
{insert file="test.html"}
{include file="test.html"}
{$num|truncate}
{$num|upper}
