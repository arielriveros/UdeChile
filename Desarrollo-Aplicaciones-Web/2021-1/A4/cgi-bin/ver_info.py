#!/usr/bin/python3
# -*- coding: utf-8 -*-

from save_data import HackBoxDatabase

print("Content-type: text/html\r\n\r\n")


hbdb = HackBoxDatabase("root", "")
data = hbdb.get_all('usuario')

head = '''
    <!DOCTYPE html>
<!--suppress ALL -->
<head>
    <meta charset="UTF-8">
    <title>Hackbox</title>
    <link rel="stylesheet" type="text/css" href="../estilo.css">
    <script src="validador.js"></script>
    <style>
table {
  font-family: arial, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

td, th {
  border: 1px solid #dddddd;
  text-align: left;
  padding: 8px;
}

tr:nth-child(even) {
  background-color: #dddddd;
}
</style>
</head>
'''
b1 = '''
<body>

<div class="menu entrada">

    <div class="entrada">
        <a href="https://google.cl">Home</a>
    </div>

    <div class="entrada">
        <a href="https://hackbox.html">Favoritos</a>
    </div>

    <div class="entrada" style="border-right: 0">
        <a href="ljfklsd">Configuraciones</a>
    </div>

</div>

<div class="titulo negrita">Hackbox</div>
<div class="main">

    

        <table>
        <tr>
    <th>Nombre</th>
    <th>Edad</th>
    <th>Comentario </th>
'''
print(head)
print(b1)
for d in data:
    row = f'''
            <tr>
                <th>{str(d[1])}</th>
                <th>{str(d[2])}</th>
                <th>{str(d[3])}</th>
            </tr>
        '''
    print(row)
  
b2='''
</table>
    

</div>

<div id="error">Este es un mensaje de error</div>

</body>


</html>
'''
print(b2)
