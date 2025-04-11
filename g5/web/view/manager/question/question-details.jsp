<%-- 
    Document   : lesson-details
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
        <title>CMSLVL10 - QUESTION DETAILS</title>
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
                                <h3 class="page-title">QUESTION DETAILS</h3>
                                <ul class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="home">Home</a></li>
                                    <li class="breadcrumb-item"><a href="question-list?action=view">Question List</a></li>
                                    <li class="breadcrumb-item active">Question Details</li>
                                </ul>
                            </div>
                            <!--NAVIGATION END-->
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-body">
                                    <form id="updateLessonForm" enctype="multipart/form-data">
                                        <div class="row">
                                            <div class="col-12">
                                                <h5 class="form-title"><span>Question Information</span></h5>
                                            </div>
                                            <div class="col-12 col-sm-6">
                                                <div class="form-group">
                                                    <input type="hidden" value="${requestScope.lesson.lessonId}" name="id">
                                                    <label>Subject <span class="text-danger">*</span></label>
                                                    <select name="subject" id="subject" onchange="getChapter()" class="form-control">
                                                        <!--<option value="-1" ${subjectIdSaved eq -1 ? 'selected' : ''}>Subject</option>-->
                                                        <c:forEach items="${subjects}" var="r">
                                                            <option value="${r.subjectId}"
                                                                    ${requestScope.question.chapter.subject.subjectId eq r.subjectId ? 'selected' : ''}
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
                                                                    ${requestScope.question.chapter.chapterId eq r.chapterId ? 'selected' : ''}
                                                                    >${r.chapterName}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-6">
                                                <div class="form-group">
                                                    <input type="hidden" value="${requestScope.lesson.lessonId}" name="id">
                                                    <label>Dimension <span class="text-danger">*</span></label>
                                                    <select name="dimension" id="dimension" onchange="getChapter()" class="form-control">
                                                        <!--<option value="-1" ${dimensionIdSaved eq -1 ? 'selected' : ''}>Subject</option>-->
                                                        <c:forEach items="${dimensions}" var="r">
                                                            <option value="${r.dimensionId}"
                                                                    ${requestScope.question.chapter.subject.subjectId eq r.subjectId ? 'selected' : ''}
                                                                    >${r.dimensionName}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-6">
                                                <div class="form-group">
                                                    <label>Lesson <span class="text-danger">*</span></label>
                                                    <select name="chapter" id="chapter" class="form-control">
                                                        <!--<option value="-1" ${lessonIdSaved eq -1 ? 'selected' : ''}>Chapter</option>-->
                                                        <c:forEach items="${lessons}" var="r">
                                                            <option value="${r.lessonId}"
                                                                    ${requestScope.question.lesson.lessonId eq r.lessonId ? 'selected' : ''}
                                                                    >${r.lessonName}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-12">
                                                <div class="form-group">
                                                    <label>Title <span class="text-danger">*</span></label>
                                                    <input id="title" name="title" type="text" class="form-control" value="${requestScope.lesson.lessonName}" required>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-12">
                                                <div class="form-group">
                                                    <label>Content</label>
                                                    <textarea id="content" name="description" class="form-control" rows="6">${requestScope.question.description}</textarea>
                                                </div>
                                            </div>

                                            <div class="col-12 col-sm-12">
                                                <div class="form-group">
                                                    <input id="activerb" name="statusrb" type="radio" class="d-none" value="1" ${requestScope.question.status ? 'checked' : ''}>
                                                    <input id="inactiverb" name="statusrb" type="radio" class="d-none" value="0" ${!requestScope.question.status ? 'checked' : ''}>
                                                    <label>Status <span class="text-danger">*</span>: </label>
                                                    <input name="status" id="status"
                                                           type="checkbox" data-toggle="switchbutton"
                                                           data-onstyle="info"
                                                           data-size="sm"
                                                           data-onlabel="Active"
                                                           data-offlabel="Inactive"
                                                           ${requestScope.question.status ? 'checked' : ''}
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
                                                        const fileInput = document.getElementById("attachedFile");
                                                        const fileNameDisplay = document.getElementById("fileNameDisplay");
                                                        fileNameDisplay.addEventListener("click", function () {
                                                            fileInput.click();
                                                        });
                                                        fileInput.addEventListener("change", function () {
                                                            // Update the text of the fileNameDisplay span with the selected filename
                                                            fileNameDisplay.textContent = fileInput.files[0].name;
                                                        });
        </script>
        <script>
            $(function () {
                // Define tabPaneId outside the event handlers
                let tabPaneId = 'solid-tab-video';
                let status = false;
                getQuiz(); // Call getQuiz when the subject changes
                // Event handler for tab shown
                getChapter();
                $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
                    const selectedTabPane = $(e.target.getAttribute('href'));
                    tabPaneId = selectedTabPane.attr('id');
                    switch (tabPaneId) {
                        case 'solid-tab-video':
                        {
                            $('#videorb').prop('checked', true);
                            $('#attachedFile').prop('required', false);
                            $('#videoLink').prop('required', true);
                            $('#quiz').prop('required', false);
                            $('#duration').prop('required', false);
                            break;
                        }
                        case 'solid-tab-quiz':
                        {
                            $('#quizrb').prop('checked', true);
                            $('#attachedFile').prop('required', false);
                            $('#videoLink').prop('required', false);
                            $('#quiz').prop('required', true);
                            $('#duration').prop('required', true);
                            break;
                        }
                        case 'solid-tab-assignment':
                        {
                            $('#assignmentrb').prop('checked', true);
                            $('#attachedFile').prop('required', true);
                            $('#videoLink').prop('required', false);
                            $('#quiz').prop('required', false);
                            $('#duration').prop('required', false);
                            break;
                        }
                    }
                });
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
                    getQuiz(); // Call getQuiz when the subject changes
                });

                $(document).ready(function () {
                    // Handle form submission
                    $("#updateQuestionForm").submit(function (event) {
                        event.preventDefault(); // Prevent the default form submission
                        var formData = new FormData(this); // Create a FormData object from the form
                        $.ajax({
                            type: "POST",
                            url: "question-list?action=update", // Use the URL of your AddUserServlet
                            processData: false, // Don't process the data
                            contentType: false, // Don't set content type (it will be set automatically)
                            data: formData,
                            success: function (response) {
                                window.location.href = 'lesson-list?action=view';
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
                    url: 'question-list?action=get-chapter',
                    data: {
                        subjectId: subjectId
                    },
                    success: function (response) {
                        document.getElementById('chapter').innerHTML = response;
                    }
                });
            }
            function getLesson() {
               var subjectId = $('#subject').val();
                $.ajax({
                    type: 'POST',
                    url: 'question-list?action=get-lesson',
                    data: {
                        subjectId: subjectId
                    },
                    success: function (response) {
                        document.getElementById('lesson').innerHTML = response;
                    }
                });
            }

            function getQuiz() {
                var subjectId = $('#subject').val();
                $.ajax({
                    type: 'POST',
                    url: 'lesson-list?action=get-quiz',
                    data: {
                        subjectId: subjectId
                    },
                    success: function (response) {
                        document.getElementById('quiz').innerHTML = response;
                    }
                });
            }
        </script>
    </body>
    <!-- Mirrored from preschool.dreamguystech.com/html-template/students.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 28 Oct 2021 11:11:49 GMT -->
</html>