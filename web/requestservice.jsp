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
        <title>Service Request</title>
        <style>
            body {
                background-color: #f5f5f5;
                font-family: 'Arial', sans-serif;
                color: #333;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }
            form {
                background: #ffffff;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                max-width: 400px;
                width: 100%;
                text-align: left;
            }
            h2 {
                text-align: center;
                color: #444;
                margin-bottom: 20px;
            }
            label {
                display: block;
                margin-bottom: 5px;
                color: #555;
                font-weight: bold;
            }
            select, input[type="text"], button {
                width: 100%;
                padding: 10px;
                margin-bottom: 20px;
                border-radius: 5px;
                border: 1px solid #ddd;
                font-size: 14px;
                box-sizing: border-box;
                transition: border-color 0.3s;
            }
            select:focus, input[type="text"]:focus {
                border-color: #007bff;
                outline: none;
            }
            button {
                background-color: #007bff;
                color: #fff;
                border: none;
                cursor: pointer;
                font-size: 16px;
                transition: background-color 0.3s;
            }
            button:hover {
                background-color: #0056b3;
            }
            #otherInput {
                display: none;
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
            <div id="otherInput">
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
