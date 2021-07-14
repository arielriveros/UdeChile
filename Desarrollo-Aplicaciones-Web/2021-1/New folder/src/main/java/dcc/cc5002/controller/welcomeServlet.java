package dcc.cc5002.controller;

import dcc.cc5002.model.HackBoxDB;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;


public class welcomeServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");

        HackBoxDB hackbox = null;

        request.setAttribute("welcome", hackbox);
        request.getRequestDispatcher("photos.jsp").forward(request, response);

    }


}