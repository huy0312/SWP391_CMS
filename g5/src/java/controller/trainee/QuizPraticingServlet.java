/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.trainee;

import controller.auth.BasedRequiredAuthenticationController;
import dal.AnswerDAO;
import dal.GradeDAO;
import dal.QuestionDAO;
import dal.QuizDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import model.Grade;
import model.Question;
import model.Quiz;
import model.User;

/**
 *
 * @author Admin
 */
@WebServlet(name = "QuizPraticing", urlPatterns = {"/quiz-practicing"})
public class QuizPraticingServlet extends BasedRequiredAuthenticationController {

    AnswerDAO adao = new AnswerDAO();
    QuestionDAO qtdao = new QuestionDAO();
    QuizDAO qdao = new QuizDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        GradeDAO gdao = new GradeDAO();
        int quizId = Integer.parseInt(request.getParameter("quizId"));
        int classId = Integer.parseInt(request.getParameter("classId"));
        Quiz quiz = new QuizDAO().getQuizById(quizId);
        List<String> selectedAnswerIds = new ArrayList<>();
        Map<String, String[]> parameterMap = request.getParameterMap();

        for (Map.Entry<String, String[]> entry : parameterMap.entrySet()) {
            String paramName = entry.getKey();
            String[] paramValues = entry.getValue();

            // Check if parameter belongs to an answer (based on the name pattern "answer_${questionId}")
            if (paramName.startsWith("answer_")) {
                selectedAnswerIds.addAll(Arrays.asList(paramValues));
            }
        }
        // Compare the selected answer IDs with the correct answer IDs for each question
        // Assuming you have a method getCorrectAnswerIdByQuestion(questionId) to retrieve correct answers
        int noQuestion = qtdao.countQuestionInQuiz(quizId);
        double gradePerQuestion = 10.0 / noQuestion;
        float grade = (float) 0.0;
        for (String questionId : getDistinctQuestionIds(request)) {
            List<String> correctAnswerIds = adao.getCorrectAnswerIdByQuestion(Integer.parseInt(questionId));
            List<String> selectedAnswersForQuestion = adao.getSelectedAnswersForQuestion(selectedAnswerIds, questionId);
            if (correctAnswerIds.containsAll(selectedAnswersForQuestion)
                    && selectedAnswersForQuestion.containsAll(correctAnswerIds)) {
                grade += gradePerQuestion;
            }
        }
        if (gdao.checkedQuiz(quizId, user.getUserId())) {
                    gdao.updateAttemptGradeQuiz(grade,quizId, user.getUserId());
                } else {
                    gdao.addGradeQuiz("Grade for " + quiz.getQuizName(), 1, grade, user.getUserId(), quizId, user.getUserId(),1,classId);
                }
        Grade g = gdao.getGradeByQuiz(quizId, user.getUserId());
        System.out.println("Id"+g.getGradeId());
//        request.setAttribute("grade", grade);
        response.sendRedirect("quiz-grade?id="+g.getGradeId());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        int quizId = Integer.parseInt(request.getParameter("quizId"));
        int classId = Integer.parseInt(request.getParameter("clid"));
        int page = 1;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }
        List<Question> quesTemp = qtdao.getQuestionListByQuiz(quizId);
//        List<Question> ques = qtdao.paginateQuestion(quesTemp, page, 1);
        Quiz quiz = qdao.getQuizById(quizId);
        int noOfPages = (int) Math.ceil(quesTemp.size() * 1.0 / 1);
        request.setAttribute("noOfPages", noOfPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("quizId", quizId);
        request.setAttribute("classId", classId);
        request.setAttribute("duration", quiz.getDuration());
        request.setAttribute("questions", quesTemp);
        request.setAttribute("quiz", qdao.getQuizById(quizId));
        request.getRequestDispatcher("view/trainee/quiz-practicing.jsp").forward(request, response);
    }

    // Utility method to get distinct question IDs from selected answers
    private List<String> getDistinctQuestionIds(HttpServletRequest request) {
        List<String> questionIds = new ArrayList<>();
        Map<String, String[]> parameterMap = request.getParameterMap();

        for (String paramName : parameterMap.keySet()) {
            if (paramName.startsWith("answer_")) {
                String questionId = paramName.substring("answer_".length());
                if (!questionIds.contains(questionId)) {
                    questionIds.add(questionId);
                }
            }
        }
        return questionIds;
    }

}
