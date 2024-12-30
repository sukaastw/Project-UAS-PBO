package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnectionManager {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/rencaruas";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    // Memastikan koneksi hanya dibuat satu kali
    private static Connection connection;

    public static Connection getConnection() {
        if (connection == null) {
            try {
                connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return connection;
    }

    public static void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
