package cc5002.controller;
import cc5002.model.CommentsModel;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class CommentsServlet extends HttpServlet {
    private static final long serialVersionUID = 102831973239L;
    public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException{
        req.setCharacterEncoding("UTF-8");
        String comment_param = req.getParameter("comment");
        String score_param = req.getParameter("score");
        String id_param = req.getParameter("id-foto");

        //CommentsModel commentsModelObject = new CommentsModel(comment_param, score_param);
        CommentsModel commentsModelObject = null;
        try {
            commentsModelObject = new CommentsModel("cc500209_db", "root", "");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        try {
            commentsModelObject.postComment(comment_param, score_param,id_param);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        req.setAttribute("comments",commentsModelObject);
        req.getRequestDispatcher("fotos.jsp").forward(req,res);
    }
}
