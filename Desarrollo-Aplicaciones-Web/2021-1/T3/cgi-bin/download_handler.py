#!/usr/bin/python3
# -*- coding: utf-8 -*-
# METADATA
import cgi
import cgitb
import db
import filetype
cgitb.enable()
utf8stdout = open(1, 'w', encoding='utf-8', closefd=False)
print("Content-type: application/json \r\n\r\n")
#print("Content-type: text/plain ; charset=utf-8 \r\n\r\n")
# END METADATA

#fotos: ["./media/insecto1"]}, 
#fotos: "["./media/aracnido1","./media/aracnido1"]"}]

def photoListFormatter(rawList):
    jsonString = '['
    for i in rawList:
        jsonString+=f'''"{i[0]}{i[1]}"'''
        jsonString+=","
    jsonList = list(jsonString)
    if jsonList[-1] == ',' : jsonList[-1] = ']'
    if jsonList[-1] == '[' : jsonList = '[]'
    return "".join(jsonList)

def formatter(rawList):
    jsonString = '['
    for i in rawList:
        rawFotos = avistamiento.getPhotoPath(i[1])
        fotos = photoListFormatter(rawFotos)
        jsonString += '{'
        jsonString += f'''"nombre": "{i[2]}","email": "{i[3]}","celular": "{i[4]}","region": "{i[6]}","comuna": "{i[7]}","sector": "{i[8]}","fecha": "{i[5]}","tipo": "{i[9]}","estado":"{i[10]}", "fotos": {fotos}'''
        jsonString += '},'
    jsonList = list(jsonString)
    if jsonList[-1] == ',' : jsonList[-1] = ']'
    if jsonList[-1] == '[' : jsonList = '[]'
    return "".join(jsonList)


avistamiento = db.Avistamiento()
avists = avistamiento.download()


print(formatter(avists))