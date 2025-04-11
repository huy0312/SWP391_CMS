<%-- 
    Document   : extra-lesson-details
    Created on : Nov 6, 2023, 5:58:36 PM
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
        <title>CMSLVL10 - ASSIGNMENT DETAILS</title>
        <link rel="shortcut icon" href="./view/assets/img/logo_short.png">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,500;0,600;0,700;1,400&amp;display=swap">
        <link rel="stylesheet" href="./view/assets/plugins/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="./view/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="./view/assets/plugins/fontawesome/css/all.min.css">
        <!--TEXT EDITOR-->
        <link rel="stylesheet" href="./view/assets/plugins/summernote/dist/summernote-bs4.css">
        <link rel="stylesheet" href="./view/assets/css/style.css">
        <link href="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/css/bootstrap4-toggle.min.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link href="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap-switch-button@1.1.0/css/bootstrap-switch-button.min.css" rel="stylesheet">
        <link href="https://unpkg.com/filepond/dist/filepond.css" rel="stylesheet">
    </head>
    <body>

        <div class="main-wrapper">
            <!--HEADER-->
            <jsp:include page="../components/general/body-header.jsp"></jsp:include>
                <!--SIDEBAR-->
            <jsp:include page="../components/general/sidebar.jsp">
                <jsp:param name="isClassDashboard" value="1"></jsp:param>
                <jsp:param name="subjectId" value="${requestScope.c.subject.subjectId}"></jsp:param>
                <jsp:param name="classId" value="${requestScope.c.classId}"></jsp:param>
                <jsp:param name="chapterId" value="${requestScope.chapter.chapterId}"></jsp:param>
            </jsp:include>
            <div class="page-wrapper">
                <div class="content container-fluid">

                    <!--TOAST START-->
                    <div aria-live="polite" aria-atomic="true" style="position: relative; z-index: 11">
                        <div class="toast bg-danger text-white border-0" id="errorToast" data-delay="2000" data-autohide="true" role="alert" aria-live="assertive" aria-atomic="true" style="position: fixed; bottom: 20px; right: 20px;">
                            <div class="toast-body">
                                This lesson has been existed! Try another title.
                                <button type="button" class="ml-2 mb-1 close" data-dismiss="toast">&times;</button>
                            </div>
                        </div>
                    </div>
                    <!--TOAST END-->

                    <div class="page-header">
                        <div class="row align-items-center">
                            <!--NAVIGATION START-->
                            <div class="col">
                                <h3 class="page-title">EXTRA LESSON DETAILS</h3>
                                <ul class="breadcrumb">
                                    <li class="breadcrumb-item">
                                        <a href="homepage">Home</a>
                                    </li>
                                    <li class="breadcrumb-item">
                                        <a href="class-dashboard?cid=${requestScope.c.classId}&ctid=${requestScope.chapter.chapterId}">
                                            ${requestScope.c.classCode} - ${requestScope.chapter.chapterName}
                                        </a>
                                    </li>
                                    <li class="breadcrumb-item">
                                        <a href="extra-lesson?action=view&ctid=${requestScope.chapter.chapterId}&cid=${requestScope.c.classId}">
                                            Extra Lesson
                                        </a>
                                    </li>
                                    <li class="breadcrumb-item active">New Extra Lesson</li>
                                </ul>
                                <h6 class="text-info">
                                    Subject: ${requestScope.c.subject.subjectName}
                                    - 
                                    Chapter: ${requestScope.chapter.chapterName}
                                </h6>
                            </div>
                            <!--NAVIGATION END-->
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-body">
                                    <form id="updateExtraLessonForm" class="needs-validation" enctype="multipart/form-data" novalidate>
                                        <div class="row">
                                            <div class="col-12">
                                                <h5 class="form-title"><span>Lesson Information</span></h5>
                                            </div>
                                            <div class="col-12 col-sm-12">
                                                <div class="form-group">
                                                    <input 
                                                        type="hidden" 
                                                        value="${requestScope.lesson.lessonId}" 
                                                        name="id">
                                                    <input 
                                                        name="ctid" 
                                                        value="${requestScope.chapter.chapterId}" 
                                                        type="hidden">
                                                    <label>Title</label>
                                                    <input id="title"
                                                           name="title"
                                                           type="text"
                                                           pattern="^.{1,100}$"
                                                           class="form-control"
                                                           value="${requestScope.lesson.lessonName}"
                                                           required>
                                                    <div class="invalid-feedback">
                                                        Title contains 1-100 characters.
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-12">
                                                <div class="form-group">
                                                    <label>Content</label>
                                                    <textarea 
                                                        id="content" 
                                                        name="content" 
                                                        class="form-control summernote" 
                                                        rows="6">
                                                        ${requestScope.lesson.description}        
                                                    </textarea>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-12">
                                                <input type="hidden" name="type" value="${requestScope.lesson.lessonType}">
                                                <label>
                                                    Type: 
                                                    <c:choose>
                                                        <c:when test="${requestScope.lesson.lessonType eq 1}">Video</c:when>
                                                        <c:when test="${requestScope.lesson.lessonType eq 2}">Quiz</c:when>
                                                        <c:when test="${requestScope.lesson.lessonType eq 3}">Assignment</c:when>
                                                    </c:choose>
                                                </label>
                                                <div class="line"></div>
                                                <c:choose>
                                                    <c:when test="${requestScope.lesson.lessonType eq 1}">
                                                        <div class="col-12 col-sm-12">
                                                            <div class="form-group">
                                                                <label>Video Link</label>
                                                                <input id="videoLink" name="videoLink" type="text" class="form-control" ${requestScope.lesson.lessonType == 1 ? 'required' : ''} value="${requestScope.lesson.youtubeLink}">
                                                            </div>
                                                        </div>
                                                    </c:when>
                                                    <c:when test="${requestScope.lesson.lessonType eq 2}">
                                                        <div class="row">
                                                            <div class="col-12 col-sm-6">
                                                                <div class="form-group">
                                                                    <label>Linked Quiz</label>
                                                                    <select id="quiz" name="quiz" class="form-control" ${requestScope.lesson.lessonType == 2 ? 'required' : ''}>
                                                                        <c:forEach items="${requestScope.quiz}" var="q">
                                                                            <option 
                                                                                value="${q.quizId}"
                                                                                ${q.quizId 
                                                                                  == 
                                                                                  requestScope.lesson.quiz.quizId 
                                                                                  ? 
                                                                                  'selected' 
                                                                                  : ''}>
                                                                                    ${q.quizName}
                                                                                </option>
                                                                            </c:forEach>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                                <div class="col-12 col-sm-6">
                                                                    <div class="form-group">
                                                                        <label>Duration (minute)</label>
                                                                        <input id="date" name="duration" type="number" min="1" value="${requestScope.lesson.quiz.duration}" class="form-control" ${requestScope.lesson.lessonType == 2 ? 'required' : ''}>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </c:when>
                                                        <c:when test="${requestScope.lesson.lessonType eq 3}">
                                                            <div class="col-12 col-sm-12">
                                                                <div class="form-group">
                                                                    <label>Attached File: </label>
                                                                    <input id="attachedFile" type="file" class="filepond" required>
                                                                    <input type="hidden" name="attachedFile" id="file_name_input">
                                                                    <div class="invalid-feedback">
                                                                        Please submit a file
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </c:when>
                                                    </c:choose>
                                                </div>
                                                <div class="col-12 col-sm-12">
                                                    <div class="row">
                                                        <div class="col-lg-6">
                                                            <div class="form-group row">
                                                                <input 
                                                                    id="activerb" 
                                                                    name="statusrb" 
                                                                    type="radio" 
                                                                    class="d-none" 
                                                                    value="1"
                                                                    ${requestScope.lesson.status ? 'checked' : ''}
                                                                    >
                                                                <input 
                                                                    id="inactiverb" 
                                                                    name="statusrb" 
                                                                    type="radio" 
                                                                    class="d-none" 
                                                                    value="0" 
                                                                    ${!requestScope.lesson.status ? 'checked' : ''}
                                                                    >
                                                                <label class="col-lg-3 col-form-label">Status <span class="text-danger">*</span>: </label>
                                                                <input name="status" id="status"
                                                                       class="form-control col-lg-2 w-auto"
                                                                       type="checkbox" data-toggle="switchbutton"
                                                                       data-onstyle="info"
                                                                       data-size="sm"
                                                                       data-onlabel="Active"
                                                                       data-offlabel="Inactive"
                                                                       ${requestScope.lesson.status ? 'checked' : ''}>
                                                            </div> 
                                                        </div>
                                                        <div class="col-lg-6">
                                                            <div class="form-group row">
                                                                <label class="col-lg-5 col-form-label">Display Order: </label>
                                                                <input name="order" type="number" value="${requestScope.lesson.displayOrder}" class="form-control col-lg-2 w-auto" required>
                                                                <div class="invalid-feedback">
                                                                    Please enter display order.
                                                                </div>
                                                            </div>
                                                        </div>
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
                <script src="./view/assets/js/form-validation.js"></script>
                <script src="https://unpkg.com/filepond/dist/filepond.js"></script>
                <!--TEXT EDITOR-->
                <script src="./view/assets/plugins/summernote/dist/summernote-bs4.min.js"></script>
                <script src="./view/assets/js/script.js"></script>
                <script src="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap-switch-button@1.1.0/dist/bootstrap-switch-button.min.js"></script>
                <script src="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/js/bootstrap4-toggle.min.js"></script>
                <script>
                    let file = {
                        options: {
                            type: 'local',
                            file: {
                                name: '${requestScope.fileName}' // Replace with the name of your file
                            }
                        }
                    };
                    // Create a FilePond instance
                    const inputElement = document.querySelector('.filepond');
                    const pond = FilePond.create(document.querySelector('.filepond'), {
                        files: [file]
                    });

                    // Listen for the addfile event
                    pond.on('addfile', (error, file) => {
                        if (!error) {
                            // Set the file name into the hidden input
                            const hiddenInput = document.getElementById('file_name_input');
                            hiddenInput.value = file.filename;
                        }
                    });
            </script>
            <script>
                function validateForm() {
                    const inputs = document.querySelectorAll('input');
                    let valid = true;

                    inputs.forEach(input => {
                        if (input.checkValidity() === false) {
                            input.classList.add('is-invalid');
                            valid = false;
                        } else {
                            input.classList.remove('is-invalid');
                        }
                    });
                    return valid;
                }
            </script>
            <script>

                $(function () {
                    $('#status').on('change', function () {
                        if ($(this).is(':checked')) {
                            $('input[name=statusrb][value=1]').prop('checked', true);
                        } else {
                            $('input[name=statusrb][value=0]').prop('checked', true);
                        }
                    });

                    $(document).ready(function () {
                        // Handle form submission
                        $("#updateExtraLessonForm").submit(function (event) {
                            const isValid = validateForm();
                            event.preventDefault(); // Prevent the default form submission
                            var formData = new FormData(this); // Create a FormData object from the form
                            if (isValid) {
                                $.ajax({
                                    type: "POST",
                                    url: "extra-lesson?action=update", // Use the URL of your AddUserServlet
                                    processData: false, // Don't process the data
                                    contentType: false, // Don't set content type (it will be set automatically)
                                    data: formData,
                                    success: function (response) {
                                        console.log(response);
                                        if (response.trim() === "fail") {
                                            $('#errorToast').toast('show');
                                            console.log("fail");
                                        } else if (response.trim() === "success") {
                                            window.location.href = 'extra-lesson?action=view&ctid=${requestScope.chapter.chapterId}&cid=${requestScope.c.classId}';
                                            console.log("success");
                                        }
                                    }
                                });
                            }
                        });
                    });
                });
            </script>
        </body>
        <!-- Mirrored from preschool.dreamguystech.com/html-template/students.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 28 Oct 2021 11:11:49 GMT -->
    </html>

