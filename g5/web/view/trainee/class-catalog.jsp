<%-- 
    Document   : class-catalog
    Created on : Oct 25, 2023, 2:27:49 PM
    Author     : win
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User" %>
<% User user = (User) session.getAttribute("user"); %>
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
        <title>CMSLVL10 - CLASS CATALOG</title>
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
                <jsp:param name="keywordSaved" value="${requestScope.keywordSaved}"></jsp:param>
            </jsp:include>
            <!--SIDEBAR START-->
            <div class="sidebar" id="sidebar">
                <div class="sidebar-inner slimscroll">
                    <div id="sidebar-menu" class="sidebar-menu">
                        <ul>
                            <li class="menu-title">
                                <span>Main Menu</span>
                            </li>
                            <li>
                                <a href="class-catalog"><i class="fas fa-university"></i> <span>Class Catalog</span></a>
                            <li>
                            <li class="submenu">
                                <a href="#">
                                    <i class="fas fa-user-graduate"></i> 
                                    <span> My Classes</span> 
                                    <span class="menu-arrow"></span>
                                </a>
                                <ul>
                                    <c:forEach items="${requestScope.classes}" var="m">
                                        <li><a href="index.html">${m.classCode}</a></li>
                                        </c:forEach>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <!--SIDEBAR END-->
            <div class="page-wrapper">
                <div class="content container-fluid">
                    <div class="page-header">
                        <div class="row align-items-center">
                            <!--NAVIGATION START-->
                            <div class="col">
                                <h3 class="page-title">Class Catalog</h3>
                                <ul class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="homepage">Home</a></li>
                                    <li class="breadcrumb-item active">Class Catalog</li>
                                </ul>
                            </div>
                            <!--NAVIGATION END-->
                        </div>
                    </div>
                    <div class="row">
                        <c:if test="${not empty requestScope.classes}">
                            <div class="col-sm-12">
                                <section class="comp-section comp-cards">
                                    <div class="section-header">
                                        <h4 class="section-title">Classes</h4>
                                        <div class="line"></div>
                                    </div>
                                    <div class="row">
                                        <c:forEach var="c" items="${requestScope.classes}">
                                            <div class="col-12">
                                                <a 
                                                    <c:if test="${dao.isClassRegistered(c.classId, studentId)}">
                                                        href="class-dashboard?cid=${c.classId}"
                                                    </c:if>
                                                    <c:if test="${!dao.isClassRegistered(c.classId, studentId)}">
                                                        data-toggle="modal" data-target="#exampleModal${c.classId}"
                                                    </c:if>
                                                    >
                                                    <div class="card flex-fill">
                                                        <div class="card-body">
                                                            <div class="row">
                                                                <div class="col-4">
                                                                    <img alt="Class Image" src="./view/assets/img/class_background.jpg" class="card-img">

                                                                </div>
                                                                <div class="col-8 d-flex flex-column">
                                                                    <div class="row">
                                                                        <div class="col-lg-6 col-12">
                                                                            <h4 class="card-title">${c.classCode}</h4>
                                                                        </div>
                                                                        <div class="col-lg-6 col-12">
                                                                            <p class="card-text">Subject: ${c.subject.subjectName}</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="row">
                                                                        <div class="col-lg-6 col-12">
                                                                            <p class="card-text">Manager: ${c.user.fullName}</p>
                                                                        </div>
                                                                        <div class="col-lg-6 col-12">
                                                                            <p class="card-text">Semester: ${c.setting.settingName}</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="row mt-auto">
                                                                        <c:set var="studentId" scope="session" value='<%= user.getUserId() %>'></c:set>
                                                                        <c:if test="${dao.isClassRegistered(c.classId, studentId)}">
                                                                            <div class="col-auto">
                                                                                <button disabled="" type="button"
                                                                                        class="btn btn-block btn-outline-success">Continue studying</button>
                                                                            </div>
                                                                        </c:if>
                                                                        <c:if test="${!dao.isClassRegistered(c.classId, studentId)}">
                                                                            <div class="col-auto">
                                                                                <button disabled="" type="button"
                                                                                        class="btn btn-block btn-outline-dark">Not enrolled</button>
                                                                            </div>
                                                                        </c:if>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </a>
                                            </div>
                                            <div class="modal fade" id="exampleModal${c.classId}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                <div class="modal-dialog" role="document">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="exampleModalLabel">Enrolment</h5>
                                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                <span aria-hidden="true">&times;</span>
                                                            </button>
                                                        </div>
                                                        <div class="modal-body">
                                                            Are you sure want to enrol to this class?
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                            <button 
                                                                type="button" 
                                                                class="btn btn-primary" 
                                                                onclick="window.location.href = 'class-catalog?action=enrol&cid=${c.classId}'">
                                                                Enrol me
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </section>
                                <!--START PAGINATION-->
                                <div>
                                    <ul class="pagination justify-content-center">
                                        <li class="page-item ${currentPage eq 1 ? 'disabled' : ''}">
                                            <a class="page-link" 
                                               href="class-catalog?page=${currentPage - 1}&keyword=${keyword}" 
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
                                                           href="class-catalog&page=${i}&keyword=${keyword}">
                                                            ${i}
                                                        </a>
                                                    </li>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                        <li class="page-item ${currentPage eq noOfPages ? 'disabled' : ''}">
                                            <a 
                                                class="page-link" 
                                                href="class-catalog&page=${currentPage + 1}&keyword=${keyword}">
                                                Next
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                                <!--END PAGINATION-->
                            </div>
                        </c:if>
                        <c:if test="${empty requestScope.classes}">
                            <div class="col-sm-12">
                                <h4 class="text-center text-muted">Sorry, we could not find any class.</h4>
                            </div>
                        </c:if>
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

