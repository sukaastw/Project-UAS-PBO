package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.User;
import dao.UserDAO;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get username and password from request
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Create User object and validate using DAO
        User user = new User(username, password);
        UserDAO userDAO = new UserDAO();
        boolean isValid = userDAO.validateUser(user);

        if (isValid) {
            // Redirect to home page or dashboard
            response.sendRedirect(request.getContextPath() + "/DashboardServlet");
        } else {
            // Redirect back to login with error message
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=true");
        }
    }
}
