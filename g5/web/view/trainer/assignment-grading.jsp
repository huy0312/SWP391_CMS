<%-- 
    Document   : grade
    Created on : Nov 15, 2023, 1:41:06 AM
    Author     : win
--%>

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
        <title>CMSLVL10 - ASSIGNMENT GRADE</title>
        <link rel="shortcut icon" href="./view/assets/img/logo_short.png">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,500;0,600;0,700;1,400&amp;display=swap">
        <link rel="stylesheet" href="./view/assets/plugins/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="./view/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="./view/assets/plugins/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="./view/assets/plugins/datatables/datatables.min.css">
        <link rel="stylesheet" href="./view/assets/css/style.css">
        <link href="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/css/bootstrap4-toggle.min.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="./view/assets/js/sort-table.js"></script>
    </head>
    <body>

        <div class="main-wrapper">
            <!--HEADER-->
            <jsp:include page="../components/general/body-header.jsp"></jsp:include>
                <!--SIDEBAR-->
            <jsp:include page="../components/general/sidebar.jsp">
                <jsp:param name="isClassDashboard" value="1"></jsp:param>
                <jsp:param name="subjectId" value="${requestScope.c.subject.subjectId}"></jsp:param>
                <jsp:param name="classId" value="${requestScope.c.classId}"></jsp:param>
                <jsp:param name="chapterId" value="${requestScope.chapter.chapterId}"></jsp:param>
            </jsp:include>
            <div class="page-wrapper">
                <div class="content container-fluid">
                    <div class="page-header">
                        <div class="row">
                            <div class="col-sm-12">
                                <h3 class="page-title">Assignment Grade</h3>
                                <ul class="breadcrumb">
                                    <li class="breadcrumb-item">
                                        <a href="homepage">Home</a>
                                    </li>
                                    <li class="breadcrumb-item active">Assignment Grade</li>
                                </ul>
                            </div>
                        </div>

                        <!--SEARCH START-->
                        <!--FILTER-->
                        <form id="searchForm" action="grade">
                            <div class="row">
                                

                                <!--SEARCH-->
                                <div class="col-auto text-right float-right ml-auto">
                                    <div class="input-group">
                                        <input type="hidden" name="action" value="view">
                                        <input type="hidden" name="cid" value="${requestScope.c.classId}">
                                        <input type="hidden" name="ctid" value="${requestScope.chapter.chapterId}">

                                        <div class="input-group-prepend">
                                            <input 
                                                class="form-control" 
                                                name="keyword" 
                                                type="text" 
                                                placeholder="Search here" 
                                                value="${keywordSaved}">
                                        </div>
                                        <div class="input-group-append">
                                            <button 
                                                class="btn btn-primary" 
                                                type="submit">
                                                <i class="fas fa-search"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                        <!--SEARCH END-->
                    </div>
                    <div class="row">

                        <div class="col-sm-12">
                            <div class="card card-table">
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-hover table-center mb-0">
                                            <thead>
                                                <tr>
                                                    <th class="sortable" data-sort="sassignmentId">
                                                        #<i class="fas fa-sort"></i>
                                                    </th>                            
                                                    <th class="sortable" data-sort="attachedFile">
                                                        File<i class="fas fa-sort"></i>
                                                    </th>
                                                    <th class="sortable" data-sort="description">
                                                        Description<i class="fas fa-sort"></i>
                                                    </th>                                                  
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${sassignments}" var="sa">
                                                    <tr>
                                                          
                                                          <td>${sa.attachedFile}</td>
                                                          <td>${sa.description}</td>
                                                    <tr>
                                                      
                                                    </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <!--START PAGINATION-->
                            <div>
                                <ul class="pagination justify-content-center">
                                    <li class="page-item ${currentPage eq 1 ? 'disabled' : ''}">
                                        <a class="page-link" 
                                           href="grade?page=${currentPage - 1}&keyword=${keyword}&type=${typeSaved}&cid=${requestScope.c.classId}&ctid=${requestScope.chapter.chapterId}" 
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
                                                       href="grade?page=${i}&keyword=${keyword}&type=${typeSaved}&cid=${requestScope.c.classId}&ctid=${requestScope.chapter.chapterId}">
                                                        ${i}
                                                    </a>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                    <li class="page-item ${currentPage eq noOfPages ? 'disabled' : ''}">
                                        <a 
                                            class="page-link" 
                                            href="grade?page=${currentPage + 1}&keyword=${keyword}&type=${typeSaved}&cid=${requestScope.c.classId}&ctid=${requestScope.chapter.chapterId}">
                                            Next
                                        </a>
                                    </li>
                                </ul>
                            </div>
                            <!--END PAGINATION-->
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

