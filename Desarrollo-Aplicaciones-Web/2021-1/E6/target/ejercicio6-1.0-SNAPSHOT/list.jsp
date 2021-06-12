<%--
  Created by IntelliJ IDEA.
  User: ariel
  Date: 05-06-2021
  Time: 18:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.cc5002.ejercicio6.Doctor" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- HTML5 -->
<html lang="es">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="utf-8" /> <!-- Declaring enconding as UTF 8-->
    <title>Auxiliar 8</title> <!-- Title in pestaña -->
    <link rel="stylesheet" type="text/css" media="screen"  href="css/index.css" />    <!-- CSS: -->

</head>
<body>


<ul class="topnav">
    <li><a class="active" href="index.html">Inicio</a></li>
    <li><a href="add_new_doctor.html">Agregar Datos de Médico</a></li>
    <li><a href="list.html">Ver Médicos</a></li>
</ul>
<div>
    <!-- Body of page -->
    <h1> Ver Médicos </h1>

    <table >
        <% Doctor medico = (Doctor) request.getAttribute("medico"); %>
        <tr>
            <th>Nombre Médico</th>
            <th>Especialidades</th>
            <th>Experiencia</th>
            <th>Localidad</th>
            <th>Datos Contacto</th>
        </tr>
        <tr>
            <td><% out.println(medico.getNombre());%></td>
            <td><% out.println(medico.getEspecialidad());%></td>
            <td><% out.println(medico.getExp());%></td>
            <td>
                <% out.println(medico.getComuna());%> <br>
                <% out.println(medico.getRegion());%>
            </td>
            <td>
                <% out.println(medico.getEmail());%> <br>
                <% out.println(medico.getTwitter());%> <br>
                <% out.println(medico.getCelular());%>
            </td>
        </tr>

        <%--
        <tr>
            <th>Nombre Médico</th>
            <th>Especialidades</th>
            <th>Comuna</th>
            <th>Datos Contacto</th>
        </tr>
        <!-- First row -->
        <tr>
            <td><a href="medico_jorge_p1.html">Jorge Pérez</a></td>
            <td>Neurología</td>
            <td>Santiago Centro</td>
            <td>jorgeperez@medicina.cl <br>
                @JorgePerez___ <br>
                569 95770936
            </td>
        </tr>
        <!-- Second row -->
        <tr>
            <td>Lucho Matthei</td>
            <td>Cardiología, Gastroenterología</td>
            <td>Ñuñoa</td>
            <td>luismate@yahoo.cl <br>
                569 99370977
            </td>
        </tr>

        <tr>
            <td>Elverto Presli</td>
            <td>Infectología, Epidemiología</td>
            <td>Padre Las Casas</td>
            <td>no.estoy.muerto@hotmail.com <br>

            </td>
        </tr>

        <tr>
            <td>Fulano Kodric</td>
            <td>Psiquiatría</td>
            <td>Chillán</td>
            <td>kodrikc@gmail.com <br>

            </td>
        </tr>

        <tr>
            <td>Juan Cuevas</td>
            <td>Medicina de urgencias, Traumatología</td>
            <td>Concepción</td>
            <td>jcuevas85@gmail.com <br>
                569 97112233

            </td>
        </tr>
    --%>
    </table>
</div>

</body>
</html>

