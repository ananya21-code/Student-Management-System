
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Student</title>

    <!-- Custom CSS -->
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
            color: #333;
        }
        header {
            background-color: #4CAF50;
            color: white;
            padding: 20px;
            text-align: center;
        }
        main {
            max-width: 600px;
            margin: 30px auto;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            color: #4CAF50;
            margin-bottom: 20px;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            margin-bottom: 5px;
            font-weight: bold;
        }
        input {
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }
        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        button:hover {
            background-color: #45a049;
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

    <!-- JavaScript -->
    <script>
        function showCustomPopup(message, redirectUrl) {
            // Display the modal
            const modal = document.getElementById("successModal");
            const modalMessage = document.getElementById("modalMessage");
            modalMessage.innerText = message; // Set the message
            modal.style.display = "block";

            // Add click event to the "OK" button to redirect
            document.getElementById("closeModal").onclick = function () {
                modal.style.display = "none";
                window.location.href = redirectUrl; // Redirect after modal closes
            };
        }

        document.addEventListener("DOMContentLoaded", function () {
            const successMessage = '${successMessage}';
            const role = '${role}';
            let redirectUrl = "";

            if (successMessage) {
                // Determine the redirect URL based on the role
                if (role === "admin") {
                    redirectUrl = "adminHome.jsp";
                } else if (role === "user") {
                    redirectUrl = "userHome.jsp";
                }

                // Show the custom popup
                showCustomPopup(successMessage, redirectUrl);
            }
        });
    </script>
</head>
<body>
    <header>
        <h1>Add New Student</h1>
    </header>
    <main>
        <h2>Enter Student Details</h2>
        <form action="AddStudentServlet" method="post">
            <label for="firstName">First Name:</label>
            <input type="text" id="firstName" name="firstName" required>

            <label for="lastName">Last Name:</label>
            <input type="text" id="lastName" name="lastName" required>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>

            <label for="phone">Phone:</label>
            <input type="text" id="phone" name="phone" required>

            <label for="course">Course:</label>
            <input type="text" id="course" name="course" required>

            <button type="submit">Add Student</button>
        </form>

        <!-- Display error message if any -->
        <c:if test="${not empty errorMessage}">
            <p class="error-message">${errorMessage}</p>
        </c:if>
    </main>

    <!-- Modal Popup -->
    <div id="successModal" class="modal">
        <div class="modal-content">
            <h3>Success</h3>
            <p id="modalMessage"></p>
            <button id="closeModal">OK</button>
        </div>
    </div>
</body>
</html>