/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import controller.auth.BasedRequiredManagerAuthenticationController;
import dal.ChapterDAO;
import dal.DimensionDAO;
import dal.LessonDAO;
import dal.QuestionDAO;
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
import model.Lesson;
import model.Question;
import model.Subject;
import model.User;
import utils.Validation;

/**
 *
 * @author win
 */
@WebServlet(name = "QuestionListServlet", urlPatterns = {"/question-list"})
public class QuestionListServlet extends BasedRequiredManagerAuthenticationController {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String action = request.getParameter("action");
        LessonDAO ldao = new LessonDAO();
        QuestionDAO qdao = new QuestionDAO();
        ChapterDAO cdao = new ChapterDAO();
        DimensionDAO ddao = new DimensionDAO();
        switch (action) {
            case "update":
                int questionId = Integer.parseInt(request.getParameter("questionId"));
                System.out.println(questionId);
                Boolean newStatus = Boolean.parseBoolean(request.getParameter("status"));
                new LessonDAO().updateLessonStatus(questionId, newStatus, user.getUserId());
                try ( PrintWriter out = response.getWriter()) {
                    out.print("success");
                }
                break;
            case "get-chapter":
                int subjectId = Integer.parseInt(request.getParameter("subjectId"));
                List<Chapter> chapters = cdao.getChapterBySubject(subjectId, user.getUserId());
                try ( PrintWriter out = response.getWriter()) {
//                    out.println("<option value='-1'>Select Chapter</option>");
                    for (Chapter chapter : chapters) {
                        out.println("<option value='" + chapter.getChapterId() + "'>" + chapter.getChapterName() + "</option>");
                    }
                }
                break;

            case "get-lesson":
                int lessonId = Integer.parseInt(request.getParameter("lessonId"));
                List<Lesson> lessons = ldao.getLessons();
                try ( PrintWriter out = response.getWriter()) {
//                    out.println("<option value='-1'>Select Chapter</option>");
                    for (Lesson lesson : lessons) {
                        out.println("<option value='" + lesson.getLessonId() + "'>" + lesson.getLessonName() + "</option>");
                    }
                }
            case "get-dimension":
                subjectId = Integer.parseInt(request.getParameter("subjectId"));
                List<Dimension> dimensions = ddao.getDimensionBySubject(subjectId, user.getUserId());
                try ( PrintWriter out = response.getWriter()) {
//                    out.println("<option value='-1'>Select Chapter</option>");
                    for (Dimension dimension : dimensions) {
                        out.println("<option value='" + dimension.getDimensionId() + "'>" + dimension.getDimensionName() + "</option>");
                    }
                }
                break;

            case "add":
                String title = request.getParameter("title");
                Boolean status = request.getParameter("statusrb").equals("1") ? true : false;
                String link = request.getParameter("link");
                String description = request.getParameter("description");
                int chapterId = Integer.parseInt(request.getParameter("chapter"));
                int dimensionId = Integer.parseInt(request.getParameter("dimension"));
                lessonId = Integer.parseInt(request.getParameter("lesson"));
                subjectId = Integer.parseInt(request.getParameter("subject"));
                System.out.println(dimensionId);
                String isSuccess = "fail";
                if (!new Validation().isColliedQuestion(title, chapterId)) {
                    isSuccess = "success";
                    qdao.addQuestion(title, link, description, status, dimensionId, lessonId, chapterId, subjectId, user.getUserId());

                    //Send response to front-end
                }
                try ( PrintWriter out = response.getWriter()) {
                    out.print(isSuccess);
                }
                break;
            case "delete":
                questionId = Integer.parseInt(request.getParameter("question"));
                qdao.deleteQuestion(questionId);
                request.getSession().setAttribute("isDeleteSuccess", true);
                response.sendRedirect("question-list?action=view");
                break;
            default:
                throw new AssertionError();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String action = request.getParameter("action");
        QuestionDAO qdao = new QuestionDAO();
        LessonDAO ldao = new LessonDAO();
        SubjectDAO sdao = new SubjectDAO();
        ChapterDAO cdao = new ChapterDAO();
        DimensionDAO ddao = new DimensionDAO();
        int status, subjectId, chapterId;
        int dimensionId, lessonId;
        switch (action) {
            case "view":
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
                if (request.getParameter("dimension") == null) {
                    dimensionId = -1;
                } else {
                    dimensionId = Integer.parseInt(request.getParameter("dimension"));
                }
                if (request.getParameter("lesson") == null) {
                    lessonId = -1;
                } else {
                    lessonId = Integer.parseInt(request.getParameter("lesson"));
                }
                if (request.getParameter("chapter") == null) {
                    chapterId = -1;
                } else {
                    chapterId = Integer.parseInt(request.getParameter("chapter"));
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

                List<Question> questionsTemp = qdao.getAllQuestions(user.getUserId(), chapterId, subjectId, dimensionId, lessonId, status, keyword);
                List<Question> questions = qdao.paginateQuestion(questionsTemp, page, 5);
                List<Lesson> lessons = ldao.getLessons();
                List<Subject> subjects = sdao.getAllSubjects(user.getUserId());
                List<Chapter> chapters = cdao.getChapterBySubject(subjectId, user.getUserId());
                List<Dimension> dimensions = ddao.getDimensionBySubject(subjectId, user.getUserId());

                int noOfPages = (int) Math.ceil(questionsTemp.size() * 1.0 / 5);

                //Properties saved for filter search
                request.setAttribute("statusSaved", status);
                request.setAttribute("subjectIdSaved", subjectId);
                request.setAttribute("chapterIdSaved", chapterId);
                request.setAttribute("keywordSaved", keyword);
                request.setAttribute("lessonIdSaved", lessonId);
                request.setAttribute("dimensionIdSaved", dimensionId);

                //Properties for pagination
                request.setAttribute("noOfPages", noOfPages);
                request.setAttribute("currentPage", page);

                //Properties for viewing list
                request.setAttribute("questions", questions);
                request.setAttribute("lessons", lessons);
                request.setAttribute("subjects", subjects);
                request.setAttribute("chapters", chapters);
                request.setAttribute("dimensions", dimensions);
                request.getRequestDispatcher("view/manager/question/question-list.jsp").forward(request, response);

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
                if (request.getParameter("dimension") == null) {
                    dimensionId = -1;
                } else {
                    dimensionId = Integer.parseInt(request.getParameter("dimension"));
                }
                if (request.getParameter("lesson") == null) {
                    lessonId = -1;
                } else {
                    lessonId = Integer.parseInt(request.getParameter("lesson"));
                }

                subjects = sdao.getAllSubjects(user.getUserId());
                chapters = cdao.getChapterBySubject(subjectId, user.getUserId());
                dimensions = ddao.getDimensionBySubject(subjectId, user.getUserId());
                lessons = ldao.getLessons();
                request.setAttribute("subjectIdSaved", subjectId);
                request.setAttribute("chapterIdSaved", chapterId);
                request.setAttribute("dimensionIdSaved", dimensionId);
                request.setAttribute("lessonIdSaved", lessonId);
                request.setAttribute("subjects", subjects);
                request.setAttribute("chapters", chapters);
                request.setAttribute("dimensions", dimensions);
                request.setAttribute("lessons", lessons);
                request.getRequestDispatcher("view/manager/question/new-question.jsp").forward(request, response);
                break;

            case "update":
                Question question = qdao.getQuestionById(Integer.parseInt(request.getParameter("id")));
                subjects = sdao.getAllSubjects(user.getUserId());
                System.out.println(question);
                request.setAttribute("question", question);
                request.setAttribute("subjects", subjects);
                request.getRequestDispatcher("view/manager/question/question-details.jsp").forward(request, response);
                break;
            default:
                break;

        }
    }
}
