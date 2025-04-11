/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import controller.auth.BasedRequiredManagerAuthenticationController;
import dal.ChapterDAO;
import dal.DimensionDAO;
import dal.QuizDAO;
import dal.SubjectDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.List;
import model.Chapter;
import model.Dimension;
import model.Quiz;
import model.Subject;
import model.User;
import utils.Validation;

/**
 *
 * @author win
 */
@WebServlet(name = "QuizListServlet", urlPatterns = {"/quiz-list"})
public class QuizListServlet extends BasedRequiredManagerAuthenticationController {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        SubjectDAO sdao = new SubjectDAO();
        QuizDAO qdao = new QuizDAO();
        ChapterDAO cdao = new ChapterDAO();
        DimensionDAO ddao = new DimensionDAO();
        String action = request.getParameter("action");
        switch (action) {
            case "view":
                int status,
                 subjectId,
                 chapterId,
                 dimensionId;
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
                if (request.getParameter("chapter") == null) {
                    chapterId = -1;
                } else {
                    chapterId = Integer.parseInt(request.getParameter("chapter"));
                }
                if (request.getParameter("dimension") == null) {
                    dimensionId = -1;
                } else {
                    dimensionId = Integer.parseInt(request.getParameter("dimension"));
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
                
                String sortField = request.getParameter("field");
                String sortOrder = request.getParameter("order");

                List<Quiz> quizsTemp = qdao.getQuizList(user.getUserId(), subjectId, chapterId, dimensionId, status, keyword);
                int noOfPages = (int) Math.ceil(quizsTemp.size() * 1.0 / 5);
                quizsTemp = qdao.paginateQuiz(quizsTemp, page, 5);
                List<Quiz> quizs = qdao.sortQuiz(quizsTemp, sortField, sortOrder);
                List<Subject> subjects = sdao.getAllSubjects(user.getUserId());
                List<Chapter> chapters = cdao.getChapterBySubject(subjectId, user.getUserId());
                List<Dimension> dimensions = ddao.getDimensionBySubject(subjectId, user.getUserId());

                

                //Properties saved for filter search
                request.setAttribute("statusSaved", status);
                request.setAttribute("subjectIdSaved", subjectId);
                request.setAttribute("chapterIdSaved", chapterId);
                request.setAttribute("dimensionIdSaved", dimensionId);
                request.setAttribute("keywordSaved", keyword);

                //Properties for pagination
                request.setAttribute("noOfPages", noOfPages);
                request.setAttribute("currentPage", page);

                //Properties for viewing list
                request.setAttribute("quizs", quizs);
                request.setAttribute("subjects", subjects);
                request.setAttribute("chapters", chapters);
                request.setAttribute("dimensions", dimensions);
                request.getRequestDispatcher("view/manager/quiz/quiz-list.jsp").forward(request, response);
                break;
            case "add":
                if (request.getParameter("subject") == null) {
                    subjectId = -1;
                } else {
                    subjectId = Integer.parseInt(request.getParameter("subject"));
                }
                if (request.getParameter("chapter") == null) {
                    chapterId = -1;
                } else {
                    chapterId = Integer.parseInt(request.getParameter("chapter"));
                }
                subjects = sdao.getAllSubjects(user.getUserId());
                chapters = cdao.getChapterBySubject(subjectId, user.getUserId());
                request.setAttribute("subjectIdSaved", subjectId);
                request.setAttribute("chapterIdSaved", chapterId);
                request.setAttribute("subjects", subjects);
                request.setAttribute("chapters", chapters);
                request.getRequestDispatcher("view/manager/quiz/add-quiz.jsp").forward(request, response);
                break;
            case "update":
                Quiz quiz = qdao.getQuizById(Integer.parseInt(request.getParameter("id")));
                subjects = cdao.getAllSubjects(user.getUserId());
                request.setAttribute("quiz", quiz);
                request.setAttribute("subjects", subjects);

                request.getRequestDispatcher("view/manager/quiz/quiz-details.jsp").forward(request, response);
                break;
            default:
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String action = request.getParameter("action");
        QuizDAO qdao = new QuizDAO();
        ChapterDAO cdao = new ChapterDAO();
        DimensionDAO ddao = new DimensionDAO();
        switch (action) {
            case "get-chapter":
                int subjectId = Integer.parseInt(request.getParameter("subjectId"));
                List<Chapter> chapters = cdao.getChapterBySubject(subjectId, user.getUserId());
                try ( PrintWriter out = response.getWriter()) {
                    for (Chapter chapter : chapters) {
                        out.println("<option value='" + chapter.getChapterId() + "'>" + chapter.getChapterName() + "</option>");
                    }
                }
                break;
            case "get-dimension":
                subjectId = Integer.parseInt(request.getParameter("subjectId"));
                List<Dimension> dimensions = ddao.getDimensionBySubject(subjectId, user.getUserId());
                try ( PrintWriter out = response.getWriter()) {
                    for (Dimension dimension : dimensions) {
                        out.println("<option value='" + dimension.getDimensionId() + "'>" + dimension.getDimensionName() + "</option>");
                    }
                }
                break;
            case "add":
                String title = request.getParameter("title");
                Boolean status = request.getParameter("statusrb").equals("1") ? true : false;
                String content = request.getParameter("content");
                String type = request.getParameter("type");
                int chapterId = Integer.parseInt(request.getParameter("chapter"));
                int dimensionId = Integer.parseInt(request.getParameter("dimension"));
                subjectId = Integer.parseInt(request.getParameter("subject"));
                String isSuccess = "fail";
                if (!new Validation().isColliedQuiz(title, dimensionId)) {
                    isSuccess = "success";
                    qdao.addQuiz(title, content, status, subjectId, user.getUserId());
                    int quiz_id = qdao.getLargestQuizId();
                    qdao.addQuizConfig(quiz_id, dimensionId, chapterId, user.getUserId());
                }
                try ( PrintWriter out = response.getWriter()) {
                    out.print(isSuccess);
                }
                request.getSession().setAttribute("isAddSuccess", true);
                break;

            case "updateStatus":
                int quizId = Integer.parseInt(request.getParameter("quizId"));

                Boolean newStatus = Boolean.parseBoolean(request.getParameter("status"));
                new QuizDAO().updateQuizStatus(quizId, newStatus, user.getUserId());
                try ( PrintWriter out = response.getWriter()) {
                    out.print("success");
                }
                request.getSession().setAttribute("isUpdateStatusSuccess", true);
                break;
            case "update":
                quizId = Integer.parseInt(request.getParameter("id"));
                title = request.getParameter("title");
                content = request.getParameter("content");
                status = request.getParameter("statusrb").equals("1") ? true : false;
                type = request.getParameter("type");
                chapterId = Integer.parseInt(request.getParameter("chapter"));
                dimensionId = Integer.parseInt(request.getParameter("dimension"));
                subjectId = Integer.parseInt(request.getParameter("subject"));
                qdao.updateQuiz(quizId, title, content, status, subjectId, user.getUserId());
                qdao.updateQuizConfig(quizId, dimensionId, chapterId, user.getUserId());
                request.getSession().setAttribute("isUpdateSuccess", true);
                break;
            case "delete":
                quizId = Integer.parseInt(request.getParameter("quizId"));
                qdao.deleteQuizFromLesson(quizId);
                qdao.deleteQuizListQuestion(quizId);
                qdao.deleteQuizConfig(quizId);
                qdao.deleteQuiz(quizId);
                request.getSession().setAttribute("isDeleteSuccess", true);
                response.sendRedirect("quiz-list?action=view");
                break;
            default:
                throw new AssertionError();
        }
    }

}
