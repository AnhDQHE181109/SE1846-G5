<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.ApartmentType, DAO.ApartmentTypeDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Apartment Details</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            color: #333;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 600px;
            margin: 40px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            text-align: center;
        }
        h1 {
            font-size: 24px;
            margin-bottom: 20px;
            color: #007BFF;
        }
        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            box-sizing: border-box;
        }
        .form-group .error {
            color: red;
            font-size: 14px;
        }
        .button {
            display: inline-block;
            padding: 10px 20px;
            margin: 10px;
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
    <script>
        function validateForm() {
            let isValid = true;
            let size = document.getElementById("size").value;
            let baseRent = document.getElementById("baseRent").value;
            let sizeError = document.getElementById("sizeError");
            let baseRentError = document.getElementById("baseRentError");

            sizeError.textContent = "";
            baseRentError.textContent = "";

            if (size.trim() === "") {
                sizeError.textContent = "Size is required.";
                isValid = false;
            }

            if (baseRent.trim() === "" || parseFloat(baseRent) <= 0) {
                baseRentError.textContent = baseRent.trim() === "" ? "Base rent is required." : "Base rent must be greater than 0.";
                isValid = false;
            }

            return isValid;
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Update Apartment Details</h1>
        <%
            int typeID = Integer.parseInt(request.getParameter("typeID"));
            ApartmentTypeDAO apartmentTypeDAO = new ApartmentTypeDAO();
            ApartmentType apartmentType = apartmentTypeDAO.getApartmentTypeByID(typeID);
            if (apartmentType != null) {
        %>
        <form action="UpdateApartmentType" method="post" onsubmit="return validateForm();">
            <input type="hidden" name="typeID" value="<%= apartmentType.getTypeID() %>">
            <div class="form-group">
                <label for="size">Size:</label>
                <input type="text" id="size" name="size" value="<%= apartmentType.getSize() %>" required>
                <div id="sizeError" class="error"><%= request.getAttribute("sizeError") != null ? request.getAttribute("sizeError") : "" %></div>
            </div>
            <div class="form-group">
                <label for="baseRent">Base Rent:</label>
                <input type="number" step="0.01" id="baseRent" name="baseRent" value="<%= apartmentType.getBaseRent() %>" required>
                <div id="baseRentError" class="error"><%= request.getAttribute("baseRentError") != null ? request.getAttribute("baseRentError") : "" %></div>
            </div>
            <button type="submit" class="button">Update</button>
        </form>
        <%
            } else {
                out.println("<p>Apartment type not found.</p>");
            }
        %>
    </div>
</body>
</html>
