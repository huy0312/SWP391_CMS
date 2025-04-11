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
        </style>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>CMSLVL10 - User List</title>
        <link rel="shortcut icon" href="./view/assets/img/logo_short.png">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,500;0,600;0,700;1,400&amp;display=swap">
        <link rel="stylesheet" href="./view/assets/plugins/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="./view/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="./view/assets/plugins/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="./view/assets/plugins/datatables/datatables.min.css">
        <link rel="stylesheet" href="./view/assets/css/style.css">
        <link href="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap-switch-button@1.1.0/css/bootstrap-switch-button.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/css/bootstrap4-toggle.min.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="./view/assets/js/sort-table.js"></script>
    </head>
    <body>

        <!--START TOASTS-->
        <c:if test="${param.isAddSucceed}">
            <jsp:include page="../components/general/alert.jsp">
                <jsp:param name="message" value="Add successfully"></jsp:param>
                <jsp:param name="type" value="success"></jsp:param>
            </jsp:include>
        </c:if>
        <c:if test="${requestScope.isUpdateSucceed}">
            <jsp:include page="../components/general/alert.jsp">
                <jsp:param name="message" value="Update successfully"></jsp:param>
                <jsp:param name="type" value="success"></jsp:param>
            </jsp:include>
        </c:if>
        <!--END TOASTS-->

        <div class="main-wrapper">
            <!--HEADER-->
            <jsp:include page="../components/general/body-header.jsp"></jsp:include>
                <!--SIDEBAR-->
            <jsp:include page="../components/general/sidebar.jsp"></jsp:include>
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
                            <div class="toast bg-success text-white border-0" id="updateStatusSuccessToast" data-delay="1000" data-autohide="true" role="alert" aria-live="assertive" aria-atomic="true" style="position: fixed; bottom: 20px; right: 20px;">
                                <div class="toast-body">
                                    Update status successfully!
                                    <button type="button" class="ml-2 mb-1 close" data-dismiss="toast">&times;</button>
                                </div>
                            </div>
                        </div>
                        <!--TOAST END-->

                        <div class="page-header">
                            <div class="row align-items-center">
                                <!--NAVIGATION START-->
                                <div class="col">
                                    <h3 class="page-title">User List</h3>
                                    <ul class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="admin-dashboard">Dashboard</a></li>
                                        <li class="breadcrumb-item active">User List</li>
                                    </ul>
                                </div>
                                <!--NAVIGATION END-->

                                <!--ADD BUTTON START-->
                                <div class="col-auto text-right float-right ml-auto">
                                    <button 
                                        type="button" 
                                        data-toggle="modal" 
                                        data-target="#addUserModal" 
                                        class="btn btn-primary">
                                        <i class="fas fa-plus"></i> Add user
                                    </button>
                                </div>
                                <!--ADD BUTTON END-->

                                <!--ADD USER MODAL-->
                            <jsp:include page="../components/admin/add-user.jsp"></jsp:include>
                            </div>

                            <!--SEARCH START-->
                            <form action="user-list">
                                <div class="row">
                                    <div class="col mt-auto">
                                        <div class="btn-group">
                                            <select 
                                                onchange="this.form.submit()" 
                                                name="status" 
                                                class="form-control">
                                                <option 
                                                    value="-1" 
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
                                        <select onchange="this.form.submit()" name="role" class="form-control">
                                            <option value="-1" ${roleIdSaved eq -1 ? 'selected' : ''}>Role</option>
                                            <c:forEach items="${roles}" var="r">
                                                <option value="${r.settingId}"
                                                        ${roleIdSaved eq r.settingId ? 'selected' : ''}
                                                        >${r.settingName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
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
                                                    <th class="sortable" data-sort="id">
                                                        #<i class="fas fa-sort"></i>
                                                    </th>
                                                    <th class="sortable" data-sort="role">
                                                        Role<i class="fas fa-sort"></i>
                                                    </th>
                                                    <th class="sortable" data-sort="name">
                                                        Name<i class="fas fa-sort"></i>
                                                    </th>
                                                    <th class="sortable" data-sort="email">
                                                        Email<i class="fas fa-sort"></i>
                                                    </th>
                                                    <th class="sortable" data-sort="mobile">
                                                        Mobile<i class="fas fa-sort"></i>
                                                    </th>
                                                    <th>Status</th>
                                                    <th class="text-right">Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${requestScope.users}" var="c">
                                                    <tr>
                                                        <td>${c.userId}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${c.role.settingValue eq '1'}">
                                                                    Admin
                                                                </c:when>
                                                                <c:when test="${c.role.settingValue eq '2'}">
                                                                    SM
                                                                </c:when>
                                                                <c:when test="${c.role.settingValue eq '3'}">
                                                                    Trainer
                                                                </c:when>
                                                                <c:when test="${c.role.settingValue eq '4'}">
                                                                    Trainee
                                                                </c:when>
                                                            </c:choose>
                                                        </td>
                                                        <td>${c.fullName}</td>
                                                        <td>${c.email}</td>
                                                        <td>${c.mobile}</td>
                                                        <td>
                                                            <input name="status" id="statusCheck${c.status}"
                                                                   type="checkbox" data-toggle="switchbutton"
                                                                   data-user-id="${c.userId}"
                                                                   ${c.status == true ? 'checked' : ''}
                                                                   data-onstyle="info"
                                                                   data-size="sm"
                                                                   data-onlabel="Active"
                                                                   data-offlabel="Inactive">
                                                        </td>
                                                        <td class="text-right">
                                                            <div class="actions">
                                                                <a
                                                                    href="user-list?action=update&id=${c.userId}"
                                                                    class="btn btn-sm bg-success-light mr-2">
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
                                               href="user-list?action=view&page=${currentPage - 1}&keyword=${keyword}&status=${statusSaved}&role=${roleIdSaved}" 
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
                                                           href="user-list?action=view&page=${i}&keyword=${keyword}&status=${statusSaved}&role=${roleIdSaved}">
                                                            ${i}
                                                        </a>
                                                    </li>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                        <li class="page-item ${currentPage eq noOfPages ? 'disabled' : ''}">
                                            <a 
                                                class="page-link" 
                                                href="user-list?action=view&page=${currentPage + 1}&keyword=${keyword}&status=${statusSaved}&role=${roleIdSaved}">
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
            <script src="./view/assets/js/form-validation.js"></script>
            <script src="./view/assets/js/script.js"></script>
            <script src="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/js/bootstrap4-toggle.min.js"></script>
            <script src="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap-switch-button@1.1.0/dist/bootstrap-switch-button.min.js"></script>
            <script>
                                            $(document).ready(function () {
            ${sessionScope.isAddSuccess == true ? "$('#addSuccessToast').toast('show');" : ''}
            ${sessionScope.isUpdateSuccess == true ? "$('#updateSuccessToast').toast('show');" : ''}
                                            });
        </script>
        <script>
            $(document).ready(function () {
                // When a switch button is clicked
                $('input[name="status"]').on('change', function () {
                    var userId = $(this).data('user-id');
                    var newStatus = $(this).prop('checked');

                    // Send an AJAX request to update the status
                    $.ajax({
                        type: 'POST',
                        url: 'user-list?action=updateStatus',
                        data: {
                            userId: userId,
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
    </body>
    <!-- Mirrored from preschool.dreamguystech.com/html-template/students.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 28 Oct 2021 11:11:49 GMT -->
</html>
<% 
    session.removeAttribute("isAddSuccess");
    session.removeAttribute("isUpdateSuccess"); 
%>
