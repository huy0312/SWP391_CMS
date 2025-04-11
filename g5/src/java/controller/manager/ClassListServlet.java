/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import controller.auth.BasedRequiredManagerAuthenticationController;
import dal.ClassDAO;
import dal.SettingDAO;
import dal.SubjectDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;
import model.Class;
import model.Setting;
import model.Subject;
import utils.Validation;

/**
 *
 * @author win
 */
@WebServlet(name = "ClassListServlet", urlPatterns = {"/class-list"})
public class ClassListServlet extends BasedRequiredManagerAuthenticationController {

    Validation valid = new Validation();
    ClassDAO cdao = new ClassDAO();
    SettingDAO sdao = new SettingDAO();
    SubjectDAO sjdao = new SubjectDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "update-status":
                int classId = Integer.parseInt(request.getParameter("classId"));
                Boolean newStatus = Boolean.parseBoolean(request.getParameter("status"));
                new ClassDAO().updateClassStatus(classId, newStatus, user.getUserId());
                try ( PrintWriter out = response.getWriter()) {
                    out.print("success");
                }
                break;
            case "update": 
                classId = Integer.parseInt(request.getParameter("classId"));
                String classCode = request.getParameter("classCode");
                int semesterId = Integer.parseInt(request.getParameter("semesterId"));
                int subjectId = Integer.parseInt(request.getParameter("subjectId"));
                 {
                    try {
                        if (!valid.isColliedClass(classCode)) {
                            cdao.updateClass(classId, classCode, semesterId, subjectId);
                        }
                    } catch (SQLException ex) {
                        Logger.getLogger(ClassListServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
                  request.getSession().setAttribute("isUpdateSuccess", true);
                break;
            case "add":
                classCode = request.getParameter("classCode");
                semesterId = Integer.parseInt(request.getParameter("semesterId"));
                subjectId = Integer.parseInt(request.getParameter("subjectId"));
                try {
                    if (!valid.isColliedClass(classCode)) {
                        cdao.addClass(classCode, semesterId, subjectId);
                        try ( PrintWriter out = response.getWriter()) {
                            out.print("success");
                        }
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(ClassListServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                request.getSession().setAttribute("isAddSuccess", true);
                break;
            default:
                throw new AssertionError();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "view":
                int status,
                 subjectId,
                 semesterId;
                if (request.getParameter("status") == null) {
                    status = -1;
                } else {
                    status = Integer.parseInt(request.getParameter("status"));
                }
                if (request.getParameter("subject") == null) {
                    subjectId = -1;
                } else {
                    subjectId = Integer.parseInt(request.getParameter("subject"));
                }
                if (request.getParameter("semester") == null) {
                    semesterId = -1;
                } else {
                    semesterId = Integer.parseInt(request.getParameter("semester"));
                }
                String keyword = request.getParameter("keyword");
                if (keyword == null) {
                    keyword = "";
                }
                //Pagination
                int page = 1;
                if (request.getParameter("page") != null) {
                    page = Integer.parseInt(request.getParameter("page"));
                }
                List<Class> classTemp = null;
                try {
                    classTemp = cdao.getAllClass(user.getUserId(), semesterId, subjectId, status, keyword);
                } catch (SQLException ex) {
                    Logger.getLogger(ClassListServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                List<Class> classes = cdao.paginateClass(classTemp, page, 5);
                List<Subject> subjects = sjdao.getAllSubjects(user.getUserId());
                List<Setting> settings = sdao.getSemester();
                int noOfPages = (int) Math.ceil(classTemp.size() * 1.0 / 5);
                //Properties saved for filter search
                request.setAttribute("statusSaved", status);
                request.setAttribute("subjectIdSaved", subjectId);
                request.setAttribute("semesterIdSaved", semesterId);
                request.setAttribute("keywordSaved", keyword);
                request.setAttribute("subjects", subjects);
                request.setAttribute("settings", settings);

                //Properties for pagination
                request.setAttribute("noOfPages", noOfPages);
                request.setAttribute("currentPage", page);

                //Properties for viewing list
                request.setAttribute("classes", classes);
                request.getRequestDispatcher("view/manager/class/class-list.jsp").forward(request, response);
                break;
            case "add":
                if (request.getParameter("subject") == null) {
                    subjectId = -1;
                } else {
                    subjectId = Integer.parseInt(request.getParameter("subject"));
                }
                if (request.getParameter("semester") == null) {
                    semesterId = -1;
                } else {
                    semesterId = Integer.parseInt(request.getParameter("semester"));
                }
                subjects = sjdao.getAllSubjects(user.getUserId());
                settings = sdao.getSemester();
                request.setAttribute("subjectIdSaved", subjectId);
                request.setAttribute("semesterIdSaved", semesterId);
                request.setAttribute("subjects", subjects);
                request.setAttribute("settings", settings);
                request.getRequestDispatcher("view/manager/class/add-class.jsp").forward(request, response);
                break;
            case "update":
                int classId = Integer.parseInt(request.getParameter("classId"));
                Class updateclass = new Class();
                subjects = sjdao.getAllSubjects(user.getUserId());
                settings = sdao.getSemester();
                updateclass = cdao.getClassById(classId);
                 request.setAttribute("updateclass", updateclass);
                request.setAttribute("subjects", subjects);
                request.setAttribute("settings", settings);
                request.getRequestDispatcher("view/manager/class/update-class.jsp").forward(request, response);
                break;

        }
    }

}
