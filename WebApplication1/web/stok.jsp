<%@ page import="java.util.List" %>
<%@ page import="model.Kendaraan" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Stok Kendaraan</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .container {
            width: 100%;
            max-width: 100%;
            background: white;
            padding: 0px;
            border-radius: 0px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            overflow-x: auto;
        }

        h1 {
            color: #333;
            margin-bottom: 20px;
            text-align: left;
            margin-left: 30px;
        }

        .table-container {
            margin-top: 40px;
            margin-left: 20px;
            margin-right: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #5032f6;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .add-stock {
            margin-top: 20px;
            text-align: center;
        }

        .add-stock button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 20px;
        }

        .add-stock button:hover {
            background-color: #45a049;
        }

        /* CSS untuk modal */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            max-width: 500px;
            width: 100%;
            text-align: center;
        }

        .modal-content input {
            width: 90%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 4px;
            border: 1px solid #ddd;
        }

        .modal-content button {
            margin-top: 10px;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .modal-content button:hover {
            background-color: #45a049;
        }

        /* Header Styling */
        header {
            background-color: #438af5;
            padding: 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            width: 100%;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 10;
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
            margin-top: 80px; 
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
        <h1>Daftar Stok Kendaraan</h1>
        <div class="table-container">
            <table id="stockTable">
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
                                <tr>
                                    <td><%= kendaraan.getNomorPolisi() %></td>
                                    <td><%= kendaraan.getMerek() %></td>
                                    <td><%= kendaraan.getJenis() %></td>
                                    <td><%= kendaraan.getStok() %></td>
                                    <td>Rp <%= String.format("%,.2f", kendaraan.getHarga()) %></td>
                                    <td><%= kendaraan.getStatus() != null ? kendaraan.getStatus() : "" %></td>
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
        <div class="add-stock">
            <button onclick="showModal()">Tambah Kendaraan Baru</button>
            <button type="button" class="back-button" onclick="window.location.href='DashboardServlet'">Kembali ke Dashboard</button>
        </div>
    </div>

    <!-- Modal untuk input data -->
    <div id="inputModal" class="modal">
        <div class="modal-content">
            <h3>Tambah Kendaraan Baru</h3>
            <form action="KendaraanServlet" method="post">
                <input type="hidden" name="action" value="add">
                <input type="text" name="nomor_polisi" placeholder="Nomor Polisi" required>
                <input type="text" name="merek" placeholder="Merek" required>
                <input type="text" name="jenis" placeholder="Jenis" required>
                <input type="number" name="stok" placeholder="Stok" min="0" required>
                <input type="text" name="harga" placeholder="Harga" required>
                <input type="text" name="status" placeholder="Status" value="Tersedia" hidden>
                <button type="submit">Tambah</button>
            </form>
        </div>
    </div>

    <script>
        function showModal() {
            document.getElementById('inputModal').style.display = 'flex';
        }

        // Menutup modal saat klik di luar modal
        window.onclick = function(event) {
            const modal = document.getElementById('inputModal');
            if (event.target == modal) {
                modal.style.display = 'none';
            }
        };
    </script> 
</body>
</html>