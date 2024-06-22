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