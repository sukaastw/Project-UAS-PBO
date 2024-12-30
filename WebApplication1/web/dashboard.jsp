<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Aplikasi Rental Mobil</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
        }

        .sidebar {
            width: 250px;
            background-color: #438af5;
            color: white;
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            display: flex;
            flex-direction: column;
        }

        .logo {
            text-align: center;
            padding: 20px 0;
            background-color: #ffffff;
            
        }

        .logo img {
            max-width: 250px;
            height: 220px;
        }

        .sidebar ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .sidebar ul li {
            padding: 15px 20px;
            border-top: 1px solid #4286ec;
            border-bottom: 1px solid #4286ec;
            cursor: pointer;
        }

        .sidebar ul li:hover {
            background-color: #3774d1;
        }

        .main-content {
            margin-left: 250px;
            padding: 20px;
        }

        .header {
            background-color: white;
            padding: 15px 20px;
            border-bottom: 1px solid #ddd;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header .user-info {
            display: flex;
            align-items: center;
        }

        .header .user-info img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
        }

        .cards {
            display: flex;
            gap: 20px;
            margin-top: 20px;
        }

        .card {
            flex: 1;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .card h3 {
            margin: 0;
            font-size: 20px;
        }

        .card p {
            margin: 10px 0 0;
            font-size: 24px;
            font-weight: bold;
        }

        .profile {
            margin-top: 20px;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .profile h3 {
            margin: 0 0 20px;
            font-size: 20px;
        }

        .profile p {
            margin: 5px 0;
        }

        .profile p span {
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="logo">
            <img src="Logo.png" alt="Logo Rental Mobil">
        </div>
        <ul>
            <li onclick="location.href='DashboardServlet'">Dashboard</li>
            <li onclick="location.href='KendaraanServlet'">Data Mobil</li>
            <li onclick="location.href='PeminjamanServlet'">Data Peminjaman</li>
            <li onclick="location.href='PengembalianServlet'">Data Pengembalian</li>
        </ul>
    </div>

    <div class="main-content">
        <div class="header">
            <h1>Selamat datang, admin</h1>
            <div class="user-info">
                <img src="ppcantik.jpg" alt="User Profile">
                <span>Administrator</span>
            </div>
        </div>

        <div class="cards">
            <div class="card">
                <h3>DATA MOBIL</h3>
                <p><%= request.getAttribute("jumlahKendaraan") %> Mobil</p>
            </div>
            <div class="card">
                <h3>DATA PEMINJAMAN</h3>
                <p><%= request.getAttribute("jumlahPeminjam") %> Peminjam</p>
            </div>
            <div class="card">
                <h3>DATA PENGEMBALIAN</h3>
                <p><%= request.getAttribute("jumlahPengembalian") %> Pengembalian Selesai</p>
            </div>
        </div>

        <div class="profile">
            <h3>Akun yang sedang login</h3>
            <p><span>Nama:</span> Administrator</p>
            <p><span>Username:</span> admin</p>
            <p><span>Tanggal & Jam Login:</span> <%= new Date() %></p>
            <p><span>Server:</span> localhost</p>
        </div>
    </div>
</body>
</html>