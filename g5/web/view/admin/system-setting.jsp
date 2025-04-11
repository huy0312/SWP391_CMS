<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
    <!-- Mirrored from preschool.dreamguystech.com/html-template/exam.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 28 Oct 2021 11:11:51 GMT -->
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>CMSLVL10 - System </title>
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
        <c:if test="${requestScope.isAddSucceed}">
            <jsp:include page="../components/general/alert.jsp">
                <jsp:param name="message" value="Add successfully"></jsp:param>
                <jsp:param name="type" value="success"></jsp:param>
            </jsp:include>
        </c:if>
        <c:if test="${requestScope.isAddSucceed eq false}">
            <jsp:include page="../components/general/alert.jsp">
                <jsp:param name="message" value="Subject is existed"></jsp:param>
                <jsp:param name="type" value="danger"></jsp:param>
            </jsp:include>
        </c:if>
        <c:if test="${requestScope.isUpdateSucceed}">
            <jsp:include page="../components/general/alert.jsp">
                <jsp:param name="message" value="Update successfully"></jsp:param>
                <jsp:param name="type" value="success"></jsp:param>
            </jsp:include>
        </c:if>
        <c:if test="${requestScope.isUpdateSucceed eq false}">
            <jsp:include page="../components/general/alert.jsp">
                <jsp:param name="message" value="Nothing changed!"></jsp:param>
                <jsp:param name="type" value="danger"></jsp:param>
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
                        <div class="page-header">
                            <div class="row align-items-center">
                                <div class="col">
                                    <h3 class="page-title">System Setting</h3>
                                    <ul class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="admin-dashboard">Dashboard</a></li>
                                        <li class="breadcrumb-item active">System Setting</li>
                                    </ul>
                                </div>
                                <!--NAVIGATION END-->
                                <!--ADD BUTTON START-->
                                <div class="col-auto text-right float-right ml-auto">
                                    <button 
                                        type="button" 
                                        data-toggle="modal" 
                                        data-target="#addSettingModal" 
                                        class="btn btn-primary">
                                        <i class="fas fa-plus"></i> Add setting
                                    </button>
                                </div>                         
                            <jsp:include page="../components/admin/add-system.jsp"></jsp:include>
                            </div>
                            <!--SEARCH START-->
                            <form action="system-setting">
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
                                    <div class="table-responsive">
                                        <table class="table table-hover table-center mb-0 ">
                                            <thead>
                                                <tr>
                                                    <th class="sortable" data-sort="settingId">
                                                        ID<i class="fas fa-sort"></i>
                                                    </th>
                                                    <th class="sortable" data-sort="settingGroup">
                                                        Setting Group<i class="fas fa-sort"></i>
                                                    </th>
                                                    <th class="sortable" data-sort="settingName">
                                                        Setting Name<i class="fas fa-sort"></i>
                                                    </th>                                                       
                                                    <th class="sortable" data-sort="settingValue">
                                                        Setting Value<i class="fas fa-sort"></i>
                                                    </th>
                                                    <th>Status</th>
                                                    <th class="text-right">Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${settings}" var="s">
                                                    <tr>
                                                    <tr>
                                                        <td>${s.settingId} </td>
                                                        <td>
                                                            ${s.settingGroup}
                                                        </td>
                                                        <td>${s.settingName}</td>
                                                        <td>${s.settingValue}</td>
                                                        <td>
                                                            <input name="status" id="statusCheck${s.status}"
                                                                   type="checkbox" data-toggle="switchbutton"
                                                                   data-setting-id="${s.settingId}"
                                                                   ${s.status == true ? 'checked' : ''}
                                                                   data-onstyle="info"
                                                                   data-size="sm"
                                                                   data-onlabel="Active"
                                                                   data-offlabel="Inactive">
                                                        </td>
                                                        <td class="text-right">
                                                            <div class="actions">
                                                                <a
                                                                    href="system-setting?action=update&id=${s.settingId}"
                                                                    class="btn btn-sm bg-success-light mr-2">
                                                                    <i class="fas fa-pen"></i>
                                                                </a>
                                                            </div>
                                                        </td> 

                                                    </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <!--START PAGINATION-->
                                <div>
                                    <ul class="pagination justify-content-center">
                                        <li class="page-item ${currentPage eq 1 ? 'disabled' : ''}">
                                            <a class="page-link" 
                                               href="system-setting?action=view&page=${currentPage - 1}&keyword=${keyword}&status=${statusSaved}&role=${roleIdSaved}" 
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
                                                           href="system-setting?action=view&page=${i}&keyword=${keyword}&status=${statusSaved}&role=${roleIdSaved}">
                                                            ${i}
                                                        </a>
                                                    </li>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                        <li class="page-item ${currentPage eq noOfPages ? 'disabled' : ''}">
                                            <a 
                                                class="page-link" 
                                                href="system-setting?action=view&page=${currentPage + 1}&keyword=${keyword}&status=${statusSaved}&role=${roleIdSaved}">
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
        </body>
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
    <!-- Mirrored from preschool.dreamguystech.com/html-template/students.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 28 Oct 2021 11:11:49 GMT -->
</html>
