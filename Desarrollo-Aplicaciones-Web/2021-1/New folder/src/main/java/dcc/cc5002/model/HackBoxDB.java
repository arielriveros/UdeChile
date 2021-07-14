package dcc.cc5002.model;

import java.sql.*;

public class HackBoxDB {

    private Connection conn;

    public HackBoxDB(String db, String user, String pass) throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        this.conn = DriverManager.getConnection("jdbc:mysql://localhost/hackbox?" +
                "user=root&password=");

    }

    public ResultSet getData() throws SQLException {
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM hackbox");
        return rs;
    }

    public void close() throws SQLException {
        this.conn.close();
    }

    public void insertData(String name, String lastname, String epic) throws SQLException {
        PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO hackbox (nombre, apellido, epic)" +
                        "VALUES (?, ?, ?)"

        );
        ps.setString(1, name);
        ps.setString(2, lastname);
        ps.setString(3, epic);
        ps.executeUpdate();
        this.close();
    }
}
