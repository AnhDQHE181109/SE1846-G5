<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.ApartmentType, DAO.ApartmentTypeDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Apartment Type</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            color: #333;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 800px;
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
        .image-grid {
            display: flex;
            justify-content: space-between;
            gap: 20px;
            margin-top: 20px;
        }
        .image-item {
            flex: 1;
            border: 2px solid transparent;
            border-radius: 8px;
            overflow: hidden;
            transition: border 0.3s ease;
            text-align: center;
        }
        .image-item img {
            max-width: 100%;
            height: auto;
            cursor: pointer;
        }
        .image-item.selected {
            border: 2px solid #007BFF;
        }
        .button {
            display: inline-block;
            padding: 10px 20px;
            margin: 20px;
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
</head>
<body>
    <div class="container">
        <h1>Select Apartment Type to Update</h1>
        <div class="image-grid">
            <div class="image-item" data-type-id="1">
                <img src="image/viewtype1.1.jpg" alt="Type 1">
                <p>Type 1: Small, Cozy, Suitable for Couples</p>
            </div>
            <div class="image-item" data-type-id="2">
                <img src="image/viewtype2.1.jpg" alt="Type 2">
                <p>Type 2: Medium, Suitable for Small Family</p>
            </div>
            <div class="image-item" data-type-id="3">
                <img src="image/viewtype3.1.jpg" alt="Type 3">
                <p>Type 3: Big, Suitable for Big Family</p>
            </div>
        </div>
        <form id="updateForm" action="updateapartmenttypedetails.jsp" method="get">
            <input type="hidden" id="typeID" name="typeID" value="">
            <button type="submit" class="button">Update</button>
        </form>
    </div>
    <script>
        document.querySelectorAll('.image-item').forEach(item => {
            item.addEventListener('click', function() {
                document.querySelectorAll('.image-item').forEach(el => el.classList.remove('selected'));
                this.classList.add('selected');
                document.getElementById('typeID').value = this.getAttribute('data-type-id');
            });
        });
        document.getElementById('updateForm').addEventListener('submit', function(event) {
            if (!document.getElementById('typeID').value) {
                event.preventDefault();
                alert('Please select an apartment type.');
            }
        });
    </script>
</body>
</html>
