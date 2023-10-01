{config_load file='foo.conf'}
{include file='foo.conf'}
<html>
{* testing comments *}
<title>{#pageTitle#}</title>
{$testing}
{$testing2}
{if $flag}
{else}
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