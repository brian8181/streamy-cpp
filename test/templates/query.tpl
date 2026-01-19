<form name="search_form" onsubmit="return on_query_submit(search_form)" action="results.php" method="get">
	<div style="text-align: center">
		<div style="text-align: center">
			<h3>Search For:  </h3>
		</div>
		<input type="text" name="album" align="right"value="{* $txtSearch *}"/>
		<input type="hidden" name="artist" />
		<input type="hidden" name="title" />
		<input type="hidden" name="file" />
		<input type="hidden" name="genre" />
		<input type="hidden" name="comments" />
		<input type="hidden" name="lyrics" />
		<input type="hidden" name="and" value="false" />
		<input type="hidden" name="order_by" value="{#default_order#}" />
		<input type="submit" value="Search" />
		in fields 
		{* TODO assing listOption in PHP *}
		{assign var=listOption value='0'}
		<select name="listOption" size="0">
			<option value="0"{if $listOption == "0"} selected="yes"{/if}>All</option>
			<option value="1"{if $listOption == "1"} selected="yes"{/if}>Title</option>
			<option value="2"{if $listOption == "2"} selected="yes"{/if}>Album</option>
			<option value="3"{if $listOption == "3"} selected="yes"{/if}>Artist</option>
			<option value="4"{if $listOption == "4"} selected="yes"{/if}>File</option>
			<option value="5"{if $listOption == "5"} selected="yes"{/if}>Lyrics</option>
		</select>
		use wildcards:
		<input name="wildcard" type="checkbox" value="on"{if isset($wildcard)} checked="yes"{/if}/>
	</div>
</form>