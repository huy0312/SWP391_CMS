/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.trainee;

import controller.auth.BasedRequiredAuthenticationController;
import dal.ClassDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.User;
import model.Class;

/**
 *
 * @author win
 */
public class HomePageServlet extends BasedRequiredAuthenticationController {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        ClassDAO cdao = new ClassDAO();
        int page = 1;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }
        List<Class> classesTemp = null;
        if (user.getRole().getSettingId() == 3) {
            classesTemp = cdao.getClassesByTrainer(user.getUserId());
        } else if (user.getRole().getSettingId() == 4) {
            classesTemp = cdao.getClassesByStudent(user.getUserId());
        }
        int noOfPages = (int) Math.ceil(classesTemp.size() * 1.0 / 10);
        List<Class> classes = cdao.paginateClassCatalog(classesTemp, page, 10);
        request.setAttribute("classes", classes);
        request.setAttribute("studentId", user.getUserId());
        //Properties for pagination
        request.setAttribute("noOfPages", noOfPages);
        request.setAttribute("currentPage", page);
        request.getRequestDispatcher("view/trainee/home.jsp").forward(request, response);
    }
}
