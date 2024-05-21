<%-- 
    Document   : index
    Created on : May 21, 2024, 3:25:33 PM
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
        :root{
            --white-color: #fff;
            --black-color: #000;
            --text-color: #90E0EF;

            --navbar-height: 34px;
            --header-height: 120px;
            --header-with-search-height: calc(var(--header-height)  - var(var(--navbar-height)))
        }
        html{
            box-sizing: border-box;
            line-height: 1.6rem;
            font-size: 62.5%;
            font-family: 'Roboto', sans-serif;
        }
        .grid{
            width: 1200px;
            max-width: 100%;
            margin:0 auto ;
        }
        .grid__full-width{
            width: 100%;
        }
        .grid__row{
            display: flex;
            flex-wrap: wrap;
        }
        @keyframes fadeIn {
            from{
                opacity: 0;
            }
            to{
                opacity: 1;
            }
        }
        /*Modal*/
        .modal{
            position: fixed;
            top: 0;
            right: 0;
            left: 0;
            bottom: 0;
            display: flex;
            display: none;

        }
        .modal__body-overlay{
            position: absolute;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.3);
        }
        .modal__body{
            background-color: var(--white-color);
            margin: auto;
            position: relative;
            border-radius: 5px;
        }
        body{
            margin: 0;
            min-height: 200vh;
        }
        *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        header{
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: 0.6s;
            padding: 40px 100px;
            z-index: 1000000;
        }
        header.sticky{
            padding: 15px 50px;
            background-color: #fff;
        }
        .logo{
            position: relative;
            font-weight: 700px;
            color: black;
            text-decoration: none;
            font-size: 1.5em;
            letter-spacing: 2px;
            transition: 0.6s
        }
        header ul{
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;

        }
        header ul li{
            position: relative;
            list-style: none;
            font-size: 2rem;
        }
        header ul li a{
            position: relative;
            margin: 0 15px;
            text-decoration: none;
            color: black;
            letter-spacing: 2px;
            font-weight: 500px;
            transition: 0.5s;
        }
        .slider{
            max-width: 100vw;
            height: 700px;
            position: relative;
            overflow: hidden;
        }
        .slider .list{
            position: absolute;
            width: max-content;
            height: 100%;
            left: 0;
            top: 0;
            display: flex;
            transition: 1s;
        }
        .slider .list img{
            width: 1500px;
            max-width: 100vw;
            height: 700px;
        }
        .slider .buttons{
            position: absolute;
            top: 45%;
            left: 5%;
            width: 90%;
            display: flex;
            justify-content: space-between;
        }
        .slider .buttons button{
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background-color: #fff5;
            color: #fff;
            border: none;
            font-family: monospace;
            font-weight: bold;
        }
        .slider .dots{
            position: absolute;
            bottom: 10px;
            left: 0;
            color: #fff;
            width: 100%;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
        }
        .slider .dots li{
            list-style: none;
            width: 10px;
            height: 10px;
            background-color: #fff;
            margin: 10px;
            border-radius: 20px;
            transition: 0.5s;
        }
        .slider .dots li.active{
            width: 30px;
        }
        @media screen and (max-width: 768px){
            .slider{
                height: 400px;
            }
        }
        .container > .container__content > .choose{
            width: 1490;
            height: 660px;
            background-image: url("../image/modern-apartment-building-designs-dusk.jpeg");
            background-repeat: no-repeat;
            background-size: cover;
            margin-top: 30px;
            color: #fff;
            text-align: center;
            align-items: center;
        }
        .choose__header{
            padding-top: 300px;
            font-size: 4rem
        }
        .choose__list{
            margin-top: 150px;
            display: flex;
            justify-content: space-around;
        }
        .choose__list button{
            padding: 20px 30px;
            background-color: rgb(242, 141, 19);
            border: none;
            border-radius: 5px;
            color: #fff;
            font-size: 1.5rem;
        }
        .choose__list button:hover{
            background-color: rgb(187, 103, 0);
            cursor: pointer;
        }
        .container__hotline{
            width: 1200px;
            height: 200px;
            background-color: aliceblue;
            margin-left: 140px;
            margin-top: -100px;
        }
        .advan__header{
            text-align: center;
            font-size: 4rem;
            margin-top: 100px;
            color: darkblue;
            margin-bottom: 50px;
        }
        .adven__body{
            display: flex;
            margin-left: 50px;
            margin-right: 60px
        }
        .adven__content-header{
            text-align: center;
            font-size: 2.5rem;
            font-weight: 700;
            color: orange;
            margin-bottom: 20px;
        }
        .adven__content-content{
            font-size: 1.5rem;
            font-weight: 400;
            width: 460px;
        }


    </style>
    <body>
        <div class="app">
        </div>
        <header class="header sticky">
            <ul>
                <li><a href="#" class="logo">Logo</a></li>
                <li class="navbar_list"><a href="#">Home</a></li>
                <li class="navbar_list"><a href="#">Privacy</a></li>
                <li class="navbar_list"><a href="#">About us</a></li>
            </ul>
            <ul class="navbar_header">
                <li class="navbar_list"><a href="login.jsp">Login</a></li>
                <li class="navbar_list"><a href="#">Log out</a></li>
            </ul>
        </header>
        <div class="slider">
            <div class="list">
                <div class="item">
                    <img src="image/nha1.jpg" alt="">
                </div>
                <div class="item">
                    <img src="image/nha2.jpg" alt="">
                </div>
                <div class="item">
                    <img src="image/nha3.jpg" alt="">
                </div>
            </div>
            <div class="buttons">
                <button id="prev"><</button>
                <button id="next">></button>
            </div>
            <ul class="dots">
                <li class="active"></li>
                <li></li>
                <li></li>
            </ul>
        </div>
        <div class="container">
            <div class="container__content">
                <div class="choose">
                    <div class="choose__header">
                        Looking for an apartment?
                    </div>
                    <div class="choose__list">
                        <button class="choose__item">100m²-200m²</button>
                        <button class="choose__item">200m²-500m²</button>
                        <button class="choose__item">500m²-700m²</button>
                    </div>
                </div>
                <div class="container__hotline">

                </div>
            </div>
            <div class="container__advantage">
                <div class="advan__header">
                    Nhung diem cong chi co tai G5 apartment
                </div>
                <div class="adven__body">
                    <div class="adven__content">
                        <div class="adven__content-header">VỊ TRÍ ĐẮC ĐỊA</div>
                        <div class="adven__content-content">Sở hữu vị trí “vàng” tại ngã tư Trần Duy Hưng – Hoàng Minh Giám, tòa nhà Charmvit Tower là một trong những dự án hiếm hoi có được vị trí chiến lược trong quá trình phát triển của khu vực phía Tây Hà Nội: vừa thuận tiện giao thông, vừa được thừa hưởng đủ hạ tầng khu vực đẳng cấp.</div>
                    </div>
                    <div class="adven__content">
                        <div class="adven__content-header">VỊ TRÍ ĐẮC ĐỊA</div>
                        <div class="adven__content-content">Sở hữu vị trí “vàng” tại ngã tư Trần Duy Hưng – Hoàng Minh Giám, tòa nhà Charmvit Tower là một trong những dự án hiếm hoi có được vị trí chiến lược trong quá trình phát triển của khu vực phía Tây Hà Nội: vừa thuận tiện giao thông, vừa được thừa hưởng đủ hạ tầng khu vực đẳng cấp.</div>
                    </div>
                    <div class="adven__content">
                        <div class="adven__content-header">VỊ TRÍ ĐẮC ĐỊA</div>
                        <div class="adven__content-content">Sở hữu vị trí “vàng” tại ngã tư Trần Duy Hưng – Hoàng Minh Giám, tòa nhà Charmvit Tower là một trong những dự án hiếm hoi có được vị trí chiến lược trong quá trình phát triển của khu vực phía Tây Hà Nội: vừa thuận tiện giao thông, vừa được thừa hưởng đủ hạ tầng khu vực đẳng cấp.</div>
                    </div>
                </div>
            </div>
        </div>
        <footer class="footer">

        </footer>
    </body>
    <script>
        let slider = document.querySelector('.slider .list');
        let items = document.querySelectorAll('.slider .list .item');
        let next = document.getElementById('next');
        let prev = document.getElementById('prev');
        let dots = document.querySelectorAll('.slider .dots li');

        let lengthItems = items.length - 1;
        let active = 0;
        next.onclick = function () {
            active = active + 1 <= lengthItems ? active + 1 : 0;
            reloadSlider();
        }
        prev.onclick = function () {
            active = active - 1 >= 0 ? active - 1 : lengthItems;
            reloadSlider();
        }
        let refreshInterval = setInterval(() => {
            next.click()
        }, 3000);
        function reloadSlider() {
            slider.style.left = -items[active].offsetLeft + 'px';
            // 
            let last_active_dot = document.querySelector('.slider .dots li.active');
            last_active_dot.classList.remove('active');
            dots[active].classList.add('active');

            clearInterval(refreshInterval);
            refreshInterval = setInterval(() => {
                next.click()
            }, 3000);


        }

        dots.forEach((li, key) => {
            li.addEventListener('click', () => {
                active = key;
                reloadSlider();
            })
        })
        window.onresize = function (event) {
            reloadSlider();
        };

        window.addEventListener("scroll", function () {
            var header = document.querySelector("header")
            header.classList.toggle("sticky", window.scrollY > 0);
        })

    </script>
</html>
