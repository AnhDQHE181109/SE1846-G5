<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Apartment Details</title>
        <style>
            body {
                font-family: 'Arial', sans-serif;
                background-color: #f4f4f4;
                color: #333;
                margin: 0;
                padding: 0;
            }
            .apartment-details {
                max-width: 800px;
                margin: 40px auto;
                padding: 20px;
                background-color: #fff;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
            }
            .apartment-details h1 {
                font-size: 24px;
                margin-bottom: 20px;
                color: #007BFF;
            }
            .apartment-image {
                width: 100%;
                max-width: 100%;
                height: auto;
                margin-bottom: 20px;
                border-radius: 8px;
            }
            .apartment-description {
                font-size: 16px;
                margin-top: 20px;
                padding: 10px;
                background-color: #f9f9f9;
                border-left: 4px solid #007BFF;
                border-radius: 4px;
            }
            .apartment-info {
                font-size: 18px;
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>
        <div class="apartment-details">
            <h1>Apartment Details</h1>
            <p>Type ID: ${apartmentType.typeID}</p>
            <p>Size: ${apartmentType.size}</p>
            <p>Base Rent: ${apartmentType.baseRent}</p>
            <div id="imageContainer"></div>
            <div id="descriptionContainer"></div>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                var typeID = ${apartmentType.typeID};
                var images = [];
                var descriptions = [];
                switch (typeID) {
                    case 1:
                        images = ['image/viewtype1.1.jpg', 'image/viewtype1.2.jpg', 'image/viewtype1.3.jpg'];
                        descriptions = [
                            'This is a cozy one-bedroom apartment, perfect for singles or couples.',
                            'Located in a vibrant neighborhood with all amenities.',
                            'Affordable living with modern facilities.'
                        ];
                        break;
                    case 2:
                        images = ['image/viewtype2.1.jpg', 'image/viewtype2.2.jpg', 'image/viewtype2.3.jpg'];
                        descriptions = [
                            'A spacious two-bedroom apartment ideal for small families.',
                            'Includes a large living room and a modern kitchen.',
                            'Close to schools and parks.'
                        ];
                        break;
                    case 3:
                        images = ['image/viewtype3.1.jpg', 'image/viewtype3.2.jpg', 'image/viewtype3.3.jpg'];
                        descriptions = [
                            'A luxurious three-bedroom apartment with a stunning view.',
                            'High-end finishes and appliances.',
                            'Located in an upscale neighborhood.'
                        ];
                        break;
                    default:
                        images = ['images/default.jpg'];
                        descriptions = ['Default apartment description. Please select an apartment type.'];
                        break;
                }
                var imageContainer = document.getElementById("imageContainer");
                var descriptionContainer = document.getElementById("descriptionContainer");

                for (var i = 0; i < images.length; i++) {
                    var img = document.createElement("img");
                    img.src = images[i];
                    img.className = "apartment-image";
                    imageContainer.appendChild(img);

                    var desc = document.createElement("p");
                    desc.innerText = descriptions[i];
                    desc.className = "apartment-description";
                    descriptionContainer.appendChild(desc);
                }
            });
        </script>
    </body>
</html>
