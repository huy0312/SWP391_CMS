

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <!-- Mirrored from preschool.dreamguystech.com/html-template/holiday.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 28 Oct 2021 11:11:50 GMT -->
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>CMSLVL10 - Semester</title>

        <link rel="shortcut icon" href="./view/assets/img/logo_short.png">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,500;0,600;0,700;1,400&amp;display=swap">

        <link rel="stylesheet" href="./view/assets/plugins/bootstrap/css/bootstrap.min.css">

        <link rel="stylesheet" href="./view/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="./view/assets/plugins/fontawesome/css/all.min.css">

        <link rel="stylesheet" href="./view/assets/plugins/datatables/datatables.min.css">

        <link rel="stylesheet" href="./view/assets/css/style.css">
        <link href="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/css/bootstrap4-toggle.min.css" rel="stylesheet">
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
                                    <h3 class="page-title">Semester</h3>
                                    <ul class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="">System setting</a></li>
                                        <div class="col-auto text-right float-right ml-auto">
                                            <button type="button" data-toggle="modal" data-target="#addSemesterModal" class="btn btn-rounded btn-outline-info">Add Semester</button>
                                        </div>
                                    <jsp:include page="../components/semester/add-semester.jsp"></jsp:include>
                                    </ul>
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
                                                    <th>ID</th>
                                                    <th>Semester Name</th>
                                                    <th>Period</th> 
                                                    <th>Status</th>
                                                    <th class="text-right">Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${setting}" var="d">
                                                <tr>
                                                    <td>${d.settingValue} </td>
                                                    <td>
                                                        ${d.settingName}
                                                    </td>
                                                    <td>
                                                        ${d.description}
                                                    </td>                                            
                                                    <td>
                                                        ${d.status == true ? '<span class="badge badge-secondary badge-success">Active</span>' : '<span class="badge badge-secondary badge-danger">Inactive</span>'}
                                                    </td>
                                                    <td class="text-right">
                                                        <div>

                                                            <div class="actions">
                                                                <a data-toggle="modal"  data-target="#semesterDetailModal_${d.settingId}" href="semester-setting?action=view&setting_id=${d.settingId}" class="btn btn-rounded btn-sm bg-success-light mr-2">
                                                                    <i class="fas fa-pen"></i>

                                                                </a>

                                                            </div>
                                                            <div class="popupModal">
                                                                <div class="modal fade bd-example-modal-lg" id="semesterDetailModal_${d.settingId}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                                    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
                                                                        <div class="modal-content">
                                                                            <form action="semester-setting?action=update&setting_id=${d.settingId}" method="POST">
                                                                                <div class="modal-header">
                                                                                    <h5 class="modal-title" id="exampleModalLabel">Detailed Information</h5>
                                                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                                        <span aria-hidden="true">&times;</span>
                                                                                    </button>
                                                                                </div>
                                                                                <div class="modal-body">
                                                                                    <div class="row">
                                                                                        <div class="col-md-8">
                                                                                            <div class="avatar avatar-xxl text-center">
                                                                                                <img src="./view/assets/img/icon-user-default.png" class="avatar-img rounded" alt="...">
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="col-md-8 ml-auto">                               

                                                                                            <div class="form-group">
                                                                                                <label for="fname">Semester Name:</label>
                                                                                                <input type="text" name="settingName" id="settingNameInput" value="${d.settingName}" />
                                                                                            </div>
                                                                                            <div class="form-group">                          
                                                                                                <label for="description">Description:</label>
                                                                                                <textarea id="description" name="description" rows="5" cols="90"></textarea>
                                                                                            </div>
                                                                                            <div class="form-group">
                                                                                                <label>Status</label>
                                                                                                <div class="btn-group">
                                                                                                    <select name="status" class="form-control">
                                                                                                        <option value="1" ${d.status == true ? 'selected' : ''}>Active</option>
                                                                                                        <option value="0" ${d.status == false ? 'selected' : ''}>Inactive</option>
                                                                                                    </select>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div> 
                                                                                </div>
                                                                                <div class="hiddenInfor">
                                                                                    <input hidden type="text" name="settingId" value ="${d.settingId}"></input>

                                                                                    <input hidden type="text" name="settingValue" value ="${d.settingValue}"></input>

                                                                                </div>
                                                                                <div class="modal-footer">
                                                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                                                    <div class="text-right">
                                                                                        <button type="submit" class="btn btn-primary">Submit</button>
                                                                                    </div>
                                                                                </div>
                                                                            </form>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </td> 
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <script>
                $(document).ready(function () {
                    var descriptionInput = $("#descriptionInput");

                    if (descriptionInput.val() === "") {
                        descriptionInput.val("${d.description}");
                    }
                });
            </script>
            <script>
                $(document).ready(function () {
                    var settingNameInput = $("#settingNameInput");

                    if (settingNameInput.val() === "") {
                        settingNameInput.val("${d.settingName}");
                    }
                });
            </script>
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
