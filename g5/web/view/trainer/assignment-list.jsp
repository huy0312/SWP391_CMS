<%-- 
    Document   :Class-View
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
            .switch.ios, .switch-on.ios, .switch-off.ios {
                border-radius: 20rem;
            }
            .switch.ios .switch-handle {
                border-radius: 20rem;
            }
        </style>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>CMSLVL10 - Class Assignment List</title>
        <link rel="shortcut icon" href="./view/assets/img/logo_short.png">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,500;0,600;0,700;1,400&amp;display=swap">
        <link rel="stylesheet" href="./view/assets/plugins/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="./view/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="./view/assets/plugins/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="./view/assets/plugins/datatables/datatables.min.css">
        <link rel="stylesheet" href="./view/assets/css/style.css">
        <link href="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/css/bootstrap4-toggle.min.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link href="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap-switch-button@1.1.0/css/bootstrap-switch-button.min.css" rel="stylesheet">
    </head>
    <body>

        <div class="main-wrapper">
            <!--HEADER-->
            <jsp:include page="../components/general/body-header.jsp"></jsp:include>
                <!--SIDEBAR-->
            <jsp:include page="../components/general/sidebar.jsp">
                <jsp:param name="isAssignmentList" value="1"></jsp:param>
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

                    </div>
                    <!--TOAST END-->

                    <!--NAVIGATION Start-->
                    <div class="page-header">
                        <div class="row align-items-center">
                            <!--NAVIGATION START-->
                            <div class="col">
                                <h3 class="page-title">Assignment List</h3>
                                <ul class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="home">Home</a></li>
                                    <li class="breadcrumb-item active">Assignment List</li>
                                </ul>
                            </div>
                            <!--NAVIGATION END-->

                            <!--ADD BUTTON START-->
                            <div class="col-auto text-right float-right ml-auto">
                                <button type="button" 
                                        onclick="window.location.href = 'assignment-list?action=add'" 
                                        class="btn btn-primary">
                                    <i class="fas fa-plus"></i> Add  Assignment
                                </button>
                            </div>
                            <!--ADD BUTTON END-->
                        </div>

                        <!--SEARCH START-->
                        <form id="searchForm" action="assignment-list">
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
                                </div>

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
                                                    <th>#</th>
                                                    <th>Title</th>
                                                    <th>Chapter</th>
                                                    <th>Deadline</th>
                                                    <th>Status</th>
                                                    <th>Class</th>
                                                    <th class="text-right">Action</th>
                                                </tr>
                                            </thead>
                                            <tr>
                                            <tbody>
                                                <c:forEach items="${assignments}" var="c">
                                                    <tr>

                                                        <td>${c.assignmentId}</td>
                                                        <td>${c.assignmentTitle}</td>
                                                   
                                                        <td class="text-truncate" data-toggle="tooltip" title="${c.chapter.chapterId}">${c.chapter.chapterName}</td>
                                                        <td class="text-truncate" data-toggle="tooltip" title="${c.deadline}">${c.deadline}</td>
                                                        <td>
                                                            <input name="status" id="statusCheck${c.assignmentId}"
                                                                   type="checkbox" data-toggle="switchbutton"
                                                                   data-assignment-id="${c.assignmentId}"
                                                                   ${c.status == true ? 'checked' : ''}
                                                                   data-onstyle="info"
                                                                   data-style="ios"
                                                                   data-size="sm"
                                                                   data-onlabel="Active"
                                                                   data-offlabel="Inactive">
                                                        </td>

                                                        <td class="text-truncate" data-toggle="tooltip" title="${c.classes.classId}">${c.classes.classCode}</td>

                                                        <td class="text-right">
                                                            <div class="actions">
                                                                <a 
                                                                    href="assignment-list?action=update&&assignmentId=${c.assignmentId}" 
                                                                    class="btn btn-rounded btn-sm bg-success-light mr-2">
                                                                    <i class="fas fa-pen"></i>
                                                                </a>
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
                                               href="assignment-list?action=view&page=${currentPage - 1}&keyword=${keyword}&status=${statusSaved}" 
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
                                                           href="assignment-list?action=view&page=${i}&keyword=${keyword}&status=${statusSaved}}">
                                                            ${i}
                                                        </a>
                                                    </li>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                        <li class="page-item ${currentPage eq noOfPages ? 'disabled' : ''}">
                                            <a 
                                                class="page-link" 
                                                href="assignment-list?action=view&page=${currentPage + 1}&keyword=${keyword}&status=${statusSaved}">
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
            </div>
            <script src="./view/assets/js/jquery-3.6.0.min.js"></script>
            <script src="./view/assets/js/popper.min.js"></script>
            <script src="./view/assets/plugins/bootstrap/js/bootstrap.min.js"></script>
            <script src="./view/assets/plugins/slimscroll/jquery.slimscroll.min.js"></script>
            <script src="./view/assets/plugins/datatables/datatables.min.js"></script>
            <script src="./view/assets/js/script.js"></script>
            <script src="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap-switch-button@1.1.0/dist/bootstrap-switch-button.min.js"></script>
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
                                                $(document).ready(function () {
                                                    // When a switch button is clicked
                                                    $('input[name="status"]').on('change', function () {
                                                        var assignmentId = $(this).data('assignment-id');
                                                        var newStatus = $(this).prop('checked');

                                                        // Send an AJAX request to update the status
                                                        $.ajax({
                                                            type: 'POST',
                                                            url: 'assignment-list?action=update-status',
                                                            data: {
                                                                assignmentId: assignmentId,
                                                                status: newStatus
                                                            },
                                                            success: function (response) {
                                                                $('#updateSuccessToast').toast('show');
                                                                console.log('Status updated successfully');
                                                            }

                                                        });
                                                    });
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
       
        session.removeAttribute("isAddSuccess");
        session.removeAttribute("isUpdateSuccess"); 
    %>

</html>
