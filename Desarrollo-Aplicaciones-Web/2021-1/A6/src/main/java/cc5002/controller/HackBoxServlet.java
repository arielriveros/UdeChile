package cc5002.controller;

import cc5002.model.HackBox;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;


public class HackBoxServlet extends HttpServlet {


    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String name = request.getParameter("nombre");
        String pass = request.getParameter("apellido");
        String select = request.getParameter("epic");

        HackBox hackbox = new HackBox(name, pass, select);

        request.setAttribute("hackbox", hackbox);
        request.getRequestDispatcher("mostrar_informacion.jsp").forward(request, response);

    }


}