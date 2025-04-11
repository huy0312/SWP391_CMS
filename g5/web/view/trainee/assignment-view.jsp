<%-- Document: home
    Created on: Oct 24, 2023, 1:00:03 AM
    Author: win
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <style type="text/css">
            a:hover {
                cursor: pointer;
            }
            .text-truncate {
                max-width: 150px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }
        </style>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>CMSLVL10 - ASSIGNMENT</title>
        <link rel="shortcut icon" href="./view/assets/img/logo_short.png">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,500;0,600;0,700;1,400&amp;display=swap">
        <link rel="stylesheet" href="./view/assets/plugins/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="./view/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="./view/assets/plugins/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="./view/assets/plugins/datatables/datatables.min.css">
        <link rel="stylesheet" href="./view/assets/css/style.css">
        <link href="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/css/bootstrap4-toggle.min.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>
    <body>

        <div class="main-wrapper">
            <!--HEADER-->
            <jsp:include page="../components/general/body-header.jsp">
                <jsp:param name="isHomePage" value="1"></jsp:param>
            </jsp:include>
            <!--SIDEBAR START-->
            <div class="sidebar" id="sidebar">
                <div class="sidebar-inner slimscroll">
                    <div id="sidebar-menu" class="sidebar-menu">
                        <ul>
                            <li class="menu-title">
                                <span>Main Menu</span>
                            </li>
                            <li>
                                <a href="class-catalog"><i class="fas fa-university"></i> <span>Class Catalog</span></a>
                            <li>
                            <li class="submenu">
                                <a href="#">
                                    <i class="fas fa-user-graduate"></i> 
                                    <span> My Classes</span> 
                                    <span class="menu-arrow"></span>
                                </a>
                                <ul>
                                    <c:forEach items="${requestScope.classes}" var="m">
                                        <li><a href="index.html">${m.classCode}</a></li>
                                        </c:forEach>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <!--SIDEBAR END-->
            <div class="page-wrapper">
                <div class="content container-fluid">
                    <div class="page-header">
                        <div class="row align-items-center">
                            <!--NAVIGATION START-->
                            <div class="col">
                                <h3 class="page-title">Assignment Details</h3>
                                <ul class="breadcrumb">
                                    
                                    <li class="breadcrumb-item"><a href="homepage">Home</a></li>
                                    <li class="breadcrumb-item"><a href="">Class</a></li>
                                    
                                    <li class="breadcrumb-item active">${requestScope.c.classCode} - ${requestScope.chapter.chapterName} - ${requestScope.c.createdBy}</li>
                                </ul>
                                
                            </div>                          
                        </div>
                        <!--NAVIGATION END-->
                        <div class="text-left">
                            Assignment 
                        </div>
                        <div class="text-left">    
                            <div class="fileuploadsubmission"> 
                                <img class="icon icon" alt="CMSLVL10.docx" title="CMSLVL10.docx" src="https://cmshn.fpt.edu.vn/theme/image.php/trema/core/1697438386/f/document">
                                <a target="_blank" href="https://docs.google.com/document/d/1StJi6knJ7wMqvnwZthhyeVvp2TtoNqp_/edit?rtpof=true">CMSLVL10.docx</a>
                            </div>
                            <div class="fileuploadsubmissiontime" id="">25 September 2023, 9:03 AM</div>
                        </div>
                        <section>
                            <h3 id="">Submission status</h3>
                        </section>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="card card-table">
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-bordered mb-0">
                                                <tbody>
                                                    <tr class="cell c0">
                                                        <td>Submission Status:</td>
                                                        <td class="submissionstatussubmitted cell c1 lastcol" style="" id="yui_3_17_2_1_1698591477827_51">Submitted for grading</td>
                                                    </tr>
                                                <td>Grading status:</td>
                                                <td class="submissionnotgraded cell c1 lastcol" style="">Not graded</td>
                                                </tr>
                                                <tr>
                                                    <td>Due Date:</td>
                                                    <td class="cell c1 lastcol" style="">Friday, 6 October 2023, 11:59 PM</td>
                                                </tr>
                                                <tr>
                                                    <td>Time Remaining:</td>
                                                    <td class="earlysubmission cell c1 lastcol" style="">Assignment was submitted 30 mins 19 secs early</td>
                                                </tr>
                                                <tr>
                                                    <td>Last modified:</td>
                                                    <td class="cell c1 lastcol" style="">Friday, 6 October 2023, 11:28 PM</td>
                                                </tr>
                                                <tr class="">
                                                    <td class="cell c0" style="">File submissions</td>
                                                    <td class="cell c1 lastcol" style="">

                                                    </td>
                                                </tr>
                                                </tbody>
                                            </table>                                           
                                        </div>
                                    </div>                               
                                </div>
                                <div class="text-left">
                                    <button type="button" class="btn btn-primary" onclick="location.href = 'assignment-submit'">ADD SUBMISSION</button>
                                </div>
                            </div>  

                        </div>                       
                    </div>
                </div>
                <jsp:include page="../components/general/footer.jsp"></jsp:include>
            </div>
        </div>
    </div>
</div>
<script src="./view/assets/js/jquery-3.6.0.min.js"></script>
<script src="./view/assets/js/popper.min.js"></script>
<script src="./view/assets/plugins/bootstrap/js/bootstrap.min.js"></script>
<script src="./view/assets/plugins/slimscroll/jquery.slimscroll.min.js"></script>
<script src="./view/assets/plugins/datatables/datatables.min.js"></script>
<script src="./view/assets/js/script.js"></script>
<script src="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/js/bootstrap4-toggle.min.js"></script>
</body>
</html>
