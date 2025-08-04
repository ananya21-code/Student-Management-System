<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.students.dao.StudentDAO"%>
<%@ page import="com.example.students.model.Student"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Student</title>
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
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h2, h3 {
            color: #4CAF50;
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
            width: 100%;
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
        .container {
            display: flex;
            gap: 20px;
            margin-top: 20px;
        }
        .details {
            flex: 1;
            border: 1px solid #ddd;
            padding: 15px;
            border-radius: 5px;
            background: #f9f9f9;
        }
        .message {
            color: red;
            text-align: center;
        }
        /* Modal Popup Styles */
        .modal {
            display: none; /* Hidden by default */
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
            const modal = document.getElementById("successModal");
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
                showCustomPopup("Student updated successfully!", "adminHome.jsp");
            } else if (status === "error") {
                showCustomPopup("Failed to update student. Please try again.", null);
            }
        });
    </script>
</head>
<body>
    <header>
        <h1>Update Student</h1>
    </header>
    <main>
        <h2>Search Student</h2>
        <form action="updateStudent.jsp" method="get">
            <label for="studentId">Student ID:</label>
            <input type="text" id="studentId" name="studentId" placeholder="Enter Student ID" required>
            <button type="submit">Fetch Details</button>
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
                        <div class="container">
                            <div class="details">
                                <h3>Previous Details</h3>
                                <p><strong>ID:</strong> <%= student.getId() %></p>
                                <p><strong>Name:</strong> <%= student.getFirstName() + " " + student.getLastName() %></p>
                                <p><strong>Email:</strong> <%= student.getEmail() %></p>
                                <p><strong>Phone:</strong> <%= student.getPhone() %></p>
                                <p><strong>Course:</strong> <%= student.getCourse() %></p>
                            </div>
                            <div class="details">
                                <h3>Update Details</h3>
                                <form action="UpdateStudentListServlet" method="post">
                                    <input type="hidden" name="studentId" value="<%= student.getId() %>">
                                    <label for="firstName">First Name:</label>
                                    <input type="text" id="firstName" name="firstName" value="<%= student.getFirstName() %>" required>
                                    <label for="lastName">Last Name:</label>
                                    <input type="text" id="lastName" name="lastName" value="<%= student.getLastName() %>" required>
                                    <label for="email">Email:</label>
                                    <input type="email" id="email" name="email" value="<%= student.getEmail() %>" required>
                                    <label for="phone">Phone:</label>
                                    <input type="text" id="phone" name="phone" value="<%= student.getPhone() %>" required>
                                    <label for="course">Course:</label>
                                    <input type="text" id="course" name="course" value="<%= student.getCourse() %>" required>
                                    <button type="submit">Update Student</button>
                                </form>
                            </div>
                        </div>
        <%
                    } else {
        %>
                        <p class="message">No student found with ID: <%= studentId %></p>
        <%
                    }
                } catch (NumberFormatException e) {
        %>
                    <p class="message">Invalid student ID format.</p>
        <%
                }
            }
        %>
    </main>

    <!-- Modal Popup -->
    <div id="successModal" class="modal">
        <div class="modal-content">
            <h3>Notification</h3>
            <p id="modalMessage"></p>
            <button id="closeModal">OK</button>
        </div>
    </div>
</body>
</html>