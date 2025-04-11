/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import controller.auth.BasedRequiredManagerAuthenticationController;
import dal.ChapterDAO;
import dal.LessonDAO;
import dal.QuizDAO;
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
import java.util.List;
import model.Chapter;
import model.Lesson;
import model.Quiz;
import model.Subject;
import model.User;
import utils.Utils;
import utils.Validation;

/**
 *
 * @author win
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 50, // 50MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
@WebServlet(name = "LessonListServlet", urlPatterns = {"/lesson-list"})
public class LessonListServlet extends BasedRequiredManagerAuthenticationController {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String action = request.getParameter("action");
        LessonDAO ldao = new LessonDAO();
        Utils utils = new Utils();
        ChapterDAO cdao = new ChapterDAO();
        switch (action) {
            case "update":
                int lessonId = Integer.parseInt(request.getParameter("id"));
                String title = request.getParameter("title");
                String content = request.getParameter("content");
                System.out.println(content);
                Boolean status = request.getParameter("statusrb").equals("1") ? true : false;
                String type = request.getParameter("type");
                int displayOrder = Integer.parseInt(request.getParameter("order"));
                int chapterId = Integer.parseInt(request.getParameter("chapter"));
                switch (type) {
                    case "1":
                        String videoLink = request.getParameter("videoLink");
                        ldao.updateLesson(title, videoLink, "", content, status, chapterId, user.getUserId(), -1, 1, displayOrder, lessonId);
                        break;
                    case "2":
                        int quizId = Integer.parseInt(request.getParameter("quiz"));
                        int duration = Integer.parseInt(request.getParameter("duration"));
                        ldao.updateLesson(title, "", "", content, status, chapterId, user.getUserId(), quizId, 2, displayOrder, lessonId);
                        new QuizDAO().updateQuizDuration(duration, quizId);
                        break;
                    case "3":
                        String fileName = request.getParameter("attachedFile");
                        String chapterFolder = "chapter" + chapterId; // Replace with your logic to determine the chapter folder
                        String uploadPath = getServletContext().getRealPath("view") + File.separator + "assets\\lessons\\assignments" + File.separator + chapterFolder;
                        File folder = new File(uploadPath);
                        if (!folder.exists()) {
                            folder.mkdirs();
                        }
                        String filePath = uploadPath + File.separator + fileName;
                        System.out.println(filePath);
                        try ( InputStream input = request
                                .getPart("attachedFile")
                                .getInputStream();  OutputStream output
                                = new FileOutputStream(filePath)) {
                            byte[] buffer = new byte[1024];
                            int bytesRead;
                            while ((bytesRead = input.read(buffer)) != -1) {
                                output.write(buffer, 0, bytesRead);
                            }
                        }
                        ldao.updateLessonWithAssignment(
                                title,
                                filePath,
                                content,
                                status,
                                chapterId,
                                user.getUserId(),
                                displayOrder,
                                lessonId);
                        break;
                    default:
                        throw new AssertionError();
                }
                request.getSession().setAttribute("isUpdateSuccess", true);
                break;
            case "get-chapter":
                int subjectId = Integer.parseInt(request.getParameter("subjectId"));
                List<Chapter> chapters = cdao.getChapterBySubject(subjectId, user.getUserId());
                try ( PrintWriter out = response.getWriter()) {
                    for (Chapter chapter : chapters) {
                        out.println("<option value='" + chapter.getChapterId() + "'>" + chapter.getChapterName() + "</option>");
                    }
                }
                break;
            case "get-quiz":
                subjectId = Integer.parseInt(request.getParameter("subjectId"));
                List<Quiz> quizzes = new QuizDAO().getQuizBySubject(subjectId);
                try ( PrintWriter out = response.getWriter()) {
                    for (Quiz quiz : quizzes) {
                        out.println("<option value='" + quiz.getQuizId() + "'>" + quiz.getQuizName() + "</option>");
                    }
                }
                break;

            case "add":
                title = request.getParameter("title");
                status = request.getParameter("statusrb").equals("1") ? true : false;
                content = request.getParameter("content");
                type = request.getParameter("type");
                chapterId = Integer.parseInt(request.getParameter("chapter"));
                subjectId = Integer.parseInt(request.getParameter("subject"));
                displayOrder = Integer.parseInt(request.getParameter("order"));
                String isSuccess = "fail";
                if (!new Validation().isColliedLesson(title, chapterId)) {
                    isSuccess = "success";
                    switch (type) {
                        case "1":
                            String videoLink = request.getParameter("videoLink");
                            ldao.addLessonWithVideo(title, videoLink, content, status, chapterId, user.getUserId(), displayOrder);
                            break;
                        case "2":
                            int quizId = Integer.parseInt(request.getParameter("quiz"));
                            int duration = Integer.parseInt(request.getParameter("duration"));
                            ldao.addLessonWithQuiz(title, quizId, content, status, chapterId, user.getUserId(), displayOrder);
                            new QuizDAO().updateQuizDuration(duration, quizId);
                            break;
                        case "3":
                            String fileName = request.getParameter("attachedFile");
                            String chapterFolder = "chapter" + chapterId; // Replace with your logic to determine the chapter folder
                            String uploadPath = getServletContext().getRealPath("view") + File.separator + "assets\\lessons\\assignments" + File.separator + chapterFolder;
                            File folder = new File(uploadPath);
                            if (!folder.exists()) {
                                folder.mkdirs();
                            }
                            String filePath = uploadPath + File.separator + fileName;
                            try ( InputStream input = request.getPart("attachedFile").getInputStream();  OutputStream output = new FileOutputStream(filePath)) {
                                byte[] buffer = new byte[1024];
                                int bytesRead;
                                while ((bytesRead = input.read(buffer)) != -1) {
                                    output.write(buffer, 0, bytesRead);
                                }
                            }
                            ldao.addLessonWithAssignment(title, filePath, content, status, chapterId, user.getUserId(), displayOrder);
                            break;
                        default:
                            throw new AssertionError();
                    }
                    isSuccess = "success";
                    request.getSession().setAttribute("isAddSuccess", true);
                }
                //Send response to front-end
                try ( PrintWriter out = response.getWriter()) {
                    out.print(isSuccess);
                }
                break;
            case "delete":
                lessonId = Integer.parseInt(request.getParameter("lesson"));
                ldao.deleteLesson(lessonId);
                request.getSession().setAttribute("isDeleteSuccess", true);
                response.sendRedirect("lesson-list?action=view");
                break;
            default:
                throw new AssertionError();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        LessonDAO ldao = new LessonDAO();
        SubjectDAO sdao = new SubjectDAO();
        Utils utils = new Utils();
        ChapterDAO cdao = new ChapterDAO();
        String action = request.getParameter("action");
        switch (action) {
            case "view":
                int status,
                 subjectId,
                 chapterId;
                List<Subject> subjects = sdao.getAllSubjects(user.getUserId());
                if (request.getParameter("status") == null) {
                    status = -1;
                } else {
                    status = Integer.parseInt(request.getParameter("status"));
                }
                if (request.getParameter("subject") == null) {
                    subjectId = subjects.get(0).getSubjectId();
                } else {
                    subjectId = Integer.parseInt(request.getParameter("subject"));
                }
                List<Chapter> chapters = cdao.getChapterBySubject(subjectId, user.getUserId());
                if (request.getParameter("chapter") == null) {
                    chapterId = chapters.get(0).getChapterId();
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
                String sortField = request.getParameter("field");
                String sortOrder = request.getParameter("order");

                List<Lesson> lessonsTemp = ldao.getAllLessons(
                        user.getUserId(),
                        subjectId,
                        chapterId,
                        status,
                        keyword);
                int noOfPages = (int) Math.ceil(lessonsTemp.size() * 1.0 / 5);
                lessonsTemp = ldao.paginateLesson(lessonsTemp, page, 5);
                List<Lesson> lessons = ldao.sortLesson(lessonsTemp, sortField, sortOrder);

                //Properties saved for filter search
                request.setAttribute("statusSaved", status);
                request.setAttribute("subjectIdSaved", subjectId);
                request.setAttribute("chapterIdSaved", chapterId);
                request.setAttribute("keywordSaved", keyword);
                //Properties for pagination
                request.setAttribute("noOfPages", noOfPages);
                request.setAttribute("currentPage", page);

                //Properties for viewing list
                request.setAttribute("lessons", lessons);
                request.setAttribute("subjects", subjects);
                request.setAttribute("chapters", chapters);
                request.getRequestDispatcher("view/manager/lesson/lesson-list.jsp").forward(request, response);
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
                request.getRequestDispatcher("view/manager/lesson/new-lesson.jsp").forward(request, response);
                break;
            case "update":
                Lesson lesson = ldao.getLessonById(Integer.parseInt(request.getParameter("id")));
                subjects = sdao.getAllSubjects(user.getUserId());
                request.setAttribute("lesson", lesson);
                request.setAttribute("subjects", subjects);
                if (lesson.getAttachedFile() != null) {
                    request.setAttribute("fileName", utils.extractFileName(lesson.getAttachedFile()));
                }
                request.setAttribute("chapters", new ChapterDAO()
                        .getChapterBySubject(lesson.getChapter()
                                .getSubject()
                                .getSubjectId()));
                request.getRequestDispatcher("view/manager/lesson/lesson-details.jsp").forward(request, response);
                break;
            default:
                break;
        }
    }
}
