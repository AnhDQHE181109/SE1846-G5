<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.ApartmentType, DAO.ApartmentTypeDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Apartment Type</title>
    <style>
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

        img {
            width: 100px;
            margin: 15px;
            border-radius: 50%;
            margin-left: 70px;
            border: 3px solid #b4b8b9;
        }

        header {
            background: #33363a;
        }

        .bell-icon {
            cursor: pointer;
            font-size: 24px;
            position: absolute;
            right: 10px;
            top: 10px;
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
    </style>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js" charset="utf-8"></script>
</head>
<body>
    <!-- Sidebar menu -->
    <div class="side-bar">
        <header>
            <div class="close-btn">
                <i class="fas fa-times"></i>
            </div>
            <h1>Welcome</h1>
        </header>
        <div class="menu">
            <div class="item"><a href="dashboard.jsp"><i class="fas fa-desktop"></i>Dashboard</a></div>
            <div class="item">
                <a class="sub-btn"><i class="fas fa-table"></i>Management<i class="fas fa-angle-right dropdown"></i></a>
                <div class="sub-menu">
                    <a href="scheduleManager.jsp" class="sub-item">View Workers</a>
                    <a href="addworker.jsp" class="sub-item">Add Workers</a>
                    <a href="updateapartmenttype.jsp" class="sub-item">Update Apartment</a>
                </div>
            </div>
            <div class="item"><a href="#"><i class="fas fa-th"></i>Forms</a></div>
            <div class="item">
                <a class="sub-btn"><i class="fas fa-cogs"></i>Settings<i class="fas fa-angle-right dropdown"></i></a>
                <div class="sub-menu">
                    <a href="#" class="sub-item">Account Details</a>
                    <a href="LogoutServlet" class="sub-item">Logout</a>
                </div>
            </div>
            <div class="item"><a href="#"><i class="fas fa-info-circle"></i>About</a></div>
        </div>
    </div>

    <!-- Toggle button for sidebar -->
    <div class="menu-btn">
        <i class="fas fa-bars"></i>
    </div>

    <!-- Content area -->
    <div class="main">
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

    <!-- JavaScript for sidebar and form interaction -->
    <script>
        $(document).ready(function () {
            // Toggle sidebar
            $('.menu-btn').click(function () {
                $('.side-bar').toggleClass('active');
            });

            // Close sidebar on close button click
            $('.close-btn').click(function () {
                $('.side-bar').removeClass('active');
            });

            // Highlight selected image-item and set typeID for form submission
            $('.image-item').click(function () {
                $('.image-item').removeClass('selected');
                $(this).addClass('selected');
                $('#typeID').val($(this).attr('data-type-id'));
            });

            // Form validation to ensure a type is selected before submission
            $('#updateForm').submit(function (event) {
                if ($('#typeID').val() === '') {
                    alert('Please select an apartment type.');
                    event.preventDefault();
                }
            });
        });
    </script>
</body>
</html>
