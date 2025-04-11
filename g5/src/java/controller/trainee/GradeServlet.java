/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.trainee;

import controller.auth.BasedRequiredAuthenticationController;
import dal.ChapterDAO;
import dal.ClassDAO;
import dal.GradeDAO;
import dal.LessonDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Grade;
import model.User;

/**
 *
 * @author win
 */
@WebServlet(name = "GradeServlet", urlPatterns = {"/grade"})
public class GradeServlet extends BasedRequiredAuthenticationController {

    ChapterDAO ctdao = new ChapterDAO();
    LessonDAO ldao = new LessonDAO();
    GradeDAO gdao = new GradeDAO();
    ClassDAO cdao = new ClassDAO();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        int type;
        int chapterId = Integer.parseInt(request.getParameter("ctid"));
        int classId = Integer.parseInt(request.getParameter("cid"));
        String keyword = request.getParameter("keyword");
        if (keyword == null) {
            keyword = "";
        }
        if (request.getParameter("type") == null) {
            type = 0;
        } else {
            type = Integer.parseInt(request.getParameter("type"));
        }
        //Pagination
        int page = 1;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        List<Grade> gradesTemp = gdao.getAllGrades(user.getUserId(), classId, type, keyword);
        int noOfPages = (int) Math.ceil(gradesTemp.size() * 1.0 / 5);
        gradesTemp = gdao.paginateGrade(gradesTemp, page, 5);
        // Sorting parameters
        String sortField = request.getParameter("field");
        String sortOrder = request.getParameter("order");
        List<Grade> sortedGrades = gdao.sortGrade(gradesTemp, sortField, sortOrder);
        //Properties for pagination
        request.setAttribute("noOfPages", noOfPages);
        request.setAttribute("currentPage", page);

        request.setAttribute("grades", sortedGrades);
        request.setAttribute("keywordSaved", keyword);
        request.setAttribute("typeSaved", type);
        request.setAttribute("chapter", ctdao.getChapterById(chapterId));
        request.setAttribute("c", cdao.getClassById(classId));
        request.getRequestDispatcher("view/trainee/grade.jsp").forward(request, response);
    }

}
