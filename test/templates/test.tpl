{config_load file='foo.conf'}
{include file='foo.conf'}
{insert file='foo.tpl'}
<html>
{* testing comments *}
<title>{#pageTitle#}</title>
{$testing}
{$testing2}
{if $flag}
    //do this
    {elseif $flag2}
    // do this
    {else}
    // do this
{/if}
<body bgcolor="{#bodyBgColor#}">
<table border="{#tableBorderSize#}" bgcolor="{#tableBgColor#}">
<tr bgcolor="{#rowBgColor#}">
    <td>First</td>
    <td>Last</td>
    <td>Address</td>
</tr>
</table>
</body>
</html>