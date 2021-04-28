#!/usr/bin/python3
# -*- coding: utf-8 -*-
# METADATA
import cgi
import cgitb
cgitb.enable()
utf8stdout = open(1, 'w', encoding='utf-8', closefd=False)
print("Content-type: text/html\r\n\r\n")
# END METADATA

html_head = " <html><body><h3> Los datos fueron enviados correctamente </h3> "    
html_end = "</body></html> "
form = cgi.FieldStorage()
print(html_head, file=utf8stdout)
for key in form.keys():
    print("<p>" + key + ": " + form[key].value + "</p>", file=utf8stdout)
print(html_end, file=utf8stdout)