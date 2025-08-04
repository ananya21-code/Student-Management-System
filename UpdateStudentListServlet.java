package com.example.students.servlets;

import com.example.students.dao.StudentDAO;
import com.example.students.model.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;


@WebServlet("/UpdateStudentListServlet")
public class UpdateStudentListServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String studentId = request.getParameter("studentId");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String course = request.getParameter("course");

        StudentDAO studentDAO = new StudentDAO();
        boolean isUpdated = false;
        try {
            // Parse studentId as int
            int id = Integer.parseInt(studentId);

            // Update student details in the database
            Student student = new Student(id, firstName, lastName, email, phone, course);
            isUpdated = studentDAO.updateStudent(student);

            // Set status for redirect
            if (isUpdated) {
                response.sendRedirect("updateStudent.jsp?status=success");
            } else {
                response.sendRedirect("updateStudent.jsp?status=error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("updateStudent.jsp?status=error");
        }
    }
}

