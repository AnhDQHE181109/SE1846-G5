<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Worker</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            color: #333;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 600px;
            margin: 40px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        h1 {
            font-size: 24px;
            margin-bottom: 20px;
            color: #007BFF;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            margin-bottom: 10px;
        }
        input, select {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }
        button {
            padding: 10px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #007BFF;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        button:hover {
            background-color: #0056b3;
        }
        .password-container {
            position: relative;
            width: fit-content;
        }
        .password-container input {
            padding-right: 30px;
        }
        .toggle-password {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
        }
    </style>
    <script>
        function togglePasswordVisibility() {
            var passwordField = document.getElementById("password");
            var toggleIcon = document.getElementById("toggleIcon");
            if (passwordField.type === "password") {
                passwordField.type = "text";
                toggleIcon.textContent = "🙈"; // Change to an icon representing hidden state
            } else {
                passwordField.type = "password";
                toggleIcon.textContent = "👁️"; // Change to an icon representing visible state
            }
        }
    </script>
</head>
<body>
    <h1>Add Worker</h1>
    <form action="AddWorkerServlet" method="post">
        <label for="workerID">Worker ID:</label>
        <input type="number" id="workerID" name="workerID" required><br>
        
        <label for="userID">User ID:</label>
        <input type="number" id="userID" name="userID" required><br>
        
        <label for="baseSalary">Base Salary:</label>
        <input type="number" step="0.01" id="baseSalary" name="baseSalary" required><br>
        
        <label for="salaryMultiplier">Salary Multiplier:</label>
        <input type="number" step="0.01" id="salaryMultiplier" name="salaryMultiplier" required><br>
        
        <label for="job">Job:</label>
        <input type="text" id="job" name="job" required><br>
        
        <label for="llogin">Last Login:</label>
        <input type="date" id="llogin" name="llogin" required><br>
        
        <h2>Account Information</h2>
        
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required><br>
        
        <div class="password-container">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
            <span id="toggleIcon" class="toggle-password" onclick="togglePasswordVisibility()">👁️</span>
        </div><br>
        
        <label for="firstname">First Name:</label>
        <input type="text" id="firstname" name="firstname" required><br>
        
        <label for="lastname">Last Name:</label>
        <input type="text" id="lastname" name="lastname" required><br>
        
        <label for="phoneNumber">Phone Number:</label>
        <input type="text" id="phoneNumber" name="phoneNumber" required><br>
        
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required><br>
        
        <label for="birthdate">Birth Date:</label>
        <input type="date" id="birthdate" name="birthdate" required><br>
        
        <button type="submit">Add Worker</button>
    </form>
    
    <c:if test="${not empty errorMessage}">
        <p style="color:red;">${errorMessage}</p>
    </c:if>
</body>
</html>
