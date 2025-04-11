/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin;

import controller.auth.BasedRequiredAdminAuthenticationController;
import dal.SubjectDAO;
import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

/**
 *
 * @author win
 */
@WebServlet(name="admin_dashboard", urlPatterns={"/admin-dashboard"})
public class AdminDashboardServlet extends BasedRequiredAdminAuthenticationController {
    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        UserDAO udao = new UserDAO();
        SubjectDAO sdao = new SubjectDAO();
        req.setAttribute("userCount", udao.countUser());
        req.setAttribute("subjectCount", sdao.countSubject());
        req.getRequestDispatcher("view/admin/dashboard.jsp").forward(req, resp);
    }

}
