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
        </style>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>CMSLVL10 - NEW ASSIGNMENT</title>
        <link rel="shortcut icon" href="./view/assets/img/logo_short.png">


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
                <jsp:param name="isAssignmentList" value="1"></jsp:param>
            </jsp:include>
            <div class="page-wrapper">
                <div class="content container-fluid">

                    <!--TOAST START-->

                    <!--TOAST END-->

                    <div class="page-header">
                        <div class="row align-items-center">
                            <!--NAVIGATION START-->
                            <div class="col">
                                <h3 class="page-title">NEW ASSIGNMENT</h3>
                                <ul class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="home">Home</a></li>
                                    <li class="breadcrumb-item"><a href="assignment-list?action=view">Assignment List</a></li>
                                    <li class="breadcrumb-item active">New Assignment</li>
                                </ul>
                            </div>
                            <!--NAVIGATION END-->
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-body">
                                    <form id="" enctype="multipart/form-data">
                                        <div class="row">
                                            <div class="col-12">
                                                <h5 class="form-title"><span>Assignment Information</span></h5>
                                            </div>
                                            <div class="col-12 col-sm-12">
                                                <div class="form-group">
                                                    <label>Title <span class="text-danger">*</span></label>
                                                    <input id="assignmentTitle" name="assignmentTitle" type="text" class="form-control" required>
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
                                                    <label>Content</label>
                                                    <textarea 
                                                        id="content" 
                                                        name="description" 
                                                        class="form-control summernote" 
                                                        rows="6"></textarea>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-6">
                                                <div class="form-group">

                                                    <label>Deadline</label>
                                                    <input type="datetime-local" id="deadline" name="deadline">

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
                        </div>`
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
        <script src="https://unpkg.com/filepond/dist/filepond.js"></script>
        <!--TEXT EDITOR-->
        <script src="./view/assets/plugins/summernote/dist/summernote-bs4.min.js"></script>
        <script src="./view/assets/js/script.js"></script>
        <script src="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap-switch-button@1.1.0/dist/bootstrap-switch-button.min.js"></script>
        <script src="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/js/bootstrap4-toggle.min.js"></script>
        <script>
            $(document).ready(function () {
                CKEDITOR.replace('content');
            });
        </script>
        <script>
            // Create a FilePond instance
            const inputElement = document.querySelector('.filepond');
            const pond = FilePond.create(inputElement);

            // Listen for the addfile event
            pond.on('addfile', (error, file) => {
                if (!error) {
                    console.log('File name:', file.filename);
                    // Set the file name into the hidden input
                    const hiddenInput = document.getElementById('file_name_input');
                    hiddenInput.value = file.filename;
                }
            });
        </script>      
        <script>

            $(function () {


                getChapter();
                $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
                    const selectedTabPane = $(e.target.getAttribute('href'));
                    tabPaneId = selectedTabPane.attr('id');
                    switch (tabPaneId) {
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

                $(document).ready(function () {
                    var data = CKEDITOR.instances.content.getData();
                    document.getElementById('content').value = data;
                    // Handle form submission
                    $("#addNewLessonForm").submit(function (event) {
                        event.preventDefault(); // Prevent the default form submission
                        var formData = new FormData(this); // Create a FormData object from the form
                        $.ajax({
                            type: "POST",
                            url: "assignment-list?action=add", // Use the URL of your AddUserServlet
                            processData: false, // Don't process the data
                            contentType: false, // Don't set content type (it will be set automatically)
                            data: formData,
                            success: function (response) {
                                console.log(response);
                                if (response.trim() === "fail") {
                                    $('#errorToast').toast('show');
                                    console.log("fail");
                                } else if (response.trim() === "success") {
                                    window.location.href = 'assignment-list?action=view';
                                    console.log("success");
                                } else if (response.trim() === "quizFailed") {
                                    $('#quizErrorToast').toast('show');
                                }
                            },
                            error: function () {
                                $('#errorToast').toast('show');
                            }
                        });
                    });
                });
            }
            );



        </script>
    </body>
    <!-- Mirrored from preschool.dreamguystech.com/html-template/students.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 28 Oct 2021 11:11:49 GMT -->
</html>