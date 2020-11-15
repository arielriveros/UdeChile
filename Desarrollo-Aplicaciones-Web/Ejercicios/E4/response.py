#!"C:\Users\ariel\AppData\Local\Programs\Python\Python39\python.exe"
import pymysql.cursors
import cgi
import os
import cgitb; cgitb.enable(display=0, logdir='.') 
import sys
from io import TextIOWrapper
sys.stdout = TextIOWrapper(sys.stdout.buffer.detach(), encoding='utf8')


print("Content-type: text/html\r\n\r\n")

form = cgi.FieldStorage()
dataBase = pymysql.connect(host='localhost',
                            user='root',
                            password='',
                            db='ejercicio4_db',
                            charset='utf8',
                            autocommit=True,
                            cursorclass=pymysql.cursors.DictCursor)

cursor = dataBase.cursor()

datos = (form['nombre'].value,
         form['telefono'].value,
         form['direccion'].value,
         form['comuna'].value,
         form['masa'].value,
         form['ingrediente'].value,
         form['comentario'].value
         )

filename = ''
archivo = form['cupon']
filename = archivo.filename

sql = """INSERT INTO `pedido` (nombre, telefono, direccion, comuna, tipp_masa, ingrediente, comentario)
    VALUES (%s,%s,%s,%s,%s,%s,%s);"""

cursor.execute(sql,datos)
print('''
<!DOCTYPE html>
<!--suppress ALL -->
<head>
<meta charset="UTF-8"/>
<title>Picsa con Pecsi</title>
</head>
<body>

<div>

Información ingresada correctamente 

</div>
''')

if filename != '':
    if '.pdf' in filename and filename != '': 
        fn = os.path.basename(filename) 
        open(fn, 'wb').write(archivo.file.read())
        sqlarchivo = """ 
        UPDATE `pedido`
        SET cupon = %s
        WHERE id = LAST_INSERT_ID();
        """
        cursor.execute(sqlarchivo,filename)
    else:
        htmlcupon = '''
                    <div>
                        El archivo debe ser un PDF.

                    <script>
                        setTimeout(function () {
                            window.location.href = "ejercicio4.html" 
                        }, 2000); //will call the function after 2 secs.
                    </script>
                    </body>
                    '''
        print(htmlcupon)

print('''

</body>
</html>
''')

