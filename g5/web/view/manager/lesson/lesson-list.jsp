<%-- 
    Document   : Lesson-View
    Created on : Oct 15, 2023, 1:42:59 AM
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
        <title>CMSLVL10 - LESSON LIST</title>
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
            <jsp:include page="../../components/general/body-header.jsp"></jsp:include>
                <!--SIDEBAR-->
            <jsp:include page="../../components/general/sidebar.jsp">
                <jsp:param name="isLessonList" value="1"></jsp:param>
            </jsp:include>
            <div class="page-wrapper">
                <div class="content container-fluid">

                    <!--TOAST START-->
                    <div aria-live="polite" aria-atomic="true" style="position: relative; z-index: 11">
                        <div class="toast bg-success text-white border-0" id="updateSuccessToast" data-delay="2000" data-autohide="true" role="alert" aria-live="assertive" aria-atomic="true" style="position: fixed; bottom: 20px; right: 20px;">
                            <div class="toast-body">
                                Updated successfully!
                                <button type="button" class="ml-2 mb-1 close" data-dismiss="toast">&times;</button>
                            </div>
                        </div>
                        <div class="toast bg-success text-white border-0" id="addSuccessToast" data-delay="2000" data-autohide="true" role="alert" aria-live="assertive" aria-atomic="true" style="position: fixed; bottom: 20px; right: 20px;">
                            <div class="toast-body">
                                Added successfully!
                                <button type="button" class="ml-2 mb-1 close" data-dismiss="toast">&times;</button>
                            </div>
                        </div>
                        <div class="toast bg-success text-white border-0" id="deleteSuccessToast" data-delay="2000" data-autohide="true" role="alert" aria-live="assertive" aria-atomic="true" style="position: fixed; bottom: 20px; right: 20px;">
                            <div class="toast-body">
                                Deleted successfully!
                                <button type="button" class="ml-2 mb-1 close" data-dismiss="toast">&times;</button>
                            </div>
                        </div>
                    </div>
                    <!--TOAST END-->

                    <div class="page-header">
                        <div class="row align-items-center">
                            <!--NAVIGATION START-->
                            <div class="col">
                                <h3 class="page-title">Lesson List</h3>
                                <ul class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="home">Home</a></li>
                                    <li class="breadcrumb-item active">Lesson List</li>
                                </ul>
                            </div>
                            <!--NAVIGATION END-->

                            <!--ADD BUTTON START-->
                            <div class="col-auto text-right float-right ml-auto">
                                <button type="button" 
                                        onclick="window.location.href = 'lesson-list?action=add'" 
                                        class="btn btn-primary">
                                    <i class="fas fa-plus"></i> Add lesson
                                </button>
                            </div>
                            <!--ADD BUTTON END-->
                        </div>

                        <!--SEARCH START-->
                        <form id="searchForm" action="lesson-list">
                            <!--FILTER-->
                            <div class="row">
                                <div class="col mt-auto">
                                    <div class="btn-group">
                                        <select 
                                            onchange="this.form.submit()" 
                                            name="status"  
                                            class="form-control text-truncate">
                                            <option value="-1" 
                                                    ${statusSaved eq -1 ? 'selected' : ''}>
                                                Status
                                            </option>
                                            <option 
                                                value="1" 
                                                ${statusSaved eq 1 ? 'selected' : ''}>
                                                Active
                                            </option>
                                            <option 
                                                value="0" 
                                                ${statusSaved eq 0 ? 'selected' : ''}>
                                                Inactive
                                            </option>
                                        </select>
                                    </div>
                                    &nbsp
                                    <div class="btn-group">
                                        <select 
                                            id="subject"
                                            name="subject" 
                                            onchange="getChapter()" 
                                            class="form-control text-truncate">
                                            <c:forEach items="${subjects}" var="r">
                                                <option 
                                                    value="${r.subjectId}"
                                                    ${subjectIdSaved eq r.subjectId ? 'selected' : ''}>
                                                    ${r.subjectName}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    &nbsp
                                    <div class="btn-group">
                                        <select
                                            id="chapter"
                                            name="chapter" 
                                            onchange="this.form.submit()" 
                                            class="form-control text-truncate">
                                            <c:forEach items="${chapters}" var="r">
                                                <option 
                                                    value="${r.chapterId}"
                                                    ${chapterIdSaved eq r.chapterId ? 'selected' : ''}>
                                                    ${r.chapterName}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>

                                <!--SEARCH-->
                                <div class="col-auto text-right float-right ml-auto">
                                    <div class="input-group">
                                        <input type="hidden" name="action" value="view">
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

                                    <!--TABLE START-->
                                    <div class="table-responsive">
                                        <table class="table table-hover table-center mb-0 ">
                                            <thead>
                                                <tr>   
                                                    <th class="sortable" data-sort="id">
                                                        #<i class="fas fa-sort"></i>
                                                    </th>
                                                    <th class="sortable" data-sort="name">
                                                        Name<i class="fas fa-sort"></i>
                                                    </th>
                                                    <th class="sortable" data-sort="type">
                                                        Type<i class="fas fa-sort"></i>
                                                    </th>
                                                    <th class="sortable" data-sort="order">
                                                        Order<i class="fas fa-sort"></i>
                                                    </th>
                                                    <th class="text-right">Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${lessons}" var="c">
                                                    <tr>
                                                        <td>${c.lessonId}</td>
                                                        <td 
                                                            class="text-truncate" 
                                                            data-toggle="tooltip" 
                                                            title="${c.lessonName}">
                                                            ${c.lessonName}
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${c.lessonType eq 1}">Video</c:when>
                                                                <c:when test="${c.lessonType eq 2}">Quiz</c:when>
                                                                <c:when test="${c.lessonType eq 3}">Assignment</c:when>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            ${c.displayOrder}
                                                        </td>
                                                        <td class="text-right">
                                                            <div class="actions">
                                                                <a 
                                                                    href="lesson-list?action=update&id=${c.lessonId}" 
                                                                    class="btn btn-sm bg-success-light mr-2">
                                                                    <i class="fas fa-pen"></i>
                                                                </a>
                                                                <a
                                                                    href=""
                                                                    data-toggle="modal" 
                                                                    data-target="#deleteLessonModal${c.lessonId}"
                                                                    class="btn btn-sm bg-danger-light">
                                                                    <i class="fas fa-trash text-white"></i>
                                                                </a>
                                                                <jsp:include page="../../components/manager/delete-lesson.jsp">
                                                                    <jsp:param name="lessonId" value="${c.lessonId}"></jsp:param>
                                                                    <jsp:param name="action" value="lesson-list?action=delete"></jsp:param>
                                                                </jsp:include>
                                                            </div>
                                                        </td> 
                                                    </tr>
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
                                               href="lesson-list?action=view&page=${currentPage - 1}&keyword=${keyword}&status=${statusSaved}&subject=${subjectIdSaved}&chapter=${chapterIdSaved}" 
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
                                                           href="lesson-list?action=view&page=${i}&keyword=${keyword}&status=${statusSaved}&subject=${subjectIdSaved}&chapter=${chapterIdSaved}">
                                                            ${i}
                                                        </a>
                                                    </li>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                        <li class="page-item ${currentPage eq noOfPages ? 'disabled' : ''}">
                                            <a 
                                                class="page-link" 
                                                href="lesson-list?action=view&page=${currentPage + 1}&keyword=${keyword}&status=${statusSaved}&subject=${subjectIdSaved}&chapter=${chapterIdSaved}">
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
            <script src="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/js/bootstrap4-toggle.min.js"></script>
            <script>

            </script>
            <script>
                $(document).ready(function () {
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
                function getChapter() {
                    var subjectId = $('#subject').val();
                    $.ajax({
                        type: 'POST',
                        url: 'lesson-list?action=get-chapter',
                        data: {
                            subjectId: subjectId
                        },
                        success: function (response) {
                            console.log('success');
                            document.getElementById('chapter').innerHTML = response;
                            $('#searchForm').submit();
                        }
                    });
                }
        </script>
    </body>
    <% 
        session.removeAttribute("isDeleteSuccess");
        session.removeAttribute("isAddSuccess");
        session.removeAttribute("isUpdateSuccess"); 
    %>
    <!-- Mirrored from preschool.dreamguystech.com/html-template/students.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 28 Oct 2021 11:11:49 GMT -->
</html>
