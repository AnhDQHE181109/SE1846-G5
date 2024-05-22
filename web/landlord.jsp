<%-- 
    Document   : landlore
    Created on : May 21, 2024, 1:20:03 PM
    Author     : Long
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
        %> 
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
    <a href="updateapartmenttype.jsp" class="button">Update Apartment Types</a> 
    </body>
    
</html>
