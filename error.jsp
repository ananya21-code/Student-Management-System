<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8d7da;
            color: #721c24;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 100%;
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            border-radius: 5px;
        }
        h2 {
            color: #721c24;
        }
        p {
            color: #721c24;
        }
        .btn {
            padding: 10px 20px;
            background-color: #f5c6cb;
            border: none;
            border-radius: 5px;
            color: #721c24;
            text-decoration: none;
            font-weight: bold;
        }
        .btn:hover {
            background-color: #f1b0b7;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Error</h2>
        <p><strong>Sorry, something went wrong.</strong></p>

        <!-- Display the error message passed from the servlet -->
        <c:if test="${not empty errorMessage}">
            <p>Error Details: ${errorMessage}</p>
        </c:if>

        <!-- Display the exception details if available -->
        <c:if test="${not empty exception}">
            <p><strong>Exception:</strong> ${exception.message}</p>
            <p><strong>Stack Trace:</strong></p>
            <pre>${exception.stackTrace}</pre>
        </c:if>

        <!-- Provide a link to return to the homepage or any other page -->
        <a href="index.jsp" class="btn">Go Back to Home</a>
    </div>
</body>
<head>
    <title>Error</title>
</head>
<body>
    <h2>Error</h2>
    <p>${errorMessage}</p>
    <a href="studentList">Go Back to Student List</a>
</body>
</html>