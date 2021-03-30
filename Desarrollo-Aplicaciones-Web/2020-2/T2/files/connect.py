#!C:\Users\ariel\AppData\Local\Programs\Python\Python39\python.exe
import mysql.connector
import cgi

class connection:
    def __init__(self, host, usr, pwd, db):
        self.db = mysql.connector.connect(
            host = self.host,
            user = self.user,
            password = self.password,
            database = self.database
            )
        self.cursor = db.cursor()
    def upload_domicilio(self, data):
        query = ''' 
        INSERT INTO domicilio (fecha_ingreso, comuna_nombre_calle, numero, sector, nombre_contacto, email, celularfecha_ingreso, comuna_nombre_calle, numero, sector, nombre_contacto, email, celular) 
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s);
        '''
        self.cursor.execute(query, data)
    