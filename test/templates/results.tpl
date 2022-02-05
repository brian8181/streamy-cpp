<center><a href="{$back}"><b>Back To Search</b></a></center>
<br />
<script src="./script/querystring.enhanced.js" type="text/javascript"></script>
<script src="./script/functions.js" type="text/javascript"></script>
<br /><br /><b>Showing {$start_number} - {$end_number} of {$total}</b>
{* The Result Table *}
<table id="result">
<tr class="header_row">
<th align="center">
	<a class="{if $clicked == "track"}yellow_white{else}white_yellow{/if}"
	name="track" onclick="on_header_click(this)" 
	href="{$query}">
	Track
	</a>
</th>
<th align="center">
	<a class="{if $clicked == "title"}yellow_white{else}white_yellow{/if}"
	name="title" onclick="on_header_click(this)"
	href="{$query}">
	Title
	</a>
</th>
<th align="center">
	<a class="{if $clicked == "album"}yellow_white{else}white_yellow{/if}"
	name="album" onclick="on_header_click(this)" 
	href="{$query}">
	Album
	</a>
</th>
<th align="center">
	<a class="{if $clicked == "artist"}yellow_white{else}white_yellow{/if}"
	name="artist" onclick="on_header_click(this)" 
	href="{$query}&clicked=artist">
	Artist
	</a>
</th>
<th>&nbsp;</th>
</tr>
{* The Result Rows *}
{foreach from=$result item=row}
<tr id="table_row">
<td>{$row.track}</td>
<td>
    {$row.title}
</td>
<td>
    <a href="results.php?album={$row.album}&amp;order_by=artist,album,track,title">{$row.album}</a>
</td>
<td>
    <a href="results.php?artist={$row.artist}&amp;order_by=artist,album,track,title">{$row.artist}</a>
</td>
<td align='center'>
	<a href="{#music_location#}{$row.song_file}">download</a>
</td>
</tr>
{/foreach}
</table>
{include file="nav_links.tpl"}
