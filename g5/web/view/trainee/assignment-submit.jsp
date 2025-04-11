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
        <title>CMSLVL10 - ASSIGNMENT SUBMISSION</title>
        <link rel="shortcut icon" href="./view/assets/img/logo_short.png">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,500;0,600;0,700;1,400&amp;display=swap">
        <link rel="stylesheet" href="./view/assets/plugins/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="./view/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="./view/assets/plugins/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="./view/assets/plugins/datatables/datatables.min.css">
        <link rel="stylesheet" href="./view/assets/plugins/summernote/dist/summernote-bs4.css">
        <link rel="stylesheet" href="./view/assets/css/style.css">
        <link href="https://unpkg.com/filepond/dist/filepond.css" rel="stylesheet">
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
                                <h3 class="page-title">Assignment Submission</h3>
                                <ul class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="homepage">Home</a></li>
                                    <li class="breadcrumb-item active">${requestScope.c.classCode} - ${requestScope.chapter.chapterName}</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <!--HEADER END-->


                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card card-table">
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-responsive">  
                                            <tbody>
                                            <label>Online text</label>
                                            <tr class="form-group">
                                            <textarea id="content" name="content" class="form-control summernote" rows="6">${requestScope.lesson.description}</textarea>
                                            </tr>     
                                            <label>File Submission</label>
                                            <tr>                                               
                                            <input type="file" class="filepond">   
                                            <input type="hidden" name="attachedFile" id="file_name_input">
                                            </tr>
                                            <p>Accepted file types:</p>
                                            <div class="form-filetypes-descriptions w-100">
                                                <ul class="list-unstyled unstyled">
                                                    <li>Excel 2007 spreadsheet <small class="text-muted muted">.xlsx</small></li>
                                                    <li>Excel spreadsheet <small class="text-muted muted">.xls</small></li>
                                                    <li>PDF document <small class="text-muted muted">.pdf</small></li>
                                                    <li>Powerpoint 2007 presentation <small class="text-muted muted">.pptx</small></li>
                                                    <li>Powerpoint presentation <small class="text-muted muted">.ppt</small></li>
                                                    <li>RTF document <small class="text-muted muted">.rtf</small></li>
                                                    <li>Word 2007 document <small class="text-muted muted">.docx</small></li>
                                                    <li>Word document <small class="text-muted muted">.doc</small></li>
                                                </ul>
                                            </div>
                                            </tbody>
                                        </table>

                                    </div>
                                    <div class="text-right">

                                        <button type="submit" class="btn btn-primary">Submit</button>

                                        <button type="button" class="btn btn-primary" onclick="location.href = ''">CANCEL</button>
                                    </div>



                                    <!--TABLE END-->


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
<script src="./view/assets/plugins/summernote/dist/summernote-bs4.min.js"></script>
<script src="./view/assets/js/script.js"></script>
<script src="https://unpkg.com/filepond/dist/filepond.js"></script>
<script>
                                            FilePond.parse(document.body);
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
</script>    <script src="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/js/bootstrap4-toggle.min.js"></script>

</body>
</html>
