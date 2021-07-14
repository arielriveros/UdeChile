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
data = avistamiento.fetch_grafico1_data()

c = []
f = []
for i in data:
    c.append(str(i[0]))
    f.append(i[1])

output = {'categoria': c, 'fecha': f}
print(json.dumps(output, ensure_ascii=False))