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
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Subject;
import model.User;
import utils.Validation;

/**
 *
 * @author minhf
 */
@WebServlet(name = "subject_list", urlPatterns = {"/subject-list"})
public class SubjectListServlet extends BasedRequiredAdminAuthenticationController {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException, SQLException {
//        SubjectDAO sdao = new SubjectDAO();
//        Validation valid = new Validation();
//        String action = request.getParameter("action");
//        try {
//            switch (action) {
//                case "view":
//                    String keyword = request.getParameter("keyword");
//                    if (keyword == null) {
//                        keyword = "";
//                    }
//                    int page = 1;
//                    int recordsPerPage = 5;
//                    if (request.getParameter("page") != null) {
//                        page = Integer.parseInt(request.getParameter("page"));
//                    }
//                    List<Subject> subjects = sdao.getSubjects((page - 1) * recordsPerPage,
//                            recordsPerPage,
//                            keyword);
//                    int noOfRecords = sdao.getNoOfRecords();
//                    int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);
//                    request.setAttribute("noOfPages", noOfPages);
//                    request.setAttribute("currentPage", page);
//                    request.setAttribute("keyword", keyword);
//                    request.setAttribute("subjects", subjects);
//                    request.getRequestDispatcher("view/admin/subject-list.jsp").forward(request, response);
//                    break;
//                case "add":
//                    String subjectCode = request.getParameter("subjectCode");
//                    String subjectName = request.getParameter("subjectName");
//                    int managerId = Integer.parseInt(request.getParameter("managerId"));
//                    String subjectDescription = request.getParameter("description");
//                    if (!valid.isColliedSubject(subjectCode, subjectName, managerId, true, true)) {
//                        sdao.addSubject(subjectCode, subjectName, managerId, subjectDescription);
//                        request.setAttribute("isAddSucceed", true);
//                    } else {
//                        request.setAttribute("isAddSucceed", false);
//                    }
//                    request.getRequestDispatcher("subject-list?action=view").forward(request, response);
//                    break;
//                case "update":
//                    int subjectId = Integer.parseInt(request.getParameter("subjectId"));
//                    subjectCode = request.getParameter("subjectCode");
//                    subjectName = request.getParameter("subjectName");
//                    managerId = Integer.parseInt(request.getParameter("managerId"));
//                    int status = Integer.parseInt(request.getParameter("status"));
//                    subjectDescription = request.getParameter("description");
//                    if (!valid.isColliedSubject(subjectCode, subjectName, managerId, false, (status == 1))) {
//                        sdao.updateSubject(subjectId, subjectCode, subjectName, managerId, status, subjectDescription);
//                        request.setAttribute("isUpdateSucceed", true);
//                    } else {
//                        request.setAttribute("isUpdateSucceed", false);
//                    }
//                    request.getRequestDispatcher("subject-list?action=view").forward(request, response);
//                    break;
//                case "delete":
//                    subjectId = Integer.parseInt(request.getParameter("subjectId"));
//                    sdao.deleteSubject(subjectId);
//                    response.sendRedirect("subject-list?action=view");
//                    break;
//                default:
//                    throw new AssertionError();
//
//            }
//        } catch (NumberFormatException e) {
//            System.out.println(e);
//        }
//    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String action = request.getParameter("action");
        Validation valid = new Validation();

        SubjectDAO sdao = new SubjectDAO();
        switch (action) {
            case "update":
//                  int subjectId = Integer.parseInt(request.getParameter("subjectId"));
//                    subjectCode = request.getParameter("subjectCode");
//                    subjectName = request.getParameter("subjectName");
//                    managerId = Integer.parseInt(request.getParameter("managerId"));
//                    int status = Integer.parseInt(request.getParameter("status"));
//                    subjectDescription = request.getParameter("description");
//                    if (!valid.isColliedSubject(subjectCode, subjectName, managerId, false, (status == 1))) {
//                        sdao.updateSubject(subjectId, subjectCode, subjectName, managerId, status, subjectDescription);
//                        request.setAttribute("isUpdateSucceed", true);
//                    } else {
//                        request.setAttribute("isUpdateSucceed", false);
//                    }
//                    request.getRequestDispatcher("subject-list?action=view").forward(request, response);
//                    break;
                int subjectId = Integer.parseInt(request.getParameter("subjectId"));
                String subjectCode = request.getParameter("subjectCode");
                String subjectName = request.getParameter("subjectName");
                int managerId = Integer.parseInt(request.getParameter("managerId"));
                String subjectDescription = request.getParameter("description");
                sdao.updateSubject(subjectId, subjectCode, subjectName, managerId, subjectDescription);
                request.getSession().setAttribute("isUpdateSuccess", true);
                response.sendRedirect("subject-list?action=view");
                break;
            case "updateStatus":
                subjectId = Integer.parseInt(request.getParameter("subjectId"));
                Boolean newStatus = Boolean.parseBoolean(request.getParameter("status"));
                sdao.updateSubjectStatus(subjectId, newStatus);
                try ( PrintWriter out = response.getWriter()) {
                    out.print("success");
                }
                request.getSession().setAttribute("isUpdateStatusSuccess", true);
                break;
            case "add":
                subjectCode = request.getParameter("subjectCode");
                subjectName = request.getParameter("subjectName");
                managerId = Integer.parseInt(request.getParameter("managerId"));
                subjectDescription = request.getParameter("description");
                if (!valid.isColliedSubject(subjectCode, subjectName, managerId, true, true)) {
                    sdao.addSubject(subjectCode, subjectName, managerId, subjectDescription);
                    try ( PrintWriter out = response.getWriter()) {
                        out.print("success");
                    }
                }
                request.getSession().setAttribute("i sAddSuccess", true);
                break;

            default:
                response.sendRedirect("view/general/error404.jsp");
        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        UserDAO udao = new UserDAO();
        SubjectDAO sdao = new SubjectDAO();
        String action = request.getParameter("action");
        switch (action) {
            case "view":
                int status;
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
                List<Subject> subjectTemp;
                subjectTemp = sdao.getSubjects(user.getUserId(), status, keyword);
                List<Subject> subjects = sdao.sortSubjects(subjectTemp, sortField, sortOrder); 
                List<Subject> subject = sdao.paginateRecords(subjectTemp, page, 5);
//                List<Subject> subjects = sdao.getAllSubjects(user.getUserId());
                int noOfPages = (int) Math.ceil(subjectTemp.size() * 1.0 / 5);
                request.setAttribute("statusSaved", status);
                request.setAttribute("keywordSaved", keyword);
                request.setAttribute("subject", subject);
                request.setAttribute("noOfPages", noOfPages);
                request.setAttribute("currentPage", page);

                request.getRequestDispatcher("view/admin/subject-list.jsp").forward(request, response);
                break;
            case "add":
                if (request.getParameter("status") == null) {
                    status = -1;
                } else {
                    status = Integer.parseInt(request.getParameter("status"));
                }
                List<User> users = udao.getManegerList();
                System.out.println(users);
                request.setAttribute("statusSaved", status);
                request.setAttribute("users", users);
                request.getRequestDispatcher("view/components/admin/subject/add-subject.jsp").forward(request, response);
                break;
            case "update":
                int subjectId = Integer.parseInt(request.getParameter("subjectId"));
                Subject sub = sdao.getSubjectById(subjectId);
                users = udao.getManegerList();

                request.setAttribute("users", users);
                request.setAttribute("sub", sub);
                request.getRequestDispatcher("view/components/admin/subject/edit-subject.jsp").forward(request, response);
                break;
            default:
                response.sendRedirect("view/general/error404.jsp");
        }
    }

}
