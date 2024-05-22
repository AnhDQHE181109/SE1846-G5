<%-- 
    Document   : worker
    Created on : May 21, 2024, 1:19:56 PM
    Author     : Long
--%>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="jakarta.servlet.http.Cookie" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    List<NotificationAlert> notilist = (List<NotificationAlert>) session.getAttribute("notilist");
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .bell-icon {
                cursor: pointer;
                font-size: 24px;
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
                width: 100%;
                border-collapse: collapse;
                text-align: center;
            }
            tr{
                padding: 0px 30px;
            }
        </style>
    </head>
    <body>

        <h2>Welcome</h2>
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
            }           
        %>
        <div>
            <span class="bell-icon" onclick="toggleNotificationBox()">🔔</span>
            <div id="notificationBox" class="notification-box">
                <%
                    if (notilist != null && !notilist.isEmpty()) {
                        for (NotificationAlert notification : notilist) {

                %>
                <div class="notification-item">
                    <%= notification.toString() %>
                </div>
                <%
                        }
                    } else {
                %>
                <div class="notification-item">No notifications</div>
                <%
                    }
                %>
            </div>
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
                <%for(int i = 0; i < 3; i++){%>
                <td class="std"> <div class ='square'></div> </td>
                <%}%>      
            </tr>
        </table>
        <script>
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
