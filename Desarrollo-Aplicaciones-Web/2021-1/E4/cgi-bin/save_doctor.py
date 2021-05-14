#!/usr/bin/python3
# -*- coding: utf-8 -*-
# METADATA
import cgi
import cgitb
import filetype
import db
cgitb.enable()
utf8stdout = open(1, 'w', encoding='utf-8', closefd=False)
print("Content-type: text/html\r\n\r\n")
# END METADATA

medicos = db.Doctor()
form = cgi.FieldStorage()
data = map(lambda i: form[i].value , ['nombre-medico','experiencia-medico','especialidad-medico','email-medico','celular-medico'])
fileObj = form['foto-medico']
tipo = filetype.guess(fileObj.file)
if not fileObj.filename:
    print('Foto vacia')
elif not 'image/' in tipo.mime:
    print(f'Archivo no es una imagen: {fileObj.filename}, {tipo}')
else:
    medicos.save_doctor(tuple(data),fileObj)
    print(" <html><body><h3> Los datos fueron enviados correctamente</h3> </body></html> ")
