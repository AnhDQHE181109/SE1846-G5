<%-- 
    Document   : login.jsp
    Created on : May 21, 2024, 2:39:04 PM
    Author     : Long
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Form</title>
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    </head>
    <%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    %>
    <body>
        <style>
            header{
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                display: flex;
                justify-content: space-between;
                align-items: center;
                transition: 0.6s;
                padding: 40px 100px;
                z-index: 1000000;

            }
            header.sticky{
                padding: 10px 50px;
                background-color: #fff;
            }
            .logo{
                position: relative;
                font-weight: 700px;
                color: black;
                text-decoration: none;
                font-size: 1em;
                letter-spacing: 2px;
                transition: 0.6s
            }
            header ul{
                position: relative;
                display: flex;
                justify-content: center;
                align-items: center;

            }
            header ul li{
                position: relative;
                list-style: none;
                font-size: 2rem;
            }
            header ul li a{
                position: relative;
                margin: 0 15px;
                text-decoration: none;
                color: black;
                letter-spacing: 2px;
                font-weight: 500px;
                transition: 0.5s;
            }
            *{
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: "Poppins", sans-serif;
            }
            body{
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                background-image: url("<%= request.getContextPath() %>/image/vecteezy_blue-sky-and-clouds-reflected-on-the-glass-of-office_8286983.jpg");
                background-repeat: no-repeat;
                background-size: cover;
                background-position: center;
            }
            .wrapper{
                margin-top: 100px;
                width: 420px;
                border: 2px solid rgba(255, 255, 255, .2);
                backdrop-filter: blur(9px);
                color: black;
                border-radius: 12px;
                padding: 30px 40px;
            }
            .wrapper h1{
                font-size: 36px;
                text-align: center;
            }
            .wrapper .input-box{
                position: relative;
                width: 100%;
                height: 50px;
                margin: 30px 0;
            }
            .input-box input{
                width: 100%;
                height: 100%;
                border: none;
                outline: none;
                border: 2px solid rgba(255, 255, 255, .2);
                border-radius: 40px;
                font-size: 16px;
                color:black;
                padding: 20px 45px 20px 20px;
            }
            .input-box input::placeholder{
                color: black;
            }
            .input-box i{
                position: absolute;
                right: 20px;
                top: 30%;
                transform: translate(-50%);
                font-size: 20px;

            }
            .wrapper .remember-forgot{
                display: flex;
                justify-content: space-between;
                font-size: 14.5px;
                margin: -15px 0 15px;
            }
            .remember-forgot label input{
                accent-color: black;
                margin-right: 3px;

            }
            .remember-forgot a{
                color: black;
                text-decoration: none;

            }
            .remember-forgot a:hover{
                text-decoration: underline;
            }
            .wrapper .btn{
                width: 100%;
                height: 45px;
                background: #fff;
                border: none;
                outline: none;
                border-radius: 40px;
                box-shadow: 0 0 10px rgba(0, 0, 0, .1);
                cursor: pointer;
                font-size: 16px;
                color: #333;
                font-weight: 600;
            }
            .wrapper .register-link{
                font-size: 14.5px;
                text-align: center;
                margin: 20px 0 15px;

            }
            .register-link p a{
                color: #fff;
                text-decoration: none;
                font-weight: 600;
            }
            .register-link p a:hover{
                text-decoration: underline;
            }
            .datepicker-toggle {
                display: inline-block;
                position: relative;
                width: 18px;
                height: 19px;
            }
            .datepicker-toggle-button {
                position: absolute;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-image: url('data:image/svg+xml;base64,...');
            }

        </style>
        <header class="header sticky">
            <ul>
                <li><a href="#" class="logo">Logo</a></li>
                <li class="navbar_list"><a href="index.jsp">Home</a></li>
                <li class="navbar_list"><a href="#">Privacy</a></li>
                <li class="navbar_list"><a href="#">About us</a></li>
            </ul>
            <ul class="navbar_header">
                <li class="navbar_list"><a href="login.jsp">Login</a></li>
            </ul>
        </header>
        <div class="wrapper">
            <form action="SignUpServlet" method="post">
                <h1>Sign Up</h1>
                <%if("true".equals(request.getParameter("error_usernametaken"))){%>
                <p style='color:red;'>Username has already been taken!</p>
                <%}%>
                <%if("true".equals(request.getParameter("error_username"))){%>
                <p style='color:red;'>Username has already been taken!</p>
                <%}%>
                <div class="input-box">
                    <input type="text" id="username" name="username" value="${username != null ? username : ''}" placeholder='Username' required>
                    <i class='bx bxs-user'></i>
                </div>
                <%if("true".equals(request.getParameter("error_pasword"))){%>
                <p style='color:red;'>Password must be at least 12 characters long and contain at least 1 digit and 1 uppercase character!</p>
                <%}%>
                <div class="input-box">
                    <input type="password" id="password" name="password" placeholder="Password" value="${password != null ? password : ''}" required>
                    <i class='bx bxs-lock-alt' ></i>
                </div>
                <%if("true".equals(request.getParameter("error_firstname"))){%>
                <p style='color:red;'>Invalid first name. Only alphabetic characters allowed!</p>
                <%}%>
                <div class="input-box">
                    <input type="text" id="firstname" name="firstname" placeholder="First name" value="${firstname != null ? firstname : ''}" required>
                </div>
                <%if("true".equals(request.getParameter("error_lastname"))){%>
                <p style='color:red;'>Invalid last name. Only alphabetic characters allowed!</p>
                <%}%>
                <div class="input-box">
                    <input type="text" id="lastname" name="lastname" placeholder="Last name" value="${lastname != null ? lastname : ''}" required>
                </div>
                <div class="input-box">
                    <input type="tel" id="phone_number" name="phone_number" placeholder="Phone number" value="${phone_number != null ? phone_number : ''}" required>
                </div>
                <%if("true".equals(request.getParameter("error_emailtaken"))){%>
                <p style='color:red;'>Email has already been used for another account!</p>
                <%}%>
                <%if("true".equals(request.getParameter("error_email"))){%>
                <p style='color:red;'>Please enter a valid email</p>
                <%}%>
                <div class="input-box">
                    <input type="email" id="email" placeholder="Email" name="email" value="${email != null ? email : ''}" required>
                </div>
                <%if("true".equals(request.getParameter("error_date"))){%>
                <p style='color:red;'>Please enter a valid date!</p>
                <%}%>
                <div>
                    <span class="datepicker-toggle">
                        <span class="datepicker-toggle-button"></span>
                        <input <input type="date" id="birthdate" name="birthdate" value="${birthdate != null ? birthdate : ''}" required class="datepicker-input">
                    </span>
                </div>
                <div class="remember-forgot">
                    <a href="#">Forgot Password</a>
                </div>
                <button type="submit" class="btn">Sign up</button>
            </form>
        </div>
        <script src="js/app.js"></script>
    </body>
</html>
