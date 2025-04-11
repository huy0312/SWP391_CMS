<%-- 
   Document   : home
   Created on : Oct 24, 2023, 1:00:03 AM
   Author     : win
--%>
<jsp:useBean id="udao" class="dal.UserDAO" scope="request"></jsp:useBean>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <!-- Mirrored from preschool.dreamguystech.com/html-template/students.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 28 Oct 2021 11:11:43 GMT -->
    <head>
        <style type="text/css">
            a:hover {
                cursor:pointer;
            }
            .text-truncate {
                max-width: 150px; /* Set a maximum width for the cell */
                white-space: nowrap; /* Prevent text from wrapping to the next line */
                overflow: hidden; /* Hide any overflow content */
                text-overflow: ellipsis; /* Show ellipsis (...) for hidden content */
            }
        </style>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>CMSLVL10 - HOME PAGE</title>
        <link rel="shortcut icon" href="./view/assets/img/logo_short.png">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,500;0,600;0,700;1,400&amp;display=swap">
        <link rel="stylesheet" href="./view/assets/plugins/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="./view/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="./view/assets/plugins/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="./view/assets/plugins/datatables/datatables.min.css">
        <link rel="stylesheet" href="./view/assets/css/style.css">
        <link href="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/css/bootstrap4-toggle.min.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>
    <body>

        <div class="main-wrapper">
            <!--HEADER-->
            <jsp:include page="../components/general/body-header.jsp">
                <jsp:param name="isHomePage" value="1"></jsp:param>
            </jsp:include>
            <!--SIDEBAR START-->
            <jsp:include page="../components/general/sidebar.jsp">
                <jsp:param name="isHomePage" value="1"></jsp:param>
            </jsp:include>
            <!--SIDEBAR END-->
            <div class="page-wrapper">
                <div class="content container-fluid">
                    <div class="page-header">
                        <div class="row align-items-center">
                            <!--NAVIGATION START-->
                            <div class="col">
                                <h3 class="page-title">Welcome!</h3>
                                <ul class="breadcrumb">
                                    <li class="breadcrumb-item active">Home</li>
                                </ul>
                            </div>
                            <!--NAVIGATION END-->
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <section class="comp-section comp-cards">
                                <div class="section-header">
                                    <h4 class="section-title">Classes</h4>
                                    <div class="line"></div>
                                </div>
                                <c:if test="${not empty requestScope.classes}">
                                    <div class="row">
                                        <c:forEach var="c" items="${requestScope.classes}">
                                            <div class="col-6 col-md-4 col-lg-3 d-flex">
                                                <a href="class-dashboard?cid=${c.classId}">
                                                    <div class="card flex-fill">
                                                        <div style="position: relative;">
                                                            <img 
                                                                alt="Card Image" 
                                                                src="./view/assets/img/class_background.jpg" 
                                                                class="card-img-top">
                                                            <div 
                                                                class="text-white" 
                                                                style="
                                                                position: absolute;
                                                                top: 50%;
                                                                left: 50%;
                                                                transform: translate(-50%, -50%);
                                                                ">
                                                                <!-- Move the class code here -->
                                                                <h2 
                                                                    class="card-title
                                                                    text-center"
                                                                    >
                                                                    ${c.classCode}
                                                                </h2>
                                                            </div>
                                                        </div>
                                                        <div class="card-body text-center">
                                                            <p 
                                                                class="
                                                                card-text
                                                                text-dark
                                                                ">
                                                                ${c.subject.subjectName} - ${c.setting.settingName}
                                                            </p>
                                                            <p 
                                                                class="
                                                                card-text
                                                                text-dark
                                                                ">
                                                                <small>
                                                                    Manager: ${udao.getUserById(c.createdBy).fullName}
                                                                </small>
                                                            </p>
                                                            <p 
                                                                class="
                                                                card-text
                                                                text-dark
                                                                ">
                                                                <small>
                                                                    Trainer: ${c.user.fullName}
                                                                </small>
                                                            </p>
                                                        </div>
                                                    </div>
                                                </a>
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <!--START PAGINATION-->
                                    <div>
                                        <ul class="pagination justify-content-center">
                                            <li class="page-item ${currentPage eq 1 ? 'disabled' : ''}">
                                                <a class="page-link" 
                                                   href="homepage?page=${currentPage - 1}" 
                                                   tabindex="-1">
                                                    Previous
                                                </a>
                                            </li>
                                            <c:forEach begin="1" end="${noOfPages}" var="i">
                                                <c:choose>
                                                    <c:when test="${currentPage eq i}">
                                                        <li class="page-item active">
                                                            <a class="page-link" 
                                                               href="#">
                                                                ${i} 
                                                                <span class="sr-only">
                                                                    (current)
                                                                </span>
                                                            </a>
                                                        </li>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <li class="page-item">
                                                            <a class="page-link" 
                                                               href="homepage&page=${i}">
                                                                ${i}
                                                            </a>
                                                        </li>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                            <li class="page-item ${currentPage eq noOfPages ? 'disabled' : ''}">
                                                <a 
                                                    class="page-link"
                                                    href="homepage&page=${currentPage + 1}">
                                                    Next
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                    <!--END PAGINATION-->
                                </c:if>
                                <c:if test="${empty requestScope.classes}">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <h4 class="text-center text-muted">You haven't registered any class.</h4>
                                        </div>
                                    </div>
                                </c:if>
                            </section>
                        </div>
                    </div>
                </div>
                <jsp:include page="../components/general/footer.jsp"></jsp:include>
            </div>
        </div>
        <script src="./view/assets/js/jquery-3.6.0.min.js"></script>
        <script src="./view/assets/js/popper.min.js"></script>
        <script src="./view/assets/plugins/bootstrap/js/bootstrap.min.js"></script>
        <script src="./view/assets/plugins/slimscroll/jquery.slimscroll.min.js"></script>
        <script src="./view/assets/plugins/datatables/datatables.min.js"></script>
        <script src="./view/assets/js/script.js"></script>
        <script src="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/js/bootstrap4-toggle.min.js"></script>
    </body>
    <!-- Mirrored from preschool.dreamguystech.com/html-template/students.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 28 Oct 2021 11:11:49 GMT -->
</html>

