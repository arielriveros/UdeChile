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


def arrayFormatter(rawList):
    arr = [0 for i in range(12)]
    for i in rawList:
        arr[i[0]-1] = i[1]
    return arr

avistamiento = db.Avistamiento()
dataVivo = arrayFormatter(avistamiento.fetch_grafico3_data('vivo'))
dataMuerto = arrayFormatter(avistamiento.fetch_grafico3_data('muerto'))
dataNoSabe = arrayFormatter(avistamiento.fetch_grafico3_data('no sé'))

outStr = '[{"name":"vivo","data":'+str(dataVivo)+'},{"name":"muerto","data":'+str(dataMuerto)+'},{"name":"no se","data":'+str(dataNoSabe)+'}]'
print(outStr)