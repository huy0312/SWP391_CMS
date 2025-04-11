<%-- 
    Document   : new-lesson
    Created on : Oct 17, 2023, 6:00:00 PM
    Author     : win
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <title>CMSLVL10 - NEW QUESTION</title>
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
                <jsp:param name="isQuestionList" value="1"></jsp:param>
            </jsp:include>
            <div class="page-wrapper">
                <div class="content container-fluid">

                    <!--TOAST START-->
                    <div aria-live="polite" aria-atomic="true" style="position: relative; z-index: 11">
                        <div class="toast bg-danger text-white border-0" id="errorToast" data-delay="1000" data-autohide="true" role="alert" aria-live="assertive" aria-atomic="true" style="position: fixed; bottom: 20px; right: 20px;">
                            <div class="toast-body">
                                Question is collied! Try another title.
                                <button type="button" class="ml-2 mb-1 close" data-dismiss="toast">&times;</button>
                            </div>
                        </div>
                    </div>
                    <!--TOAST END-->

                    <div class="page-header">
                        <div class="row align-items-center">
                            <!--NAVIGATION START-->
                            <div class="col">
                                <h3 class="page-title">NEW QUESTION</h3>
                                <ul class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="home">Home</a></li>
                                    <li class="breadcrumb-item"><a href="question-list?action=view">Question List</a></li>
                                    <li class="breadcrumb-item active">New Question</li>
                                </ul>
                            </div>
                            <!--NAVIGATION END-->
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-body">
                                    <form id="addQuestionForm" enctype="multipart/form-data">
                                        <div class="row">
                                            <div class="col-12">
                                                <h5 class="form-title"><span>Question</span></h5>
                                            </div>
                                            <div class="col-12 col-sm-6">
                                                <div class="form-group">
                                                    <label>Subject <span class="text-danger">*</span></label>
                                                    <select name="subject" id="subject" onchange="getChapter()" class="form-control">
                                                        <!--<option value="-1" ${subjectIdSaved eq -1 ? 'selected' : ''}>Subject</option>-->
                                                        <c:forEach items="${subjects}" var="r">
                                                            <option value="${r.subjectId}"
                                                                    ${subjectIdSaved eq r.subjectId ? 'selected' : ''}
                                                                    >${r.subjectName}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-6">
                                                <div class="form-group">
                                                    <label>Dimension <span class="text-danger">*</span></label>
                                                    <select name="dimension" id="dimension" onchange="getChapter()" class="form-control">
                                                        <!--<option value="-1" ${dimensionIdSaved eq -1 ? 'selected' : ''}>Dimension</option>-->
                                                        <c:forEach items="${dimensions}" var="r">
                                                            <option value="${r.dimensionId}"
                                                                    ${dimensionIdSaved eq r.dimensionId ? 'selected' : ''}
                                                                    >${r.dimensionName}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-6">
                                                <div class="form-group">
                                                    <label>Lesson <span class="text-danger">*</span></label>
                                                    <select name="lesson" id="lesson" onchange="getChapter()" class="form-control">
                                                        <!--<option value="-1" ${lessonIdSaved eq -1 ? 'selected' : ''}>Lesson</option>-->
                                                        <c:forEach items="${lessons}" var="r">
                                                            <option value="${r.lessonId}"
                                                                    ${lesondIdSaved eq r.lessonId ? 'selected' : ''}
                                                                    >${r.lessonName}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="col-12 col-sm-6">
                                                <div class="form-group">
                                                    <label>Chapter <span class="text-danger">*</span></label>
                                                    <select name="chapter" id="chapter" class="form-control">
                                                        <option value="-1" ${chapterIdSaved eq -1 ? 'selected' : ''}>Chapter</option>
                                                        <c:forEach items="${chapters}" var="r">
                                                            <option value="${r.chapterId}"
                                                                    ${chapterIdSaved eq r.chapterId ? 'selected' : ''}
                                                                    >${r.chapterName}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-12">
                                                <div class="form-group">
                                                    <label>Question<span class="text-danger"></span></label>
                                                    <input id="title" name="title" type="text" class="form-control" required>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-12">
                                                <div class="form-group">
                                                    <label>Link</label>
                                                    <textarea id="link" name="link" class="form-control" rows="1"></textarea>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-12">
                                                <div class="form-group">
                                                    <label>Description</label>
                                                    <textarea id="description" name="decription" class="form-control" rows="3" required></textarea>
                                                </div>
                                            </div>

                                            <div class="col-12 col-sm-12">
                                                <div class="form-group">
                                                    <!--<input name="action" type="hidden" class="d-none" value="add">-->
                                                    <input id="activerb" name="statusrb" type="radio" class="d-none" value="1">
                                                    <input id="inactiverb" name="statusrb" type="radio" class="d-none" value="0" checked>
                                                    <label>Status <span class="text-danger">*</span>: </label>
                                                    <input name="status" id="status"
                                                           type="checkbox" data-toggle="switchbutton"
                                                           data-onstyle="info"
                                                           data-style="ios"
                                                           data-size="sm"
                                                           data-onlabel="Active"
                                                           data-offlabel="Inactive">
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
                                                            $("#addQuestionForm").submit(function (event) {
                                                                event.preventDefault(); // Prevent the default form submission
                                                                var formData = $(this).serialize();
                                                                $.ajax({
                                                                    type: "POST",
                                                                    url: "question-list?action=add",
                                                                    data: formData,
                                                                    success: function (response) {
                                                                        console.log(response);
                                                                        if (response.trim() === "success") {
                                                                            window.location.href = 'question-list?action=view&success=true';
                                                                            console.log("success");
                                                                        } else {
                                                                            $('#errorToast').toast('show');
                                                                        }
                                                                    },
                                                                    error: function () {
                                                                        console.log("chiu");
                                                                    }
                                                                });
                                                            });
                                                        });

        </script>
    </body>
    <!-- Mirrored from preschool.dreamguystech.com/html-template/students.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 28 Oct 2021 11:11:49 GMT -->
</html>