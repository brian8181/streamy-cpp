<h1>{$headers}</h1>
{$page_title}
{* extra headers *}
{if isset($headers)}
<HTML>Testing{* Wrong *}</HTML>
<HTML>{* Right *}</HTML?
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