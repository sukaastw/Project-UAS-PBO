<%-- 
    Document   : login.jsp
    Created on : Dec 25, 2024, 7:22:04 PM
    Author     : USER
--%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Rental Mobil</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-image: url('<%= request.getContextPath() %>/loginbg.png');
            background-repeat: no-repeat;
            background-position: center;
            background-attachment: fixed;
            background-size: cover;
        }

        .login-box {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 300px;
        }

        .login-box h2 {
            margin-bottom: 20px;
        }

        .login-box input {
            width: 90%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .login-box button {
            width: 100%;
            padding: 10px;
            background-color: #438af5;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .login-box button:hover {
            background-color: #3774d1;
        }

        .error-message {
            color: red;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="login-box">
        <h2>Rental Mobil</h2>
        <form action="<%= request.getContextPath() %>/LoginServlet" method="post">
            <input type="text" name="username" placeholder="Masukkan Username" required>
            <input type="password" name="password" placeholder="Masukkan Password" required>
            <button type="submit">Masuk</button>
            <%
                if (request.getParameter("error") != null) {
            %>
                <div class="error-message">Username atau password salah!</div>
            <%
                }
            %>
        </form>
    </div>
</body>
</html>