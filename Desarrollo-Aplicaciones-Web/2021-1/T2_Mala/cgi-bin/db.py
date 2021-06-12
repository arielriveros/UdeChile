#!/usr/bin/python3
# -*- coding: utf-8 -*-
import mysql.connector
import sys
sys.stdout = open(sys.stdout.fileno(), mode='w', encoding='utf8', buffering=1)
# END METADATA

class Avistamiento:
    #def __init__(self, user="cc500209_u", password="usvestibul", database="cc500209_db", host="localhost"):
    def __init__(self, user="root", password="", database="cc500209_db", host="localhost"):
        self.db = mysql.connector.connect(host=host, user=user, password=password, database=database)
        self.cursor = self.db.cursor()
    def upload(self, comuna, data, detalle, fotos):
        sqlComuna = f"SELECT id FROM comuna WHERE nombre='{comuna}';"
        self.cursor.execute(sqlComuna)
        comuna_id = (self.cursor.fetchall())[0][0]
        sqlQuery = "INSERT INTO avistamiento (dia_hora, sector, nombre, email, celular, comuna_id) VALUES (%s,%s,%s,%s,%s,%s)"
        data += (comuna_id,)
        self.cursor.execute(sqlQuery, data)
        self.db.commit()
        id_avistamiento = self.cursor.getlastrowid()
        sqlDetalle = "INSERT INTO detalle_avistamiento (dia_hora, tipo, estado, avistamiento_id) VALUES (%s, %s, %s, %s);"
        detalle += (id_avistamiento, )
        self.cursor.execute(sqlDetalle, detalle)
        self.db.commit()
        id_detalle = self.cursor.getlastrowid()
        for i in fotos:
            sqlFoto = "INSERT INTO foto (ruta_archivo, nombre_archivo, detalle_avistamiento_id) VALUES (%s, %s, %s);"
            datosFotos = ('../media/', 'caca', id_detalle)
            self.cursor.execute(sqlFoto, datosFotos)
            self.db.commit()
    def download(self):
        sql = "SELECT AV.nombre, AV.email, AV.celular, DA.dia_hora,RE.nombre, CO.nombre, AV.sector,  DA.tipo, DA.estado FROM avistamiento AV, detalle_avistamiento DA, region RE, comuna CO WHERE DA.avistamiento_id = AV.id AND AV.comuna_id=CO.id ORDER BY DA.dia_hora ASC LIMIT 5"
        self.cursor.execute(sql)
        avistamientos = self.cursor.fetchall()
        return avistamientos