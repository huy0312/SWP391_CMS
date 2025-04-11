<%-- 
    Document   : user-details
    Created on : Sep 22, 2023, 5:19:40 AM
    Author     : win
--%>
<jsp:useBean id="udao" class="dal.UserDAO" scope="request"></jsp:useBean>
<jsp:useBean id="sdao" class="dal.SettingDAO" scope="request"></jsp:useBean>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:forEach var="c" items="${udao.userList}">
    <div class="modal fade bd-example-modal-lg" id="userDetailsModal${c.userId}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
            <div class="modal-content">
                <form action="user-list?action=update" method="POST">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Detailed Information</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <!-- Hidden input fields to store original email and mobile -->
                        <input type="hidden" name="originalEmail" value="${c.email}">
                        <input type="hidden" name="originalMobile" value="${c.mobile}">

                        <div class="row">
                            <!-- First row with Avatar, Full Name, and Email -->
                            <div class="col-md-3">
                                <div class="avatar avatar-xxl">
                                    <img src="${c.avatarImg}" class="avatar-img rounded" alt="...">
                                </div>
                            </div>
                            <div class="col-md-9">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Full Name <span class="text-danger">*</span></label>
                                            <input type="hidden" class="form-control" name="userId" value="${c.userId}" required>
                                            <input type="text" class="form-control" name="fullName" value="${c.fullName}" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Email <span class="text-danger">*</span></label>
                                            <input type="email" class="form-control" name="email" value="${c.email}" required>
                                        </div>
                                    </div> 
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Phone Number <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control" name="mobile" value="${c.mobile}" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Password <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control" name="password" value="${c.password}" required>
                                        </div>
                                    </div> 
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group row">
                                            <label class="d-block col-md-4">Role <span class="text-danger">*</span></label>
                                            <div class="btn-group col-md-8">
                                                <select name="role" class="select form-control">
                                                    <c:forEach items="${sdao.settingByRole}" var="r">
                                                        <option value="${r.settingId}"
                                                                ${r.settingId eq c.role.settingId ? 'selected' : ''}
                                                                >
                                                            ${r.settingName}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="d-block">Status <span class="text-danger">*</span></label>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" 
                                                       type="radio" name="status" 
                                                       id="status_true" value="1" 
                                                       ${c.status == true ? 'checked' : ''}>
                                                <label class="form-check-label" for="status_true">Active</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" 
                                                       type="radio" name="status" 
                                                       id="status_false" value="0" 
                                                       ${c.status == false ? 'checked' : ''}>
                                                <label class="form-check-label" for="status_false">Inactive</label>
                                            </div>
                                        </div>
                                    </div> 
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label>Description:</label>
                                    <textarea name="description" 
                                              style="resize: none" 
                                              rows="5" cols="5" 
                                              class="form-control" 
                                              placeholder="${c.description}"
                                              ></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <div class="text-right">
                            <button type="submit" class="btn btn-primary">Submit</button>
                        </div>
                    </div>
                </form>

            </div>
        </div>
    </div>
</c:forEach>
<!--<script>
    $(document).ready(function () {
        // Handle form submission
        $("#addUserForm").submit(function (event) {
            event.preventDefault(); // Prevent the default form submission
            var errorAlertHtml = '<div class="alert alert-danger alert-dismissible fade show" role="alert">' +
                    '<strong>User collied!</strong> Change Email or Phone Number.' +
                    '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                    '<span aria-hidden="true">&times;</span>' +
                    '</button>' +
                    '</div>';

            var formData = $(this).serialize();
            $.ajax({
                type: "POST",
                url: "user-list?action=update", // Use the URL of your AddUserServlet
                data: formData,
                success: function (response) {
                    if (response.trim() === "updateSuccess") {
                        // Close the modal
                        $('#addUserModal').modal('hide');
                        // Redirect to user-list?action=view
                        window.location.href = 'user-list?action=view&isAddSucceed=true';
                    } else {
                        // Display error notification
                        document.getElementById('noti').innerHTML = errorAlertHtml;
                    }
                }
            });
        });
    });
</script>-->


