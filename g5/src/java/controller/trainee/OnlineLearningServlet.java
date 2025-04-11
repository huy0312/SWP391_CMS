/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.trainee;

import controller.auth.BasedRequiredAuthenticationController;
import dal.AnswerDAO;
import dal.ChapterDAO;
import dal.ClassDAO;
import dal.GradeDAO;
import dal.LessonDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.List;
import model.Chapter;
import model.Lesson;
import model.User;
import model.Class;
import model.Grade;
import utils.Utils;

/**
 *
 * @author win
 */
@WebServlet(name = "OnlineLearningServlet", urlPatterns = {"/online-learning"})
public class OnlineLearningServlet extends BasedRequiredAuthenticationController {

    LessonDAO ldao = new LessonDAO();
    ClassDAO cdao = new ClassDAO();
    GradeDAO gdao = new GradeDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "save-progress":
                Float videoPosition = Float.parseFloat(request.getParameter("videoProgress"));
                int lessonId = Integer.parseInt(request.getParameter("lessonId"));
                //Check if video progress exists or not
                if (ldao.getProgress(lessonId, user.getUserId())) {
                    ldao.updateVideoProgress(videoPosition, lessonId, user.getUserId());
                } else {
                    ldao.addVideoProgress(videoPosition, lessonId, user.getUserId());
                }
                break;

            default:
                response.sendRedirect("view/general/error404.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response,
            User user) throws ServletException, IOException {
        Utils utils = new Utils();
        String action = request.getParameter("action");
        switch (action) {
            case "learn":
                int subjectId = Integer.parseInt(request.getParameter("sid"));
                List<Chapter> chapters = new ChapterDAO().getChapterBySubject(subjectId);
                int chapterId = chapters.get(0).getChapterId();
                int lessonId = ldao.getLessonsByChapter(chapterId).get(0).getLessonId();

                if (request.getParameter("lid") != null) {
                    lessonId = Integer.parseInt(request.getParameter("lid"));
                }
                request.setAttribute("subjectId", subjectId);
                Lesson lesson = ldao.getLessonById(lessonId);
                request.setAttribute("lesson", lesson);
                switch (lesson.getLessonType()) {
                    case 1:
                        request.setAttribute("savedProgress", ldao.getVideoPosition(lessonId, user.getUserId()));
                        break;
                    case 2:
                        Grade g = gdao.getGradeByQuiz(
                                lesson.getQuiz().getQuizId(),
                                user.getUserId());
                        if(g != null) {
                            request.setAttribute("grade", g);
                        }
                        break;
                    case 3:
                        String path = lesson.getAttachedFile().replace("\\", "\\\\");
                        request.setAttribute("path", path);
                        request.setAttribute("fileName", utils.extractFileName(lesson.getAttachedFile()));
                        break;
                    default:
                        response.sendRedirect("view/general/error404.jsp");
                }
                Class c = cdao.getClassById(Integer.parseInt(request.getParameter("cid")));
                request.setAttribute("c", c);
                request.getRequestDispatcher("view/trainee/online-learning.jsp").forward(request, response);
                break;
            case "download-file":
                String filePath = request.getParameter("path");
                System.out.println("download:" + filePath);
                // Validate filePath if necessary
                File file = new File(filePath);

                if (file.exists()) {
                    response.setContentType("application/octet-stream");
                    response.setHeader("Content-Disposition", "attachment;filename=" + file.getName());
                    try ( FileInputStream fis = new FileInputStream(file);  BufferedInputStream bis = new BufferedInputStream(fis)) {
                        byte[] buffer = new byte[8192];
                        int bytesRead;
                        while ((bytesRead = bis.read(buffer, 0, 8192)) != -1) {
                            response.getOutputStream().write(buffer, 0, bytesRead);
                        }
                    }
                } else {
                    response.getWriter().write("File not found");
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                }
                break;
            default:
                response.sendRedirect("view/general/error404.jsp");
        }
    }
}
