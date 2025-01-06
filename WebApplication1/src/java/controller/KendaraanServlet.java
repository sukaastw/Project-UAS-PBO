package controller;

import dao.KendaraanDAO;
import model.Kendaraan;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/KendaraanServlet")
public class KendaraanServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(KendaraanServlet.class.getName());
    private KendaraanDAO kendaraanDAO = new KendaraanDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        LOGGER.info("doGet called");
        List<Kendaraan> kendaraanList = kendaraanDAO.getAllKendaraan();
        request.setAttribute("kendaraanList", kendaraanList);
        request.getRequestDispatcher("stok.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        LOGGER.info("doPost called");
        
        // Ambil data dari form
        String nomorPolisi = request.getParameter("nomor_polisi");
        String merek = request.getParameter("merek");
        String jenis = request.getParameter("jenis");
        int stok = Integer.parseInt(request.getParameter("stok"));
        double harga = Double.parseDouble(request.getParameter("harga").replace("Rp ", "").replace(".", "").replace(",", ""));
        String status = request.getParameter("status");

        LOGGER.info("Received data: " + nomorPolisi + ", " + merek + ", " + jenis + ", " + stok + ", " + harga + ", " + status);

        // Buat objek kendaraan dan simpan ke database
        Kendaraan kendaraan = new Kendaraan(nomorPolisi, merek, jenis, stok, harga, status);
        kendaraanDAO.addKendaraan(kendaraan);

        // Redirect kembali ke halaman daftar kendaraan
        response.sendRedirect("KendaraanServlet");
    }
}