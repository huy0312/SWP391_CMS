<%-- 
    Document   : user-management
    Created on : Sep 15, 2023, 8:30:21 AM
    Author     : win
--%>

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
        <title>CMSLVL10 - Quiz List</title>
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
            <div class="toast bg-success text-white border-0" id="updateStatusSuccessToast" data-delay="1000" data-autohide="true" role="alert" aria-live="assertive" aria-atomic="true" style="position: fixed; bottom: 20px; right: 20px;">
                <div class="toast-body">
                    Update status successfully!
                    <button type="button" class="ml-2 mb-1 close" data-dismiss="toast">&times;</button>
                </div>
            </div>
        </div>
        <!--END TOASTS-->

        <div class="main-wrapper">
            <!--HEADER-->
            <jsp:include page="../../components/general/body-header.jsp"></jsp:include>
                <!--SIDEBAR-->
            <jsp:include page="../../components/general/sidebar.jsp">
                <jsp:param name="isQuizList" value="1"></jsp:param>
            </jsp:include>
            <div class="page-wrapper">
                <div class="content container-fluid">
                    <div class="page-header">
                        <div class="row align-items-center">
                            <!--NAVIGATION START-->
                            <div class="col">
                                <h3 class="page-title">Quiz List</h3>
                                <ul class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="admin-dashboard">Dashboard</a></li>
                                    <li class="breadcrumb-item active">Quiz List</li>
                                </ul>
                            </div>
                            <!--NAVIGATION END-->

                            <!--ADD BUTTON START-->
                            <div class="col-auto text-right float-right ml-auto">
                                <button type="button" onclick="window.location.href = 'quiz-list?action=add'" class="btn btn-primary"><i class="fas fa-plus"></i> Add Quiz</button>
                            </div>
                            <!--ADD BUTTON END-->

                            <!--ADD USER MODAL-->

                        </div>

                        <!--SEARCH START-->
                        <form action="quiz-list">
                            <!--FILTER-->
                            <div class="row">
                                <div class="col mt-auto">
                                    <div class="btn-group">
                                        <select onchange="this.form.submit()" name="status"  class="form-control text-truncate" >
                                            <option value="-1" ${statusSaved eq -1 ? 'selected' : ''}>Status</option>
                                            <option value="1" ${statusSaved eq 1 ? 'selected' : ''}>Active</option>
                                            <option value="0" ${statusSaved eq 0 ? 'selected' : ''}>Inactive</option>
                                        </select>
                                    </div>
                                    &nbsp
                                    <div class="btn-group">
                                        <select name="subject" onchange="this.form.submit()" class="form-control text-truncate" >
                                            <option value="-1" ${subjectIdSaved eq -1 ? 'selected' : ''}>Subject</option>
                                            <c:forEach items="${subjects}" var="r">
                                                <option value="${r.subjectId}"
                                                        ${subjectIdSaved eq r.subjectId ? 'selected' : ''}
                                                        >${r.subjectName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    &nbsp
                                    <div class="btn-group">
                                        <select name="chapter" onchange="this.form.submit()" class="form-control text-truncate" >
                                            <option value="-1" ${chapterIdSaved eq -1 ? 'selected' : ''}>Chapter</option>
                                            <c:forEach items="${chapters}" var="r">
                                                <option value="${r.chapterId}"
                                                        ${chapterIdSaved eq r.chapterId ? 'selected' : ''}
                                                        >${r.chapterName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    &nbsp
                                    <div class="btn-group">
                                        <select name="chapter" onchange="this.form.submit()" class="form-control text-truncate">
                                            <option value="-1" ${dimensionIdSaved eq -1 ? 'selected' : ''}>Dimension</option>
                                            <c:forEach items="${dimensions}" var="q">
                                                <option value="${q.dimensionId}"
                                                        ${dimensionIdSaved eq q.dimensionId ? 'selected' : ''}
                                                        >${q.dimensionName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>

                                <!--SEARCH-->
                                <div class="col-auto text-right float-right ml-auto">
                                    <div class="input-group">
                                        <input type="hidden" name="action" value="view">
                                        <div class="input-group-prepend">
                                            <input class="form-control" name="keyword" type="text" placeholder="Search here" value="${keywordSaved}">
                                        </div>
                                        <div class="input-group-append">
                                            <button class="btn btn-primary" type="submit"><i class="fas fa-search"></i></button>
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

                                    <!--TABLE START-->
                                    <div class="table-responsive">
                                        <table class="table table-hover table-center mb-0 ">
                                            <thead>
                                                <tr>
                                                    <th class="sortable" data-sort="id">Id<i class="fas fa-sort"></i></th>
                                                    <th class="sortable" data-sort="name">Name<i class="fas fa-sort"></i></th>
                                                    <th class="sortable" data-sort="subjectName">Subject<i class="fas fa-sort"></i></th>
                                                    <th class="sortable" data-sort="chapterName">Chapter<i class="fas fa-sort"></i></th>
                                                    <th class="sortable" data-sort="dimensionName">Dimension<i class="fas fa-sort"></i></th>

                                                    <th>Status</th>
                                                    <th class="text-right">Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${quizs}" var="q">
                                                    <tr>
                                                        <td class="text-truncate" data-toggle="tooltip" title="${q.quizId}">${q.quizId}</td>
                                                        <td class="text-truncate" data-toggle="tooltip" title="${q.quizName}">${q.quizName}</td>
                                                        <td class="text-truncate" data-toggle="tooltip" title="${q.subject.subjectName}">${q.subject.subjectName}</td>
                                                        <td class="text-truncate" data-toggle="tooltip" title="${q.chapter.chapterName}">${q.chapter.chapterName}</td>
                                                        <td class="text-truncate" data-toggle="tooltip" title="${q.dimension.dimensionName}">${q.dimension.dimensionName}</td>

                                                        <td>
                                                            <input name="status" id="statusCheck${q.quizId}"
                                                                   type="checkbox" data-toggle="switchbutton"
                                                                   data-quiz-id="${q.quizId}"
                                                                   ${q.status == true ? 'checked' : ''}
                                                                   data-onstyle="info"
                                                                   data-style="ios"
                                                                   data-size="sm"
                                                                   data-onlabel="Active"
                                                                   data-offlabel="Inactive">
                                                        </td>
                                                        <td class="text-right">
                                                            <div class="actions ">
                                                                <a 
                                                                    href="quiz-list?action=update&id=${q.quizId}"
                                                                    class="btn btn-sm bg-success-light mr-2">
                                                                    <i class="fas fa-pen"></i>
                                                                </a>
                                                                <a
                                                                    href=""
                                                                    data-toggle="modal" 
                                                                    data-target="#deleteQuizModal${q.quizId}"
                                                                    class="btn btn-sm bg-danger-light">
                                                                    <i class="fas fa-trash text-white"></i>
                                                                </a>
                                                                <jsp:include page="../../components/manager/delete-quiz.jsp">
                                                                    <jsp:param name="quizId" value="${q.quizId}"></jsp:param>
                                                                </jsp:include>
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
                                               href="quiz-list?action=view&page=${currentPage - 1}&keyword=${keyword}&status=${statusSaved}&subject=${subjectIdSaved}&chapter=${chapterIdSaved}&dimension=${dimensionIdSaved}" 
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
                                                           href="quiz-list?action=view&page=${i}&keyword=${keyword}&status=${statusSaved}&subject=${subjectIdSaved}&chapter=${chapterIdSaved}&dimension=${dimensionIdSaved}">
                                                            ${i}
                                                        </a>
                                                    </li>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                        <li class="page-item ${currentPage eq noOfPages ? 'disabled' : ''}">
                                            <a 
                                                class="page-link" 
                                                href="quiz-list?action=view&page=${currentPage + 1}&keyword=${keyword}&status=${statusSaved}&subject=${subjectIdSaved}&chapter=${chapterIdSaved}&dimension=${dimensionIdSaved}">
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
                <jsp:include page="../../components/general/footer.jsp"></jsp:include>
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
                                                // When a switch button is clicked
                                                $('input[name="status"]').on('change', function () {
                                                    var quizId = $(this).data('quiz-id');
                                                    var newStatus = $(this).prop('checked');
                                                    console.log(quizId);

                                                    // Send an AJAX request to update the status
                                                    $.ajax({
                                                        type: 'POST',
                                                        url: 'quiz-list?action=updateStatus',
                                                        data: {
                                                            quizId: quizId,
                                                            status: newStatus
                                                        },
                                                        success: function (response) {
                                                            $('#updateStatusSuccessToast').toast('show');
                                                            console.log('Status updated successfully');
                                                        },
                                                        error: function (xhr, status, error) {
                                                            // Handle the AJAX request error
                                                            console.error('Ajax request error:', status, error);
                                                        }
                                                    });
                                                });
                                            });
            </script>
            <script>
                $(document).ready(function () {
            <c:if test="${sessionScope.isUpdateStatusSuccesss == true}">
                    $('#updateStatusSuccessToast').toast('show');
            </c:if>
            <c:if test="${sessionScope.isDeleteSuccess == true}">
                    $('#deleteSuccessToast').toast('show');
            </c:if>
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
        session.removeAttribute("isUpdateStatusSuccesss");
        session.removeAttribute("isDeleteSuccess");
        session.removeAttribute("isAddSuccess");
        session.removeAttribute("isUpdateSuccess"); 
    %>
    <!-- Mirrored from preschool.dreamguystech.com/html-template/students.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 28 Oct 2021 11:11:49 GMT -->
</html>
