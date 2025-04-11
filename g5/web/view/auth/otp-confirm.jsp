<%-- 
    Document   : otp-confirm
    Created on : Sep 26, 2023, 6:37:29 AM
    Author     : win
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <!-- Mirrored from preschool.dreamguystech.com/html-template/forgot-password.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 28 Oct 2021 11:11:58 GMT -->
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>CMSLVL10 - OTP CONFIRM</title>

        <link rel="shortcut icon" href="./view/assets/img/logo_short.png">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,500;0,600;0,700;1,400&amp;display=swap">

        <link rel="stylesheet" href="./view/assets/plugins/bootstrap/css/bootstrap.min.css">

        <link rel="stylesheet" href="./view/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="./view/assets/plugins/fontawesome/css/all.min.css">

        <link rel="stylesheet" href="./view/assets/css/style.css">
    </head>
    <body>

        <div class="main-wrapper login-body">
            <div class="login-wrapper">
                <div class="container">
                    <c:if test="${not empty param.error}">
                        <jsp:include page="../components/general/alert.jsp">
                            <jsp:param name="message" value="${param.error}"></jsp:param>
                            <jsp:param name="type" value="danger"></jsp:param>
                        </jsp:include>
                    </c:if>
                    <div class="loginbox">
                        <div class="login-left">
                            <h1 style="color: white">cmslvl10</h1>
                        </div>
                        <div class="login-right">
                            <div class="login-right-wrap">
                                <h1>Enter your OTP here</h1>
                                <p class="account-subtitle">OTP Code was sent to your email.</p>
                                <form action="auth?action=confirm" method="POST">
                                    <div class="form-group">
                                        <input class="form-control" type="hidden" name="email" value="${requestScope.email}">
                                        <input class="form-control" type="text" name="otp" placeholder="OTP Code" required>
                                    </div>
                                    <div class="form-group mb-0">
                                        <button class="btn btn-primary btn-block" type="submit">Reset Password</button>
                                    </div>
                                </form>
                                <div class="text-center dont-have">Remember your password? <a href="auth?action=login">Login</a></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <script src="./view/assets/js/jquery-3.6.0.min.js"></script>

        <script src="./view/assets/js/popper.min.js"></script>
        <script src="./view/assets/plugins/bootstrap/js/bootstrap.min.js"></script>

        <script src="./view/assets/js/script.js"></script>
    </body>

    <!-- Mirrored from preschool.dreamguystech.com/html-template/forgot-password.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 28 Oct 2021 11:11:58 GMT -->
</html>
