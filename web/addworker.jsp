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
        .side-bar {
            background: #1b1a1b;
            backdrop-filter: blur(15px);
            width: 250px;
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            overflow-y: auto;
        }
        .side-bar::-webkit-scrollbar {
            width: 0px;
        }
        .side-bar header {
            background: #33363a;
            padding: 10px;
            text-align: center;
            color: white;
        }
        .side-bar header img {
            width: 100px;
            border-radius: 50%;
            margin-bottom: 10px;
        }
        .side-bar header h1 {
            font-size: 20px;
            margin: 0;
            font-weight: normal;
        }
        .side-bar .menu {
            width: 100%;
            margin-top: 20px;
        }
        .side-bar .menu .item {
            position: relative;
            cursor: pointer;
        }
        .side-bar .menu .item a {
            color: #fff;
            font-size: 16px;
            text-decoration: none;
            display: block;
            padding: 10px 20px;
            line-height: 40px;
        }
        .side-bar .menu .item a:hover {
            background: #33363a;
        }
        .side-bar .menu .item a i {
            margin-right: 10px;
        }
        .side-bar .menu .item .sub-menu {
            background: #262627;
            display: none;
        }
        .side-bar .menu .item .sub-menu a {
            padding-left: 40px;
        }
        .side-bar .menu .item .sub-menu a:hover {
            background: #33363a;
        }
        .side-bar .menu .item .dropdown {
            position: absolute;
            right: 20px;
            transition: transform 0.3s ease;
        }
        .side-bar .menu .item .rotate {
            transform: rotate(90deg);
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
        .error {
            color: red;
            font-size: 14px;
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
        .main {
            margin-left: 270px;
            padding: 20px;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js" charset="utf-8"></script>
</head>
<body>
    <div class="side-bar">
        <header>
            <img src="" alt="">
            <h1>Welcome</h1>
        </header>
        <div class="menu">
            <div class="item"><a href="#"><i class="fas fa-desktop"></i>Dashboard</a></div>
            <div class="item">
                <a class="sub-btn"><i class="fas fa-table"></i>Services<i class="fas fa-angle-right dropdown"></i></a>
                <div class="sub-menu">
                    <a href="requestservice.jsp" class="sub-item">Request</a>
                    <a href="addworker.jsp" class="sub-item">Add workers</a>
                    <a href="updateapartmenttype.jsp" class="sub-item">Update apart</a>
                </div>
            </div>
            <div class="item"><a href="#"><i class="fas fa-th"></i>Forms</a></div>
            <div class="item">
                <a class="sub-btn"><i class="fas fa-cogs"></i>Settings<i class="fas fa-angle-right dropdown"></i></a>
                <div class="sub-menu">
                    <a href="userDetails" class="sub-item">Account details</a>
                    <a href="#" class="sub-item">
                        <%
                        String username = null;
                        Cookie[] cookies = request.getCookies();
                        if (cookies != null) {
                            for (Cookie cookie : cookies) {
                                if (cookie.getName().equals("user")) {
                                    username = cookie.getValue();
                                    break;
                                }
                            }
                        }
                        if (username != null) {
                            out.println("<a href='LogoutServlet'>Logout</a>");
                        } else {
                            response.sendRedirect("login.jsp");
                            return;
                        }
                        %>
                    </a>
                </div>
            </div>
            <div class="item"><a href="#"><i class="fas fa-info-circle"></i>About</a></div>
        </div>
    </div>
    <div class="main">
        <div class="container">
            <h2>Add Worker</h2>
            <form action="AddWorkerServlet" method="post">
                <label for="baseSalary">Base Salary:</label>
                <input type="text" name="baseSalary" id="baseSalary">
                <div class="error">${errorMsg.contains('Base salary') ? 'Base salary must be greater than 0 and a valid number.' : ''}</div>

                <label for="salaryMultiplier">Salary Multiplier:</label>
                <input type="text" name="salaryMultiplier" id="salaryMultiplier">
                <div class="error">${errorMsg.contains('Salary multiplier') ? 'Salary multiplier must be greater than 0 and a valid number.' : ''}</div>

                <label for="job">Job:</label>
                <input type="text" name="job" id="job">

                <label for="lastLoginDay">Last Login Day:</label>
                <input type="date" name="lastLoginDay" id="lastLoginDay">
                <div class="error">${errorMsg.contains('last login day') ? 'Invalid last login day format.' : ''}</div>

                <label for="username">Username:</label>
                <input type="text" name="username" id="username">
                <div class="error">${errorMsg.contains('Username') ? 'Username is already taken.' : ''}</div>

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
                <div class="error">${errorMsg.contains('birthdate') ? 'Invalid birthdate format.' : ''}</div>

                <label for="rollID">Role ID:</label>
                <input type="text" name="rollID" id="rollID">
                <div class="error">${errorMsg.contains('Role ID') ? 'Role ID must be greater than 0 and a valid integer.' : ''}</div>

                <input type="submit" value="Add Worker">
            </form>
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.sub-btn').click(function () {
                $(this).next('.sub-menu').slideToggle();
                $(this).find('.dropdown').toggleClass('rotate');
            });
        });
    </script>
</body>
</html>
