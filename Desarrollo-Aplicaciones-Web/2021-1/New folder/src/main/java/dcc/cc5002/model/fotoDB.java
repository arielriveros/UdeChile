package dcc.cc5002.model;

import java.sql.*;

public class fotoDB {

    private Connection conn;

    public fotoDB(String db, String user, String pass) throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        this.conn = DriverManager.getConnection("jdbc:mysql://localhost/tarea2?" +
                "user=root&password=");

    }

    public ResultSet getData() throws SQLException {
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM foto ORDER BY id desc");
        return rs;
    }

    public void close() throws SQLException {
        this.conn.close();
    }



}