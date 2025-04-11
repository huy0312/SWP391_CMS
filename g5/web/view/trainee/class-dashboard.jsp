<%-- 
    Document   : class-dashboard
    Created on : Nov 1, 2023, 4:02:10 PM
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
        <title>CMSLVL10 - HOME PAGE</title>
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
            <jsp:include page="../components/general/sidebar.jsp">
                <jsp:param name="isClassDashboard" value="1"></jsp:param>
                <jsp:param name="subjectId" value="${requestScope.c.subject.subjectId}"></jsp:param>
                <jsp:param name="classId" value="${requestScope.c.classId}"></jsp:param>
                <jsp:param name="chapterId" value="${requestScope.chapter.chapterId}"></jsp:param>
            </jsp:include>
            <!--SIDEBAR END-->
            <div class="page-wrapper">
                <div class="content container-fluid">
                    <!--HEADER START-->
                    <div class="page-header">
                        <div class="row">
                            <div class="col-sm-12">
                                <h3 class="page-title">Class Dashboard</h3>
                                <ul class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="homepage">Home</a></li>
                                    <li class="breadcrumb-item active">${requestScope.c.classCode} - ${requestScope.chapter.chapterName}</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <!--HEADER END-->

                    <div class="row">
                        <div class="col-lg-8">

                            <!--GENERAL INFORMATION START-->
                            <div class="card">
                                <div class="card-body">
                                    <div class="row">
                                        <p class="col-sm-3 text-muted text-sm-right mb-0 mb-sm-3">Manager</p>
                                        <p class="col-sm-9">${requestScope.manager.fullName}</p>
                                    </div>
                                    <div class="row">
                                        <p class="col-sm-3 text-muted text-sm-right mb-0 mb-sm-3">Trainer</p>
                                        <p class="col-sm-9">${requestScope.c.user.fullName}</p>
                                    </div>
                                    <div class="row">
                                        <p class="col-sm-3 text-muted text-sm-right mb-0 mb-sm-3">Subject</p>
                                        <p class="col-sm-9">${requestScope.c.subject.subjectName}</p>
                                    </div>
                                    <div class="row">
                                        <p class="col-sm-3 text-muted text-sm-right mb-0 mb-sm-3">Semester</p>
                                        <p class="col-sm-9">${requestScope.c.setting.settingName}</p>
                                    </div>
                                    <div class="row">
                                        <p class="col-sm-3 text-muted text-sm-right mb-0 mb-sm-3">Chapter</p>
                                        <p class="col-sm-9">${requestScope.chapter.chapterName}</p>
                                    </div>
                                </div>
                            </div>
                            <!--GENERAL INFORMATION END-->

                            <!--LESSONS START-->
                            <section class="comp-section">
                                <div class="section-header">
                                    <h4 class="section-title">Lessons</h4>
                                    <p><small>${requestScope.lessonsCount} lessons</small></p>
                                    <div class="line"></div>
                                </div>

                                <!-- LESSON START -->
                                <div class="card">
                                    <div class="card-body">
                                        <c:if test="${empty requestScope.lessons}">
                                            <div class="alert alert-primary alert-dismissible fade show" role="alert">
                                                This chapter hasn't had any lesson yet.
                                            </div>
                                        </c:if>
                                        <c:if test="${not empty requestScope.lessons}">
                                            <c:forEach var="l" items="${requestScope.lessons}">
                                                <button
                                                    onclick="window.location.href = 'online-learning?action=learn&sid=${l.chapter.subject.subjectId}&lid=${l.lessonId}&cid=${requestScope.c.classId}'"
                                                    type="button" 
                                                    class="btn btn-block btn-outline-light d-flex">
                                                    <div
                                                        class="text-left text-muted">
                                                        <c:if test="${l.lessonType eq 1}">
                                                            <i class="fas
                                                               fa-play-circle
                                                               fa-sm mr-2"></i>
                                                        </c:if>
                                                        <c:if test="${l.lessonType eq 2}">
                                                            <i class="fas
                                                               fa-bolt
                                                               fa-sm
                                                               mr-2"></i>
                                                        </c:if>
                                                        <c:if test="${l.lessonType eq 3}">
                                                            <i class="fas
                                                               fa-file-alt
                                                               fa-sm mr-2"></i>
                                                        </c:if>
                                                        ${l.lessonName}
                                                    </div>
                                                    <!--Display if lesson is extra added-->
                                                    <c:if test="${l.createdBy eq requestScope.userId}">
                                                        <div class="ml-auto">
                                                            <p class="mb-0"><small><mark>extra</mark></small></p>
                                                        </div>
                                                    </c:if>
                                                </button>
                                                <!-- LESSON END -->
                                            </c:forEach>
                                        </c:if>
                                    </div>
                                </div>
                                <!--LESSONS END-->

                            </section>
                        </div>

                        <!--BUTTONS START-->
                        <div class="col-lg-4">
                            <div style="top: 80px" class="card card-body sticky-top">
                                <button type="button" 
                                        onclick="window.location.href = 'grade?ctid=${requestScope.chapter.chapterId}&cid=${requestScope.c.classId}'" 
                                        class="btn btn-block btn-info">
                                    <div class="text-left">Grades</div>
                                </button>
                                <button type="button" 
                                        class="btn btn-block btn-info">
                                        
                                    <div onclick="window.location.href = 'clas-discussion'" 
                                        class="text-left">Discussion</div>
                                </button>
                                <button type="button" class="btn btn-block btn-info"> 
                                    <div 
                                        onclick="window.location.href = 'assignment-list?action=view&sid=${requestScope.c.subject.subjectId} '" 
                                        class="text-left">
                                        Assignment
                                    </div>
                                </button>
                                <button type="button" 
                                        class="btn btn-block btn-info">
                                    <div 
                                        onclick="window.location.href = 'quiz-practice?action=view&sid=${requestScope.c.subject.subjectId}&cid=${requestScope.chapter.chapterId}&clid=${requestScope.c.classId}'" 
                                        class="text-left">
                                        Practice Quizzes
                                    </div>
                                </button>
                                <c:if test="${requestScope.isTrainer eq true}">
                                    <button type="button"
                                            onclick="window.location.href = 'extra-lesson?action=view&ctid=${requestScope.chapter.chapterId}&cid=${requestScope.c.classId}'" 
                                            class="btn btn-block btn-info">
                                        <div class="text-left">Extra lessons</div>
                                    </button>
                                </c:if> 
                                <c:if test="${requestScope.isTrainer eq true}">
                                    <button type="button"
                                            onclick="window.location.href = 'assignment-grading?action=view'" 
                                            class="btn btn-block btn-info">
                                        <div class="text-left">Assignment Grades</div>
                                    </button>
                                </c:if> 
                            </div>
                        </div>
                        <!--BUTTONS END-->

                    </div>
                </div>
                <jsp:include page="../components/general/footer.jsp"></jsp:include>
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
    <!-- Mirrored from preschool.dreamguystech.com/html-template/students.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 28 Oct 2021 11:11:49 GMT -->
</html>


