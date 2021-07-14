package cc5002.controller;
import cc5002.model.CommentsModel;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class CommentsServlet extends HttpServlet {
    public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException{
        req.setCharacterEncoding("UTF-8");
        String comment_param = req.getParameter("comment");
        String score_param = req.getParameter("score");

        //CommentsModel commentsModelObject = new CommentsModel(comment_param, score_param);
        CommentsModel commentsModelObject = null;
        try {
            commentsModelObject = new CommentsModel("cc500209_db", "root", "");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        commentsModelObject.postComment(comment_param, score_param);
        req.setAttribute("commentsHandler",commentsModelObject);
        req.getRequestDispatcher("fotos.jsp").forward(req,res);
    }
}
