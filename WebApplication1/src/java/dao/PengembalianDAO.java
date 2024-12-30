package dao;

import model.Pengembalian;
import model.Peminjaman;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

public class PengembalianDAO {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/rencaruas";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";
    private static final Logger LOGGER = Logger.getLogger(PengembalianDAO.class.getName());

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    public List<Peminjaman> getAllPeminjaman() {
        List<Peminjaman> peminjamanList = new ArrayList<>();
        String sql = "SELECT * FROM peminjaman";

        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Peminjaman peminjaman = new Peminjaman(
                        rs.getString("nik"),
                        rs.getString("nama"),
                        rs.getString("no_hp"),
                        rs.getString("alamat"),
                        rs.getString("jenis_mobil"),
                        rs.getDouble("harga"),
                        rs.getDate("tanggal_sewa"),
                        rs.getDate("tanggal_kembali"),
                        rs.getString("nomor_polisi")
                );
                peminjamanList.add(peminjaman);
            }
        } catch (SQLException e) {
            LOGGER.severe("Database error: " + e.getMessage());
            e.printStackTrace();
        }

        return peminjamanList;
    }

    public void addPengembalian(Pengembalian pengembalian) {
        String sql = "INSERT INTO pengembalian (nomor_polisi, alamat, no_hp, jenis_mobil, tanggal_sewa, tanggal_kembali, tanggal_dikembalikan, denda, biaya_kerusakan, total_biaya, nama) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        LOGGER.info("Executing query: " + sql);

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, pengembalian.getNomorPolisi());
            ps.setString(2, pengembalian.getAlamat());
            ps.setString(3, pengembalian.getNoHp());
            ps.setString(4, pengembalian.getJenisMobil());
            ps.setDate(5, pengembalian.getTanggalSewa());
            ps.setDate(6, pengembalian.getTanggalKembali());
            ps.setDate(7, pengembalian.getTanggalDikembalikan());
            ps.setDouble(8, pengembalian.getDenda());
            ps.setDouble(9, pengembalian.getBiayaKerusakan());
            ps.setDouble(10, pengembalian.getTotalBiaya());
            ps.setString(11, pengembalian.getNama());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                LOGGER.info("Data berhasil ditambahkan: " + pengembalian.getNomorPolisi());
                updateStatusKendaraan(pengembalian.getNomorPolisi(), "Tersedia");
                deletePeminjamanByNomorPolisi(pengembalian.getNomorPolisi());
            } else {
                LOGGER.warning("Data tidak berhasil ditambahkan: " + pengembalian.getNomorPolisi());
            }
        } catch (SQLException e) {
            LOGGER.severe("Database error: " + e.getMessage());
            e.printStackTrace();
        }
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

    private void deletePeminjamanByNomorPolisi(String nomorPolisi) {
        String sql = "DELETE FROM peminjaman WHERE nomor_polisi=?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, nomorPolisi);
            ps.executeUpdate();
            LOGGER.info("Data peminjaman berhasil dihapus untuk nomor polisi: " + nomorPolisi);
        } catch (SQLException e) {
            LOGGER.severe("Database error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}