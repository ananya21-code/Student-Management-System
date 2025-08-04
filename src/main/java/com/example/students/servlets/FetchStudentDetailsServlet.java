package com.example.students.servlets;

import com.example.students.dao.StudentDAO;
import com.example.students.model.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/FetchStudentDetailsServlet")
public class FetchStudentDetailsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String studentIdStr = request.getParameter("studentId");

        if (studentIdStr == null || studentIdStr.isEmpty()) {
            request.setAttribute("errorMessage", "Student ID is required.");
            request.getRequestDispatcher("updateStudent.jsp").forward(request, response);
            return;
        }

        try {
            int studentId = Integer.parseInt(studentIdStr);

            // Fetch student details using StudentDAO
            StudentDAO studentDAO = new StudentDAO();
            Student student = studentDAO.getStudentById(studentId);

            if (student != null) {
                // Pass the student object to the JSP
                request.setAttribute("student", student);
                request.getRequestDispatcher("updateStudent.jsp").forward(request, response);
            } else {
                // Student not found
                request.setAttribute("errorMessage", "Student not found with ID: " + studentId);
                request.getRequestDispatcher("updateStudent.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid student ID format.");
            request.getRequestDispatcher("updateStudent.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error fetching student details: " + e.getMessage());
            request.getRequestDispatcher("updateStudent.jsp").forward(request, response);
        }
    }
}
