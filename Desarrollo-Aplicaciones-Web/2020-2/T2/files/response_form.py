#!C:\Users\ariel\AppData\Local\Programs\Python\Python39\python.exe
import connect.py


print("Content-type: text/html\r\n\r\n")

db = connection("localhost","root","","tarea2")
form = cgi.FieldStorage()
data_domicilio = (
    form['fecha_ingreso'].value, 
    form['comuna_nombre_calle'].value, 
    form['numero'].value,
    form['sector'].value, 
    form['nombre_contacto'].value, 
    form['email'].value, 
    form['celular'].value)
db.upload_domicilio(data_domicilio)


html = '''
    <!DOCTYPE html>
<!--suppress ALL -->
<head>

</head>


<body>

<div class="main">

    

        Su mensaje informacion se guardo con exito!!!

    

</div>



</body>


</html>
'''
print(html)