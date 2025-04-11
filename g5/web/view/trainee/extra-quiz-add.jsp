<%-- 
    Document   : new-quiz
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
        <title>CMSLVL10 - NEW QUIZ</title>
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

                        <!--TOAST START-->
                        <div aria-live="polite" aria-atomic="true" style="position: relative; z-index: 11">
                            <div class="toast bg-danger text-white border-0" id="errorToast" data-delay="1000" data-autohide="true" role="alert" aria-live="assertive" aria-atomic="true" style="position: fixed; bottom: 20px; right: 20px;">
                                <div class="toast-body">
                                    Quiz is collied! Try another title.
                                    <button type="button" class="ml-2 mb-1 close" data-dismiss="toast">&times;</button>
                                </div>
                            </div>
                        </div>
                        <!--TOAST END-->

                        <div class="page-header">
                            <div class="row align-items-center">
                                <!--NAVIGATION START-->
                                <div class="col">
                                    <h3 class="page-title">NEW EXTRA QUIZ</h3>
                                    <ul class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="homepage">Home</a></li>
                                        <li class="breadcrumb-item"><a href="quiz-practice?action=view&sid=${requestScope.subjectId}&cid=${requestScope.chapterId}">Quiz Practice</a></li>
                                    <li class="breadcrumb-item active">New Practice Quiz</li>
                                </ul>
                            </div>
                            <!--NAVIGATION END-->
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-body">
                                    <form id="addNewQuizForm" class="needs-validation">
                                        <div class="row">
                                            <div class="col-12">
                                                <h5 class="form-title"><span>Quiz Information</span></h5>
                                            </div>



                                            <div class="col-12 col-sm-12">
                                                <div class="form-group">
                                                    <label>Title <span class="text-danger">*</span></label>
                                                    <input id="title" name="title" type="text" class="form-control" required>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-2">
                                                <div class="form-group">
                                                    <label>Number of question <span class="text-danger">*</span></label>
                                                    <input id="noQues" name="noQues" type="number"class="form-control" required>
                                                    <small class="text-danger" id="noQuesError" style="display: none;">Please enter a value greater than 0.</small>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-12">
                                                <div class="form-group">
                                                    <label>Content</label>
                                                    <textarea id="content" name="content" class="form-control" rows="6"></textarea>
                                                </div>
                                            </div>
                                            <div class="col-12 col-sm-2">
                                                <div class="form-group">
                                                    <label>Duration (minutes) <span class="text-danger">*</span></label>
                                                    <input id="duration" name="duration" type="number"class="form-control" required>
                                                    <small class="text-danger" id="durationError" style="display: none;">Please enter a value greater than 0.</small>
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
                <jsp:include page="../components/general/footer.jsp"></jsp:include>
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
            document.getElementById('noQues').addEventListener('input', function () {
                var userInput = parseInt(this.value, 10);
                var errorField = document.getElementById('noQuesError');

                if (Number.isInteger(userInput) && userInput > 0) {
                    errorField.style.display = 'none';
                    this.setCustomValidity('');
                } else {
                    errorField.style.display = 'block';
                    this.setCustomValidity('Please enter a valid positive integer.');
                }
            });
        </script>
        <script>
            document.getElementById('duration').addEventListener('input', function () {
                var userInput = parseInt(this.value, 10);
                var errorField = document.getElementById('durationError');

                if (Number.isInteger(userInput) && userInput > 0) {
                    errorField.style.display = 'none';
                    this.setCustomValidity('');
                } else {
                    errorField.style.display = 'block';
                    this.setCustomValidity('Please enter a valid positive integer.');
                }
            });
        </script>
        <script>

            $(function () {
                // Define tabPaneId outside the event handlers
                let tabPaneId = 'solid-tab-video';
                let status = false;
                // Event handler for tab shown
                
                $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
                    const selectedTabPane = $(e.target.getAttribute('href'));
                    tabPaneId = selectedTabPane.attr('id');

                });
                $('#status').on('change', function () {
                    if ($(this).is(':checked')) {
                        $('input[name=statusrb][value=1]').prop('checked', true);
                    } else {
                        $('input[name=statusrb][value=0]').prop('checked', true);
                    }
                });

                // Event handler for subject change
                

                $(document).ready(function () {
                    // Handle form submission
                    $("#addNewQuizForm").submit(function (event) {
                        event.preventDefault(); // Prevent the default form submission
                        var formData = $(this).serialize();
                        $.ajax({
                            type: "POST",
                            url: "quiz-practice?action=add&sid=${requestScope.subjectId}&cid=${requestScope.chapterId}&clid=${requestScope.classId}", // Use the URL of your AddUserServlet
                            data: formData,
                            success: function (response) {
                                if (response.trim() === "fail") {
                                    $('#errorToast').toast('show');
                                    console.log("fail");
                                } else if (response.trim() === "success") {
                                    window.location.href = 'quiz-practice?action=view&sid=${requestScope.subjectId}&cid=${requestScope.chapterId}&clid=${requestScope.classId}&success=true';
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