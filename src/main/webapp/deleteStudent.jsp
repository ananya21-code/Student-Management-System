<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.students.dao.StudentDAO"%>
<%@ page import="com.example.students.model.Student"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Student</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
            color: #333;
        }
        header {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            text-align: center;
        }
        main {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h2, h3 {
            color: #4CAF50;
            text-align: center;
        }
        form {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        label {
            font-weight: bold;
        }
        input {
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        button:hover {
            background-color: #45a049;
        }
        .message {
            text-align: center;
            margin-top: 20px;
            font-size: 1em;
        }
        .message.success {
            color: green;
        }
        .message.error {
            color: red;
        }
        .student-details {
            margin-bottom: 20px;
        }
        /* Modal Popup Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.6);
        }
        .modal-content {
            position: relative;
            background: white;
            margin: 15% auto;
            padding: 20px;
            border-radius: 10px;
            width: 400px;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .modal-content h3 {
            color: #4CAF50;
        }
        .modal-content button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            margin-top: 10px;
            transition: background-color 0.3s;
        }
        .modal-content button:hover {
            background-color: #45a049;
        }
    </style>
    <script>
        function showCustomPopup(message, redirectUrl) {
            const modal = document.getElementById("statusModal");
            const modalMessage = document.getElementById("modalMessage");
            modalMessage.innerText = message;
            modal.style.display = "block";

            document.getElementById("closeModal").onclick = function () {
                modal.style.display = "none";
                if (redirectUrl) window.location.href = redirectUrl;
            };
        }

        document.addEventListener("DOMContentLoaded", function () {
            const status = '<%= request.getParameter("status") %>';
            if (status === "success") {
                showCustomPopup("Student deleted successfully!", "adminHome.jsp");
            } else if (status === "error") {
                showCustomPopup("Failed to delete student. Please try again.", null);
            }
        });
    </script>
</head>
<body>
    <header>
        <h1>Delete Student</h1>
    </header>
    <main>
        <h2>Search Student</h2>
        <form action="deleteStudent.jsp" method="get">
            <label for="studentId">Student ID:</label>
            <input type="text" id="studentId" name="studentId" required placeholder="Enter Student ID">
            <button type="submit">Search</button>
        </form>

        <%
            String studentId = request.getParameter("studentId");

            if (studentId != null && !studentId.isEmpty()) {
                try {
                    int id = Integer.parseInt(studentId);
                    StudentDAO studentDAO = new StudentDAO();
                    Student student = studentDAO.getStudentById(id);

                    if (student != null) {
        %>
                        <div class="student-details">
                            <h3>Student Details</h3>
                            <p><strong>ID:</strong> <%= student.getId() %></p>
                            <p><strong>First Name:</strong> <%= student.getFirstName() %></p>
                            <p><strong>Last Name:</strong> <%= student.getLastName() %></p>
                            <p><strong>Email:</strong> <%= student.getEmail() %></p>
                            <p><strong>Phone:</strong> <%= student.getPhone() %></p>
                            <p><strong>Course:</strong> <%= student.getCourse() %></p>
                        </div>

                        <form action="DeleteStudentServlet" method="post">
                            <input type="hidden" name="studentId" value="<%= student.getId() %>">
                            <button type="submit" name="confirmDelete" value="true">Confirm Delete</button>
                        </form>
        <%
                    } else {
        %>
                        <p class="message error">Student not found with ID: <%= studentId %></p>
        <%
                    }
                } catch (NumberFormatException e) {
        %>
                    <p class="message error">Invalid student ID format.</p>
        <%
                }
            }
        %>
    </main>

    <!-- Modal Popup -->
    <div id="statusModal" class="modal">
        <div class="modal-content">
            <h3>Notification</h3>
            <p id="modalMessage"></p>
            <button id="closeModal">OK</button>
        </div>
    </div>
</body>
</html>