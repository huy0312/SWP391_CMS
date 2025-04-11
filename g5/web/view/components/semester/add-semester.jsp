<div class="modal fade bd-example-modal-lg" id="addSemesterModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content">
            <form action="semester-setting?action=add" method="POST">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Start New Semester</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        <div class="form-group">
                            <label>Number</label>
                            <input type="text" class="form-control" name="settingValue" required>
                        </div>
                        <div class="form-group">
                            <label>Semester ID</label>
                            <input type="text" class="form-control" name="settingName" required>
                        </div>
                        
                        <div class="form-group">
                            <label>Period</label>
                            <input type="text" class="form-control" name="description" required>
                        </div>
                       
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Submit</button>
                </div>
            </form>
        </div>
    </div>
</div>
