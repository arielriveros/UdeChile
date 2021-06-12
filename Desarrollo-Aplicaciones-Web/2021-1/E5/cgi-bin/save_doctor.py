#!/usr/bin/python3
# -*- coding: utf-8 -*-
# METADATA
import cgi
import cgitb
import html
import codecs
import filetype
import db
cgitb.enable()
utf8stdout = open(1, 'w', encoding='utf-8', closefd=False)
print("Content-type: text/html; charset=UTF-8\r\n\r\n")
# END METADATA
medicos = db.Doctor()
form = cgi.FieldStorage()
data = map(lambda i: form[i].value , ['nombre-medico','experiencia-medico','especialidad-medico','email-medico','celular-medico'])
medicos.save_doctor(data)
print(" <html><body><h3> Los datos fueron enviados correctamente</h3> </body></html> ")
