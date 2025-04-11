<%-- 
    Document   : add-user
    Created on : Sep 23, 2023, 10:52:52 PM
    Author     : win
--%>

<div class="modal fade bd-example-modal-lg" id="addSettingModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content">
            <form class="needs-validation" id="addSettingForm" novalidate>
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Add setting</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">

                        <!--NOTIFICATION-->
                        <div aria-live="polite" aria-atomic="true" style="position: relative; z-index: 11">
                            <div class="toast bg-danger text-white border-0" id="addFailedToast" data-delay="2000" data-autohide="true" role="alert" aria-live="assertive" aria-atomic="true" style="position: fixed; bottom: 20px; right: 20px;">
                                <div class="toast-body">
                                    This setting has been existed !
                                    <button type="button" class="ml-2 mb-1 close" data-dismiss="toast">&times;</button>
                                </div>
                            </div>
                        </div>

                        <!--FORM-->
                        <div class="row">
                            <div class="col-12 col-sm-6">
                                <div class="form-group">
                                    <label>Setting Group</label>
                                    <select class="form-control" name="settingGroup" required>
                                        <option value="Role">Role</option>
                                        <option value="Semester">Semester</option>
                                        <option value="Domain">Domain</option>
                                    </select>
                                    <div class="invalid-feedback">
                                        Please provide a valid name.
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>Setting Name</label>
                                    <input 
                                        type="text" 
                                        class="form-control" 
                                        name="settingName" 
                                        pattern="^[Ap-Za-z]+(?: [A-Za-z]+)*$" 
                                        required>
                                    <div class="invalid-feedback">
                                        Please provide a valid name.
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 col-sm-6">
                                <div class="form-group">
                                    <label>Setting Value</label>
                                    <input 
                                        type="text" 
                                        name="settingValue" 
                                        class="form-control" 
                                       
                                        required>

                                </div>
                            </div>
                            <div class="col-12 col-sm-6">
                                <div class="form-group">
                                    <label>Description</label>
                                    <textarea type="text" 
                                              name="description" 
                                              class="form-control" 
                                              pattern="^(03|07|08|09)[0-9]{8}$" 
                                              required></textarea>
                                    <div class="invalid-feedback">

                                    </div>                        
                                </div>
                            </div>
                            <div class="col-12 col-sm-6">
                                <div class="form-group">
                                    <input 
                                        id="activerb" 
                                        name="statusrb" 
                                        type="radio" 
                                        class="d-none" 
                                        value="1">
                                    <input 
                                        id="inactiverb" 
                                        name="statusrb" 
                                        type="radio" 
                                        class="d-none" 
                                        value="0"
                                        checked>
                                    <label>Status: </label>
                                    <br/>
                                    <input name="status" id="status"
                                           type="checkbox" data-toggle="switchbutton"
                                           data-onstyle="info"
                                           data-onlabel="A"
                                           data-offlabel="IA"
                                           >
                                </div>
                            </div>                           
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Add</button>
                </div>
            </form>
        </div>
    </div>
</div>
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
    $(document).ready(function () {
        $('#status').on('change', function () {
            if ($(this).is(':checked')) {
                $('input[name=statusrb][value=1]').prop('checked', true);
            } else {
                $('input[name=statusrb][value=0]').prop('checked', true);
            }
        });
        // Handle form submission
        $("#addSettingForm").submit(function (event) {
            const formIsValid = validateForm(); // Check the form's validity
            event.preventDefault(); // Prevent the default form submission
            var formData = $(this).serialize();
            if (formIsValid) {
                $.ajax({
                    type: "POST",
                    url: "system-setting?action=add", // Use the URL of your AddUserServlet
                    data: formData,
                    success: function (response) {
                        if (response.trim() === 'success') {
                            window.location.href = 'system-setting?action=view';
                        } else {
                            $('#addFailedToast').toast('show');
                        }
                    }
                });
            }
            console.log(validateForm());
        });
    });
</script>