<%-- 
    Document   : subject-details
    Created on : Sep 22, 2023, 5:19:40 AM
    Author     : win
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="sdao" class="dal.SubjectDAO" scope="request"></jsp:useBean>
<jsp:useBean id="udao" class="dal.UserDAO" scope="request"></jsp:useBean>
<c:forEach var="s" items="${sdao.subjectList}">
    <div class="modal fade bd-example-modal-lg" id="subjectDetailsModal${s.subjectId}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
            <div class="modal-content">
                <form action="subject-list?action=update&subjectId=${s.subjectId}" method="POST">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">                         
                            <div class="col-md-8 ml-auto">
                                <div class="form-group">
                                    <label>Code</label>
                                    <input type="text" class="form-control" name="subjectCode" value="${s.subjectCode}" required>
                                </div>
                                <div class="form-group">
                                    <label>Name</label>
                                    <input type="text" class="form-control" name="subjectName" value="${s.subjectName}" required>
                                </div>
                                <div class="form-group">
                                    <label>Manager name</label>
                                    <select name="managerId" class="form-control" >
                                        <c:forEach var ="u" items="${udao.userList}" > 
                                            <c:if test="${u.getRole().getSettingId() eq 2}">
                                                <option 
                                                    value ="${u.getUserId()}" 
                                                    ${u.getUserId() eq s.getManagerId() ? 'selected' : ''}
                                                    >
                                                    ${u.getFullName()}
                                                </option>
                                            </c:if>
                                        </c:forEach> 
                                    </select>
                                </div>
<!--                                <div class="form-group">
                                    <label>Status</label>
                                    <div class="btn-group">
                                        
                                        <select name="status" class="form-control">
                                            <option value="1" ${s.status == true ? 'selected' : ''}>Active</option>
                                            <option value="0" ${s.status == false ? 'selected' : ''}>Inactive</option>
                                        </select>
                                    </div>
                                </div>-->
                                          <div class="form-group">
                                    <label>Status: </label>
                                   <input type="radio" name="status" value="0" ${s.status == false ? 'checked' : ''}>
                                   <label for ="0"> Inactive</label>
                                   <input type="radio" name="status" value="1"  ${s.status == true ? 'checked' : ''}>
                                   <label for ="1"> Active</label>
                                          </div>
                             
                                     <div class="form-group">
                                    <label>Subject description</label>
                                      <textarea id="description" name="description" rows="5" cols="60" placeholder="${s.subjectDescription}"></textarea>
                              
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


