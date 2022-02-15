// sets "ORDER BY" sting when header is clicked
function on_header_click(link, order) 
{
	var qs = new Querystring();
	var order = qs.get("order_by");
	var cols = order.split(",");
	var pair = cols[0].split(" ");
	var ret;
	
	var name = new String(link.name);
	if(name == pair[0])
	{
		if( pair[1] == "ASC" )
			ret = order.replace("ASC", "DESC", "gi");
		else
			ret = order.replace("DESC", "ASC", "gi");
	}
	else
	{
		order = "";
		for( var i in cols )
		{
			pair = cols[i].split(" "); 
			if(pair[0] == link.name)
				continue;
			order += cols[i] + ",";	
		}
		order = order.substr( 0, order.length-1 );
		ret = link.name +  " ASC," + order;
	}
	link.href += "&order_by=" + ret;
}
function on_quick_submit(form) 
{
	form.elements['artist'].value = form.elements['album'].value;
	form.elements['title'].value = form.elements['album'].value;
}
/* create a search string form from data */
function on_query_submit(form)  // intialize all values
{
	var search_string = form.elements['album'].value;
	var option = form.elements['listOption'].value;
	form.elements['album'].value = "";
	if(search_string.length > 1)
	{
		switch(option)
		{
		case "0":  // ALL
			form.elements['album'].value = search_string;
			form.elements['artist'].value = search_string;
			form.elements['title'].value = search_string;
			break;
		case "1": // Title
			form.elements['title'].value = search_string;
			break;
		case "2": // Album
			form.elements['album'].value = search_string;
			break;
		case "3": // Artist
			form.elements['artist'].value = search_string;
			break;
		case "4": // File
			form.elements['file'].value = search_string;
			break;
		case "5": // File
			form.elements['lyrics'].value = search_string;
			break;	
		default:
			return false;
		}
	}
	else
	{
		return false;
	}
	return true;
}
/* trim space from left */
function lTrim(sString)
{
	while (sString.substring(0,1) == ' ')
	{
		sString = sString.substring(1, sString.length);
	}
	return sString;
}
/* trim space from right */
function rTrim(sString)
{
	while (sString.substring(sString.length-1, sString.length) == ' ')
	{
		sString = sString.substring(0,sString.length-1);
	}
	return sString;
}