<%-- 
    Document   : requestservice
    Created on : May 26, 2024, 5:26:13 PM
    Author     : Long
--%>
<%@ page import="java.util.List" %>
<%@ page import="model.ServiceRequest" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<ServiceRequest> rslist = (List<ServiceRequest>) session.getAttribute("rslist");
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
    </head>
    <body>
        <form action="ServiceRequestServlet" method="post">
            <h2>Request Service</h2>
            <label for="options">Type:</label>
            <select name="type" id="options" onchange="showOtherInput(this)">
                <option value="Maintenance">Maintenance</option>
                <option value="Security">Security</option>
                <option value="Other">Other</option>
            </select>
            <br>
            <div id="otherInput" style="display:none">
                <label for="otherText">Please specify:</label>
                <input type="text" id="otherText" name="othertype">
            </div>
            <label for="title">Title:</label>
            <input name="title" type="text" maxlength="50" id="title"><br>
            <label for="des">Description:</label>
            <input id="des" name="desc" type="text"><br>
            <button type="submit">Submit</button>
        </form>
        <table border="1">
            <thead>
                <tr>
                    <th>Date</th>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (rslist != null) {
                        for (ServiceRequest sr : rslist) {
                            String rowClass = "";
                            String date = "";
                            String status = "";
                            if (sr.getAssigndate() == null) {
                                rowClass = "light-gray";
                                date = sdf.format(sr.getRequestdate());
                                status = "Not assigned";
                            } else if (sr.getFinishdate() == null) {
                                rowClass = "dark-gray";
                                date = sdf.format(sr.getAssigndate());
                                status = "Assigned to a worker";
                            } else {
                                rowClass = "light-green";
                                date = sdf.format(sr.getFinishdate());
                                status = "Finished";
                            }
                %>
                <tr class="<%= rowClass %>">
                    <td><%= date %></td>
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
        <script>
            function showOtherInput(selectElement) {
                var otherInput = document.getElementById("otherInput");
                if (selectElement.value === "Other") {
                    otherInput.style.display = "block";
                } else {
                    otherInput.style.display = "none";
                }
            }
        </script>
    </body>
</html>
