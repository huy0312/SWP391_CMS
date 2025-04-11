<%-- 
    Document   : delete-quiz
    Created on : Oct 20, 2023, 2:38:40 AM
    Author     : Admin
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<form action="question-list?action=delete" method="POST">
    <div class="modal fade" id="deleteQuestionModal${param.questionId}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Delete Confirm</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="question" value="${param.questionId}">
                    <div class="float-left">Are you sure want to delete this question?</div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" onclick="this.form.submit()" class="btn btn-primary">Save changes</button>
                </div>
            </div>
        </div>
    </div>
</form>

