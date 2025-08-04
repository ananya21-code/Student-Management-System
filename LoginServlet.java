//package com.example.students.servlets;
//
//import com.example.students.utils.DBUtil;
//
//import jakarta.servlet.*;
//import jakarta.servlet.http.*;
//import java.io.*;
//import java.sql.*;
//
//public class LoginServlet extends HttpServlet {
//
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String username = request.getParameter("username");
//        String password = request.getParameter("password");
//
//        try (Connection conn = DBUtil.getConnection()) {
//            String sql = "SELECT username, password, role FROM users WHERE username = ? AND password = ?";
//            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
//                stmt.setString(1, username);
//                stmt.setString(2, password);
//                ResultSet rs = stmt.executeQuery();
//
//                if (rs.next()) {
//                    String role = rs.getString("role");
//                    HttpSession session = request.getSession();
//                    session.setAttribute("username", username);
//                    session.setAttribute("role", role);
//
//                    // Redirect to the appropriate home page based on the user role
//                    if ("admin".equals(role)) {
//                        response.sendRedirect("adminHome.jsp");
//                    } else {
//                        response.sendRedirect("userHome.jsp");
//                    }
//                } else {
//                    // If invalid credentials, redirect back to login page with an error parameter
//                    response.sendRedirect("index.jsp?error=invalid");
//                }
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//            response.sendRedirect("index.jsp?error=server");
//        }
//    }
//}
package com.example.students.servlets;

import com.example.students.utils.DBUtil;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT username, password, role FROM users WHERE username = ? AND password = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, username);
                stmt.setString(2, password);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    String role = rs.getString("role");
                    HttpSession session = request.getSession();
                    session.setAttribute("username", username);
                    session.setAttribute("role", role);

                    // Redirect to the appropriate home page based on the user role
                    if ("admin".equals(role)) {
                        response.sendRedirect("adminHome.jsp");
                    } else {
                        response.sendRedirect("userHome.jsp");
                    }
                } else {
                    // If invalid credentials, redirect back to login page with an error parameter
                    response.sendRedirect("index.jsp?error=invalid");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?error=server");
        }
    }
}