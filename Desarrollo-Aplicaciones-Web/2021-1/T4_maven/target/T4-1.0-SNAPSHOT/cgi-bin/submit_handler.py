#!/usr/bin/python
# -*- coding: utf-8 -*-
# METADATA
import cgi
import cgitb
import db
import filetype
import hashlib
import time
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

def checkImage(imgFile): # True si es una imagen
    auxFile = imgFile
    tipo = filetype.guess(auxFile.file)
    if tipo:
        if tipo.mime.find('image') == 0:
            return True
    else:
        return False
    
def saveImages(img):
    nombresFotos = []
    if not isinstance(img, list):
        imgList = [img,]
    else:
        imgList = img
    for foto in imgList:
        if checkImage(foto):
            newName = hashlib.sha256(foto.filename.encode()).hexdigest()[0:16]
            with open('./media/fotos/'+newName,'wb') as outputFile:
                outputFile.write(foto.file.read())
            nombresFotos.append(newName)
    return nombresFotos

multipleInput = isinstance(region, list) or isinstance(comuna, list) or isinstance(fecha, list)
if multipleInput:
    numAvistamientos = max(len(region), len(comuna), len(fecha))
else:
    numAvistamientos = 1

if multipleInput is True:
    for i in range(numAvistamientos):
        data = (fecha[i].value, sector[i].value, nombre, email, celular)
        detalle = (fecha[i].value, tipo[i].value, estado[i].value)
        formFoto = form[f'foto-avistamiento-${i}']
        lista = saveImages(formFoto)
        time.sleep(2)
        avistamiento.upload(comuna[i].value, data, detalle, lista)
else:
    data = (fecha.value, sector.value, nombre, email, celular)
    detalle = (fecha.value, tipo.value, estado.value)
    formFoto = form['foto-avistamiento-0']
    lista = saveImages(formFoto)
    time.sleep(2)
    avistamiento.upload(comuna.value, data, detalle, lista)
        
#print(f'<html><meta http-equiv="refresh" content="0;url=../index.html" /> Datos enviados exitosamente </html>')

################## T E S T I N G ##################
