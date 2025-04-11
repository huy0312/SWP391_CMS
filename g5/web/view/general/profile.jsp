<!DOCTYPE html>
<html lang="en">
    <!-- Mirrored from preschool.dreamguystech.com/html-template/profile.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 28 Oct 2021 11:11:38 GMT -->
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>CMSLVL10 - Profile</title>
        <link rel="shortcut icon" href="view/assets/img/logo_short.png">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,500;0,600;0,700;1,400&amp;display=swap">
        <link rel="stylesheet" href="view/assets/plugins/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="view/assets/plugins/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="view/assets/plugins/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="view/assets/css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
        <style>
            .file {
                position: relative;
                overflow: hidden;
                margin-top: 10px;
                width: 100%;
                border: none;
                border-radius: 0;
                font-size: 12px;
            }
            .file input {
                position: absolute;
                opacity: 0;
                right: 0;
                top: 0;
            }
        </style>
    </head>
    <body>
        <div class="main-wrapper">
            <jsp:include page="../components/general/body-header.jsp"></jsp:include>
            <jsp:include page="../components/general/sidebar.jsp"></jsp:include>
                <div class="page-wrapper">
                    <div class="content container-fluid">
                        <div class="page-header">
                            <div class="row">
                                <div class="col">
                                    <h3 class="page-title">Profile</h3>
                                    <ul class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="home">Home</a></li>
                                        <li class="breadcrumb-item active">Profile</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="profile-header">
                                    <div class="row align-items-center">
                                        <div class="col-auto profile-image">
                                            <a href="#">
                                                <img style="height: 100px; width: 100px" class="rounded-circle" alt="User Image" src="${sessionScope.imgU}">
                                            <br>
                                        </a>
                                        <form id="myForm" action="profile" enctype="multipart/form-data" method="post">
                                            <div class="file btn btn-sm btn-primary">
                                                Change Photo
                                                <input type="file" name="file" onchange="changeImage()" />
                                                <input name="type" type="hidden" value="changePhoto">
                                                <input name="userId" type="hidden" value=${sessionScope.user.userId}>
                                                
                                            </div>
                                        </form>
                                    </div>
                                    <div class="col ml-md-n2 profile-user-info">
                                        <h4 class="user-name mb-0">${sessionScope.user.fullName}</h4>
                                        <h6 class="text-muted">${sessionScope.user.role.settingName}</h6>
                                    </div>
                                </div>
                            </div>
                            <div class="profile-menu">
                                <ul class="nav nav-tabs nav-tabs-solid">
                                    <li class="nav-item">
                                        <a class="nav-link active" data-toggle="tab" href="#per_details_tab">About</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" data-toggle="tab" href="#password_tab">Password</a>
                                    </li>
                                </ul>
                            </div>
                            <div class="tab-content profile-tab-cont">
                                <div class="tab-pane fade show active" id="per_details_tab">
                                    <div class="row">
                                        <div class="col-lg-9">
                                            <div class="card">
                                                <div class="card-body">
                                                    <h5 class="card-title d-flex justify-content-between">
                                                        <span>Personal Details</span>
                                                        <a class="edit-link" href="#edit_personal_details" data-toggle="modal" data-target="#updateInfo"><i class="far fa-edit mr-1"></i>Edit</a>
                                                    </h5>
                                                    <div class="row">
                                                        <p class="col-sm-3 text-muted text-sm-right mb-0 mb-sm-3">Name</p>
                                                        <p class="col-sm-9">${sessionScope.user.fullName}</p>
                                                    </div>
                                                    <div class="row">
                                                        <p class="col-sm-3 text-muted text-sm-right mb-0 mb-sm-3">Email ID</p>
                                                        <p class="col-sm-9">${sessionScope.user.email}</p>
                                                    </div>
                                                    <div class="row">
                                                        <p class="col-sm-3 text-muted text-sm-right mb-0 mb-sm-3">Mobile</p>
                                                        <p class="col-sm-9">${sessionScope.user.mobile}</p>
                                                    </div>
                                                    <div class="row">
                                                        <p class="col-sm-3 text-muted text-sm-right mb-0">Date Of Creation</p>
                                                        <p class="col-sm-9 mb-0">${sessionScope.user.createdAt}</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                    </div>
                                </div>
                                <div id="password_tab" class="tab-pane fade">
                                    <div class="card">
                                        <div class="card-body">
                                            <h5 class="card-title">Change Password</h5>

                                            <div class="row">
                                                <div class="col-md-10 col-lg-6">
                                                    <form action = "profile" method="post">
                                                        <input name="type" type="hidden" value="changePassword">
                                                        <input name="userId" type="hidden" value=${sessionScope.user.userId}>
                                                        <div class="form-group">
                                                            <label>Old Password</label>
                                                            <input type="password"
                                                                   class="form-control"
                                                                   id="oldPass"
                                                                   name="oldPass"
                                                                   required maxlength="50">
                                                            <i class="far fa-eye" id="toggleOldPassword" style=" cursor: pointer;" ></i>
                                                        </div>
                                                        <div class="form-group">
                                                            <label>New Password</label>
                                                            <input type="password"
                                                                   class="form-control"
                                                                   id="newPass"
                                                                   name="newPass"
                                                                   pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$"
                                                                   title="Password must contain at least eight characters, at least one number and both lower and uppercase letters and special characters"
                                                                   required
                                                                   maxlength="50">
                                                            <i class="far fa-eye" id="toggleNewPassword" style=" cursor: pointer;" ></i>
                                                        </div>
                                                        <div class="form-group">
                                                            <label>Confirm Password</label>
                                                            <input type="password"
                                                                   class="form-control"
                                                                   id="reNewPass"
                                                                   name="reNewPass"
                                                                   required
                                                                   maxlength="50">
                                                            <i class="far fa-eye" id="toggleReNewPassword" style=" cursor: pointer;" ></i>
                                                        </div>
                                                        <button onclick="myFunction()" class="btn btn-primary" type="submit">Save Changes</button>
                                                    </form>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Update user information modal -->
        <div class="modal fade" id="updateInfo" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Account Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form action = "profile" method="post">
                        <input name="type" type="hidden" value="updateInformation">
                        <input name="userId" type="hidden" value=${sessionScope.user.userId}>
                        <div class="modal-body">
                            <div class="input-group mb-3">
                                <span class="input-group-text" id="inputGroup-sizing-default">Fullname</span>
                                <input type="text" required="" name="fullname"  title="Please enter your real fullname" class="form-control col-sm-9" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" value="${sessionScope.user.fullName}">
                            </div>
                            <div class="input-group mb-3">
                                <span class="input-group-text" id="inputGroup-sizing-default">Mobile</span>
                                <input type="text" readonly="" name="mobile" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" value="${sessionScope.user.mobile}">
                            </div>
                            <div class="input-group mb-3">
                                <span class="input-group-text" id="inputGroup-sizing-default">Email</span>
                                <input type="text" readonly="" name="fullname" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" value="${sessionScope.user.email}">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-success btn-sm">Update Information</button>
                            <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Close</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>


        <script>
            const toggleOldPassword = document.querySelector('#toggleOldPassword');
            const oldPassword = document.querySelector('#oldPass');

            toggleOldPassword.addEventListener('click', function (e) {
                // toggle the type attribute
                const type = oldPassword.getAttribute('type') === 'password' ? 'text' : 'password';
                oldPassword.setAttribute('type', type);
                // toggle the eye slash icon
                this.classList.toggle('fa-eye-slash');
            });</script>
        <script>
            const toggleNewPassword = document.querySelector('#toggleNewPassword');
            const newPassword = document.querySelector('#newPass');

            toggleNewPassword.addEventListener('click', function (e) {
                // toggle the type attribute
                const type = newPassword.getAttribute('type') === 'password' ? 'text' : 'password';
                newPassword.setAttribute('type', type);
                // toggle the eye slash icon
                this.classList.toggle('fa-eye-slash');
            });</script>
        <script>
            const toggleReNewPassword = document.querySelector('#toggleReNewPassword');
            const reNewPassword = document.querySelector('#reNewPass');

            toggleReNewPassword.addEventListener('click', function (e) {
                // toggle the type attribute
                const type = reNewPassword.getAttribute('type') === 'password' ? 'text' : 'password';
                reNewPassword.setAttribute('type', type);
                // toggle the eye slash icon
                this.classList.toggle('fa-eye-slash');
            });</script>
        <script>
            function changeImage() {
                document.getElementById("myForm").submit();
            }
        </script>
        <script data-cfasync="false" src="../cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script><script src="view/assets/js/jquery-3.6.0.min.js"></script>
        <script src="view/assets/js/popper.min.js"></script>
        <script src="view/assets/plugins/bootstrap/js/bootstrap.min.js"></script>
        <script src="view/assets/plugins/slimscroll/jquery.slimscroll.min.js"></script>
        <script src="view/assets/js/script.js"></script>
    </body>
    <%
        request.getSession().removeAttribute("msg");
    %>
    <!-- Mirrored from preschool.dreamguystech.com/html-template/profile.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 28 Oct 2021 11:11:39 GMT -->
</html>