/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import controller.auth.BasedRequiredManagerAuthenticationController;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import dal.ChapterDAO;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Chapter;
import model.Subject;
import utils.Validation;

/**
 *
 * @author minhf
 */
@WebServlet(name = "ChapterListServlet", urlPatterns = {"/chapter-list"})
public class ChapterListServlet extends BasedRequiredManagerAuthenticationController {

    Validation valid = new Validation();
    ChapterDAO cdao = new ChapterDAO();

    @Override

    protected void doPost(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "update-status":
                int chapterId = Integer.parseInt(request.getParameter("chapterId"));
                Boolean newStatus = Boolean.parseBoolean(request.getParameter("status"));
                new ChapterDAO().updateChapterStatus(chapterId, newStatus, user.getUserId());
                try ( PrintWriter out = response.getWriter()) {
                    out.print("success");
                }
                
                break;
            
            case "add":
                String chapterName = request.getParameter("chapterName");
                int subjectId = Integer.parseInt(request.getParameter("subjectId"));
                try {
                    if (!valid.isColliedChapter(chapterName)) {
                        cdao.addChapter(chapterName, subjectId);
                        try ( PrintWriter out = response.getWriter()) {
                            out.print("success");
                        }
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(ChapterListServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
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
                 subjectId;
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
                String keyword = request.getParameter("keyword");
                if (keyword == null) {
                    keyword = "";
                }
                //Pagination
                int page = 1;
                if (request.getParameter("page") != null) {
                    page = Integer.parseInt(request.getParameter("page"));
                }
                List<Chapter> chapterTemp;
                chapterTemp = cdao.getAllChapter(user.getUserId(), subjectId, status, keyword);
                List<Chapter> chapter = cdao.paginateChapter(chapterTemp, page, 5);
                List<Subject> subjects = cdao.getAllSubjects(user.getUserId());

                int noOfPages = (int) Math.ceil(chapterTemp.size() * 1.0 / 5);
                //Properties saved for filter search
                request.setAttribute("statusSaved", status);
                request.setAttribute("subjectIdSaved", subjectId);

                request.setAttribute("keywordSaved", keyword);
                request.setAttribute("subjects", subjects);

                //Properties for pagination
                request.setAttribute("noOfPages", noOfPages);
                request.setAttribute("currentPage", page);

                //Properties for viewing list
                request.setAttribute("chapter", chapter);
                request.getRequestDispatcher("view/manager/subjectsetting/chapter-list.jsp").forward(request, response);
                break;
            case "add":
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
                subjects = cdao.getAllSubjects(user.getUserId());
                request.setAttribute("subjectIdSaved", subjectId);
                request.setAttribute("subjects", subjects);
                request.getRequestDispatcher("view/manager/subjectsetting/add-chapter.jsp").forward(request, response);
                break;
        }
    }

}
