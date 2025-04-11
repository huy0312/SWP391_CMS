<%-- 
    Document   : user-details
    Created on : Nov 4, 2023, 1:05:36 PM
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
        <title>CMSLVL10 - System Details</title>
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
            <jsp:include page="../components/general/sidebar.jsp"></jsp:include>
                <div class="page-wrapper">
                    <div class="content container-fluid">
                        <div class="page-header">
                            <div class="row align-items-center">
                                <!--NAVIGATION START-->
                                <div class="col">
                                    <h3 class="page-title">System Details</h3>
                                    <ul class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="admin-dashboard">Dashboard</a></li>
                                        <li class="breadcrumb-item"><a href="system-setting?action=view">System Setting</a></li>
                                        <li class="breadcrumb-item active">Setting Details</li>
                                    </ul>
                                </div>
                                <!--NAVIGATION END-->
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="card">
                                    <div class="card-body">
                                        <form class="needs-validation" action="system-setting?action=update" method="post" novalidate>
                                            <div class="row">
                                                <div class="col-12">
                                                    <h5 class="form-title"><span>System Setting</span></h5>
                                                </div>
                                                <div class="col-12 col-sm-6">
                                                    <div class="form-group">
                                                        <input type="hidden" name="id" value="${requestScope.setting.settingId}">
                                                    <label>Setting Group</label>
                                                    <input 
                                                        type="text" 
                                                        name="settingGroup" 
                                                        class="form-control" 
                                                        value="${requestScope.setting.settingGroup}" 
                                                        pattern="^[A-Za-z]+(?: [A-Za-z]+)*$" 
                                                        required>
                                                    <div class="invalid-feedback">
                                                        Please provide a valid name.
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-6">
                                                <div class="form-group">
                                                    <label>Setting Name</label>
                                                    <input 
                                                        type="text" 
                                                        name="settingName" 
                                                        class="form-control" 
                                                        value="${requestScope.setting.settingName}" 
                                                       
                                                        required>
                                                    <div class="invalid-feedback">

                                                    </div>
                                                </div>                                                
                                            </div>
                                            <div class="col-12 col-sm-6">
                                                <div class="form-group">
                                                    <label>Setting Value</label>
                                                    <input 
                                                        type="text" 
                                                        name="settingValue" 
                                                        class="form-control" 
                                                        
                                                        value="${requestScope.setting.settingValue}" 
                                                        required>
                                                    
                                                </div>
                                            </div>                                         
                                            <div class="col-12 col-sm-3">
                                                <div class="form-group">
                                                    <input 
                                                        id="activerb" 
                                                        name="statusrb" 
                                                        type="radio" 
                                                        class="d-none" 
                                                        value="1" 
                                                        ${requestScope.setting.status 
                                                          ? 'checked' 
                                                          : ''}>
                                                    <input 
                                                        id="inactiverb" 
                                                        name="statusrb" 
                                                        type="radio" 
                                                        class="d-none" 
                                                        value="0" 
                                                        ${!requestScope.setting.status 
                                                          ? 'checked' 
                                                          : ''}>
                                                    <label>Status: </label>
                                                    <br/>
                                                    <input name="status" id="status"
                                                           type="checkbox" data-toggle="switchbutton"
                                                           data-onstyle="info"
                                                           data-onlabel="Active"
                                                           data-offlabel="Inactive"
                                                           ${requestScope.setting.status ? 'checked' : ''}
                                                           >
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-12">
                                                <div class="form-group">
                                                    <label>Description</label>
                                                    <textarea 
                                                        type="text" 
                                                        name="description" 
                                                        class="form-control" 
                                                        rows="6">
                                                        ${requestScope.setting.description}
                                                    </textarea>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <button 
                                                    type="submit" 
                                                    class="btn btn-primary">
                                                    Update
                                                </button>
                                            </div>
                                        </div>
                                    </form>
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
            <script src="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap-switch-button@1.1.0/dist/bootstrap-switch-button.min.js"></script>
            <script src="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/js/bootstrap4-toggle.min.js"></script>
            <script>
                $('#status').on('change', function () {
                    if ($(this).is(':checked')) {
                        $('input[name=statusrb][value=1]').prop('checked', true);
                    } else {
                        $('input[name=statusrb][value=0]').prop('checked', true);
                    }
                });
            </script>
    </body>
    <!-- Mirrored from preschool.dreamguystech.com/html-template/students.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 28 Oct 2021 11:11:49 GMT -->
</html>
