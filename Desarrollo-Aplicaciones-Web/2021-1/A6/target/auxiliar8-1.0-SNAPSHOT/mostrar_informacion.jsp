<%@ page import="cc5002.model.HackBox" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<meta charset="UTF-8">
<title>Hackbox</title>

<!-- comentarios -->
<style>
    /* comentario */
    body {
        font-size: 20px;
        font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial,
        sans-serif, Apple Color Emoji, Segoe UI Emoji;
        margin: 0;
    }

    .titulo {
        text-align: center;
        font-size: 50px;
        margin-top: 5%;
    }

    .negrita {
        font-weight: 800;
    }

    @media screen and (max-width: 600px) {
        .negrita {
            font-size: 15px;
        }
    }

    #main {
        background-color: #d2d2d2;
        width: 50%;
        margin-left: 25%;
        padding: 25px;
        margin-top: 5%;
        border-radius: 15px;
        box-shadow: #00000012 0 0 5px 6px;
    }

    .leyenda {
        width: 20%;
        display: inline;
        margin-right: 10px;
    }

    input {
        padding: 5px;
        width: 30%;
    }

    .entrada {
        margin-bottom: 5px;
    }


</style>


</head>


<body>

<div class="titulo negrita ">Hackbox epic</div>


<div id="main">

    <% HackBox hackbox = (HackBox) request.getAttribute("hackbox"); %>

    <p><% out.println(hackbox.getNombre()); %></p>
    <p><% out.println(hackbox.getApellido()); %></p>
    <p><% out.println(hackbox.getSelect()); %></p>
</div>

</body>


</html>