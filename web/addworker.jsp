<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Worker</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }
        form {
            display: grid;
            grid-gap: 10px;
        }
        label {
            font-weight: bold;
            color: #555;
        }
        input[type="text"],
        input[type="password"],
        input[type="date"] {
            width: calc(100% - 22px);
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 5px;
            font-size: 16px;
            outline: none;
        }
        input[type="submit"] {
            background-color: #007bff;
            color: #fff;
            padding: 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Add Worker</h2>
        <form action="AddWorkerServlet" method="post">
            <label for="workerID">Worker ID:</label>
            <input type="text" name="workerID" id="workerID">
            
            <label for="userID">User ID:</label>
            <input type="text" name="userID" id="userID">
            
            <label for="baseSalary">Base Salary:</label>
            <input type="text" name="baseSalary" id="baseSalary">
            
            <label for="salaryMultiplier">Salary Multiplier:</label>
            <input type="text" name="salaryMultiplier" id="salaryMultiplier">
            
            <label for="job">Job:</label>
            <input type="text" name="job" id="job">
            
            <label for="lastLoginDay">Last Login Day:</label>
            <input type="date" name="lastLoginDay" id="lastLoginDay">
            
            <label for="username">Username:</label>
            <input type="text" name="username" id="username">
            
            <label for="password">Password:</label>
            <input type="password" name="password" id="password">
            
            <label for="firstname">First Name:</label>
            <input type="text" name="firstname" id="firstname">
            
            <label for="lastname">Last Name:</label>
            <input type="text" name="lastname" id="lastname">
            
            <label for="phoneNumber">Phone Number:</label>
            <input type="text" name="phoneNumber" id="phoneNumber">
            
            <label for="email">Email:</label>
            <input type="text" name="email" id="email">
            
            <label for="profilePictureLink">Profile Picture Link:</label>
            <input type="text" name="profilePictureLink" id="profilePictureLink">
            
            <label for="birthdate">Birthdate:</label>
            <input type="date" name="birthdate" id="birthdate">
            
            <label for="rollID">Role ID:</label>
            <input type="text" name="rollID" id="rollID">
            
            <input type="submit" value="Add Worker">
        </form>
    </div>
</body>
</html>
