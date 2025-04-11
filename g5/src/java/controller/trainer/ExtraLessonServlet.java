/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.trainer;

import controller.auth.BasedRequiredTrainerAuthenticationController;
import dal.ChapterDAO;
import dal.ClassDAO;
import dal.LessonDAO;
import dal.QuizDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;
import model.Chapter;
import model.Lesson;
import model.Quiz;
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
@WebServlet(name = "ExtraLessonServlet", urlPatterns = {"/extra-lesson"})
public class ExtraLessonServlet extends BasedRequiredTrainerAuthenticationController {

    private static final long serialVersionUID = 1L;
    LessonDAO ldao = new LessonDAO();
    Utils utils = new Utils();
    ClassDAO cdao = new ClassDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "add":
                String title = request.getParameter("title");
                Boolean status = request.getParameter("statusrb").equals("1") ? true : false;
                String content = request.getParameter("content");
                String type = request.getParameter("type");
                int chapterId = Integer.parseInt(request.getParameter("ctid"));
                int displayOrder = Integer.parseInt(request.getParameter("order"));
                System.out.println(title + "\t" + status + "\t" + content + "\t" + type + "\t" + chapterId);
                String isSuccess = "fail";
                if (!new Validation().isColliedLesson(title, chapterId)) {
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
                int lessonId = Integer.parseInt(request.getParameter("lesson"));
                chapterId = Integer.parseInt(request.getParameter("ctid"));
                int classId = Integer.parseInt(request.getParameter("cid"));
                ldao.deleteLesson(lessonId);
                request.getSession().setAttribute("isDeleteSuccess", true);
                response.sendRedirect("extra-lesson?action=view&ctid=" + chapterId + "&cid=" + classId);
                break;
            case "update":
                lessonId = Integer.parseInt(request.getParameter("id"));
                title = request.getParameter("title");
                content = request.getParameter("content");
                status = request.getParameter("statusrb").equals("1") ? true : false;
                type = request.getParameter("type");
                displayOrder = Integer.parseInt(request.getParameter("order"));
                chapterId = Integer.parseInt(request.getParameter("ctid"));
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
                try ( PrintWriter out = response.getWriter()) {
                    out.print("success");
                }
                request.getSession().setAttribute("isUpdateSuccess", true);
                break;
            default:
                throw new AssertionError();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String action = request.getParameter("action");
        LessonDAO ldao = new LessonDAO();
        ChapterDAO ctdao = new ChapterDAO();
        QuizDAO qdao = new QuizDAO();
        Utils utils = new Utils();
        switch (action) {
            case "view":
                int status;
                int chapterId = Integer.parseInt(request.getParameter("ctid"));
                int classId = Integer.parseInt(request.getParameter("cid"));
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
                String sortField = request.getParameter("field");
                String sortOrder = request.getParameter("order");

                List<Lesson> lessonsTemp = ldao.getExtraLessons(
                        user.getUserId(),
                        chapterId,
                        status,
                        keyword);
                int noOfPages = (int) Math.ceil(lessonsTemp.size() * 1.0 / 5);

                lessonsTemp = ldao.paginateLesson(lessonsTemp, page, 5);
                List<Lesson> lessons = ldao.sortLesson(lessonsTemp, sortField, sortOrder);

                //Properties saved for filter search
                request.setAttribute("statusSaved", status);
                request.setAttribute("chapter", ctdao.getChapterById(chapterId));
                request.setAttribute("c", cdao.getClassById(classId));
                request.setAttribute("keywordSaved", keyword);
                //Properties for pagination
                request.setAttribute("noOfPages", noOfPages);
                request.setAttribute("currentPage", page);

                //Properties for viewing list
                request.setAttribute("lessons", lessons);
                request.getRequestDispatcher("view/trainer/extra-lesson/extra-lesson-list.jsp").forward(request, response);
                break;
            case "add":
                chapterId = Integer.parseInt(request.getParameter("ctid"));
                Chapter chapter = ctdao.getChapterById(chapterId);
                List<Quiz> quiz = qdao.getQuizBySubject(
                        chapter.getSubject().getSubjectId());
                classId = Integer.parseInt(request.getParameter("cid"));
                request.setAttribute("c", cdao.getClassById(classId));
                request.setAttribute("chapter", chapter);
                request.setAttribute("quiz", quiz);
                request.getRequestDispatcher("view/trainer/extra-lesson/new-extra-lesson.jsp").forward(request, response);
                break;
            case "update":
                Lesson lesson = ldao.getLessonById(Integer.parseInt(request.getParameter("lid")));
                chapterId = Integer.parseInt(request.getParameter("ctid"));
                chapter = ctdao.getChapterById(chapterId);
                quiz = qdao.getQuizBySubject(
                        chapter.getSubject().getSubjectId());
                classId = Integer.parseInt(request.getParameter("cid"));
                request.setAttribute("c", cdao.getClassById(classId));
                request.setAttribute("lesson", lesson);
                request.setAttribute("chapter", chapter);
                request.setAttribute("quiz", quiz);
                if (lesson.getAttachedFile() != null) {
                    request.setAttribute("fileName", utils.extractFileName(lesson.getAttachedFile()));
                }
                request.getRequestDispatcher("view/trainer/extra-lesson/extra-lesson-details.jsp").forward(request, response);
                break;
            default:
                throw new AssertionError();
        }
    }

}
