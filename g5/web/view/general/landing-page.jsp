<%-- 
    Document   : landing-page
    Created on : Sep 26, 2023, 10:54:49 AM
    Author     : win
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="no-js" lang="">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="x-ua-compatible" content="ie=edge" />
        <title>CMSLVL10 - Learning Management System</title>
        <meta name="description" content="" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link
            rel="shortcut icon"
            type="image/x-icon"
            href="./view/assets/img/logo_short.png"
            />
        <!-- Place favicon.ico in the root directory -->

        <!-- ======== CSS here ======== -->
        <link rel="stylesheet" href="./view/assets/landing-page/css/bootstrap.min.css" />
        <link rel="stylesheet" href="./view/assets/landing-page/css/lineicons.css" />
        <link rel="stylesheet" href="./view/assets/landing-page/css/animate.css" />
        <link rel="stylesheet" href="./view/assets/landing-page/css/main.css" />
    </head>
    <body>
        <!--[if lte IE 9]>
          <p class="browserupgrade">
            You are using an <strong>outdated</strong> browser. Please
            <a href="https://browsehappy.com/">upgrade your browser</a> to improve
            your experience and security.
          </p>
        <![endif]-->

        <!-- ======== preloader start ======== -->
        <div class="preloader">
            <div class="loader">
                <div class="spinner">
                    <div class="spinner-container">
                        <div class="spinner-rotator">
                            <div class="spinner-left">
                                <div class="spinner-circle"></div>
                            </div>
                            <div class="spinner-right">
                                <div class="spinner-circle"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- preloader end -->

        <!-- ======== header start ======== -->
        <header class="header">
            <div class="navbar-area">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-lg-12">
                            <nav class="navbar navbar-expand-lg">
                                <a class="navbar-brand" href="index.html">
                                    <img style="max-height: 50px" src="./view/assets/img/logo_short.png" alt="Logo" />
                                </a>
                                <button
                                    class="navbar-toggler"
                                    type="button"
                                    data-bs-toggle="collapse"
                                    data-bs-target="#navbarSupportedContent"
                                    aria-controls="navbarSupportedContent"
                                    aria-expanded="false"
                                    aria-label="Toggle navigation"
                                    >
                                    <span class="toggler-icon"></span>
                                    <span class="toggler-icon"></span>
                                    <span class="toggler-icon"></span>
                                </button>

                                <div
                                    class="collapse navbar-collapse sub-menu-bar"
                                    id="navbarSupportedContent"
                                    >
                                    <ul id="nav" class="navbar-nav ms-auto">
                                        <li class="nav-item">
                                            <a class="page-scroll active" href="#home">Home</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="page-scroll" href="#features">Features</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="page-scroll" href="#contact">Contact</a>
                                        </li>
                                    </ul>
                                </div>
                                <!-- navbar collapse -->
                            </nav>
                            <!-- navbar -->
                        </div>
                    </div>
                    <!-- row -->
                </div>
                <!-- container -->
            </div>
            <!-- navbar area -->
        </header>
        <!-- ======== header end ======== -->

        <!-- ======== hero-section start ======== -->
        <section id="home" class="hero-section">
            <div class="container">
                <div class="row align-items-center position-relative">
                    <div class="col-lg-6">
                        <div class="hero-content">
                            <h1 class="wow fadeInUp" data-wow-delay=".4s">
                                CMS LEVEL 10
                            </h1>
                            <p class="wow fadeInUp" data-wow-delay=".6s">
                                Unlock the power of education with CMSLVL10. 
                                Our user-friendly Learning Management System provides a wide array of courses, 
                                fostering a dynamic and collaborative learning environment. 
                                Join us now to access top-notch resources and take your learning to the next level.
                            </p>
                            <a
                                href="<%=request.getContextPath()%>/auth?action=login"
                                class="main-btn border-btn btn-hover wow fadeInUp"
                                data-wow-delay=".6s"
                                >Login</a
                            >
                            <a href="#features" class="scroll-bottom">
                                <i class="lni lni-arrow-down"></i
                                ></a>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="hero-img wow fadeInUp" data-wow-delay=".5s">
                            <img style="max-width: 100%" src="./view/assets/landing-page/img/What_is_an_LMS_1.png" alt="" />
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- ======== hero-section end ======== -->

        <!-- ======== feature-section start ======== -->
        <section id="features" class="feature-section pt-120">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-4 col-md-8 col-sm-10">
                        <div class="single-feature">
                            <div class="icon">
                                <i class="lni lni-library"></i>
                            </div>
                            <div class="content">
                                <h3>Robust Course Library</h3>
                                <p>
                                    Explore an extensive library of courses spanning 
                                    diverse subjects and skill levels. From academic 
                                    subjects to professional development, our 
                                    Learning Management System offers a wide array 
                                    of content to cater to your learning needs.
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-8 col-sm-10">
                        <div class="single-feature">
                            <div class="icon">
                                <i class="lni lni-layout"></i>
                            </div>
                            <div class="content">
                                <h3>Interactive Learning Tools</h3>
                                <p>
                                    Engage in immersive learning experiences with interactive quizzes, 
                                    assignments, and collaborative discussion forums. Our platform encourages 
                                    active participation and knowledge sharing among learners, enhancing 
                                    comprehension and retention.
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-8 col-sm-10">
                        <div class="single-feature">
                            <div class="icon">
                                <i class="lni lni-stats-up"></i>
                            </div>
                            <div class="content">
                                <h3>EProgress Tracking and Analytics</h3>
                                <p>
                                    Stay on top of your learning journey with 
                                    built-in progress tracking and insightful 
                                    analytics. Monitor your performance, identify 
                                    areas for improvement, and make data-driven 
                                    decisions to achieve your educational goals.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- ======== feature-section end ======== -->


        <!-- ======== footer start ======== -->
        <footer id="contact" class="footer">
            <div class="container">
                <div class="widget-wrapper">
                    <div class="row">
                        <div class="col-xl-4 col-lg-4 col-md-6">
                            <div class="footer-widget">
                                <div class="logo mb-30">
                                    <a href="index.html">
                                        <img style="max-width: 50%" src="./view/assets/img/logo_name.png" alt="" />
                                    </a>
                                </div>
                                <p class="desc mb-30 text-white">
                                    Elevate your learning journey with CMSLVL10. Learn, grow, succeed. Join us now!
                                </p>
                                <ul class="socials">
                                    <li>
                                        <a href="jvascript:void(0)">
                                            <i class="lni lni-facebook-filled"></i>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="jvascript:void(0)">
                                            <i class="lni lni-twitter-filled"></i>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="jvascript:void(0)">
                                            <i class="lni lni-instagram-filled"></i>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="jvascript:void(0)">
                                            <i class="lni lni-linkedin-original"></i>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>

                        <div class="col-xl-2 col-lg-2 col-md-6">
                            <div class="footer-widget">
                            </div>
                        </div>
                        <div class="col-xl-3 col-lg-3 col-md-6">
                            <div class="footer-widget">
                                <h3>About us</h3>
                                <ul class="links">
                                    <li><a href="https://www.fb.com/huu.huy0312" target="_blank">Nguyen Huu Huy</a></li>
                                    <li><a href="https://www.fb.com/toantran.0311" target="_blank">Tran The Toan</a></li>
                                    <li><a href="https://www.fb.com/profile.php?id=100011685756150" target="_blank">Nguyen Hai Minh</a></li>
                                    <li><a href="https://www.fb.com/le.vietnhat.12" target="_blank">Le Viet Nhat</a></li>
                                    <li><a href="https://www.facebook.com/profile.php?id=100081759694746&sk=photos" target="_blank">Nguyen Quang Huy</a></li>
                                </ul>
                            </div>
                        </div>

                        <div class="col-xl-3 col-lg-3 col-md-6">
                            <div class="footer-widget">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
        <!-- ======== footer end ======== -->

        <!-- ======== scroll-top ======== -->
        <a href="#" class="scroll-top btn-hover">
            <i class="lni lni-chevron-up"></i>
        </a>

        <!-- ======== JS here ======== -->
        <script src="./view/assets/landing-page/js/bootstrap.bundle.min.js"></script>
        <script src="./view/assets/landing-page/js/wow.min.js"></script>
        <script src="./view/assets/landing-page/js/main.js"></script>
    </body>
</html>
