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
# END METADATA


def formatter(rawList):
    jsonString = '['
    for i in rawList:
        jsonString += '{'
        jsonString += f'''"name": "{i[0]}","y": {i[1]}'''
        jsonString += '},'
    jsonList = list(jsonString)
    if jsonList[-1] == ',' : jsonList[-1] = ']'
    if jsonList[-1] == '[' : jsonList = '[]'
    return "".join(jsonList)


avistamiento = db.Avistamiento()
data = avistamiento.fetch_grafico2_data()
print(formatter(data))