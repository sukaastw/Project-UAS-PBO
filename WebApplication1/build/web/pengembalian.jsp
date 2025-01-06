<%@ page import="java.util.List" %>
<%@ page import="model.Peminjaman" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pengembalian</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            background-color: #f4f4f4;
        }
        .header {
            display: flex;
            align-items: center;
            padding: 10px 20px;
            background-color: #438af5;
            color: white;
        }
        .header img {
            height: 50px;
            margin-right: 20px;
        }
        .header h1 {
            margin: 0;
            font-size: 24px;
        }
        .container {
            display: flex;
            flex-direction: row;
            justify-content: space-between;
            margin: 20px;
        }
        .form-container {
            width: 35%;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .form-container label {
            font-weight: bold;
            margin-bottom: 5px;
        }
        .form-container input {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }
        .form-container input:focus {
            border-color: #438af5;
        }
        .form-container button {
            width: 100%;
            padding: 10px;
            border: none;
            background-color: #438af5;
            color: white;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        .form-container button:hover {
            background-color: #0056b3;
        }
        .table-container {
            width: 60%;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table th, table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }
        table th {
            background-color: #438af5;
            color: white;
        }
        table tr:hover {
            background-color: #f1f1f1;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="header">
        <img src="Logo.png" alt="Logo">
        <h1>Rencar</h1>
    </div>
    <div class="container">
        <!-- Form Pengembalian -->
        <div class="form-container">
            <h3>Form Pengembalian</h3>
            <form id="pengembalianForm" action="PengembalianServlet" method="post">
                <label for="nomorPolisi">Nomor Polisi</label>
                <input type="text" id="nomorPolisi" name="nomorPolisi" readonly required>

                <label for="nama">Nama</label>
                <input type="text" id="nama" name="nama" readonly required>

                <label for="alamat">Alamat</label>
                <input type="text" id="alamat" name="alamat" readonly required>

                <label for="noHp">No HP</label>
                <input type="text" id="noHp" name="noHp" readonly required>

                <label for="jenisMobil">Jenis Mobil</label>
                <input type="text" id="jenisMobil" name="jenisMobil" readonly required>

                <label for="tanggalSewa">Tanggal Sewa</label>
                <input type="date" id="tanggalSewa" name="tanggalSewa" readonly required>

                <label for="tanggalKembali">Tanggal Kembali</label>
                <input type="date" id="tanggalKembali" name="tanggalKembali" readonly required>

                <label for="tanggalDikembalikan">Tanggal Dikembalikan</label>
                <input type="date" id="tanggalDikembalikan" name="tanggalDikembalikan" required onchange="calculateDenda()">

                <label for="denda">Denda</label>
                <input type="text" id="denda" name="denda" readonly required>

                <label for="biayaKerusakan">Biaya Kerusakan</label>
                <input type="text" id="biayaKerusakan" name="biayaKerusakan" required onchange="calculateTotalBiaya()">

                <label for="totalBiaya">Total Biaya</label>
                <input type="text" id="totalBiaya" name="totalBiaya" readonly required>

                <button type="submit">Kembalikan</button>
                <button type="button" class="back-button" onclick="window.location.href='DashboardServlet'">Kembali ke Dashboard</button>
            </form>
        </div>

        <!-- Table Data Penyewa -->
        <div class="table-container">
            <h3>Data Penyewa</h3>
            <table>
                <thead>
                    <tr>
                        <th>Nomor Polisi</th>
                        <th>Nama</th>
                        <th>Alamat</th>
                        <th>No HP</th>
                        <th>Jenis Mobil</th>
                        <th>Tanggal Sewa</th>
                        <th>Tanggal Kembali</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Peminjaman> peminjamanList = (List<Peminjaman>) request.getAttribute("peminjamanList");
                        if (peminjamanList != null && !peminjamanList.isEmpty()) {
                            for (Peminjaman peminjaman : peminjamanList) {
                    %>
                                <tr onclick="selectPeminjaman('<%= peminjaman.getNomorPolisi() %>', '<%= peminjaman.getNama() %>', '<%= peminjaman.getAlamat() %>', '<%= peminjaman.getNoHp() %>', '<%= peminjaman.getJenisMobil() %>', '<%= peminjaman.getTanggalSewa() %>', '<%= peminjaman.getTanggalKembali() %>')">
                                    <td><%= peminjaman.getNomorPolisi() %></td>
                                    <td><%= peminjaman.getNama() %></td>
                                    <td><%= peminjaman.getAlamat() %></td>
                                    <td><%= peminjaman.getNoHp() %></td>
                                    <td><%= peminjaman.getJenisMobil() %></td>
                                    <td><%= peminjaman.getTanggalSewa() %></td>
                                    <td><%= peminjaman.getTanggalKembali() %></td>
                                </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="7">Tidak ada data peminjaman.</td>
                        </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        // Fungsi untuk mentransfer data penyewa ke form
        function selectPeminjaman(nomorPolisi, nama, alamat, noHp, jenisMobil, tanggalSewa, tanggalKembali) {
            document.getElementById("nomorPolisi").value = nomorPolisi;
            document.getElementById("nama").value = nama;
            document.getElementById("alamat").value = alamat;
            document.getElementById("noHp").value = noHp;
            document.getElementById("jenisMobil").value = jenisMobil;
            document.getElementById("tanggalSewa").value = tanggalSewa;
            document.getElementById("tanggalKembali").value = tanggalKembali;
        }

        // Fungsi untuk menghitung denda jika terlambat mengembalikan kendaraan
        function calculateDenda() {
            const tanggalKembali = new Date(document.getElementById("tanggalKembali").value);
            const tanggalDikembalikan = new Date(document.getElementById("tanggalDikembalikan").value);

            const timeDiff = tanggalDikembalikan - tanggalKembali;
            const daysLate = Math.ceil(timeDiff / (1000 * 3600 * 24));

            let denda = 0;
            if (daysLate > 0) {
                denda = daysLate * 100000;
            }

            document.getElementById("denda").value = denda.toLocaleString();
            calculateTotalBiaya();
        }

        // Fungsi untuk menghitung total biaya
        function calculateTotalBiaya() {
            const denda = parseInt(document.getElementById("denda").value.replace(/[^0-9]/g, '')) || 0;
            const biayaKerusakan = parseInt(document.getElementById("biayaKerusakan").value) || 0;
            const totalBiaya = denda + biayaKerusakan;
            document.getElementById("totalBiaya").value = totalBiaya.toLocaleString();
        }
    </script>
</body>
</html>
