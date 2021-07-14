#!/usr/bin/python3
# -*- coding: utf-8 -*-
# METADATA
import cgi
import cgitb
import db
import json
import filetype
cgitb.enable()
utf8stdout = open(1, 'w', encoding='utf-8', closefd=False)
print("Content-type: application/json \r\n\r\n")
# END METADATA




avistamiento = db.Avistamiento()
data = avistamiento.comunasConAvistamientos()
output = {'comunas':data}
print(json.dumps(output, ensure_ascii=False))