package com.cc5002.ejercicio6;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;


public class SaveDoctor extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String nombre = request.getParameter("nombre-medico");
        String exp = request.getParameter("experiencia-medico");
        String region = request.getParameter("region-medico");
        String comuna = request.getParameter("comuna-medico");
        String especialidad = request.getParameter("especialidades-medico");
        String twitter = request.getParameter("twitter-medico");
        String email = request.getParameter("email-medico");
        String celular = request.getParameter("celular-medico");

        Doctor medico = new Doctor(nombre, exp, region, comuna, especialidad, twitter, email, celular);

        request.setAttribute("medico", medico);
        request.getRequestDispatcher("list.jsp").forward(request,response);

    }

}