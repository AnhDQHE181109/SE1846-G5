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
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <style>
        .light-gray {
            background-color: lightgray;
        }
        .dark-gray {
            background-color: darkgray;
        }
        .light-green {
            background-color: lightgreen;
        }
    </style>
    <body>
        <h1>Assigned Services</h1>
        <table border="1">
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
                    if (alist != null){
                    for(ServiceRequest sr : alist){%>
                <tr>
                    <td><%= sr.getRequestdate() %></td>
                    <td><%= sr.getAssigndate() %></td>
                    <td><%= sr.getTitle() %></td>
                    <td><%= sr.getDescription() %></td>
                    <%if (sr.getFinishdate() != null) {%>
                    <td>Finished on <%= sr.getFinishdate()%></td> <%}else{%>
                    <td> <form action="RequestStatusServlet" method="get">
                            <input type="hidden" name="requestID" value="<%= sr.getRequestID() %>">
                            <input class ="finish" type="submit" value="Finish">
                        </form></td>
                        <%}%>
                </tr>               
                <%
                    }
                }
                %>
            </tbody>
        </table>
        <h1>Unassigned Services</h1>
        <table border="1">
            <thead>
                <tr>
                    <th>Request Date</th>
                    <th>Title</th>
                    <th>Description</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (ualist != null){
                    for(ServiceRequest sr : ualist){%>
                <tr>
                    <td><%= sr.getRequestdate() %></td>
                    <td><%= sr.getTitle() %></td>
                    <td><%= sr.getDescription() %></td>
                    <td> <form action="RequestStatusServlet" method="post">
                            <input type="hidden" name="requestID" value="<%= sr.getRequestID() %>">
                            <input class ="assign" type="submit" value="Self Assign">
                       </form></td>
                </tr>               
                <%
                    }
                }
                %>
            </tbody>
        </table>
    </body>
</html>
