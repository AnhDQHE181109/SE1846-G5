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
    
    int x = (int) session.getAttribute("x");
    int dim = (int) session.getAttribute("dim");
    int count = 1;
    int c = 0;
    int[] atarray = (int[]) session.getAttribute("atarray");
    int abs = 0;
    for(int i = 0; i < dim; i++){if (atarray[i] == 1){abs++;}}
    float salary_multi = 100 - abs;
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            html{
                box-sizing: border-box;
                line-height: 1.6rem;
                font-size: 62.5%;
                font-family: 'Roboto', sans-serif;
            }
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
                width: 80%;
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

        <div>
            <a href="userDetails">User details</a>
        </div>
        <div> <h2>Absence = <%=abs%> days</h2></div>
        <div> <h2>Salary Multiplier = <%=salary_multi%>%</h2></div>
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

                <%for(int i = 0; i < x; i++){%>
                <td class="std"> <div style="background-color: white" class ='square'></div> </td>
                <%}%>

                <%for(int i = 0; i < 7-x-1; i++){%>
                <%if(atarray[c] == 0){%>
                <td class="std"> <div style="background-color: #e3e3e3" class ='square'><%=c+1%></div> </td>
                <%}%>
                <%if(atarray[c] == 1){%>
                <td class="std"> <div style="background-color: #ffd6d0" class ='square'><%=c+1%></div> </td>
                <%}%>
                <%if(atarray[c] == 2){%>
                <td class="std"> <div style="background-color: #c6e8da" class ='square'><%=c+1%></div> </td>
                <%}%>
                <%c++;}%> 

                <td class="std"> <div style="background-color: #bedae5" class ='square'><%=c+1%></div> </td>
                <%c++;%>
            <tr>
                <%for(int i = 0; i < dim-7+2; i++){%>

            <%if (count == 0){%><tr><%}%>
                <%if(atarray[c] == 0){%>
                <td class="std"> <div style="background-color: #e3e3e3" class ='square'><%=c+1%></div> </td>
                <%}%>
                <%if(atarray[c] == 1){%>
                <td class="std"> <div style="background-color: #ffd6d0" class ='square'><%=c+1%></div> </td>
                <%}%>
                <%if(atarray[c] == 2){%>
                <td class="std"> <div style="background-color: #c6e8da" class ='square'><%=c+1%></div> </td>
                <%}%>
                <%if(atarray[c] == 3){%>
                <td class="std"> <div style="background-color: #bedae5" class ='square'><%=c+1%></div> </td>
                <%}%>
                <%if (count == 7){%></tr><%;count = 0;}%>
                <%count++;c++;}%> 
        </tr>
        <%%>
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
