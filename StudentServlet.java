package com.example.students.servlets;

import com.example.students.dao.StudentDAO;
import com.example.students.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/student")
public class StudentServlet extends HttpServlet {

    private StudentDAO studentDAO;

    @Override
    public void init() throws ServletException {
        studentDAO = new StudentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if (action == null) {
                action = "list";
            }
            switch (action) {
                case "list":
                    listStudents(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
//                case "delete":
//                    deleteStudent(request, response);
//                    break;
                default:
                    listStudents(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if (action == null) {
                action = "list";
            }
            switch (action) {
                case "add":
                    addStudent(request, response);
                    break;
//                case "update":
//                    updateStudent(request, response);
//                    break;
                default:
                    listStudents(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private void listStudents(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Student> students = studentDAO.getAllStudents();
        request.setAttribute("students", students);
        request.getRequestDispatcher("/viewStudents.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Student existingStudent = studentDAO.getStudentById(id);
        request.setAttribute("student", existingStudent);
        request.getRequestDispatcher("/editStudent.jsp").forward(request, response);
    }

    private void addStudent(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Student student = new Student();
        student.setFirstName(request.getParameter("firstName"));
        student.setLastName(request.getParameter("lastName"));
        student.setEmail(request.getParameter("email"));
        student.setPhone(request.getParameter("phone"));
        student.setCourse(request.getParameter("course"));

        studentDAO.addStudent(student);
        response.sendRedirect("student?action=list");
    }

//    private void updateStudent(HttpServletRequest request, HttpServletResponse response)
//            throws IOException {
//        int id = Integer.parseInt(request.getParameter("id"));
//        Student student = new Student();
//        student.setId(id);
//        student.setFirstName(request.getParameter("firstName"));
//        student.setLastName(request.getParameter("lastName"));
//        student.setEmail(request.getParameter("email"));
//        student.setPhone(request.getParameter("phone"));
//        student.setCourse(request.getParameter("course"));
//
//        studentDAO.updateStudent(student);
//        response.sendRedirect("student?action=list");
//    }

//    private void deleteStudent(HttpServletRequest request, HttpServletResponse response)
//            throws IOException {
//        int id = Integer.parseInt(request.getParameter("id"));
//        studentDAO.deleteStudent(id);
//        response.sendRedirect("student?action=list");
//    }
//
//    @Override
//    public void destroy() {
//        studentDAO = null;
//    }
}