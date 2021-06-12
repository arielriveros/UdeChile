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


def formatter(rawList):
    jsonString = '['
    for i in rawList:
        jsonString += '{'
        jsonString += f'''"nombre": "{i[0]}", "email": "{i[1]}", "celular": "{i[2]}","region": "{i[3]}", "comuna": "{i[4]}", "sector": "{i[5]}", "fecha": "{i[6]}", "tipo": "{i[7]}", "estado":"{i[8]}"'''
        jsonString += '},'
    jsonList = list(jsonString)
    jsonList[-1] = ']'
    return "".join(jsonList)


avistamiento = db.Avistamiento()
avists = avistamiento.download()
print(formatter(avists))