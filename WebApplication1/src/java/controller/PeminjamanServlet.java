package controller;

import dao.PeminjamanDAO;
import model.Peminjaman;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;
import java.util.List;
import java.util.logging.Logger;
import model.Kendaraan;

@WebServlet("/PeminjamanServlet")
public class PeminjamanServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(PeminjamanServlet.class.getName());
    private PeminjamanDAO peminjamanDAO = new PeminjamanDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        LOGGER.info("doGet called");

        // Ambil data kendaraan dari database
        List<Kendaraan> kendaraanList = peminjamanDAO.getAvailableKendaraan();
        request.setAttribute("kendaraanList", kendaraanList);

        // Teruskan ke halaman JSP
        request.getRequestDispatcher("peminjaman.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        LOGGER.info("doPost called");

        // Ambil data dari form
        String nik = request.getParameter("nik");
        String nama = request.getParameter("nama");
        String noHp = request.getParameter("noHp");
        String alamat = request.getParameter("alamat");
        String jenisMobil = request.getParameter("jenisMobil");
        double harga = Double.parseDouble(request.getParameter("harga"));
        Date tanggalSewa = Date.valueOf(request.getParameter("tanggalSewa")); // Konversi ke java.sql.Date
        Date tanggalKembali = Date.valueOf(request.getParameter("tanggalKembali")); // Konversi ke java.sql.Date
        String nomorPolisi = request.getParameter("nomorPolisi");

        LOGGER.info("Received data: " + nik + ", " + nama + ", " + noHp + ", " + alamat + ", " + jenisMobil + ", " + harga + ", " + tanggalSewa + ", " + tanggalKembali + ", " + nomorPolisi);

        // Buat objek peminjaman dan simpan ke database
        Peminjaman peminjaman = new Peminjaman(nik, nama, noHp, alamat, jenisMobil, harga, tanggalSewa, tanggalKembali, nomorPolisi);
        peminjamanDAO.addPeminjaman(peminjaman);

        // Redirect kembali ke halaman daftar peminjaman
        response.sendRedirect("PeminjamanServlet");
    }
}