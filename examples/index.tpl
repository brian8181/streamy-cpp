<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<title>{$page_title|default:'Default'}</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="shortcut icon" href="./favicon.png" />
	<link rel="stylesheet" type="text/css" href="./css/blue.css" />
	<script src="./script/functions.js" type="text/javascript"></script>
{* extra headers *}
{if isset($headers)}
{$headers}
{/if}
</head>
<body>
<div class="text_area">
<div class="box" style="text-align: center">
<h1>{$page_title|default:'Default'}</h1>
</div>

{$body}
Version is {$version}
{$version_date}
{* this is a comment *}

form name="search_form" onsubmit="return on_query_submit(search_form)" action="results.php" method="get">
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

<br />
<div style="text-align: center">
<a class="NoColor" href="http://validator.w3.org/check?uri=referer">
	<img src="./image/valid-xhtml10-blue.png" alt="Valid XHTML 1.0 Transitional" height="31" width="88" align="middle" />
</a>
</div>

<br />
{* contact info *}
<div style="text-align: center">
	{#mail_message#}
	<br />
	<a href="mailto:{#admin_email#}?subject=Web Password">{#admin_email#}</a>
	{$admin_email}
	{$version}
	{$version_date}
    {* this is a comment *}
</div>
<br />
<span style="font-size: smaller;"><em>Version {#version#} {#version_date#} ~(Copyright &#169; 2008)</em></span>
</div>
</body>
</html>
