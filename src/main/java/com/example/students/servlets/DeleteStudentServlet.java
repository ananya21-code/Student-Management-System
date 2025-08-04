package com.example.students.servlets;

import com.example.students.dao.StudentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/DeleteStudentServlet")
public class DeleteStudentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Your doGet implementation here (if needed)
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Add this method here
        String studentId = request.getParameter("studentId");

        if (studentId != null) {
            try {
                int id = Integer.parseInt(studentId);
                StudentDAO studentDAO = new StudentDAO();
                boolean isDeleted = studentDAO.deleteStudent(id);

                if (isDeleted) {
                    response.sendRedirect("deleteStudent.jsp?status=success");
                } else {
                    response.sendRedirect("deleteStudent.jsp?status=error");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect("deleteStudent.jsp?status=error");
            }
        } else {
            response.sendRedirect("deleteStudent.jsp?status=error");
        }
    }
}
