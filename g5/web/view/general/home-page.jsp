<%-- 
    Document   : home-page
    Created on : Sep 27, 2023, 5:47:14 PM
    Author     : win
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>CMSLVL10 - Home</title>
        <style>
        </style>
        <link rel="shortcut icon" href="view/assets/img/logo_short.png">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,500;0,600;0,700;1,400&amp;display=swap">
        <link rel="stylesheet" href="view/assets/plugins/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="view/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="view/assets/plugins/fontawesome/css/all.min.css">
        <link href="view/assets/css/style.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <div class="main-wrapper">
            <jsp:include page="../components/general/body-header.jsp"></jsp:include>
            <jsp:include page="../components/general/sidebar.jsp"></jsp:include>
                <div class="page-wrapper">
                    <div class="content container-fluid">
                        <div class="page-header">
                            <div class="row">
                                <div class="col-sm-12 home-text">
                                    <h3 class="page-title">Welcome!</h3>
                                    <ul class="breadcrumb">
                                        <li class="breadcrumb-item active">Home</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <img class="w-100" src="view/assets/img/fpt1.jpg" alt="">
                        </div>
                    </div>
                <jsp:include page="../components/general/footer.jsp"></jsp:include>
            </div>
        </div>
        <script src="view/assets/js/jquery-3.6.0.min.js"></script>
        <script src="view/assets/js/popper.min.js"></script>
        <script src="view/assets/plugins/bootstrap/js/bootstrap.min.js"></script>
        <script src="view/assets/plugins/slimscroll/jquery.slimscroll.min.js"></script>
        <script src="view/assets/plugins/apexchart/apexcharts.min.js"></script>
        <script src="view/assets/plugins/apexchart/chart-data.js"></script>
        <script src="view/assets/js/script.js"></script>
    </body>

</html>
