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
<%@ page import="model.ApartmentType, DAO.ApartmentTypeDAO" %>
<html>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            color: #333;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        h1 {
            font-size: 24px;
            margin-bottom: 20px;
            color: #007BFF;
        }
        .apartment-list {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
        }
        .apartment-item {
            flex: 1 1 calc(33.333% - 40px);
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }
        .apartment-item:hover {
            transform: translateY(-5px);
        }
        .apartment-item img {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            margin-bottom: 15px;
        }
        .apartment-item h2 {
            font-size: 20px;
            margin-bottom: 10px;
            color: #333;
        }
        .button {
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
        .button:hover {
            background-color: #0056b3;
        }
    </style>
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
        <%
            ApartmentTypeDAO dao = new ApartmentTypeDAO();
            List<ApartmentType> apartmentTypes = dao.getApartmentTypes();
        %>
        <!DOCTYPE html>
    <html>
        <head>
            <meta charset="UTF-8">
            <title>Apartment Types</title>

        </head>
        <body>
            <div class="container">
                <h1>Available Apartment Types</h1>
                <form action="ViewApartmentDetails" method="get"> 
                <div class="apartment-list">
                    <% for (ApartmentType apartmentType : apartmentTypes) { %>
                    <div class="apartment-item">
                        <img src="images/type<%= apartmentType.getTypeID() %>_1.jpg" alt="Apartment Type <%= apartmentType.getTypeID() %>">
                        <h2>Type <%= apartmentType.getTypeID() %> - <%= apartmentType.getSize() %></h2>
                        <p>Base Rent: $<%= apartmentType.getBaseRent() %> per month</p>
                        <button type="submit" name="typeID" value="1">View</button>
                    </div>
                    <% } %>
                </div>
                </form>
            </div>
        </body>
    </html>

</body>

</html>
