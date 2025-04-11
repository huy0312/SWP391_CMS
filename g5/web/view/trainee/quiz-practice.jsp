<%-- 
    Document   : user-management
    Created on : Sep 15, 2023, 8:30:21 AM
    Author     : win
--%>
<jsp:useBean class="dal.UserDAO" id="udao" scope="request"></jsp:useBean>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

            .center-container {
                display: flex;
                justify-content: center; /* Center horizontally */
                align-items: center; /* Center vertically */
            }
        </style>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>CMSLVL10 - Quizzes Practice</title>
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
        <link href="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap-switch-button@1.1.0/css/bootstrap-switch-button.min.css" rel="stylesheet">
    </head>
    <body>

        <!--START TOASTS-->
        <div aria-live="polite" aria-atomic="true" style="position: relative; z-index: 11">
            <div class="toast bg-success text-white border-0" data-delay="1000" data-autohide="true" role="alert" aria-live="assertive" aria-atomic="true" style="position: fixed; bottom: 20px; right: 20px;">
                <div class="toast-body">
                    Updated successfully!
                    <button type="button" class="ml-2 mb-1 close" data-dismiss="toast">&times;</button>
                </div>
            </div>
            <div class="toast bg-success text-white border-0" id="addSuccessToast" data-delay="1000" data-autohide="true" role="alert" aria-live="assertive" aria-atomic="true" style="position: fixed; bottom: 20px; right: 20px;">
                <div class="toast-body">
                    Added successfully!
                    <button type="button" class="ml-2 mb-1 close" data-dismiss="toast">&times;</button>
                </div>
            </div>
            <div class="toast bg-success text-white border-0" id="deleteSuccessToast" data-delay="1000" data-autohide="true" role="alert" aria-live="assertive" aria-atomic="true" style="position: fixed; bottom: 20px; right: 20px;">
                <div class="toast-body">
                    Deleted successfully!
                    <button type="button" class="ml-2 mb-1 close" data-dismiss="toast">&times;</button>
                </div>
            </div>

        </div>
        <!--END TOASTS-->

        <div class="main-wrapper">
            <!--HEADER-->
            <jsp:include page="../components/general/body-header.jsp"></jsp:include>
                <!--SIDEBAR-->
            <jsp:include page="../components/general/sidebar.jsp">
                <jsp:param name="isClassDashboard" value="1"></jsp:param>
                <jsp:param name="subjectId" value="${requestScope.subjectId}"></jsp:param>
                <jsp:param name="classId" value="${requestScope.classId}"></jsp:param>
                <jsp:param name="chapterId" value="${requestScope.chapterId}"></jsp:param>
            </jsp:include>
                <div class="page-wrapper">
                    <div class="content container-fluid">
                        <div class="page-header">
                            <div class="row">
                                <div class="col-sm-12">
                                    <h3 class="page-title">Practice Quizzes</h3>
                                    <ul class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="homepage">Home</a></li>
                                        <li class="breadcrumb-item active">Practice Quizzes</li>
                                    </ul>
                                    <br>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <h4 class="text-left" style="font-size: 20px">
                                                Subject: ${requestScope.subject.subjectName} - Chapter: ${requestScope.chapter.chapterName}
                                        </h4>
                                    </div>

                                    <div class="col-md-8 d-flex justify-content-end">
                                        <form action="quiz-practice" class="ml-auto">
                                            <div class="input-group">
                                                <input type="hidden" name="action" value="view">
                                                <input type="hidden" name="sid" value="${requestScope.subjectId}">
                                                <input type="hidden" name="cid" value="${requestScope.chapterId}">
                                                <div class="input-group-prepend">
                                                    <input class="form-control" name="keyword" type="text" placeholder="Search here" value="${keywordSaved}">
                                                </div>
                                                <div class="input-group-append">
                                                    <button class="btn btn-primary" type="submit"><i class="fas fa-search"></i></button>
                                                </div>
                                            </div>
                                        </form>
                                        <button type="button" onclick="window.location.href = 'quiz-practice?action=add&sid=${requestScope.subjectId}&cid=${requestScope.chapterId}&clid=${requestScope.classId}'" class="btn btn-primary ml-2">
                                            <i class="fas fa-plus"></i> Add Quiz
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <!--SEARCH END-->
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card card-table">
                                <div class="card-body">

                                    <!--TABLE START-->
                                    <div class="table-responsive">
                                        <table class="table table-hover table-center mb-0 ">
                                            <thead>
                                                <tr>
                                                    <th class="sortable" data-sort="id">Id<i class="fas fa-sort"></i></th>
                                                    <th class="sortable" data-sort="name">Name<i class="fas fa-sort"></i></th>
                                                    <th class="sortable" data-sort="type">Quiz type<i class="fas fa-sort"></i></th>
                                                    <th class="sortable" data-sort="time">Quiz time<i class="fas fa-sort"></i></th>
                                                    <th class="sortable" data-sort="duration">Duration<i class="fas fa-sort"></i></th>
                                                    <th class="sortable" data-sort="noQuestion"># Questions<i class="fas fa-sort"></i></th>
                                                    <th class="sortable" data-sort="createdBy">Created By<i class="fas fa-sort"></i></th>
                                                    <th class="text-right">Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${quizs}" var="q">
                                                    <tr>
                                                        <td class="text-truncate" data-toggle="tooltip" title="${q.quizId}">${q.quizId}</td>
                                                        <td class="text-truncate" data-toggle="tooltip" title="${q.quizName}">${q.quizName}</td>
                                                        <td class="text-truncate" data-toggle="tooltip" title="${q.quizType.settingName}">${q.quizType.settingName}</td>
                                                        <td class="text-truncate" data-toggle="tooltip" title="${q.createdAt}">${q.createdAt}</td>
                                                        <td class="text-truncate" data-toggle="tooltip" title="${q.duration}">${q.duration} minutes</td>
                                                        <td class="text-truncate center-container" data-toggle="tooltip" title="${q.noQuiz}">${q.noQuiz}</td>
                                                        <td class="text-truncate" data-toggle="tooltip" title="${q.createdBy}">${udao.getUserById(q.createdBy).getFullName()}</td>
                                                        <td class="text-right">
                                                            <div class="actions ">
                                                                <c:choose>
                                                                    <c:when test="${q.status eq true}">
                                                                        <a 
                                                                            title="Practicing Quiz"
                                                                            href="quiz-practicing?quizId=${q.quizId}&clid=${requestScope.classId}"
                                                                            target="_blank"
                                                                            class="btn btn-sm bg-warning-light mr-2">
                                                                            <i class="fas fa-feather-alt"></i>
                                                                        </a>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <div title="This quiz is not available to do at this moment"  class="btn btn-sm bg-danger mr-1"> <i class="fas fa-exclamation-triangle"></i></div>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                    <c:if test="${q.createdBy == user.userId}">
                                                                    <a 
                                                                        title="Edit Quiz"
                                                                        href="quiz-practice?action=update&id=${q.quizId}&sid=${requestScope.subjectId}&cid=${requestScope.chapterId}&clid=${requestScope.classId}"
                                                                        class="btn btn-sm bg-success-light mr-2">
                                                                        <i class="fas fa-pen"></i>
                                                                    </a>
                                                                </c:if>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                <input type="hidden" name="quizIdDetail" value="${q.quizId}">
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                    <!--TABLE END-->
                                </div>

                                <!--START PAGINATION-->
                                <div>
                                    <ul class="pagination justify-content-center">
                                        <li class="page-item ${currentPage eq 1 ? 'disabled' : ''}">
                                            <a class="page-link" 
                                               href="quiz-practice?action=view&page=${currentPage - 1}&keyword=${keyword}&sid=${subjectId}&cid=${chapterId}&clid=${requestScope.classId}" 
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
                                                           href="quiz-practice?action=view&page=${i}&keyword=${keyword}&sid=${subjectId}&cid=${chapterId}&clid=${requestScope.classId}">
                                                            ${i}
                                                        </a>
                                                    </li>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                        <li class="page-item ${currentPage eq noOfPages ? 'disabled' : ''}">
                                            <a 
                                                class="page-link" 
                                                href="quiz-practice?action=view&page=${currentPage + 1}&keyword=${keyword}&sid=${subjectId}&cid=${chapterId}&clid=${requestScope.classId}">
                                                Next
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                                <!--END PAGINATION-->

                            </div>
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
            <script src="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap-switch-button@1.1.0/dist/bootstrap-switch-button.min.js"></script>s
            <script src="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/js/bootstrap4-toggle.min.js"></script>
            <script>
                                            $(document).ready(function () {
            <c:if test="${sessionScope.isAddSuccess == true}">
                                                $('#addSuccessToast').toast('show');
            </c:if>
            <c:if test="${sessionScope.isUpdateSuccess == true}">
                                                $('#updateSuccessToast').toast('show');
            </c:if>
                                            });
        </script>
    </body>
    <% 
        session.removeAttribute("isAddSuccess");
        session.removeAttribute("isUpdateSuccess"); 
    %>
</body>

<!-- Mirrored from preschool.dreamguystech.com/html-template/students.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 28 Oct 2021 11:11:49 GMT -->
</html>
