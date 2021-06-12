#!/usr/bin/python3
# -*- coding: utf-8 -*-
# METADATA
import cgi
import cgitb
import db
import json
cgitb.enable()
utf8stdout = open(1, 'w', encoding='utf-8', closefd=False)
print("Content-type: application/json\r\n\r\n")
# END METADATA

medicos = db.Doctor()
lista = medicos.get_doctors()
if lista == []: print("EMPTY")
else:
    print(json.dumps(lista))
