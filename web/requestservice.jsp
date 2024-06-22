<%-- 
    Document   : requestservice
    Created on : May 26, 2024, 5:26:13 PM
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
        <form action="ServiceRequestServlet" method="post">
            <h2>Request Service</h2>
            <label for="options">Type:</label>
            <select name="type" id="options" onchange="showOtherInput(this)">
                <option value="Maintenance">Maintenance</option>
                <option value="Security">Security</option>
                <option value="Other">Other</option>
            </select>
            <div id="otherInput" style="display:none">
                <label for="otherText">Please specify:</label>
                <input type="text" id="otherText" name="othertype">
            </div>
            <label for="title">Title:</label>
            <input name="title" type="text" maxlength="50" id="title">
            <label for="des">Description:</label>
            <input id="des" name="desc" type="text">
            <button type="submit">Submit</button>
        </form>

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
