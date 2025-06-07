<div class="left">
<table class="info">
<tr>
	<th style="text-align: left">Name</th>
	<th style="text-align: center">Count</th>
</tr>
{foreach from=$result item=row}
<tr>
<td style="text-align: left"><a href="./view_playlist.php?pid={$id}&nav_row=0&order_by={$default_order}">{$name}</a><br /></td>
<td style="text-align: center"><em>{$count}</em></td>
</tr>
{/foreach}
