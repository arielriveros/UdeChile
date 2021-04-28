#!/usr/bin/python3
# -*- coding: utf-8 -*-


import mysql.connector

db = mysql.connector.connect(
  host="localhost", # 127.0.0.1
  user="root",
  password="",
  database="hackbox"
)

cursor = db.cursor()

cursor.execute('''
        CREATE TABLE usuario (
            id int(10) unsigned NOT NULL AUTO_INCREMENT,
            nombre VARCHAR(255), 
            edad INT(10),
            comentario TEXT(1000),
            PRIMARY KEY (id)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8;    
    '''
)

print("La tabla se creo con éxito!")