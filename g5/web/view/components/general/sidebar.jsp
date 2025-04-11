<%-- 
    Document   : sidebar
    Created on : Sep 15, 2023, 8:54:09 AM
    Author     : win
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="model.User" %>
<jsp:useBean class="dal.LessonDAO" id="ldao" scope="request"></jsp:useBean>
<jsp:useBean class="dal.ClassDAO" id="cdao" scope="request"></jsp:useBean>
<jsp:useBean class="dal.ChapterDAO" id="ctdao" scope="request"></jsp:useBean>
<%
User u = (User) session.getAttribute("user");
if (u != null) {
%>
<c:set var="userId" scope="session" value='<%= u.getUserId() %>'></c:set>
    <div class="sidebar" id="sidebar">
        <div class="sidebar-inner slimscroll">
            <div id="sidebar-menu" class="sidebar-menu">
                <ul>
                    <li class="menu-title">
                        <span>Main Menu</span>
                    </li>
                    <!--ADMIN START-->
                <% if(u.getRole() != null && u.getRole().getSettingId() == 1) { %>
                <li>
                    <a href="system-setting?action=view"><i class="fas fa-cog"></i> <span>System Setting</span></a>
                </li>
                <li>
                    <a href="user-list?action=view"><i class="fas fa-users-cog"></i> <span>User List</span></a>
                </li>
                <li>
                    <a href="subject-list?action=view"><i class="fas fa-book"></i> <span>Subject List</span></a>
                </li>
                <!--ADMIN END-->

                <!--SUBJECT MANAGER START-->
                <% } else if(u.getRole() != null && u.getRole().getSettingId() == 2) { %>
                <li>
                    <a href="class-list?action=view"><i class="fas fa-users-cog"></i> <span>Class List</span></a>
                </li>   
                <li>
                    <a href="lesson-list?action=view"><i class="fas fa-book-open"></i> <span>Lesson List</span></a>
                </li>     
                <li>
                    <a href="question-list?action=view"><i class="fas fa-question"></i> <span>Question List</span></a>
                <li>
                    <a href="chapter-list?action=view"><i class="fas fa-book-reader"></i> <span>Chapter List</span></a>
                </li>
                <li>
                    <a href="quiz-list?action=view"><i class="fas fa-laptop-code"></i> <span>Quiz List</span></a>
                </li>
                <li>
                    <a href="dimension-list?action=view"><i class="fas fa-th-list"></i> <span>Dimension List</span></a>
                </li>
                <!--SUBJECT MANAGER END-->

                <!--HOMEPAGE TRAINER START-->
                <% } else if(u.getRole() != null && u.getRole().getSettingId() == 3) { %>
                <c:if test="${not empty param.isHomePage}">
                    <li>
                        <a href="class-catalog?action=view"><i class="fas fa-university"></i> <span>Class Catalog</span></a>
                    </li>
                    <li class="submenu">
                        <a href="#">
                            <i class="fas fa-user-graduate"></i> 
                            <span> My Classes</span> 
                            <span class="menu-arrow"></span>
                        </a>
                        <ul>
                            <c:forEach items="${cdao.getClassesByTrainer(userId)}" var="c">
                                <li>
                                    <a href="class-dashboard?sid=${c.subject.subjectId}&cid=${c.classId}">
                                        ${c.classCode}
                                    </a>
                                </li>
                            </c:forEach>
                        </ul>
                    </li>
                </c:if>
                <!--HOMEPAGE TRAINER END-->

                <!--CLASS DASHBOARD TRAINER START-->
                <c:if test="${not empty param.isClassDashboard}">
                    <c:set var="subjectId" value="${param.subjectId}"></c:set>

                        <li class="submenu active subdrop">
                            <a href="#">
                                <i class="fas fa-university"></i>
                                <span>
                                    Class Material
                                </span>
                                <span class="menu-arrow"></span>
                            </a>
                            <ul>
                            <c:forEach 
                                items="${ctdao.getChapterBySubject(subjectId)}" 
                                var="c">
                                <li>
                                    <a 
                                        href="class-dashboard?cid=${param.classId}&ctid=${c.chapterId}"
                                        class="${c.chapterId eq param.chapterId ? 'active' : ''}">
                                        <i class="fas fa-window-maximize"></i> 
                                        <span>${c.chapterName}</span>
                                    </a>
                                </li>
                            </c:forEach>
                        </ul>
                    </li>
                </c:if>
                <!--CLASS DASHBOARD TRAINER END-->

                <!--ONLINE LEARNING TRAINER START-->
                <c:if test="${not empty param.isOnlineLearning}">
                    <c:set var="subjectId" value="${param.subjectId}"></c:set>
                    <c:forEach items="${ctdao.getChapterBySubject(subjectId)}" var="c">
                        <li class="submenu ${c.chapterId eq param.chapterId ? 'active' : ''}">
                            <a href="#">
                                <i class="fas fa-user-graduate"></i> 
                                <span class="text-truncate" 
                                      data-toggle="tooltip" 
                                      title="${c.chapterName}">
                                    ${c.chapterName}
                                </span>
                                <span class="menu-arrow"></span>
                            </a>
                            <ul>
                                <c:forEach 
                                    items="${ldao.getLessonsByChapter(c.chapterId)}" 
                                    var="l">
                                    <li>
                                        <a 
                                            href="online-learning?action=learn&sid=${c.subject.subjectId}&lid=${l.lessonId}&cid=${param.classId}"
                                            class="${l.lessonId eq param.lessonId ? 'active' : ''}">
                                            ${l.lessonName}
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </li>
                    </c:forEach>
                </c:if>
                <!--ONLINE LEARNING TRAINER START-->

                <!--HOMEPAGE TRAINEE START-->
                <% } else if(u.getRole() != null && u.getRole().getSettingId() == 4) { %>
                <c:if test="${not empty param.isHomePage}">
                    <li>
                        <a href="class-catalog?action=view"><i class="fas fa-university"></i> <span>Class Catalog</span></a>
                    </li>
                    <li class="submenu">
                        <a href="#">
                            <i class="fas fa-user-graduate"></i> 
                            <span> My Classes</span> 
                            <span class="menu-arrow"></span>
                        </a>
                        <ul>
                            <c:forEach items="${cdao.getClassesByStudent(userId)}" var="c">
                                <li>
                                    <a href="class-dashboard?cid=${c.classId}">
                                        ${c.classCode}
                                    </a>
                                </li>
                            </c:forEach>
                        </ul>
                    </li>
                </c:if>
                <!--HOMEPAGE TRAINEE START-->

                <!--CLASS DASHBOARD TRAINEE START-->
                <c:if test="${not empty param.isClassDashboard}">
                    <c:set var="subjectId" value="${param.subjectId}"></c:set>

                        <li class="submenu active subdrop">
                            <a href="#">
                                <i class="fas fa-university"></i>
                                <span>
                                    Class Material
                                </span>
                                <span class="menu-arrow"></span>
                            </a>
                            <ul>
                            <c:forEach 
                                items="${ctdao.getChapterBySubject(subjectId)}" 
                                var="c">
                                <li>
                                    <a 
                                        href="class-dashboard?cid=${param.classId}&ctid=${c.chapterId}"
                                        class="${c.chapterId eq param.chapterId ? 'active' : ''}">
                                        <i class="fas fa-window-maximize"></i> 
                                        <span>${c.chapterName}</span>
                                    </a>
                                </li>
                            </c:forEach>
                        </ul>
                    </li>
                </c:if>
                <!--CLASS DASHBOARD TRAINEE END-->

                <!--ONLINE LEARNING START-->
                <c:if test="${not empty param.isOnlineLearning}">
                    <c:set var="subjectId" value="${param.subjectId}"></c:set>
                    <c:forEach items="${ctdao.getChapterBySubject(subjectId)}" var="c">
                        <li class="submenu ${c.chapterId eq param.chapterId ? 'active' : ''}">
                            <a href="#">
                                <i class="fas fa-user-graduate"></i> 
                                <span class="text-truncate" 
                                      data-toggle="tooltip" 
                                      title="${c.chapterName}">
                                    ${c.chapterName}
                                </span>
                                <span class="menu-arrow"></span>
                            </a>
                            <ul>
                                <c:forEach 
                                    items="${ldao.getLessonsByChapter(c.chapterId)}" 
                                    var="l">
                                    <li>
                                        <a 
                                            href="online-learning?action=learn&sid=${c.subject.subjectId}&lid=${l.lessonId}&cid=${param.classId}"
                                            class="${l.lessonId eq param.lessonId ? 'active' : ''}">
                                            ${l.lessonName}
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </li>
                    </c:forEach>
                </c:if>
                <!--ONLINE LEARNING START-->

                <% } %>
            </ul>
        </div>
    </div>
</div>
<% } else {
    // Handle the case when the user is not logged in
    // You can redirect to the login page or display a message
    response.sendRedirect("auth?action=login");
}
%>
