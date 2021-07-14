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
        color: #5D737E;
        font-weight: 800;
        margin-left: 30%;
        background-color: #64b6ac;
        cursor: pointer;
        padding: 15px;
        margin-top: 5%;
        border-radius: 10px;
        border-color: #64b6ac ;

    }

    select{font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial,
    sans-serif, Apple Color Emoji, Segoe UI Emoji;
        color: #9BC59D;
        font-weight: 600;
        display: table;
        margin-left: 10px;
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
        width: 600px;
        height: 800px;
        border: 1px solid #000;
        margin-right: 1em;
        margin-left: 680px;
        margin-top: 120px;
    }



</style>


</head>


<body>

<div class="titulo negrita ">Rating de imagenes</div>


<%

    String path = request.getAttribute("path").toString();

    String id = request.getAttribute("id").toString();

    out.println("<img src=" + path + " alt="+id+ ">");


%>


<div id="main">


        <form method="post" action="exito">

            <div class="entrada">

                <div class="leyenda">Comentario</div>

                <textarea name="comentario" id= "Comentario" rows="10" cols="50" placeholder="Escriba sus comentarios aquí"></textarea>

            </div>

            <div class="entrada">

                <div class="leyenda">Calificación</div>

                <select name="calificacion">
                    <option>0</option>
                    <option>1</option>
                    <option>2</option>
                    <option>3</option>
                    <option>4</option>
                    <option>5</option>
                    <option>6</option>
                    <option>7</option>

                </select>

            </div>

            <%

                out.println("<input id=\"photo-Id\" name=\"foto-id\" type=\"hidden\" value="+id+">");

            %>

            <div class="boton">
                <button type="submit">Enviar formulario</button>
            </div>
        </form>

    </div>

<div class="titulo" style="margin-top: 80px; margin-bottom: 50px">Rating promedio de la imagen</div>


<%
    try{

        commentDB fdb = new commentDB("tarea2", "user", "");
        ResultSet data = fdb.getNotas(Integer.valueOf(id));

        int prom = 0;
        int i = 0;
        while(data.next()){
            // id out.println("<p>"+data.getString(1)+"</p>");
            // path out.println("<p>"+data.getString(2)+"</p>");
            // name out.println("<p>"+data.getString(3)+"</p>");
            prom = prom + Integer.valueOf(data.getString(1));
            i++;
        }


        if(i==0){
            out.println("<div class=\"subtitulo\">No hay notas ingresadas para este avistamiento</div>");
        }
        else{
            int promedio = prom/i;
            out.println("<div class=\"subtitulo\">"+promedio+"</div>");
        }

    } catch(Exception e){
        System.out.println(e);
    }



%>


<div class="titulo" style="margin-top: 80px; margin-bottom: 50px">Comentarios más recientes</div>


<%
        try{

            commentDB fdb = new commentDB("tarea2", "user", "");
            ResultSet data = fdb.getComentarios(Integer.valueOf(id));

            int i = 0;
            while(data.next()){
                // id out.println("<p>"+data.getString(1)+"</p>");
                // path out.println("<p>"+data.getString(2)+"</p>");
                // name out.println("<p>"+data.getString(3)+"</p>");
                out.println("<div class=\"subtitulo\">" + data.getString(1) +"</div>");
                i++;
            }

            if(i==0){
                out.println("<div class=\"subtitulo\">No existen comentarios ingresados para este avistamiento</div>");
            }

        } catch(Exception e){
            System.out.println(e);
        }



    %>

<form method="post" action="welcome">
    <button style="margin-left: 900px" type="submit">Volver a las imagenes</button>
</form>

</div>

</body>


</html>