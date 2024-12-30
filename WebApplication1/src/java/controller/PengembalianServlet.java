package controller;

import dao.PengembalianDAO;
import model.Peminjaman;
import model.Pengembalian;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/PengembalianServlet")
public class PengembalianServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PengembalianDAO pengembalianDAO = new PengembalianDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Ambil data peminjaman dari database
        List<Peminjaman> peminjamanList = pengembalianDAO.getAllPeminjaman();
        request.setAttribute("peminjamanList", peminjamanList);

        // Teruskan ke halaman JSP
        request.getRequestDispatcher("pengembalian.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Ambil data dari form
        String nomorPolisi = request.getParameter("nomorPolisi");
        String alamat = request.getParameter("alamat");
        String noHp = request.getParameter("noHp");
        String jenisMobil = request.getParameter("jenisMobil");
        Date tanggalSewa = Date.valueOf(request.getParameter("tanggalSewa"));
        Date tanggalKembali = Date.valueOf(request.getParameter("tanggalKembali"));
        Date tanggalDikembalikan = Date.valueOf(request.getParameter("tanggalDikembalikan"));
        double denda = Double.parseDouble(request.getParameter("denda").replace(",", ""));
        double biayaKerusakan = Double.parseDouble(request.getParameter("biayaKerusakan").replace(",", ""));
        double totalBiaya = Double.parseDouble(request.getParameter("totalBiaya").replace(",", ""));
        String nama = request.getParameter("nama");

        // Buat objek pengembalian dan simpan ke database
        Pengembalian pengembalian = new Pengembalian(nomorPolisi, alamat, noHp, jenisMobil, tanggalSewa, tanggalKembali, tanggalDikembalikan, denda, biayaKerusakan, totalBiaya, nama);
        pengembalianDAO.addPengembalian(pengembalian);

        // Redirect kembali ke halaman pengembalian
        response.sendRedirect("PengembalianServlet");
    }
}