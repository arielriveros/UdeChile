#!/usr/bin/python3
# -*- coding: utf-8 -*-
# METADATA
import cgi
import cgitb
import db
import filetype
cgitb.enable()
utf8stdout = open(1, 'w', encoding='utf-8', closefd=False)
print("Content-type: text/html\r\n\r\n")
# END METADATA

avistamiento = db.Avistamiento()
form = cgi.FieldStorage()

nombre = form['nombre'].value
celular = form['celular'].value
email = form['email'].value
sector = form['sector']
region = form['region']
comuna = form['comuna']
fecha = form['dia-hora-avistamiento']
tipo = form['tipo-avistamiento']
estado = form['estado-avistamiento']

multipleInput = isinstance(region, list) or isinstance(comuna, list) or isinstance(fecha, list)
if multipleInput:
    numAvistamientos = max(len(region), len(comuna), len(fecha))
else:
    numAvistamientos = 1

test = ''

if multipleInput is True:
    for i in range(numAvistamientos):
        data = (fecha[i].value, sector[i].value, nombre, email, celular)
        detalle = (fecha[i].value, tipo[i].value, estado[i].value)
        fotos = form.getlist(f'foto-avistamiento-${i}')
        test += f'{fotos}'
        avistamiento.upload(comuna[i].value, data, detalle, fotos)
else:
    data = (fecha.value, sector.value, nombre, email, celular)
    detalle = (fecha.value, tipo.value, estado.value)
    fotos = form.getlist('foto-avistamiento-0')
    test += f'{fotos}'
    avistamiento.upload(comuna.value, data, detalle, fotos)
        

print(f'<html><body> <h3> Hemos recibido su informacion, muchas gracias por colaborar </h3> <div> <a href="../index.html"><button type="button"> Volver a inicio </button> </a></div></body></html>')