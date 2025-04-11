/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.trainee;

import controller.auth.BasedRequiredAuthenticationController;
import dal.ClassDAO;
import dal.LessonDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Class;
import model.User;

/**
 *
 * @author win
 */
@WebServlet(name = "ClassCatalogServlet", urlPatterns = {"/class-catalog"})
public class ClassCatalogServlet extends BasedRequiredAuthenticationController {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        LessonDAO ldao = new LessonDAO();
        ClassDAO cdao = new ClassDAO();
        String action = request.getParameter("action");
        switch (action) {
            case "view":
                String keyword = request.getParameter("keyword");
                if (keyword == null) {
                    keyword = "";
                }

                //Pagination
                int page = 1;
                if (request.getParameter("page") != null) {
                    page = Integer.parseInt(request.getParameter("page"));
                }
                List<Class> classesTemp = cdao.getClassCatalog(keyword);
                int noOfPages = (int) Math.ceil(classesTemp.size() * 1.0 / 10);
                List<Class> classes = new ClassDAO().paginateClassCatalog(classesTemp, page, 10);
                request.setAttribute("classes", classes);
                request.setAttribute("keywordSaved", keyword);
                //Properties for pagination
                request.setAttribute("noOfPages", noOfPages);
                request.setAttribute("currentPage", page);
                request.getRequestDispatcher("view/trainee/class-catalog.jsp").forward(request, response);
                break;
            case "enrol": {
                int classId = Integer.parseInt(request.getParameter("cid"));
                cdao.enrolClass(classId, user.getUserId());
                response.sendRedirect("class-dashboard?action=view&cid=" + classId);
                break;
            }
            default:
                throw new AssertionError();
        }

    }

}
