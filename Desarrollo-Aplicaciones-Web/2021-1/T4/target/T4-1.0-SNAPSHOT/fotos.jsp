<%@ page import="cc5002.model.CommentsModel" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="style.css">
    <script src="js/commentsScripts.js"></script>
    <title>Animols</title>
</head>
<body>
<div class="main-container">
    <div class="navbar">
        <a href="./index.html"><button class="menu-button"> VOLVER </button></a>
    </div>
    <div class="photo-capsule">
        <div hidden id="details-img">
            <button onclick='enlargeImg("",false)'> Cerrar </button>
            <div id="details-img-photo"></div>

            <form class="comentario-form" name="fomulario" method="post" action="comments">
                <label for="comments"> Comentario </label>
                <textarea rows="10" cols="50" id="comments" name="comments"></textarea>
                <br>
                <label for="id-foto"> ID </label>
                <input disabled id="id-foto">
                <br>
                <p> Puntuación</p>
                <label for="score1"> 1 </label>
                <input type="radio" id="score1" name="score" value="1"><br><label for="score2"> 2 </label><input type="radio" id="score2" name="score" value="2"><br><label for="score3"> 3 </label><input type="radio" id="score3" name="score" value="3"><br><label for="score4"> 4 </label><input type="radio" id="score4" name="score" value="4"><br><label for="score5"> 5 </label><input type="radio" id="score5" name="score" value="5"><br><input type="submit" value="Enviar"></form>
        </div>
            <%
                try{
                    CommentsModel db = new CommentsModel("cc500209_db", "root", "");
                    ResultSet data = db.getData();
                    while(data.next()){
                        out.println("<div class='comment-container' onclick='loadComments("+data.getString(1)+",\""+data.getString(2)+data.getString(3)+"\",true)'><img width=\"120\" height=\"120\" src=\"" +data.getString(2)+data.getString(3) + "\"alt='Fotografia-animal'><br>");
                        out.println("</div>");
                    }
                } catch(Exception e){
                    System.out.println(e);
                }

            %>
        </div>

</div>
</body>
</html>