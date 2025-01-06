package dao;

import model.Peminjaman;
import model.Kendaraan;
import dao.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

public class PeminjamanDAO {
    private static final Logger LOGGER = Logger.getLogger(PeminjamanDAO.class.getName());

    private Connection getConnection() throws SQLException {
        return DatabaseConnection.getConnection();
    }

    public void addPeminjaman(Peminjaman peminjaman) {
        String sql = "INSERT INTO peminjaman (nik, nama, no_hp, alamat, jenis_mobil, harga, tanggal_sewa, tanggal_kembali, nomor_polisi) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        LOGGER.info("Executing query: " + sql);

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, peminjaman.getNik());
            ps.setString(2, peminjaman.getNama());
            ps.setString(3, peminjaman.getNoHp());
            ps.setString(4, peminjaman.getAlamat());
            ps.setString(5, peminjaman.getJenisMobil());
            ps.setDouble(6, peminjaman.getHarga());
            ps.setDate(7, (Date) peminjaman.getTanggalSewa());
            ps.setDate(8, (Date) peminjaman.getTanggalKembali());
            ps.setString(9, peminjaman.getNomorPolisi());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                LOGGER.info("Data berhasil ditambahkan: " + peminjaman.getNik());
                updateStatusKendaraan(peminjaman.getNomorPolisi(), "Tidak Tersedia");
            } else {
                LOGGER.warning("Data tidak berhasil ditambahkan: " + peminjaman.getNik());
            }
        } catch (SQLException e) {
            LOGGER.severe("Database error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public List<Kendaraan> getAvailableKendaraan() {
        List<Kendaraan> kendaraanList = new ArrayList<>();
        String sql = "SELECT * FROM kendaraan WHERE status='Tersedia'";

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

    private void updateStatusKendaraan(String nomorPolisi, String status) {
        String sql = "UPDATE kendaraan SET status=? WHERE nomor_polisi=?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setString(2, nomorPolisi);
            ps.executeUpdate();
            LOGGER.info("Status kendaraan berhasil diperbarui: " + nomorPolisi + " menjadi " + status);
        } catch (SQLException e) {
            LOGGER.severe("Database error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}