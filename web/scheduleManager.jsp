<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.util.*" %>
<%@page import = "java.sql.*" %>
<%@page import = "model.*" %>
<!DOCTYPE html>
<%
Integer dayOfWeek = (Integer) request.getAttribute("dayOfWeek");
Integer daysInMonth = (Integer) request.getAttribute("daysInMonth");
String dateHeader = (String) request.getAttribute("dateHeader");
List<Integer> daysOfWork = (List<Integer>) request.getAttribute("daysOfWork");
Integer month = (Integer) request.getAttribute("month");
Integer year = (Integer) request.getAttribute("year");

int dayOfMonth = 1;
String linkOrNot = "";

response.setHeader("Cache-Control", "private, no-store, no-cache, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Schedule manager</title>
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
    <%
        Account account = (Account) session.getAttribute("account");
        if (account != null) {
            if (account.getRollID() == 3) {
        %>

    <h2 style="text-align:center"><%=dateHeader %></h2>
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
            <% for (int i = 0; i < dayOfWeek - 2; i++) { %>
                <td class="std"> <div style="background-color: white" class ='square'></div> </td>
            <% } %>

            <%    for (int j = dayOfWeek - 2; j < 7 && (dayOfMonth <= daysInMonth); j++) {
                    if (daysOfWork != null) {
                        if (!daysOfWork.isEmpty()) {
                            for (Integer workDay : daysOfWork) {
                                if (workDay == dayOfMonth) {
                                    linkOrNot = "<a href=\"scheduleManager?checkDate=" + year + "-" + month + "-" + dayOfMonth + "\">" + dayOfMonth + "</a>";
                                    break;
                                } else {
                                    linkOrNot = dayOfMonth + "";
                                }
                            }
                        }
                    }

                    if (j == 6) { %>
                    <td class="std"> <div style="background-color: #bedae5" class ='square'><%=linkOrNot %></div> </td>
                    <% } else { %>
                    <td class="std"> <div style="background-color: #e3e3e3" class ='square'><%=linkOrNot %></div> </td>
                    <% } %>
            <%      dayOfMonth++;
            } %>

            <% for (int i = 0; dayOfMonth <= daysInMonth; i++) { %>
                <tr>
            <%    for (int j = 0; j < 7 && (dayOfMonth <= daysInMonth); j++) { 
                    if (daysOfWork != null) {
                        if (!daysOfWork.isEmpty()) {
                            for (Integer workDay : daysOfWork) {
                                if (workDay == dayOfMonth) {
                                    linkOrNot = "<a href=\"scheduleManager?checkDate=" + year + "-" + month + "-" + dayOfMonth + "\">" + dayOfMonth + "</a>";
                                    break;
                                } else {
                                    linkOrNot = dayOfMonth + "";
                                }
                            }
                        }
                    }

                    if (j == 6) { %>
                    <td class="std"> <div style="background-color: #bedae5" class ='square'><%=linkOrNot %></div> </td>
                    <% } else { %>
                    <td class="std"> <div style="background-color: #e3e3e3" class ='square'><%=linkOrNot %></div> </td>
                    <% } %>
            <%      dayOfMonth++;
            } %>
                </tr>
            <% } %>
        </tr>
    
    </table>

    <br><br>

    <% List<WorkersWorkInDay> workersList = (List<WorkersWorkInDay>) request.getAttribute("workersList");
       java.sql.Date checkDate = (java.sql.Date) request.getAttribute("checkDate");
       if (workersList != null) {
        if (!workersList.isEmpty()) {
    %>
    <h2>Workers assigned on <%=checkDate %></h2>
    <table>
        <tr>
            <th>Picture</th>
            <th>First name</th>
            <th>Last name</th>
            <th>Contact number</th>
            <th>Task title</th>
            <th>Task description</th>
            <th>Task assigned date</th>
        </tr>

        <% for (WorkersWorkInDay worker : workersList) { %>
        <tr>
            <td><img src="<%=worker.getProfilePictureLink() %>"></td>
            <td><%=worker.getFirstName() %></td>
            <td><%=worker.getLastName() %></td>
            <td><%=worker.getPhoneNumber() %></td>
            <td><%=worker.getTitle() %></td>
            <td><%=worker.getDescription() %></td>
            <td><%=worker.getAssignDate() %></td>
        </tr>
        <% } %>
    </table>
   
    <%
        }
       } %>  
       
    <%
            } else { %>
                <script>location.href="login.jsp"</script>
    <%      }
        } else { %>
            <script>location.href="login.jsp"</script>
    <%
    }
    %>
</body>
</html>