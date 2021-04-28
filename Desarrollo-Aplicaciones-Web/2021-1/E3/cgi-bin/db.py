#!/usr/bin/python3
# -*- coding: utf-8 -*-
import mysql.connector

class Doctor:
    def __init__(self, database="cc500209_db", host="localhost",  user="cc500209_u", password="usvestibul"):
        self.db = mysql.connector.connect(
            host=host,
            user=user,
            password=password,
            database=database
        )
        self.cursor = self.db.cursor()

    def save_doctor(self, data):
        sqlQuery = """
        INSERT INTO `medico` (nombre,experiencia,especialidad,email,celular)
        VALUES (%s,%s,%s,%s,%s);
        """
        self.cursor.execute(sqlQuery, data)
        self.db.commit()

    def get_doctors(self):
        self.cursor.execute("SELECT * FROM `medico`;")
        return self.cursor.fetchall()