{config_load file}
{"literal"}
{include file='foo.conf'}
{insert file='foo.tpl'}
<html>
{* testing comments *  }
{ * test comment *}
<title>{#pageTitle#}</title>
{$testing}
{$testing2}
{$test.foo.bar}
{$test[2]}
{$test[2].bar}
{$test->bar}
{$test($test)}
{$name|cat}
{$path|lower}
{if "test"|test:0}
{if $flag}
    //do this
    {elseif $flag2}
    // do this
    {else}
    // do this
{/if}

{foreach from=$foo item=bar}
    // foreach body
    {foreachelse}
    // foreachelse body
{/foreach}

<body bgcolor="{#bodyBgColor#}">
<table border="{#tableBorderSize#}" bgcolor="{#tableBgColor#}">
<tr bgcolor="{#rowBgColor#}">
    <td>First</td>
    <td>Last</td>
    <td>Address</td>
</tr>
<insert file="123">
</table>
</body>
</html>
{$foo[7]|test:3 $boo[3]}

{$foo.bar}
{$foo->bar}
{foo() foo () foo( )}
