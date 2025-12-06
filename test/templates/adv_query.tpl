<center>
<form action="results.php" method="get">
<table>
	<tr>
		<td>Artist:&nbsp;</td>
		<td><input type="text" name="artist" value="{if isset($artist)}{$artist}{/if}" /></td>
	</tr>
	<tr>
		<td>Album:&nbsp;</td>
		<td><input type="text" name="album" value="{if isset($album)}{$album}{/if}" /></td>
	</tr>
	<tr>
		<td>Title:&nbsp;</td>
		<td><input type="text" name="title" value="{if isset($title)}{$title}{/if}" /></td>
	</tr>
	<tr>
		<td>Genre:&nbsp;</td>
		<td><input type="text" name="genre" value="{if isset($genre)}{$genre}{/if}" /></td>
	</tr>
	<tr>
		<td>Year:&nbsp;</td>
		<td><input type="text" name="year" value="{if isset($year)}{$year}{/if}" /></td>
	</tr>
	<tr>
		<td>File:&nbsp;</td>
		<td><input type="text" name="file" value="{if isset($file)}{$file}{/if}" /></td>
	</tr>
	<tr>
		<td>Comments:&nbsp;</td>
		<td><input type="text" name="comments" value="{if isset($comments)}{$comments}{/if}" /></td>
	</tr>
	<tr>
		<td>Lyrics:&nbsp;</td>
		<td><input type="text" name="lyrics" value="{if isset($lyrics)}{$lyrics}{/if}" /></td>
	</tr>
	<tr>
		<td colspan="2"><br />
		<div align="center">
		<fieldset>
		<legend>Boolean Modifier</legend>
			All&nbsp;<i>(AND)</i>&nbsp;<input type="radio" name="and" value="true" 
			{if !isset($and) || $and=="true"}"checked="checked"{/if}/>
			Any<i>&nbsp;(OR)</i>&nbsp;<input type="radio" name="and" value="false" 
			{if isset($and) && $and=="false" } "checked="checked" {/if} />
		</fieldset>
		</div>
		</td>
	</tr>
</table>
<br />
<input type="submit" value="Search" />&nbsp;&nbsp;
Use&nbsp;wildcards:&nbsp;<input name="wildcard" type="checkbox" value="on"{if isset($wildcard)}"checked="checked"{/if}/>
<br />
</form>
</center>