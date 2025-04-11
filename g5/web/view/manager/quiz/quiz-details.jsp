<%-- 
    Document   : quiz-details
    Created on : Oct 22, 2023, 3:37:29 PM
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
        </style>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>CMSLVL10 - QUIZ DETAILS</title>
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
                <jsp:param name="isQuizList" value="1"></jsp:param>
            </jsp:include>
            <div class="page-wrapper">
                <div class="content container-fluid">

                    <!--TOAST START-->
                    <div aria-live="polite" aria-atomic="true" style="position: relative; z-index: 11">
                        <div class="toast bg-danger text-white border-0" id="errorToast" data-delay="1000" data-autohide="true" role="alert" aria-live="assertive" aria-atomic="true" style="position: fixed; bottom: 20px; right: 20px;">
                            <div class="toast-body">
                                Update Failed.
                                <button type="button" class="ml-2 mb-1 close" data-dismiss="toast">&times;</button>
                            </div>
                        </div>
                    </div>
                    <!--TOAST END-->

                    <div class="page-header">
                        <div class="row align-items-center">
                            <!--NAVIGATION START-->
                            <div class="col">
                                <h3 class="page-title">QUIZ DETAILS</h3>
                                <ul class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="home">Home</a></li>
                                    <li class="breadcrumb-item"><a href="quiz-list?action=view">Quiz List</a></li>
                                    <li class="breadcrumb-item active">Quiz Details</li>
                                </ul>
                            </div>
                            <!--NAVIGATION END-->
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-body">
                                    <form id="updateQuizForm" >
                                        <input type="hidden" value="${requestScope.quiz.quizId}" name="id">
                                        <div class="row">
                                            <div class="col-12">
                                                <h5 class="form-title"><span>Quiz Information</span></h5>
                                            </div>
                                            <div class="col-12 col-sm-6">
                                                <div class="form-group">

                                                    <label>Subject <span class="text-danger">*</span></label>
                                                    <select name="subject" id="subject" onchange="getChapter()" class="form-control">
                                                        <!--<option value="-1" ${subjectIdSaved eq -1 ? 'selected' : ''}>Subject</option>-->
                                                        <c:forEach items="${subjects}" var="r">
                                                            <option value="${r.subjectId}"
                                                                    ${requestScope.quiz.chapter.subject.subjectId eq r.subjectId ? 'selected' : ''}
                                                                    >${r.subjectName}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-6">
                                                <div class="form-group">
                                                    <label>Chapter <span class="text-danger">*</span></label>
                                                    <select name="chapter" id="chapter" class="form-control">
                                                        <!--<option value="-1" ${chapterIdSaved eq -1 ? 'selected' : ''}>Chapter</option>-->
                                                        <c:forEach items="${chapters}" var="r">
                                                            <option value="${r.chapterId}"
                                                                    ${requestScope.quiz.chapter.chapterId eq r.chapterId ? 'selected' : ''}
                                                                    >${r.chapterName}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-6">
                                                <div class="form-group">
                                                    <label>Dimension <span class="text-danger">*</span></label>
                                                    <select name="dimension" id="dimension" class="form-control">
                                                        <option value="-1" ${dimensionIdSaved eq -1 ? 'selected' : ''}>Dimension</option>
                                                        <c:forEach items="${dimensions}" var="r">
                                                            <option value="${r.dimensionId}"
                                                                    ${requestScope.quiz.dimension.dimensionId eq r.dimensionId ? 'selected' : ''}
                                                                    >${r.dimensionName}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-12">
                                                <div class="form-group">
                                                    <label>Title <span class="text-danger">*</span></label>
                                                    <input id="title" name="title" type="text" class="form-control" value="${requestScope.quiz.quizName}" required>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-12">
                                                <div class="form-group">
                                                    <label>Content</label>
                                                    <textarea id="content" name="content" class="form-control" rows="6">${requestScope.quiz.description}</textarea>
                                                </div>
                                            </div>

                                            <div class="col-12 col-sm-12">
                                                <div class="form-group">
                                                    <input id="activerb" name="statusrb" type="radio" class="d-none" value="1" ${requestScope.quiz.status ? 'checked' : ''}>
                                                    <input id="inactiverb" name="statusrb" type="radio" class="d-none" value="0" ${!requestScope.quiz.status ? 'checked' : ''}>
                                                    <label>Status <span class="text-danger">*</span>: </label>
                                                    <input name="status" id="status"
                                                           type="checkbox" data-toggle="switchbutton"
                                                           data-onstyle="info"
                                                           data-size="sm"
                                                           data-onlabel="Active"
                                                           data-offlabel="Inactive"
                                                           ${requestScope.quiz.status ? 'checked' : ''}
                                                           >
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
                                                        $(function () {
                                                            // Define tabPaneId outside the event handlers

                                                            let status = false;
                                                            getChapter();
                                                            getDimension();

                                                            $('#status').on('change', function () {
                                                                if ($(this).is(':checked')) {
                                                                    $('input[name=statusrb][value=1]').prop('checked', true);
                                                                } else {
                                                                    $('input[name=statusrb][value=0]').prop('checked', true);
                                                                }
                                                            });

                                                            // Event handler for subject change
                                                            $('#subject').change(function () {
                                                                getChapter();
                                                                getDimension();
                                                            });

                                                            $(document).ready(function () {
                                                                // Handle form submission
                                                                $("#updateQuizForm").submit(function (event) {
                                                                    event.preventDefault(); // Prevent the default form submission
                                                                    var formData = $(this).serialize(); // Create a FormData object from the form
                                                                    $.ajax({
                                                                        type: "POST",
                                                                        url: "quiz-list?action=update", // Use the URL of your AddUserServlet
                                                                        // Don't set content type (it will be set automatically)
                                                                        data: formData,
                                                                        success: function (response) {
                                                                            window.location.href = 'quiz-list?action=view';
                                                                        },
                                                                        error: function () {
                                                                            $('#errorToast').toast('show');
                                                                        }
                                                                    });
                                                                });
                                                            });
                                                        }
                                                        );

                                                        function getChapter() {
                                                            var subjectId = $('#subject').val();
                                                            $.ajax({
                                                                type: 'POST',
                                                                url: 'quiz-list?action=get-chapter',
                                                                data: {
                                                                    subjectId: subjectId
                                                                },
                                                                success: function (response) {
                                                                    document.getElementById('chapter').innerHTML = response;
                                                                }
                                                            });
                                                        }

                                                        function getDimension() {
                                                            var subjectId = $('#subject').val();
                                                            console.log(subjectId);
                                                            $.ajax({
                                                                type: 'POST',
                                                                url: 'quiz-list?action=get-dimension',
                                                                data: {
                                                                    subjectId: subjectId
                                                                },
                                                                success: function (response) {
                                                                    document.getElementById('dimension').innerHTML = response;
                                                                }
                                                            });
                                                        }
        </script>
    </body>
    <!-- Mirrored from preschool.dreamguystech.com/html-template/students.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 28 Oct 2021 11:11:49 GMT -->
</html>