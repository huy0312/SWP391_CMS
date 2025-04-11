
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User" %>
<%@page import="model.Lesson" %>
<% User user = (User) session.getAttribute("user"); %>
<!DOCTYPE html>
<html lang="en">
    <!-- Mirrored from preschool.dreamguystech.com/html-template/students.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 28 Oct 2021 11:11:43 GMT -->
    <head>
        <style>
            .video-container {
                position: relative;
                width: 100%;
                padding-bottom: 56.25%;
            }

            .aspect-ratio {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                border: 0;
            }
            .text-truncate {
                max-width: 200px; /* Set a maximum width for the cell */
                white-space: nowrap; /* Prevent text from wrapping to the next line */
                overflow: hidden; /* Hide any overflow content */
                text-overflow: ellipsis; /* Show ellipsis (...) for hidden content */
            }
        </style>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>CMSLVL10 - ONLINE LEARNING</title>
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
            <!--HEADER START-->
            <jsp:include page="../components/general/body-header.jsp"></jsp:include>
                <!--HEADER END-->

                <!--SIDEBAR START-->
            <jsp:include page="../components/general/sidebar.jsp">
                <jsp:param name="isOnlineLearning" value="1"></jsp:param>
                <jsp:param name="subjectId" value="${requestScope.subjectId}"></jsp:param>
                <jsp:param name="classId" value="${requestScope.c.classId}"></jsp:param>
                <jsp:param name="chapterId" value="${requestScope.lesson.chapter.chapterId}"></jsp:param>
                <jsp:param name="lessonId" value="${requestScope.lesson.lessonId}"></jsp:param>
            </jsp:include>
            <!--SIDEBAR END-->

            <div class="page-wrapper">
                <div class="content container-fluid">
                    <div class="page-header">
                        <div class="row align-items-center">
                            <!--NAVIGATION START-->
                            <div class="col">
                                <h3 class="page-title">${requestScope.lesson.lessonName}</h3>
                                <ul class="breadcrumb">
                                    <li class="breadcrumb-item">
                                        <a href="homepage">Home</a>
                                    </li>
                                    <li class="breadcrumb-item">
                                        <a href="class-dashboard?cid=${requestScope.c.classId}&ctid=${requestScope.lesson.chapter.chapterId}">
                                            ${requestScope.c.classCode} - ${requestScope.lesson.chapter.chapterName}
                                        </a>
                                    </li>
                                    <li class="breadcrumb-item active">
                                        ${requestScope.lesson.lessonName}
                                    </li>
                                </ul>
                            </div>
                            <!--NAVIGATION END-->
                        </div>
                    </div>

                    <!--VIDEO START-->
                    <c:if test="${requestScope.lesson.lessonType eq 1}">
                        <section class="comp-section">
                            <div class="section-header">
                                <h4 class="section-title">Video</h4>
                                <div class="line"></div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="video-container">
                                                <div id="player" class="aspect-ratio">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                    </c:if>
                    <!--VIDEO END-->

                    <div class="comp-sec-wrapper">

                        <!--CONTENT START-->
                        <section class="comp-section">
                            <div class="section-header">
                                <h4 class="section-title">
                                    <c:if test="${requestScope.lesson.lessonType eq 1}">
                                        ${requestScope.lesson.lessonName}
                                    </c:if>
                                    <c:if test="${requestScope.lesson.lessonType eq 2}">
                                        ${requestScope.lesson.quiz.quizName}
                                    </c:if>
                                </h4>
                                <p><small>Updated at ${requestScope.lesson.updatedAt}</small></p>
                                <div class="line"></div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <!--CONTENT START-->
                                    <div>
                                        ${requestScope.lesson.description}
                                    </div>
                                    <!--CONTENT END-->

                                    <!--QUIZ START-->
                                    <c:if test="${requestScope.lesson.lessonType eq 2}">
                                        <div class="card">
                                            <div class="card-body">
                                                <div class="form-group">
                                                    <div class="row">
                                                        <div class="col-12">
                                                            <div class="table-responsive">
                                                                <table class="table table-bordered mb-0">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td 
                                                                                style="width: 40%"
                                                                                class="font-weight-bold">
                                                                                Duration
                                                                            </td>
                                                                            <td>${requestScope.lesson.quiz.duration} minutes</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td 
                                                                                style="width: 40%"
                                                                                class="font-weight-bold">
                                                                                Number of questions
                                                                            </td>
                                                                            <td>${requestScope.lesson.quiz.noQuiz}</td>
                                                                        </tr>
                                                                        <c:if test="${not empty requestScope.grade}">
                                                                            <tr>
                                                                                <td 
                                                                                    style="width: 40%"
                                                                                    class="font-weight-bold">
                                                                                    Last attempt
                                                                                </td>
                                                                                <td>${requestScope.grade.grade}</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <div class="col-12">
                                                                                        <button 
                                                                                            onclick="window.location.href = 'quiz-practicing?quizId=${requestScope.lesson.quiz.quizId}&clid=${requestScope.c.classId}'"
                                                                                            type="submit" 
                                                                                            class="btn btn-primary">
                                                                                            Retake
                                                                                        </button>
                                                                                    </div>
                                                                                </td>
                                                                            </tr>
                                                                        </c:if>
                                                                        <c:if test="${empty requestScope.grade}">
                                                                            <tr>
                                                                                <td>
                                                                                    <div class="col-12">
                                                                                        <button 
                                                                                            onclick="window.location.href = 'quiz-practicing?quizId=${requestScope.lesson.quiz.quizId}&clid=${requestScope.c.classId}'"
                                                                                            type="submit" 
                                                                                            class="btn btn-primary">
                                                                                            Take Quiz
                                                                                        </button> 
                                                                                    </div>
                                                                                </td>
                                                                            </tr>
                                                                        </c:if>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                        <!--QUIZ END-->

                                        <!--ASSIGNMENT START-->
                                        <c:if test="${requestScope.lesson.lessonType eq 3}">
                                            <section class="comp-section">
                                                <div class="section-header">
                                                    <h6 class="section-title">Attached File:</h6>
                                                    <div class="line"></div>
                                                </div>
                                                <div class="text-left" style="margin-bottom: 2rem">
                                                    <form action="online-learning">
                                                        <input type="hidden" value="download-file" name="action">
                                                        <input type="hidden" value="${requestScope.path}" name="path">
                                                        <button
                                                            class="btn btn-primary" 
                                                            type="submit"
                                                            >
                                                            Download File
                                                        </button>
                                                    </form>


                                                </div>                                              
                                            </section>
                                            <div>
                                                <a href="assignment-submit?action=view" class="btn btn-primary btn-lg active" role="button" aria-pressed="true">Submit</a>
                                            </div>
                                        </c:if>

                                        <!--ASSIGNMENT END-->
                                    </div>
                                </div>
                        </section>
                        <!--CONTENT END-->
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
        <c:if test="${requestScope.lesson.lessonType eq 1}">
            <script>
                                                                                                //This code loads the IFrame Player API code asynchronously.
                                                                                                var tag = document.createElement('script');

                                                                                                tag.src = "https://www.youtube.com/iframe_api";
                                                                                                var firstScriptTag = document.getElementsByTagName('script')[0];
                                                                                                firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

                                                                                                // This function creates an <iframe> (and YouTube player)
                                                                                                // after the API code downloads.
                                                                                                var player;
                                                                                                var videoId = extractYouTubeVideoId('${requestScope.lesson.youtubeLink}');
                                                                                                function onYouTubeIframeAPIReady() {
                                                                                                    player = new YT.Player('player', {
                                                                                                        videoId: videoId,
                                                                                                        playerVars: {
                                                                                                            'playsinline': 1,
                                                                                                            'autoplay': 0
                                                                                                        },
                                                                                                        events: {
                                                                                                            'onReady': onPlayerReady,
                                                                                                            'onStateChange': onPlayerStateChange
                                                                                                        }
                                                                                                    });
                                                                                                }

                                                                                                // The API will call this function when the video player is ready.
                                                                                                function onPlayerReady(event) {
                                                                                                    loadSavedVideoProgress();
                                                                                                }

                                                                                                // The API calls this function when the player's state changes.
                                                                                                function onPlayerStateChange(event) {
                                                                                                    if (event.data === YT.PlayerState.PAUSED) {
                                                                                                        var videoTime = player.getCurrentTime();
                                                                                                        saveVideoProgress(videoTime);
                                                                                                    }
                                                                                                }
                                                                                                // Save video progress when the user leaves the page
                                                                                                window.addEventListener('beforeunload', function (event) {
                                                                                                    var videoTime = player.getCurrentTime();
                                                                                                    saveVideoProgress(videoTime);
                                                                                                });

                                                                                                function loadSavedVideoProgress() {
                                                                                                    var savedProgress = ${requestScope.savedProgress};
                                                                                                    if (savedProgress) {
                                                                                                        player.seekTo(parseFloat(savedProgress));
                                                                                                    }
                                                                                                }
                                                                                                function saveVideoProgress(progress) {
                                                                                                    // Make an Ajax call to the server to save the video progress
                                                                                                    $.ajax({
                                                                                                        type: "POST",
                                                                                                        url: "online-learning?action=save-progress",
                                                                                                        data: {
                                                                                                            videoProgress: progress,
                                                                                                            lessonId: ${requestScope.lesson.lessonId}
                                                                                                        },
                                                                                                        success: function (response) {
                                                                                                            console.log("Video progress saved to the database");
                                                                                                        },
                                                                                                        error: function (error) {
                                                                                                            console.error("Error saving video progress:", error);
                                                                                                        }
                                                                                                    });
                                                                                                }
                                                                                                function stopVideo() {
                                                                                                    player.stopVideo();
                                                                                                }
                                                                                                function extractYouTubeVideoId(url) {
                                                                                                    var videoId = url.match(/[?&]v=([^?&]+)/);
                                                                                                    return videoId ? videoId[1] : null;
                                                                                                }
            </script>
        </c:if>

    </body>
    <!-- Mirrored from preschool.dreamguystech.com/html-template/students.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 28 Oct 2021 11:11:49 GMT -->
</html>

