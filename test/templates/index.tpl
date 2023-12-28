
{$headers}
{$page_title}
{$foo[3] + 3}
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
<HTML>Testing{* Wrong * }</HTML>
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