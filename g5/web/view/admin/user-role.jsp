

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <!-- Mirrored from preschool.dreamguystech.com/html-template/holiday.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 28 Oct 2021 11:11:50 GMT -->
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>CMSLEVEL10 - User Role Setting</title>

        <link rel="shortcut icon" href="./view/assets/img/logo_short.png">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,500;0,600;0,700;1,400&amp;display=swap">

        <link rel="stylesheet" href="./view/assets/plugins/bootstrap/css/bootstrap.min.css">

        <link rel="stylesheet" href="./view/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="./view/assets/plugins/fontawesome/css/all.min.css">

        <link rel="stylesheet" href="./view/assets/plugins/datatables/datatables.min.css">

        <link rel="stylesheet" href="./view/assets/css/style.css">

    </head>
    <body>

        <div class="main-wrapper">
            <jsp:include page="../components/general/body-header.jsp"></jsp:include>
            <jsp:include page="../components/general/sidebar.jsp"></jsp:include>
                <div class="page-wrapper">
                    <div class="content container-fluid">
                        <div class="page-header">
                            <div class="row align-items-center">
                                <div class="col">
                                    <h3 class="page-title">User Role</h3>
                                    <ul class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="">System Setting</a></li>
                                    </ul>
                                </div>
                                <div class="col-auto text-right float-right ml-auto">
                                    <a href="#" class="btn btn-outline-primary mr-2"><i class="fas fa-download"></i> Download</a>                                   
                                </div>
                            </div>
                        </div>
                    </div>  
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card card-table">
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-hover table-center mb-0 ">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>Role</th>                                                                                                                                              
                                                    <th>Description</th>
                                                    <th>Status</th>                                                                                      
                                                </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${setting}" var="d">                                           
                                                <tr>    
                                                    <td>${d.settingValue}</td>
                                                    <td>${d.settingName}</td>
                                                    <td>${d.description}</td>
                                                    <td> ${d.status == true ? '<span class="badge badge-secondary badge-success">Active</span>' : '<span class="badge badge-secondary badge-danger">Inactive</span>'}</td>
                                                </tr>
                                                </form>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <script src="./view/assets/js/jquery-3.6.0.min.js"></script>
                <script src="./view/assets/js/popper.min.js"></script>
                <script src="./view/assets/plugins/bootstrap/js/bootstrap.min.js"></script>
                <script src="./view/assets/plugins/slimscroll/jquery.slimscroll.min.js"></script>
                <script src="./view/assets/plugins/datatables/datatables.min.js"></script>
                <script src="./view/assets/js/script.js"></script>
                <script src="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/js/bootstrap4-toggle.min.js"></script>
                <jsp:include page="../components/general/footer.jsp"></jsp:include>
                </body>
                </html>


