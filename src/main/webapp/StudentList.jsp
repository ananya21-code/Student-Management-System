<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student List</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f0f8f4; /* Soft green background */
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #333;
        }

        .container {
            background-color: #ffffff;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
        }

        h3 {
            color: #4CAF50; /* Classy dark green */
            font-weight: 600;
            font-size: 24px;
            text-align: center;
        }

        table {
            margin-top: 20px;
        }

        th {
            background-color: #4CAF50; /* Dark green header */
            color: white;
            font-weight: 600;
            text-align: center;
            font-size: 16px;
        }

        td {
            text-align: center;
            font-size: 15px;
            padding: 12px 15px;
            vertical-align: middle;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9; /* Light alternating row colors */
        }

        tr:hover {
            background-color: #e8f5e9; /* Soft green hover effect */
        }

        .text-center {
            font-size: 16px;
        }

        .no-data {
            color: #dc3545; /* Red color for no data */
            font-weight: 500;
            text-align: center;
            font-size: 18px;
        }

        /* Styling for the table container */
        .table-container {
            border-top: 2px solid #4CAF50;
            padding-top: 20px;
        }

        .table-container table {
            width: 100%;
        }

        .table-bordered {
            border: 1px solid #ddd;
        }
    </style>
</head>
<body>
    <div class="container">
        <h3>List of Students</h3>
        <hr>
        <div class="table-container">
            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Course</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Loop through students and display each student in a row -->
                    <c:forEach var="student" items="${students}">
                        <tr>
                            <td><c:out value="${student.id}" /></td>
                            <td><c:out value="${student.firstName}" /></td>
                            <td><c:out value="${student.lastName}" /></td>
                            <td><c:out value="${student.email}" /></td>
                            <td><c:out value="${student.phone}" /></td>
                            <td><c:out value="${student.course}" /></td>
                        </tr>
                    </c:forEach>

                    <!-- If no students, show a message -->
                    <c:if test="${empty students}">
                        <tr>
                            <td colspan="6" class="no-data">No students available</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>
