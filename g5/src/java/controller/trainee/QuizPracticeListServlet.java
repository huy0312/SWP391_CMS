/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.trainee;

import controller.auth.BasedRequiredAuthenticationController;
import dal.ChapterDAO;
import dal.QuestionDAO;
import dal.QuizDAO;
import dal.SubjectDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Question;
import model.Quiz;
import model.User;
import utils.Validation;

/**
 *
 * @author Admin
 */
@WebServlet(name = "QuizPracticeListServlet", urlPatterns = {"/quiz-practice"})
public class QuizPracticeListServlet extends BasedRequiredAuthenticationController {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String action = request.getParameter("action");
        QuizDAO qdao = new QuizDAO();
        switch (action) {
            case "add":
                String title = request.getParameter("title");
                Boolean status = request.getParameter("statusrb").equals("1") ? true : false;
                String content = request.getParameter("content");
                int type = 6;
                int subjectId = Integer.parseInt(request.getParameter("sid"));
                int chapterId = Integer.parseInt(request.getParameter("cid"));
                int noQues = Integer.parseInt(request.getParameter("noQues"));
                int duration = Integer.parseInt(request.getParameter("duration"));
                String isSuccess = "fail";
                if (!new Validation().isColliedQuizTitle(title, subjectId, chapterId)) {
                    isSuccess = "success";
                    qdao.addExtraQuiz(title, content, status, subjectId, user.getUserId(), type, duration);
                    int quizId = qdao.getLargestQuizId();
                    qdao.addExtraQuizConfig(quizId, noQues, chapterId, user.getUserId());
                    //Send response to front-end
                    qdao.addQuizListQuestionRandom(quizId, user.getUserId(), noQues);
                }
                try ( PrintWriter out = response.getWriter()) {
                    out.print(isSuccess);
                }

                request.getSession().setAttribute("isAddSuccess", true);
                break;
            case "update":
                int quizId = Integer.parseInt(request.getParameter("id"));
                title = request.getParameter("title");
                status = request.getParameter("statusrb").equals("1") ? true : false;
                content = request.getParameter("content");
                noQues = Integer.parseInt(request.getParameter("noQues"));
                duration = Integer.parseInt(request.getParameter("duration"));
                qdao.updateExtraQuiz(quizId, title, content, status, user.getUserId(), duration);
                qdao.updateExtraQuizConfig(quizId, noQues, user.getUserId());
                qdao.deleteQuizListQuestion(quizId);
                qdao.addQuizListQuestionRandom(quizId, user.getUserId(), noQues);
                request.getSession().setAttribute("isUpdateSuccess", true);
                break;
            default:
                throw new AssertionError();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        QuizDAO qdao = new QuizDAO();
        ChapterDAO cdao = new ChapterDAO();
        SubjectDAO sdao = new SubjectDAO();
        QuestionDAO qtdao = new QuestionDAO();
        request.setAttribute("isTrainer", user.getRole().getSettingName().equals("Trainer"));
        String action = request.getParameter("action");
        int subjectId = Integer.parseInt(request.getParameter("sid"));
        int chapterId = Integer.parseInt(request.getParameter("cid"));
        int classId = Integer.parseInt(request.getParameter("clid"));
        switch (action) {
            case "view":
                String keyword = request.getParameter("keyword");
                if (keyword == null) {
                    keyword = "";
                }
                String sortField = request.getParameter("field");
                String sortOrder = request.getParameter("order");
                //Pagination
                int page = 1;
                if (request.getParameter("page") != null) {
                    page = Integer.parseInt(request.getParameter("page"));
                }
                List<Quiz> quizsTemp = qdao.getQuizBySubjectAndChapter(subjectId, chapterId, keyword);
                int noOfPages = (int) Math.ceil(quizsTemp.size() * 1.0 / 5);
                quizsTemp = qdao.paginateQuiz(quizsTemp, page, 5);
                List<Quiz> quizs = qdao.sortQuiz(quizsTemp, sortField, sortOrder);

                
                request.setAttribute("subjectId", subjectId);
                request.setAttribute("chapterId", chapterId);
                request.setAttribute("classId", classId);
                request.setAttribute("keywordSaved", keyword);

                request.setAttribute("subject", sdao.getSubjectById(subjectId));
                request.setAttribute("chapter", cdao.getChapterById(chapterId));

                request.setAttribute("noOfPages", noOfPages);
                request.setAttribute("currentPage", page);

                request.setAttribute("quizs", quizs);
                request.getRequestDispatcher("view/trainee/quiz-practice.jsp").forward(request, response);
                break;
            case "add":
                request.setAttribute("subjectId", subjectId);
                request.setAttribute("chapterId", chapterId);
                request.setAttribute("classId", classId);
                request.getRequestDispatcher("view/trainee/extra-quiz-add.jsp").forward(request, response);
                break;
            case "update":
                int quizId = Integer.parseInt(request.getParameter("id"));
                System.out.println(quizId);
                Quiz quiz = qdao.getQuizById(quizId);
                int noQues = quiz.getNoQuiz();
                System.out.println("no:" + noQues);
                List<Question> quesList = qtdao.getQuestionListByQuiz(quizId);
                System.out.println(quesList);
                request.setAttribute("quiz", quiz);
                request.setAttribute("subjectId", subjectId);
                request.setAttribute("chapterId", chapterId);
                request.setAttribute("classId", classId);
                request.setAttribute("quesList", quesList);
                request.getRequestDispatcher("view/trainee/extra-quiz-details.jsp").forward(request, response);
        }
    }

}
