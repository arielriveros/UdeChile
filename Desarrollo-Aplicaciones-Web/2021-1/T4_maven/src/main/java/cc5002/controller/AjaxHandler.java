package cc5002.controller;
import com.mysql.cj.xdevapi.JsonArray;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;

public class AjaxHandler extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public AjaxHandler(){super();}
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
        JsonArray arr = new JsonArray();
    }
}
