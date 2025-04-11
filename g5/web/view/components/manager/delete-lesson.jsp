<%-- 
    Document   : delete-lesson
    Created on : Oct 19, 2023, 9:59:14 PM
    Author     : win
--%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<form action="${param.action}" method="POST">
    <div class="modal fade" id="deleteLessonModal${param.lessonId}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Delete Confirm</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="ctid" value="${param.chapterId}">
                    <input type="hidden" name="cid" value="${param.classId}">
                    <input type="hidden" name="lesson" value="${param.lessonId}">
                    <div class="float-left">Are you sure want to delete this lesson?</div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" onclick="this.form.submit()" class="btn btn-primary">Save changes</button>
                </div>
            </div>
        </div>
    </div>
</form>
