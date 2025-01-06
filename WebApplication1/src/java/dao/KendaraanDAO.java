package dao;

import model.Kendaraan;
import dao.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

public class KendaraanDAO {
    private static final Logger LOGGER = Logger.getLogger(KendaraanDAO.class.getName());

    private Connection getConnection() throws SQLException {
        return DatabaseConnection.getConnection();
    }

    public List<Kendaraan> getAllKendaraan() {
        List<Kendaraan> kendaraanList = new ArrayList<>();
        String sql = "SELECT * FROM kendaraan";

        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Kendaraan kendaraan = new Kendaraan(
                        rs.getString("nomor_polisi"),
                        rs.getString("merek"),
                        rs.getString("jenis"),
                        rs.getInt("stok"),
                        rs.getDouble("harga"),
                        rs.getString("status")
                );
                kendaraanList.add(kendaraan);
            }
        } catch (SQLException e) {
            LOGGER.severe("Database error: " + e.getMessage());
            e.printStackTrace();
        }

        return kendaraanList;
    }

    public void addKendaraan(Kendaraan kendaraan) {
        String sql = "INSERT INTO kendaraan (nomor_polisi, merek, jenis, stok, harga, status) VALUES (?, ?, ?, ?, ?, ?)";
        LOGGER.info("Executing query: " + sql);

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, kendaraan.getNomorPolisi());
            ps.setString(2, kendaraan.getMerek());
            ps.setString(3, kendaraan.getJenis());
            ps.setInt(4, kendaraan.getStok());
            ps.setDouble(5, kendaraan.getHarga());
            ps.setString(6, kendaraan.getStatus());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                LOGGER.info("Data berhasil ditambahkan: " + kendaraan.getNomorPolisi());
            } else {
                LOGGER.warning("Data tidak berhasil ditambahkan: " + kendaraan.getNomorPolisi());
            }
        } catch (SQLException e) {
            LOGGER.severe("Database error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}