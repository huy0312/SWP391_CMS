<%-- 
    Document   : new-class
    Created on : Oct 17, 2023, 6:00:00 PM
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
            .switch.ios, .switch-on.ios, .switch-off.ios {
                border-radius: 20rem;
            }
            .switch.ios .switch-handle {
                border-radius: 20rem;
            }
        </style>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>CMSLVL10 - CLASS DETAILS</title>
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
            <jsp:include page="../../components/general/body-header.jsp"></jsp:include>
                <!--SIDEBAR-->
            <jsp:include page="../../components/general/sidebar.jsp">
                <jsp:param name="isClassList" value="1"></jsp:param>
            </jsp:include>
            <div class="page-wrapper">
                <div class="content container-fluid">

                    <!--TOAST START-->
                    <div aria-live="polite" aria-atomic="true" style="position: relative; z-index: 11">
                        <div class="toast bg-danger text-white border-0" id="errorToast" data-delay="1000" data-autohide="true" role="alert" aria-live="assertive" aria-atomic="true" style="position: fixed; bottom: 20px; right: 20px;">
                            <div class="toast-body">
                                Class is collied! Try another code.
                                <button type="button" class="ml-2 mb-1 close" data-dismiss="toast">&times;</button>
                            </div>
                        </div>
<!--                        <div class="toast bg-success text-white border-0" id="updateSuccessToast" data-delay="1000" data-autohide="true" role="alert" aria-live="assertive" aria-atomic="true" style="position: fixed; bottom: 20px; right: 20px;">
                            <div class="toast-body">
                                Updated successfully!
                                <button type="button" class="ml-2 mb-1 close" data-dismiss="toast">&times;</button>
                            </div>
                        </div>-->
                    </div>
                    <!--TOAST END-->

                    <div class="page-header">
                        <div class="row align-items-center">
                            <!--NAVIGATION START-->
                            <div class="col">
                                <h3 class="page-title">Class Details</h3>
                                <ul class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="home">Home</a></li>
                                    <li class="breadcrumb-item"><a href="class-list?action=view">Class List</a></li>
                                    <li class="breadcrumb-item active">Class details</li>
                                </ul>
                            </div> 
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-body">
                                    <form id="updateClassForm" >
                                        <div class="row">
                                            <div class="col-12">
                                                <h5 class="form-title"><span>Class Information</span></h5>
                                            </div>
                                            <div class="col-12 col-sm-12">
                                                <div class="form-group">
                                                    <label>Code <span class="text-danger">*</span></label>
                                                    <input type="hidden" name="classId" value="${requestScope.updateclass.classId}">
                                                    <input id="classCode" name="classCode" type="text" class="form-control" value="${requestScope.updateclass.classCode}"  required>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-6">
                                                <div class="form-group">
                                                    <label>Semester <span class="text-danger">*</span></label>
                                                    <select name="semesterId"  class="form-control">
                                                        <c:forEach items="${requestScope.settings}" var="set">
                                                            <option value="${set.settingId}"
                                                                    ${set.settingId eq requestScope.updateclass.setting.settingId ? 'selected' : ''}
                                                                    > ${set.settingName}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-6">
                                                <div class="form-group">
                                                    <label>Subject <span class="text-danger">*</span></label>
                                                    <select name="subjectId"  class="form-control">
                                                        <c:forEach items="${subjects}" var="r">
                                                            <option value="${r.subjectId}"
                                                                    ${requestScope.updateclass.subject.subjectId eq r.subjectId ? 'selected' : ''}
                                                                    >${r.subjectName}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <button type="submit" class="btn btn-primary">Submit</button>
                                            </div>
                                        </div>
                                    </form>
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
            <script src="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap-switch-button@1.1.0/dist/bootstrap-switch-button.min.js"></script>
            <script src="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/js/bootstrap4-toggle.min.js"></script>
            <script>
                $(document).ready(function () {
                    $("#updateClassForm").submit(function (event) {
                        event.preventDefault();
                        var formData = $(this).serialize();
                        $.ajax({
                            type: "POST",
                            url: "class-list?action=update",
                            data: formData,
                            success: function (response) {
                                window.location.href = 'class-list?action=view';
                            },
                            error: function () {
                                console.log("error");

                            }
//                            if(response.trim() != "success"){
//                                 $('#errorToast').toast('show');
//                            }

                        });
                    });
                });
//                success: function (response) {
//                                console.log(response);
//                                if (response.trim() === "success") {
//                                    window.location.href = 'class-list?action=view&success=true';
//                                    console.log("success");
//                                } else {
//                                    $('#errorToast').toast('show');
//                                }
//                            },
//                            error: function () {
//                                console.log("chiu");
//                            }
            </script>
    </body>
    <!-- Mirrored from preschool.dreamguystech.com/html-template/students.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 28 Oct 2021 11:11:49 GMT -->
</html>