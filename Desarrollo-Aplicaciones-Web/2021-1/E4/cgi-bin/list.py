#!/usr/bin/python3
# -*- coding: utf-8 -*-
# METADATA
import cgi
import cgitb
import db
cgitb.enable()
utf8stdout = open(1, 'w', encoding='utf-8', closefd=False)
print("Content-type: text/html\r\n\r\n")
# END METADATA

medicos = db.Doctor()
lista = medicos.get_doctors()
response = print("No hay médicos registrados") if lista == [] else [print(f"""
<ul>
    <li> Nombre: {i[1]} </li>
    Experiencia: {i[2]}
    <br>
    Especialidad: {i[3]}
    <br>
    Foto: <img style="{{height:120px;width:120px}}"  src='../media/{i[7]}' alt='imagen'></img>
    <br>
    Email: {i[5]}
    <br>
    Celular: {i[6]}
    <br>
</ul>""") for i in lista]