/* 
    ------------------------------------------------------------------------
    Modified by Danie Bruwer  2008/08/06
    http://dotnet.org.za/danieb    
    ------------------------------------------------------------------------
    Original File :
    http://adamv.com/dev/javascript/querystring
    Client-side access to querystring name=value pairs
	Version 1.3
	28 May 2008	
	License (Simplified BSD):
	http://adamv.com/dev/javascript/qslicense.txt	
*/
function Querystring(qs) { // optionally pass a querystring to parse
	this.params = {};
	this.keys = new Array();
	this.path = (qs && qs.indexOf('?') > 0) ? qs.split('?')[0] : location.protocol +location.host + location.pathname;
	
	if (qs == null) qs = location.search.substring(1, location.search.length);	
	if (qs.length == 0) return;
	if (qs.indexOf('?') > 0)
	    qs = qs.split('?')[1];

// Turn <plus> back to <space>
// See: http://www.w3.org/TR/REC-html40/interact/forms.html#h-17.13.4.1
	qs = qs.replace(/\+/g, ' ');
	var args = qs.split('&'); // parse out name/value pairs separated via &
	
// split out each name=value pair
	for (var i = 0; i < args.length; i++) {
		var pair = args[i].split('=');
		var name = decodeURIComponent(pair[0]);
		
		var value = (pair.length==2)
			? decodeURIComponent(pair[1])
			: name;
			
		this.keys[i] = name;
		this.params[name] = value;
	}		
}
	
Querystring.prototype.get = function(key, default_) {
	var value = this.params[key];
	return (value != null) ? value : default_;
}
Querystring.prototype.set = function(key, value) {
    value = encodeURI(value);
	this.params[key] = value;
	var index = this.indexOfKey(key);
	if(index < 0)	
	    this.keys[this.keys.length] = key;	
}
Querystring.prototype.indexOfKey = function(key) {
	for (var i = 0; i < this.keys.length; i++) 
    {
        if(this.keys[i] == key)
            return i;
    }
    return -1;
}
Querystring.prototype.remove = function(key) {
	var index = this.indexOfKey(key);
	if(index >= 0)
	{
	    this.params[key] = null;
	    this.keys.splice(index,1);
	    return true;
	}
	return false;
}
Querystring.prototype.toString = function() {
    var ret = "";
    for (var i = 0; i < this.keys.length; i++) 
    {
        if(this.keys[i])
            ret += ((i == 0) ? "?" : "&") + this.keys[i] + "=" + this.params[this.keys[i]];
    }
    return ret;
}
Querystring.prototype.getAbsolutePath = function() {
    return this.path;
}
Querystring.prototype.toAbsoluteUrl = function() {
   return this.path + this.toString();
}

Querystring.prototype.contains = function(key) {
	var value = this.params[key];
	return (value != null);
}