package cc5002.model;
import java.sql.*;
public class CommentsModel {
    private Connection conn;
    public CommentsModel(String database, String user, String password) throws ClassNotFoundException, SQLException{
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = String.format("jdbc:mysql://localhost:3306/%s?user=%s&password=%s", database,user,password);
        this.conn = DriverManager.getConnection(url);
    }

    public void close() throws SQLException{
        this.conn.close();
    }

    public ResultSet getData() throws SQLException{
        Statement stmt = conn.createStatement();
        ResultSet res = stmt.executeQuery("SELECT id, ruta_archivo, nombre_archivo FROM foto;");
        return res;
    }
    public ResultSet getComments() throws SQLException{
        Statement stmt = conn.createStatement();
        ResultSet res = stmt.executeQuery("SELECT comentario, nota,fecha FROM comentario_foto WHERE foto_bicho=320;");
        return res;
    }

    public void postComment(String comment_param, String score_param) {
    }
}
