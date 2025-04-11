<%-- 
    Document   : delete-quiz
    Created on : Oct 20, 2023, 2:38:40 AM
    Author     : Admin
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<form action="quiz-list?action=delete" method="POST">
    <div class="modal fade" id="deleteQuizModal${param.quizId}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Delete Confirm</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="quizId" value="${param.quizId}">
                    <div class="float-left">Are you sure want to delete this quiz?</div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" onclick="this.form.submit()" class="btn btn-primary">Yes</button>
                </div>
            </div>
        </div>
    </div>
</form>
                    

