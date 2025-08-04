package com.example.students.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/errorPage")
public class ErrorPageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("errorMessage", "A custom error occurred.");
        request.getRequestDispatcher("/WEB-INF/error.jsp").forward(request, response);
    }
}