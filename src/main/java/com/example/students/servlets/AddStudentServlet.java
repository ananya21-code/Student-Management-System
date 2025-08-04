package com.example.students.servlets;

import com.example.students.dao.StudentDAO;
import com.example.students.model.Student;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class AddStudentServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward to the Add Student form (addStudent.jsp)
        RequestDispatcher dispatcher = request.getRequestDispatcher("addStudent.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data from the request
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String course = request.getParameter("course");

        // Validate the input fields
        if (firstName == null || lastName == null || email == null || phone == null || course == null ||
                firstName.isEmpty() || lastName.isEmpty() || email.isEmpty() || phone.isEmpty() || course.isEmpty()) {
            request.setAttribute("errorMessage", "All fields are required.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("addStudent.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // Create a Student object with the data
        Student student = new Student();
        student.setFirstName(firstName);
        student.setLastName(lastName);
        student.setEmail(email);
        student.setPhone(phone);
        student.setCourse(course);

        // Use StudentDAO to add the student to the database
        StudentDAO studentDAO = new StudentDAO();
        boolean isAdded = studentDAO.addStudent(student);

        // Handle the response based on the success of the operation
        if (isAdded) {
            // Pass a success message to the JSP
            request.setAttribute("successMessage", "Student added successfully!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("addStudent.jsp");
            dispatcher.forward(request, response);
        } else {
            // Set an error message and forward back to the addStudent.jsp page
            request.setAttribute("errorMessage", "Failed to add student. Please try again.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("addStudent.jsp");
            dispatcher.forward(request, response);
        }
    }
}
