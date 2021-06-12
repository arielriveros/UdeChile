#!/usr/bin/python3
# -*- coding: utf-8 -*-
import mysql.connector
import hashlib
utf8stdout = open(1, 'w', encoding='utf-8', closefd=False)
class Doctor:
    #def __init__(self, database="cc500209_db", host="localhost",  user="cc500209_u", password="usvestibul"):
    def __init__(self, database="cc500209_db", host="localhost",  user="root", password=""):
        self.db = mysql.connector.connect(
            host=host,
            user=user,
            password=password,
            database=database
        )
        self.cursor = self.db.cursor()

    #def save_doctor(self, data, fileObj):
    def save_doctor(self, data):
        """ fileName = fileObj.filename
        self.cursor.execute("SELECT COUNT(id) FROM archivo")
        total = self.cursor.fetchall()[0][0] + 1
        hashArchivo = str(total) + hashlib.sha256(fileName.encode()).hexdigest() 
        open('media/' + hashArchivo, 'wb').write(fileObj.file.read())
        sqlQuery = 'INSERT INTO archivo (nombre,file) values (%s,%s)'
        self.cursor.execute(sqlQuery, (fileName, hashArchivo))
        self.db.commit()
        id_foto = self.cursor.getlastrowid() """
        sqlQuery = """
        INSERT INTO `medico` (nombre,experiencia,especialidad,email,celular, fotoId)
        VALUES (%s,%s,%s,%s,%s,%s);
        """
        self.cursor.execute(sqlQuery, (*data, 1))
        self.db.commit()

    def get_doctors(self):
        #self.cursor.execute("SELECT medico.*, archivo.file FROM `medico` INNER JOIN archivo ON medico.fotoId = archivo.id ;")
        self.cursor.execute("SELECT medico.* FROM `medico`;")
        return self.cursor.fetchall()
        

    def create_medicoTable(self):
        self.cursor.execute(f"""
        CREATE TABLE `medico` (
            `id` INT NOT NULL AUTO_INCREMENT,
            `nombre` VARCHAR(20) NOT NULL,
            `experiencia` VARCHAR (1000) NOT NULL,
            `especialidad` VARCHAR(20) NOT NULL,
            `fotoId` INT NOT NULL,
            `email` VARCHAR(100) NULL,
            `celular` VARCHAR(100) NULL,
            PRIMARY KEY (`id`),
            FOREIGN KEY (fotoId) REFERENCES {self.db.database}.archivo(id))
        """)

    def create_archivoTable(self):
        self.cursor.execute("""
        create table archivo
            (
            	id int auto_increment,
            	nombre varchar(256) not null,
            	file varchar(256) not null,
            	primary key (id)
            );
        """)