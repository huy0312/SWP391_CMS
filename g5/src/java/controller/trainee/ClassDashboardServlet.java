/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.trainee;

import controller.auth.BasedRequiredAuthenticationController;
import dal.ChapterDAO;
import dal.ClassDAO;
import dal.LessonDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Chapter;
import model.User;
import model.Class;
import model.Lesson;

/**
 *
 * @author win
 */
@WebServlet(name = "ClassDashboardServlet", urlPatterns = {"/class-dashboard"})
public class ClassDashboardServlet extends BasedRequiredAuthenticationController {

    LessonDAO ldao = new LessonDAO();
    ChapterDAO ctdao = new ChapterDAO();
    UserDAO udao = new UserDAO();
    ClassDAO cdao = new ClassDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        int chapterId;
        int classId = Integer.parseInt(request.getParameter("cid"));
        Class c = cdao.getClassById(classId);
        if (request.getParameter("ctid") == null) {
            chapterId = ctdao.getFirstChapterId(c.getSubject().getSubjectId());
        } else {
            chapterId = Integer.parseInt(request.getParameter("ctid"));
        }
        List<Lesson> lessons = ldao.getLessonsByChapter(chapterId);
        request.setAttribute("lessons", lessons);
        request.setAttribute("isTrainer", user.getRole().getSettingName().equals("Trainer"));
        request.setAttribute("lessonsCount", lessons.size());
        request.setAttribute("chapter", ctdao.getChapterById(chapterId));
        request.setAttribute("c", c);
        request.setAttribute("userId", user.getUserId());
        request.setAttribute("manager", udao.getUserById(c.getCreatedBy()));
        request.getRequestDispatcher("view/trainee/class-dashboard.jsp").forward(request, response);
    }

}
