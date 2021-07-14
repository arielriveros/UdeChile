package dcc.cc5002.model;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.sql.Date;
public class commentDB {

    private Connection conn;

    public commentDB(String db, String user, String pass) throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        this.conn = DriverManager.getConnection("jdbc:mysql://localhost/tarea2?" +
                "user=root&password=");

    }

    public ResultSet getData() throws SQLException {
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM comentario_foto");
        return rs;
    }

    public ResultSet getComentarios(int idfoto) throws SQLException {

        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT comentario FROM comentario_foto WHERE foto_bicho="+ String.valueOf(idfoto) + " ORDER BY id DESC");
        return rs;
    }

    public ResultSet getNotas(int idfoto) throws SQLException {
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT nota FROM comentario_foto WHERE foto_bicho="+ String.valueOf(idfoto));
        return rs;
    }

    public void close() throws SQLException {
        this.conn.close();
    }

    public void insertData(String comentario, int nota, int fotobicho) throws SQLException {
        LocalDateTime tiempo = LocalDateTime.now();
        PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO comentario_foto (fecha, comentario, nota, foto_bicho)" +
                        "VALUES (now(), ?, ?, ?)"

        );

        ps.setString(1, comentario);
        ps.setInt(2, nota);
        ps.setInt(3, fotobicho);
        ps.executeUpdate();
        this.close();
    }

}