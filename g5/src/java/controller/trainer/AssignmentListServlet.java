/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.trainer;

import controller.auth.BasedRequiredAuthenticationController;
import dal.AssignmentDAO;
import dal.ChapterDAO;
import dal.ClassDAO;
import dal.SubjectDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Assignment;
import model.Chapter;
import model.User;
import utils.Utils;
import model.Class;
import model.Subject;

/**
 *
 * @author minhf
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 50, // 50MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
@WebServlet(name = "AssignmentListServlet", urlPatterns = {"/assignment-list"})
public class AssignmentListServlet extends BasedRequiredAuthenticationController {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String action = request.getParameter("action");
        AssignmentDAO adao = new AssignmentDAO();
        ChapterDAO chdao = new ChapterDAO();
        Utils utils = new Utils();
        switch (action) {
            case "update-status":
                int assignmentId = Integer.parseInt(request.getParameter("assignmentId"));
                Boolean newStatus = Boolean.parseBoolean(request.getParameter("status"));
                new AssignmentDAO().updateAssigmentStatus(assignmentId, newStatus, user.getUserId());
                try ( PrintWriter out = response.getWriter()) {
                    out.print("success");
                }
                break;
            case "get-chapter":
                int subjectId = Integer.parseInt(request.getParameter("subjectId"));
                List<Chapter> chapters = chdao.getChapterBySubject(subjectId, user.getUserId());
                try ( PrintWriter out = response.getWriter()) {
                    for (Chapter chapter : chapters) {
                        out.println("<option value='" + chapter.getChapterId() + "'>" + chapter.getChapterName() + "</option>");
                    }
                }
                break;
            case "add":
                String assignmentTitle = request.getParameter("assginmentTitle");
                int chapterId = Integer.parseInt(request.getParameter("chapterId"));
                String dlString = request.getParameter("deadline");
                SimpleDateFormat dlDateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                Date parsedDL = null;
                try {
                    parsedDL = dlDateFormat.parse(dlString);
                } catch (ParseException ex) {
                    Logger.getLogger(AssignmentListServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                Timestamp deadline = new Timestamp(parsedDL.getTime());
                String description = request.getParameter("description");
                Boolean status = request.getParameter("statusrb").equals("1") ? true : false;
                int classId = Integer.parseInt(request.getParameter("classId"));
                adao.addAssigment(assignmentTitle, chapterId, deadline, description, status, user.getUserId(), classId);
                request.getSession().setAttribute("isAddSuccess", true);
                break;

            default:
                throw new AssertionError();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        AssignmentDAO adao = new AssignmentDAO();
        ClassDAO cdao = new ClassDAO();
        SubjectDAO sdao = new SubjectDAO();
        ChapterDAO chdao = new ChapterDAO();
        String action = request.getParameter("action");
        int status;
           
        switch (action) {
            case "view":
                 if (request.getParameter("status") == null) {
                    status = -1;
                } else {
                    status = Integer.parseInt(request.getParameter("status"));
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
                List<Assignment> assignmentsTemp = adao.getAllAssignments(user.getUserId(),status,keyword);
                List<Assignment> assignments = adao.paginateAssignment(assignmentsTemp, page, 5);
                List<Class> classes = cdao.getAllClasses(user.getUserId());

                int noOfPages = (int) Math.ceil(assignmentsTemp.size() * 1.0 / 5);
                //Properties saved for filter search
                request.setAttribute("statusSaved", status);
                request.setAttribute("keywordSaved", keyword);
                //Properties for pagination
                request.setAttribute("noOfPages", noOfPages);
                request.setAttribute("currentPage", page);

                //Properties for viewing list
                request.setAttribute("assignments", assignments);
                request.setAttribute("classes", classes);
                request.getRequestDispatcher("view/trainer/assignment-list.jsp").forward(request, response);
                break;
            case "add":
            if (request.getParameter("status") == null) {
                    status = -1;
                } else {
                    status = Integer.parseInt(request.getParameter("status"));
                }
                classes = cdao.getAllClasses(user.getUserId());
                request.setAttribute("classes", classes);
                request.setAttribute("statusSaved", status);

                request.getRequestDispatcher("view/trainer/new-assignment.jsp").forward(request, response);
                break;
        }
    }
}
