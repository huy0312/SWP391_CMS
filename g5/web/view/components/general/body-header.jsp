<%-- 
    Document   : body-header
    Created on : Sep 15, 2023, 8:41:19 AM
    Author     : win
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User" %>
<% User u = (User) session.getAttribute("user"); %>
<div class="header">
    <div class="header-left">
        <a href="
           <% if(u.getRole().getSettingId() == 1) { %>
           admin-dashboard
           <% } else if(u.getRole().getSettingId() == 2) { %>
           home
           <% } else if(u.getRole().getSettingId() == 3) { %>
           homepage
           <% } else if(u.getRole().getSettingId() == 4) { %>
           homepage
           <% } %>
           " class="logo">
            <img src="./view/assets/img/cmslogo.png" alt="Logo">
        </a>
        <a href="
           <% if(u.getRole().getSettingId() == 1) { %>
           admin-dashboard
           <% } else if(u.getRole().getSettingId() == 2) { %>
           home
           <% } else if(u.getRole().getSettingId() == 3) { %>
           homepage
           <% } else if(u.getRole().getSettingId() == 4) { %>
           homepage
           <% } %>
           " class="logo logo-small">
            <img src="./view/assets/img/logo_short.png" alt="Logo" width="30" height="30">
        </a>
    </div>
    <a href="javascript:void(0);" id="toggle_btn">
        <i class="fas fa-align-left"></i>
    </a>
    <c:if test="${not empty param.isHomePage}">
        <div class="top-nav-search">
            <form action="class-catalog">
                <input value="view" type="hidden" name="action">
                <input style="color: black" type="search" name="keyword" class="form-control" placeholder="Search class here" value="${param.keywordSaved}">
                <button class="btn" type="submit"><i class="fas fa-search"></i></button>
            </form>
        </div>
    </c:if>
    <a class="mobile_btn" id="mobile_btn">
        <i class="fas fa-bars"></i>
    </a>
    <ul class="nav user-menu">

        <li class="nav-item dropdown has-arrow">
            <a href="#" class="dropdown-toggle nav-link" data-toggle="dropdown">
                <span class="user-img"><img style="width: 75%; height: 75%" class="rounded-circle" src=${sessionScope.user.avatarImg} width="31" alt="<%= u.getFullName() %>"></span>
            </a>
            <div class="dropdown-menu">
                <div class="user-header">
                    <div class="avatar avatar-sm">
                        <img src=${sessionScope.user.avatarImg} alt="User Image" class="avatar-img rounded-circle">
                    </div>
                    <div class="user-text">
                        <h6><%= u.getFullName() %></h6>
                        <p class="text-muted mb-0"><%= u.getRole().getSettingName() %></p>
                    </div>
                </div>
                <a class="dropdown-item" href="profile">My Profile</a>
                <a class="dropdown-item" href="auth?action=logout">Logout</a>
            </div>
        </li>
    </ul>
</div>