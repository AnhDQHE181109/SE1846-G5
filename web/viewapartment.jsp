<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Apartment Details</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <div class="wrapper">
        <h1>Apartment Details</h1>
        <%
            model.ApartmentType apartmentType = (model.ApartmentType) request.getAttribute("apartmentType");
            if (apartmentType != null) {
        %>
            <h2>Apartment Type: <%= apartmentType.getTypeID() %></h2>
            <p>Size: <%= apartmentType.getSize() %></p>
            <p>Base Rent: <%= apartmentType.getBaseRent() %></p>
        <% } else { %>
            <p>Error: Apartment type not found.</p>
        <% } %>
    </div>
</body>
</html>
