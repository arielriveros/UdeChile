#!C:\Users\ariel\AppData\Local\Programs\Python\Python39\python.exe

import cgi

print("Content-type: text/html\r\n\r\n")

form = cgi.FieldStorage()

print('''
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" href="ejercicio3.css">
        <script src="ejercicio3.js"></script>
        <title>Ejercicio 3</title>
    </head>
    
<body>

<h1> Arma tu Pizza!</h1>

<div id="container">

</div>

</body>
</html>
''')