package cc5002.model;
import java.sql.*;
import java.util.Calendar;
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
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM comentario_foto");
        ps.executeUpdate();
        ResultSet res = ps.executeQuery("SELECT * FROM comentario_foto");
        return res;
    }

    public void postComment(String comment_param, String score_param,  String id_param) throws SQLException{
        PreparedStatement ps = conn.prepareStatement("INSERT INTO comentario_foto (fecha, comentario, nota, foto_bicho) VALUES (?,?,?,?)");
        java.sql.Date sqlDate = new java.sql.Date(Calendar.getInstance().getTime().getTime());
        System.out.println(sqlDate);
        ps.setDate(1,sqlDate);
        ps.setString(2,comment_param);
        ps.setInt(3,Integer.parseInt(score_param));
        ps.setInt(4,Integer.parseInt(id_param));
        ps.executeUpdate();
        this.close();
    }
}
