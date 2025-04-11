<%-- 
    Document   : update-subject
    Created on : Sep 23, 2023, 10:52:52 PM
    Author     : win
--%>
<!DOCTYPE html>
<html lang="en">
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <title>CMSLVL10 - SUBJECT DETAILS</title>
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
            <jsp:include page="../../../components/general/body-header.jsp"></jsp:include>
                <!--SIDEBAR-->
            <jsp:include page="../../../components/general/sidebar.jsp"></jsp:include>

                <div class="page-wrapper">
                    <div class="content container-fluid">

                        <!--TOAST START-->
                      <div aria-live="polite" aria-atomic="true" style="position: relative; z-index: 11">
                        <div class="toast bg-danger text-white border-0" id="errorToast" data-delay="1000" data-autohide="true" role="alert" aria-live="assertive" aria-atomic="true" style="position: fixed; bottom: 20px; right: 20px;">
                            <div class="toast-body">
                                Subject is collied! Try another code.
                                <button type="button" class="ml-2 mb-1 close" data-dismiss="toast">&times;</button>
                            </div>
                        </div>
<!--                  
                        <!--TOAST END-->

                        <div class="page-header">
                            <div class="row align-items-center">
                                <!--NAVIGATION START-->
                                <div class="col">
                                    <h3 class="page-title">SUBJECT DETAILS</h3>
                                    <ul class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="home">Home</a></li>
                                        <li class="breadcrumb-item"><a href="subject-list?action=view">Subject List</a></li>
                                        <li class="breadcrumb-item active">Subject Details</li>
                                    </ul>
                                </div> 
                            </div>
                        </div>
                        <!-- Form-->
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="card">
                                    <div class="card-body">
                                        <form id="updateSubjectForm" >
                                            <div class="row">
                                                <div class="col-12">
                                                    <h5 class="form-title"><span>Subject Information</span></h5>
                                                </div>
                                                <div class="col-12 col-sm-12">
                                                    <div class="form-group">
                                                        <div class="form-group">
                                                            <label>Code</label>
                                                            <input type="hidden" name="subjectId" value="${requestScope.sub.subjectId}">
                                                            <input type="text" class="form-control" name="subjectCode" value="${requestScope.sub.subjectCode}">                                                        </div>
                                                        <div class="form-group">
                                                            <label>Name</label>
                                                            <input type="text" class="form-control" name="subjectName" value="${requestScope.sub.subjectCode}">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-12">
                                                    <div class="form-group">
                                                        <label>Subject Manager</label>
                                                        <select name="managerId" class="form-control" >
                                                            <option value="${requestScope.sub.manager.getFullName() }"></option>
                                                        <c:forEach items="${requestScope.users}" var="u">
                                                            <option value="${u.userId}" ${requestScope.sub.manager.userId eq u.userId ? 'selected' : ''}>
                                                                ${u.fullName}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="col-12 col-sm-12">
                                                <div class="form-group">
                                                    <label>Description</label>
                                                    <textarea 
                                                        type="text" 
                                                        name="description" 
                                                        class="form-control" 
                                                        rows="6"
                                                      >${requestScope.sub.subjectDescription}
                                                    </textarea>
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
                    <jsp:include page="../../../components/general/footer.jsp"></jsp:include>
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
                $("#updateSubjectForm").submit(function (event) {
                    event.preventDefault(); // Prevent the default form submission
                    var formData = $(this).serialize();
                    $.ajax({
                        type: "POST",
                        url: "subject-list?action=update",
                        data: formData,
                        success: function (response) {
                                window.location.href = 'subject-list?action=view';
                            },
                            error: function () {
                                console.log("error");

                        }
                    });
                });
            });

        </script>
    </body>
    <!-- Mirrored from preschool.dreamguystech.com/html-template/students.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 28 Oct 2021 11:11:49 GMT -->
</html>