<%@ page import="java.util.List" %>
<%@ page import="model.Kendaraan" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Form Peminjaman</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        header {
            background-color: #438af5;
            padding: 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .logo {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            overflow: hidden;
        }

        .logo img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .logo-text {
            font-size: 24px;
            color: white;
            font-weight: bold;
            margin-left: 10px;
            flex-grow: 1;
            text-align: left;
        }

        .container {
            max-width: 100%;
            margin: 0;
            background: white;
            padding: 30px;
            display: flex;
            gap: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .form-left, .form-right {
            flex: 1;
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            margin-bottom: 5px;
            color: #555;
        }

        input, select, button {
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 5px;
            border: 1px solid #000000;
        }

        input:focus, select:focus {
            border-color: #438af5;
        }

        button {
            background-color: #438af5;
            color: white;
            border: none;
            cursor: pointer;
        }

        button:hover {
            background-color: #438af5;
        }

        .form-right {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        table th, table td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #010101;
        }

        table th {
            background-color: #438af5;
            color: white;
        }

        table tr:hover {
            background-color: #f1f1f1;
            cursor: pointer;
        }

        .popup {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
            border-radius: 8px;
            display: none;
            z-index: 10;
            width: 400px;
        }

        .popup h3 {
            margin-top: 0;
            margin-bottom: 15px;
            text-align: center;
        }

        .popup table {
            width: 100%;
            border-collapse: collapse;
        }

        .popup table td {
            padding: 8px 10px;
        }

        .popup table td:first-child {
            font-weight: bold;
            text-align: left;
            width: 40%;
        }

        .popup table td:last-child {
            text-align: right;
        }

        .popup button {
            background-color: #438af5;
            color: white;
            border: none;
            padding: 10px 20px;
            margin-top: 20px;
            cursor: pointer;
            display: block;
            margin-left: auto;
        }

        .popup button:hover {
            background-color: #438af5;
        }

        .overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            display: none;
            z-index: 5;
        }

        .back-button {
            background-color: #ff0000;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            display: block;
            margin-top: 20px;
            text-align: center;
        }

        .back-button:hover {
            background-color: #cc0000;
        }
    </style>
</head>
<body>
    <header>
        <div class="logo">
            <img src="Logo.png" alt="Logo">
        </div>
        <div class="logo-text">Rencar</div>
    </header>

    <div class="container">
        <!-- Form Input -->
        <div class="form-left">
            <h2>Form Peminjaman</h2>
            <form id="peminjamanForm" action="PeminjamanServlet" method="post" onsubmit="submitForm(event)">
                <label for="nama">Nama</label>
                <input type="text" id="nama" name="nama" placeholder="Masukkan Nama" required>

                <label for="nik">NIK</label>
                <input type="text" id="nik" name="nik" placeholder="Masukkan NIK" required>

                <label for="alamat">Alamat</label>
                <input type="text" id="alamat" name="alamat" placeholder="Masukkan Alamat" required>

                <label for="noHp">No. HP</label>
                <input type="text" id="noHp" name="noHp" placeholder="Masukkan No. HP" required>

                <label for="jenisMobil">Jenis Mobil</label>
                <input type="text" id="jenisMobil" name="jenisMobil" placeholder="Jenis Mobil" readonly required>

                <label for="harga">Harga</label>
                <input type="text" id="harga" name="harga" placeholder="Harga per Hari" readonly required>

                <label for="nomorPolisi">Nomor Polisi</label>
                <input type="text" id="nomorPolisi" name="nomorPolisi" placeholder="Nomor Polisi" readonly required>

                <label for="tanggalSewa">Tanggal Sewa</label>
                <input type="date" id="tanggalSewa" name="tanggalSewa" required>

                <label for="tanggalKembali">Tanggal Pengembalian</label>
                <input type="date" id="tanggalKembali" name="tanggalKembali" required>

                <button type="submit">Pesan</button>
                <!-- Tombol Kembali ke Dashboard -->
                <button type="button" class="back-button" onclick="window.location.href='DashboardServlet'">Kembali ke Dashboard</button>
            </form>
        </div>

        <!-- Output Data -->
        <div class="form-right">
            <h2>Stock Mobil Tersedia</h2>
            <table>
                <thead>
                    <tr>
                        <th>Nomor Polisi</th>
                        <th>Merek</th>
                        <th>Jenis</th>
                        <th>Stok</th>
                        <th>Harga</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Kendaraan> kendaraanList = (List<Kendaraan>) request.getAttribute("kendaraanList");
                        if (kendaraanList != null && !kendaraanList.isEmpty()) {
                            for (Kendaraan kendaraan : kendaraanList) {
                    %>
                                <tr onclick="selectKendaraan('<%= kendaraan.getMerek() %>', '<%= kendaraan.getJenis() %>', '<%= kendaraan.getHarga() %>', '<%= kendaraan.getNomorPolisi() %>')">
                                    <td><%= kendaraan.getNomorPolisi() %></td>
                                    <td><%= kendaraan.getMerek() %></td>
                                    <td><%= kendaraan.getJenis() %></td>
                                    <td><%= kendaraan.getStok() %></td>
                                    <td>Rp <%= String.format("%,.2f", kendaraan.getHarga()) %></td>
                                    <td><%= kendaraan.getStatus() %></td>
                                </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="6">Tidak ada data kendaraan.</td>
                        </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Popup -->
    <div class="overlay" id="overlay"></div>
    <div class="popup" id="popup">
        <h3>Data Peminjaman</h3>
        <table>
            <tr><td>Nama</td><td id="popupNama"></td></tr>
            <tr><td>NIK</td><td id="popupNIK"></td></tr>
            <tr><td>Alamat</td><td id="popupAlamat"></td></tr>
            <tr><td>No. HP</td><td id="popupNoHp"></td></tr>
            <tr><td>Jenis Mobil</td><td id="popupJenisMobil"></td></tr>
            <tr><td>Harga</td><td id="popupHarga"></td></tr>
            <tr><td>Nomor Polisi</td><td id="popupNomorPolisi"></td></tr>
            <tr><td>Tanggal Sewa</td><td id="popupTanggalSewa"></td></tr>
            <tr><td>Tanggal Pengembalian</td><td id="popupTanggalKembali"></td></tr>
        </table>
        <button onclick="closePopup()">Simpan Data</button>
    </div>

    <script>
        // Fungsi untuk memilih mobil
        function selectKendaraan(merek, jenis, harga, nomorPolisi) {
            document.getElementById("jenisMobil").value = jenis;
            document.getElementById("harga").value = harga;
            document.getElementById("nomorPolisi").value = nomorPolisi;
        }

        // Fungsi untuk menampilkan popup konfirmasi
        function submitForm(event) {
            event.preventDefault();

            // Mengambil nilai input
            document.getElementById("popupNama").innerText = document.getElementById("nama").value;
            document.getElementById("popupNIK").innerText = document.getElementById("nik").value;
            document.getElementById("popupAlamat").innerText = document.getElementById("alamat").value;
            document.getElementById("popupNoHp").innerText = document.getElementById("noHp").value;
            document.getElementById("popupJenisMobil").innerText = document.getElementById("jenisMobil").value;
            document.getElementById("popupHarga").innerText = document.getElementById("harga").value;
            document.getElementById("popupNomorPolisi").innerText = document.getElementById("nomorPolisi").value;
            document.getElementById("popupTanggalSewa").innerText = document.getElementById("tanggalSewa").value;
            document.getElementById("popupTanggalKembali").innerText = document.getElementById("tanggalKembali").value;

            document.getElementById("popup").style.display = "block";
            document.getElementById("overlay").style.display = "block";
        }

        function closePopup() {
            document.getElementById("popup").style.display = "none";
            document.getElementById("overlay").style.display = "none";
            document.getElementById("peminjamanForm").submit(); // Submit form setelah menutup popup
        }
    </script>
</body>
</html>