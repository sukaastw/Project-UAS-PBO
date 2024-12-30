package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int jumlahKendaraan = 0;
        int jumlahPeminjam = 0;
        int jumlahPengembalian = 0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rencaruas", "root", "");

            // Menghitung jumlah kendaraan
            PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM kendaraan");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                jumlahKendaraan = rs.getInt(1);
            }

            // Menghitung jumlah peminjam
            ps = conn.prepareStatement("SELECT COUNT(*) FROM peminjaman");
            rs = ps.executeQuery();
            if (rs.next()) {
                jumlahPeminjam = rs.getInt(1);
            }

            // Menghitung jumlah pengembalian
            ps = conn.prepareStatement("SELECT COUNT(*) FROM pengembalian");
            rs = ps.executeQuery();
            if (rs.next()) {
                jumlahPengembalian = rs.getInt(1);
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("jumlahKendaraan", jumlahKendaraan);
        request.setAttribute("jumlahPeminjam", jumlahPeminjam);
        request.setAttribute("jumlahPengembalian", jumlahPengembalian);

        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }
}