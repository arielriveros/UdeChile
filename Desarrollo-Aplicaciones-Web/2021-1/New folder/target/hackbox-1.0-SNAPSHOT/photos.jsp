<%@ page import="dcc.cc5002.model.HackBoxDB" %>
<%@ page import="dcc.cc5002.model.fotoDB" %>
<%@ page import="dcc.cc5002.model.commentDB" %>

<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<meta charset="UTF-8">
<title>Registro de avistamientos - Ratings de imagenes</title>

<!-- comentarios -->
<style>
    /* comentario */
    body {
        background-color: #D0FCB3;
        font-size: 20px;
        font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial,
        sans-serif, Apple Color Emoji, Segoe UI Emoji;
        margin: 0;
    }

    .negrita {
        font-weight: 800;
    }

    .titulo {
        text-align: center;
        font-size: 50px;
        margin-top: 5%;
        color: #9BC59D;
    }

    .leyenda {
        font-weight: 800;
        width: 20%;
        display: inline;
        margin-right: 100px;
        font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial,
        sans-serif, Apple Color Emoji, Segoe UI Emoji;
        color: #6C5A49;
    }

    .formSect {
        font-weight: 800;
        width: 20%;
        font-size: 35px;
        display: inline;
        font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial,
        sans-serif, Apple Color Emoji, Segoe UI Emoji;
        color: #046B00;
    }

    .subtitulo {
        font-weight: 800;
        font-size: 25px;
        text-align: center;
        font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial,
        sans-serif, Apple Color Emoji, Segoe UI Emoji;
        color: #9BC59D;
    }

    .index {
        font-weight: 800;
        margin-left: 40px;
        margin-top: 15px;
        font-size: 40px;
        text-align: left;
        font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial,
        sans-serif, Apple Color Emoji, Segoe UI Emoji;
        color: #9BC59D;
    }

    .hypertext {
        font-weight: 800;
        font-size: 15px;
        font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial,
        sans-serif, Apple Color Emoji, Segoe UI Emoji;
        color: #9BC59D;
    }

    .parent {
        display: flex;
        margin-top: 8px;
        justify-content: center;
        align-items: center;
        gap: 60px;
    }

    table, th, td {
        margin-top: 20px;
        border-collapse: collapse;
        width: 1200px;
        border: 4px solid ;
        margin-left: auto;
        margin-right: auto;
        border-color:#9BC59D;
        background: white;
        font-weight: 800;
        font-size: 20px;
        text-align: center;
        font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial,
        sans-serif, Apple Color Emoji, Segoe UI Emoji;
        color: #9BC59D;
    }

    #main {
        background-color: #a3e6e4;
        width: 50%;
        margin-left: 25%;
        padding: 25px;
        margin-top: 5%;
        border-radius: 15px;
        box-shadow: #a3e6e4 0 0 5px 6px;
    }

    .leyenda {
        font-weight: 800;
        width: 20%;
        display: inline;
        margin-right: 10px;
        font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial,
        sans-serif, Apple Color Emoji, Segoe UI Emoji;
        color: #9BC59D;
    }

    input {
        font-weight: 600;
        padding: 5px;
        width: 30%;
        margin-left: 15px;
        font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial,
        sans-serif, Apple Color Emoji, Segoe UI Emoji;
        color: #9BC59D;
        display:table;
        margin-left: 10px;



    }


    .entrada {
        font-weight: 600;
        margin-bottom: 5px;
        font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial,
        sans-serif, Apple Color Emoji, Segoe UI Emoji;
        color: #9BC59D;
        margin-left: 10px;


    }
    textarea {
        font-weight: 600;
        margin-bottom: 5px;
        font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial,
        sans-serif, Apple Color Emoji, Segoe UI Emoji;
        color: #9BC59D;
        display: table;
        margin-left: 10px;

    }



    button {font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial,
    sans-serif, Apple Color Emoji, Segoe UI Emoji;
        border:none;
        background-color:transparent;
        width: 120px;
        height: 120px;
        margin-bottom: 100px;
        margin-right: 80px;
        margin-left: 80px;
    }

    .icon {
        width: 0.5em;
        height: 0.5em;
        fill: red;
        vertical-align: top;
    }

    .flex-container {
        flex-direction:row;
        display: -webkit-flex;
        display: flex;
        background-color: grey;
        width: 100%;
        height: 100px;
        align-content: center;
        flex-flow: row wrap;
    }

    .flex-item {
        background-color: lightblue;
        width: 40%;
        height: 100px;
        margin: 10px;
        order: 4;
    }

    img {
        width: 120px;
        height: 120px;
        border: 1px solid #000;
        margin-bottom: 100px;
        margin-right: 80px;
        margin-left: 80px;
    }

    form{
        width: 120px;
        height: 120px;
        margin-bottom: 100px;
        margin-right: 80px;
        margin-left: 80px;
    }


     .form_wrapper {
         width: 25%; /* the width of half of your space or 50% */
         float: left;
     }
</style>



</head>


<body>

<div class="titulo negrita ">Registro de Avistamientos - Rating de imagenes</div>
<div class="subtitulo">Imagenes del registro ordenadas desde la más reciente</div>
<div class="subtitulo" style="margin-bottom: 30px">Haga click en cualquier imagen para ver su nota promedio, comentarios. Puede añadir nueva nota y comentario</div>



    <%
        try{

            fotoDB fdb = new fotoDB("tarea2", "user", "");
            ResultSet data = fdb.getData();

            int contador = 0;
            while(data.next()){
                if(contador ==0){
                    out.println("<div class=\"form_wrapper\">");
                    out.println("<form method=\"post\" action=\"fotos\">");
                    out.println("<input type=\"hidden\" name=\"id-foto\" value="+data.getString(1)+">");
                    out.println("<input type=\"hidden\" name=\"path-foto\" value="+data.getString(2)+">");
                    out.println("<button type=submit><img src=" + data.getString(2) + " alt= "+ data.getString(3) + "></button></form>");
                    out.println("</div>");
                }

                else{
                    out.println("<div class=\"form_wrapper\">");
                    out.println("<form method=\"post\" action=\"fotos\">");
                    out.println("<input type=\"hidden\" name=\"id-foto\" value="+data.getString(1)+">");
                    out.println("<input type=\"hidden\" name=\"path-foto\" value="+data.getString(2)+">");
                    out.println("<button type=submit><img src=" + data.getString(2) + " alt= "+ data.getString(3) + "></button></form>");
                    out.println("</div>");
                }

                contador +=1;

                if (contador==4){
                    out.println("<br>");
                    contador=0;
                }


            }

        } catch(Exception e){
            System.out.println(e);
        }



    %>





</body>


</html>