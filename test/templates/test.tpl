{config_load file='index.conf'}
{include file='foo.conf'}
{insert file='foo.tpl'}
<html>
{* testing comments *}
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
{if "test"}
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