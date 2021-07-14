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


public class fotoCommentsServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        String id = request.getParameter("id-foto");
        String path = request.getParameter("path-foto");

        commentDB commentDB = null;

        request.setAttribute("fotos", commentDB);
        request.setAttribute("id", id);
        request.setAttribute("path", path);
        request.getRequestDispatcher("choseAV.jsp").forward(request, response);

    }


}