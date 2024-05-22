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
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%
    List<NotificationAlert> notilist = (List<NotificationAlert>) session.getAttribute("notilist");
        %>
    </head>
    <style>
        .bell-icon {
            cursor: pointer;
            font-size: 24px;
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
