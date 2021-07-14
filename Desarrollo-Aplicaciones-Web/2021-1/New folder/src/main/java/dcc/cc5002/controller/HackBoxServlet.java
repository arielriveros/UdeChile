package dcc.cc5002.controller;

import dcc.cc5002.model.HackBoxDB;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;


public class HackBoxServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        String name = request.getParameter("nombre");
        String lastname = request.getParameter("apellido");
        String epic = request.getParameter("epic");

        HackBoxDB hackbox = null;
        try {
            hackbox = new HackBoxDB("hackbox", "root", "");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        try {
            hackbox.insertData(name, lastname, epic);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

        request.setAttribute("hackbox", hackbox);
        request.getRequestDispatcher("mostrar_informacion.jsp").forward(request, response);

    }


}