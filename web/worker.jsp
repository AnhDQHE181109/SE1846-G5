<%-- 
    Document   : worker
    Created on : May 21, 2024, 1:19:56 PM
    Author     : Long
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
    </body>
</html>
