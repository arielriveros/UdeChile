#!/usr/bin/python3
# -*- coding: utf-8 -*-
import mysql.connector
import sys
sys.stdout = open(sys.stdout.fileno(), mode='w', encoding='utf8', buffering=1)
# END METADATA

class Avistamiento:
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
        self.uploadPhoto(fotos, id_detalle)
    def download(self):
        sql = """ SELECT AV.id, DA.id, AV.nombre, AV.email, AV.celular, DA.dia_hora,RE.nombre, CO.nombre, AV.sector,  DA.tipo, DA.estado
                    FROM avistamiento AV, detalle_avistamiento DA, region RE, comuna CO
                    WHERE DA.avistamiento_id = AV.id AND AV.comuna_id=CO.id AND RE.id=CO.region_id ORDER BY AV.id DESC """
        self.cursor.execute(sql)
        avistamientos = self.cursor.fetchall()
        return avistamientos
    def uploadPhoto(self, fotos, id_detalle):
        for i in fotos:
            sqlFoto = "INSERT INTO foto (ruta_archivo, nombre_archivo, detalle_avistamiento_id) VALUES (%s, %s, %s);"
            datosFotos = ('./media/fotos/', i, id_detalle)
            self.cursor.execute(sqlFoto, datosFotos)
            self.db.commit()
    def getPhotoPath(self,id):
        sql = f'SELECT ruta_archivo, nombre_archivo FROM foto WHERE detalle_avistamiento_id = {id}'
        self.cursor.execute(sql)
        fotos = self.cursor.fetchall()
        return fotos
    def fetch_grafico1_data(self):
        sql = "SELECT DATE(dia_hora) as 'dia',  COUNT(DISTINCT id) as 'avistamientos' FROM detalle_avistamiento GROUP BY dia ORDER BY dia;"
        self.cursor.execute(sql)
        return self.cursor.fetchall()
    def fetch_grafico2_data(self):
        sql = "SELECT tipo as 'tipo', COUNT(tipo) as 'count' FROM detalle_avistamiento GROUP BY tipo;"
        self.cursor.execute(sql)
        return self.cursor.fetchall()
    def fetch_grafico3_data(self,estado):
        sql = f"SELECT MONTH(dia_hora) as mes, count(estado) as 'count' FROM detalle_avistamiento WHERE estado='{estado}' group by mes;"
        self.cursor.execute(sql)
        return self.cursor.fetchall()
    def comunasConAvistamientos(self):
        sql = "SELECT DISTINCT(CO.nombre), COUNT(FO.id) FROM foto FO,avistamiento AV, detalle_avistamiento DA,comuna CO WHERE AV.comuna_id=CO.id AND FO.detalle_avistamiento_id = DA.id AND DA.avistamiento_id=AV.id GROUP BY comuna_id;"
        self.cursor.execute(sql)
        return self.cursor.fetchall()