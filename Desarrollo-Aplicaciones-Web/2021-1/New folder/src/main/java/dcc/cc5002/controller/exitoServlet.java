package dcc.cc5002.controller;

import dcc.cc5002.model.HackBoxDB;
import dcc.cc5002.model.fotoDB;
import dcc.cc5002.model.commentDB;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;


public class exitoServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        int id = Integer.valueOf(request.getParameter("foto-id"));
        int nota = Integer.valueOf(request.getParameter("calificacion"));
        String comentario = request.getParameter("comentario");

        commentDB commentDB = null;
        try {
            commentDB = new commentDB("tarea2", "root", "");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        try {
            commentDB.insertData(comentario, nota, id);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

        request.setAttribute("exito", commentDB);
        request.getRequestDispatcher("exito.jsp").forward(request, response);

    }
}


