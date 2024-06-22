<%-- 
    Document   : resident
    Created on : May 21, 2024, 1:19:48 PM
    Author     : Long
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="jakarta.servlet.http.Cookie" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en" dir="ltr">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resident</title>
    <%
    List<NotificationAlert> notilist = (List<NotificationAlert>) session.getAttribute("notilist");       
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    int x = (int) session.getAttribute("x");
    int dim = (int) session.getAttribute("dim");
    int count = 1;
    int c = 0;
    int[] atarray = (int[]) session.getAttribute("atarray");
    int abs = 0;
    for(int i = 0; i < dim; i++){if (atarray[i] == 1){abs++;}}
    if (abs <= 4){abs = 0;}else{abs -= 4;}
    float salary_multi = 100 - abs;
    %>  
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
            color: white;
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
            height: 100vh;
            padding: 50px;
            margin-left: 250px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        @media (max-width: 900px) {
            .main h1 {
                font-size: 40px;
                line-height: 60px;
            }
        }

        img {
            width: 100px;
            margin: 15px;
            border-radius: 50%;
            margin-left: 70px;
            border: 3px solid #b4b8b9;
        }

        header {
            background: #33363a;
        }

        .bell-icon {
            cursor: pointer;
            font-size: 24px;
            position: absolute;
            right: 10px;
            top: 10px;
        }

        .square {
            height: 50px;
            width: 50px;
            max-width: 100%;
            background-color: #555;
            text-align: center;
            color: black;
            background-color: #e0e0e0;
            border-radius: 15px;
            margin: 5px auto;
            display: flex;
            justify-content: center;
            align-items: center;
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

        table {
            width: 80%;
            border-collapse: collapse;
            text-align: center;
        }

        tr {
            padding: 0px 30px;
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
                    <a href="resident_request.jsp" class="sub-item">Resident Request</a>
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
        <div>
            <span class="bell-icon" onclick="toggleNotificationBox()">🔔</span>
            <div id="notificationBox" class="notification-box">
                <%
                    if (notilist != null && !notilist.isEmpty()) {
                        for (NotificationAlert notification : notilist) {
                            if(notification.isNotiStatus()){
                %>
                <div class="notification-item" style="background-color:#f0f0f0">
                    <%= notification.toString() %>
                </div>
                <%
                            } else {
                %>
                <div class="notification-item">
                    <%= notification.toString() %>
                </div>
                <%
                            }
                        }
                    } else {
                %>
                <div class="notification-item">No notifications</div>
                <%
                    }
                %>
            </div>
        </div>
        <div>
            <h2>Absence = <%=abs%> days</h2>
        </div>
        <div>
            <h2>Salary Multiplier = <%=salary_multi%>%</h2>
        </div>
        <table>
            <tr>
                <th>Monday</th>
                <th>Tuesday</th>
                <th>Wednesday</th>
                <th>Thursday</th>
                <th>Friday</th>
                <th>Saturday</th>
                <th>Sunday</th>
            </tr>
            <tr class="container">
                <% for(int i = 0; i < x; i++){ %>
                <td class="std">
                    <div style="background-color: white" class='square'></div>
                </td>
                <% } %>
                <% for(int i = 0; i < 7-x-1; i++){ %>
                <% if(atarray[c] == 0){ %>
                <td class="std">
                    <div style="background-color: #e3e3e3" class='square'><%=c+1%></div>
                </td>
                <% } %>
                <% if(atarray[c] == 1){ %>
                <td class="std">
                    <div style="background-color: #ffd6d0" class='square'><%=c+1%></div>
                </td>
                <% } %>
                <% if(atarray[c] == 2){ %>
                <td class="std">
                    <div style="background-color: #c6e8da" class='square'><%=c+1%></div>
                </td>
                <% } %>
                <% c++; } %>
                <td class="std">
                    <div style="background-color: #bedae5" class='square'><%=c+1%></div>
                </td>
                <% c++; %>
            </tr>
            <tr>
                <% for(int i = 0; i < dim-7+2; i++){ %>
                <% if (count == 0){ %><tr><% } %>
                <% if(atarray[c] == 0){ %>
                <td class="std">
                    <div style="background-color: #e3e3e3" class='square'><%=c+1%></div>
                </td>
                <% } %>
                <% if(atarray[c] == 1){ %>
                <td class="std">
                    <div style="background-color: #ffd6d0" class='square'><%=c+1%></div>
                </td>
                <% } %>
                <% if(atarray[c] == 2){ %>
                <td class="std">
                    <div style="background-color: #c6e8da" class='square'><%=c+1%></div>
                </td>
                <% } %>
                <% if(atarray[c] == 3){ %>
                <td class="std">
                    <div style="background-color: #bedae5" class='square'><%=c+1%></div>
                </td>
                <% } %>
                <% if (count == 7){ %></tr><% count = 0; } %>
                <% count++; c++; } %>
            </tr>
        </table>
    </section>

    <script type="text/javascript">
        $(document).ready(function () {
            //jquery for toggle sub menus
            $('.sub-btn').click(function () {
                $(this).next('.sub-menu').slideToggle();
                $(this).find('.dropdown').toggleClass('rotate');
            });
        });

        function toggleNotificationBox() {
            var notificationBox = document.getElementById('notificationBox');
            if (notificationBox.style.display === 'none' || notificationBox.style.display === '') {
                notificationBox.style.display = 'block';
            } else {
                notificationBox.style.display = 'none';
            }
        }
    </script>

</body>

</html>
