<%-- 
    Document   : test
    Created on : May 21, 2024, 12:57:02 PM
    Author     : Long
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
     <style>
        .notification-bell {
            position: relative;
            display: inline-block;
        }

        .bell-icon {
            width: 32px;
            height: 32px;
            cursor: pointer;
            margin-left: 1000px;
        }

        .notifications {
            display: none;
            position: absolute;
            top: 40px;
            right: 0;
            width: 300px;
            border: 1px solid #ccc;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            z-index: 1;
        }

        .notification-item {
            padding: 10px;
            border-bottom: 1px solid #eee;
        }
    </style>
</head>
<body>
    <div class="notification-bell">
        <img src="image/bell-icon.png" alt="Notifications" class="bell-icon" id="bell-icon">
        <div class="notifications" id="notification-list">
            <!-- Notifications will be inserted here -->
        </div>
    </div>

    <script>
        // Mock of the Noti object array
        const notiList = [
            { date: '2024-05-21', message: 'You have a new message.', userID: 1, read: false },
            { date: '2024-05-20', message: 'Your order has been shipped.', userID: 2, read: true },
            // Add more notifications here
        ];

        function renderNotifications() {
            const notificationList = document.getElementById('notification-list');
            notificationList.innerHTML = ''; // Clear previous notifications

            notiList.forEach(noti => {
                const notiElement = document.createElement('div');
                notiElement.className = 'notification-item';
                notiElement.innerHTML = `
                    <div>${noti.date}</div>
                    <div>${noti.message}</div>
                `;
                notificationList.appendChild(notiElement);
            });
        }

        document.getElementById('bell-icon').addEventListener('click', function() {
            const notificationList = document.getElementById('notification-list');
            notificationList.classList.toggle('active');
            if (notificationList.classList.contains('active')) {
                notificationList.style.display = 'block';
                renderNotifications();
            } else {
                notificationList.style.display = 'none';
            }
        });
    </script>
    </body>
</html>
