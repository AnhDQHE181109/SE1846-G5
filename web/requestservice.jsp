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
    <style>
        #des {
            width: 300px;
            height: 300px;
        }
    </style>
    <body>
        <form style="margin:10px;" action="ServiceRequestServlet" method="post">
            Type: <select name = "type" id="options" onchange="showOtherInput(this)">
                <option value="Maintenance"> Maintenance</option>
                <option value="Security"> Security</option>
                <option value="Other"> Other</option>
            </select>
            <div style="display:none" id="otherInput">
            Please specify: <input style="margin:10px;" type="text" id="otherText" name="othertype">
            </div>
            <br>
            Title: <input style="margin:10px;" name="title" type="text" maxlength="50"><br>
            Description: <input style="margin:10px;" id="des" name="desc" type="text"><br>
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
