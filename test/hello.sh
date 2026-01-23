#!/bin/bash
# Send the required HTTP header
echo "Content-type: text/html"
echo ""

# Output the body of the page
echo "<html><head><title>CGI Bash Example</title></head>"
echo "<body>"
echo "<h1>Hello from a Bash CGI script!</h1>"
echo "<p>Current Server Time: $(date)</p>"
echo "<p>System Hostname: $(hostname)</p>"
echo "</body></html>"
