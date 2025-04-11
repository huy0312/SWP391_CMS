<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean class="dal.AnswerDAO" id="adao" scope="request"></jsp:useBean>
    <!DOCTYPE html>
    <html>
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
        <head>
            <style>
                .countdown {
                    text-align: center;
                    font-size: 60px;
                    margin-top: 0px;
                    transition: opacity 0.5s ease-in-out; /* Smooth transition effect for fading */
                }
            </style>
            <title>CMSLVL10 - Quizzes Practicing</title>
            <script>
                function startTimer(duration, display) {
                    var timer = localStorage.getItem('timer') || duration;
                    var minutes, seconds;
                    var interval = setInterval(function () {
                        minutes = parseInt(timer / 60, 10);
                        seconds = parseInt(timer % 60, 10);
                        minutes = minutes < 10 ? '0' + minutes : minutes;
                        seconds = seconds < 10 ? '0' + seconds : seconds;
                        display.textContent = minutes + ':' + seconds;
                        if (--timer < 0) {
                            timer = duration;
                        }
                        localStorage.setItem('timer', timer); // Store timer value in local storage
                    }, 1000);
                    // Clear the interval on page unload
                    window.addEventListener('beforeunload', function () {
                        clearInterval(interval);
                    });
                }

                window.onload = function () {
                    var duration = 60 * ${requestScope.duration};
                    var display = document.querySelector('#time');
                    interval = startTimer(duration, display);
                };
                function finish() {
                    clearInterval(interval); // Clear the interval
                    localStorage.removeItem('timer'); // Clear the timer from local storage
//                    window.location.href = 'quiz-practice?action=view&sid=${requestScope.quiz.subject.subjectId}&cid=${requestScope.quiz.chapter.chapterId}';
                    document.getElementById('questionnaireForm').submit();
                }
        </script>
    </head>
    <body>
        <div class="main-wrapper">
            <div class="content container-fluid p-20">
                <div class="page-header">
                    <div class="row align-items-center">
                        <!--NAVIGATION START-->
                        <div class="col d-flex justify-content-center">
                            <h3 class="page-title">${requestScope.quiz.quizName}</h3>
                        </div>
                        <!--NAVIGATION END-->
                    </div>
                </div>
                <div class="row">

                </div>
                <div class="row">
                    <div class="col-md-8">
                        <div class="card card-body">
                            <form id="questionnaireForm" action="quiz-practicing" method="post">
                                <input type="hidden" value="${requestScope.classId}" name="classId">
                                <input type="hidden" value="${requestScope.quizId}" name="quizId">
                                <c:forEach items="${requestScope.questions}" var="q">
                                    <c:set var="noOption" value="${adao.countCorrectAnswerInQuestion(q.questionId)}"></c:set>
                                        <div class="question" style="display: none;">
                                            <h5 class="mb-20">${q.questionText}</h5>
                                        <p><small>Choose ${noOption} option.</small></p>
                                        <div class="answers">
                                            <c:forEach items="${adao.getAnswerByQuestion(q.questionId)}" var="a">
                                                <div class="row">
                                                    <div class="col-12">
                                                        <label 
                                                            class="btn btn-block btn-outline-secondary d-flex" 
                                                            for="${a.answerId}"
                                                            >
                                                            <input 
                                                                class="d-none"
                                                                type="checkbox" 
                                                                id="${a.answerId}" 
                                                                name="answer_${q.questionId}" 
                                                                value="${a.answerId}" 
                                                                data-questionId="${q.questionId}"
                                                                >
                                                            ${a.text}
                                                        </label>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </c:forEach>
                            </form>
                        </div>
                        <div class="container">
                            <div class="question-container">
                                <div class="question" id="currentQuestion">
                                    <!-- Current question will be displayed here -->
                                </div>
                                <button type="button" class="btn btn-outline-secondary pr-3 pl-3" id="previousBtn">Prev</button>
                                <button type="button" class="btn btn-outline-secondary pr-3 pl-3" id="nextBtn">Next</button>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card card-body">
                            <div class="row">
                                <div class="d-flex col-md-12 justify-content-center">
                                    <button class="btn btn-block btn-outline-info disabled"><h3 id="time"></h3></button>
                                </div>
                            </div>
                            <div class="row mt-auto">
                                <div class="d-flex col-md-12 justify-content-center">
                                    <button type="submit" onclick="finish()" class="btn btn-block btn-success mt-3">Submit</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <script>
                const questions = document.querySelectorAll('.question');
                let currentQuestionIndex = 0;
                const questionContainer = document.getElementById('currentQuestion');
                const previousBtn = document.getElementById('previousBtn');
                const nextBtn = document.getElementById('nextBtn');

                // Function to display the current question and hide others
                function displayQuestion(index) {
                    questions.forEach((question, idx) => {
                        if (idx === index) {
                            question.style.display = 'block';
                        } else {
                            question.style.display = 'none';
                        }
                    });
                }

                // Initial display of the first question
                displayQuestion(currentQuestionIndex);

                // Event listener for the Next button
                nextBtn.addEventListener('click', function () {
                    if (currentQuestionIndex < questions.length - 2) {
                        currentQuestionIndex++;
                        displayQuestion(currentQuestionIndex);
                    }
                });

                // Event listener for the Previous button
                previousBtn.addEventListener('click', function () {
                    if (currentQuestionIndex > 0) {
                        currentQuestionIndex--;
                        displayQuestion(currentQuestionIndex);
                    }
                });

                // Event listener for form submission
                const form = document.getElementById('questionnaireForm');
                form.addEventListener('submit', function (event) {
                    event.preventDefault(); // Prevents the form from submitting for demonstration

                    // You can gather selected answers here before actual form submission
                    const selectedAnswers = {};
                    questions.forEach(question => {
                        const questionId = question.querySelector('.form-check-input').getAttribute('data-questionId');
                        const checkboxes = question.querySelectorAll('.form-check-input:checked');
                        const selected = Array.from(checkboxes).map(checkbox => checkbox.value);
                        selectedAnswers[questionId] = selected;
                    });

                    // For demonstration, log the selected answers
                    console.log('Selected Answers:', selectedAnswers);
                    // Perform actual form submission here
                    // form.submit();
                });
                // Get all the checkboxes
                const checkboxes = document.querySelectorAll('input[type="checkbox"]');
                function handleCheckboxChange(event) {
                    const checkbox = event.target;
                    const label = checkbox.parentElement;

                    if (checkbox.checked) {
                        label.classList.add('active');
                    } else {
                        label.classList.remove('active');
                    }
                }
                checkboxes.forEach((checkbox) => {
                    checkbox.addEventListener('change', handleCheckboxChange);
                });
            </script>
    </body>
</html>