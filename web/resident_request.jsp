<%-- 
    Document   : resident_request
    Created on : Jun 16, 2024, 1:10:14 PM
    Author     : Long
--%>
<%@ page import="java.util.List" %>
<%@ page import="model.ServiceRequest" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<ServiceRequest> ualist = (List<ServiceRequest>) session.getAttribute("ualist");
    List<ServiceRequest> alist = (List<ServiceRequest>) session.getAttribute("alist");
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>
<!DOCTYPE html>
<html lang="en" dir="ltr">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resident Request</title>
    <style media="screen">
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Poppins", sans-serif;
        }

        body {
            min-height: 100vh;
            background: white;
            color: black;
            background-size: cover;
            background-position: center;
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

        h1 {
            text-align: center;
            font-weight: 500;
            font-size: 25px;
            padding-bottom: 13px;
            font-family: sans-serif;
            letter-spacing: 2px;
        }

        .side-bar .menu {
            width: 100%;
            margin-top: 30px;
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
            padding: 5px 30px;
            line-height: 60px;
        }

        .side-bar .menu .item a:hover {
            background: #33363a;
            transition: 0.3s ease;
        }

        .side-bar .menu .item i {
            margin-right: 15px;
        }

        .side-bar .menu .item a .dropdown {
            position: absolute;
            right: 0;
            margin: 20px;
            transition: 0.3s ease;
        }

        .side-bar .menu .item .sub-menu {
            background: #262627;
            display: none;
        }

        .side-bar .menu .item .sub-menu a {
            padding-left: 80px;
        }

        .rotate {
            transform: rotate(90deg);
        }

        .main {
            color: black;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 50px;
            margin-left: 250px;
            width: calc(100% - 250px);
        }

        .container {
            margin-top: 20px;
            padding: 20px;
            max-width: 1200px;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        .table-container {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }

        .light-gray {
            background-color: lightgray;
        }

        .dark-gray {
            background-color: darkgray;
        }

        .light-green {
            background-color: lightgreen;
        }

        button {
            display: inline-block;
            padding: 10px 20px;
            margin-top: 10px;
            font-size: 16px;
            color: #fff;
            background-color: #007BFF;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #0056b3;
        }

        header {
            background: #33363a;
            padding: 10px;
            text-align: center;
        }

        header img {
            width: 100px;
            border-radius: 50%;
            border: 3px solid #b4b8b9;
            margin-bottom: 10px;
        }

        header h1 {
            color: white;
            font-size: 20px;
        }

        .bell-icon {
            cursor: pointer;
            font-size: 24px;
            position: absolute;
            right: 10px;
            top: 10px;
        }

        .notification-box {
            display: none;
            border: 1px solid #ccc;
            background: #fff;
            padding: 10px;
            position: absolute;
            right: 10px;
            top: 40px;
            width: 300px;
            max-height: 400px;
            overflow-y: auto;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .notification-item {
            border-bottom: 1px solid #ddd;
            padding: 5px;
        }

        .notification-item:last-child {
            border-bottom: none;
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
                    <a href="billing.jsp" class="sub-item">Bill</a>
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

    <section class="main">
        <div class="container">
            <h1>Assigned Services</h1>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Request Date</th>
                            <th>Assign Date</th>
                            <th>Title</th>
                            <th>Description</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (alist != null) {
                                for (ServiceRequest sr : alist) {
                                    String rowClass = sr.getFinishdate() != null ? "light-green" : "dark-gray";
                                    String status = sr.getFinishdate() != null ? "Finished on " + sdf.format(sr.getFinishdate()) : 
                                    "<form action='RequestStatusServlet' method='get'><input type='hidden' name='requestID' value='" + sr.getRequestID() + "'><input type='submit' value='Finish'></form>";
                        %>
                        <tr class="<%= rowClass %>">
                            <td><%= sdf.format(sr.getRequestdate()) %></td>
                            <td><%= sr.getAssigndate() != null ? sdf.format(sr.getAssigndate()) : "" %></td>
                            <td><%= sr.getTitle() %></td>
                            <td><%= sr.getDescription() %></td>
                            <td><%= status %></td>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
            <h1>Unassigned Services</h1>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Request Date</th>
                            <th>Title</th>
                            <th>Description</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (ualist != null) {
                                for (ServiceRequest sr : ualist) {
                        %>
                        <tr class="light-gray">
                            <td><%= sdf.format(sr.getRequestdate()) %></td>
                            <td><%= sr.getTitle() %></td>
                            <td><%= sr.getDescription() %></td>
                            <td>
                                <form action="RequestStatusServlet" method="post">
                                    <input type="hidden" name="requestID" value="<%= sr.getRequestID() %>">
                                    <input type="submit" value="Self Assign">
                                </form>
                            </td>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </section>

    <script>
        $(document).ready(function () {
            //jquery for toggle sub menus
            $('.sub-btn').click(function () {
                $(this).next('.sub-menu').slideToggle();
                $(this).find('.dropdown').toggleClass('rotate');
            });
        });
    </script>
</body>

</html>
