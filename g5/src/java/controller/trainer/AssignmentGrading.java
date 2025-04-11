/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.trainer;

import controller.auth.BasedRequiredAuthenticationController;
import dal.AssignmentDAO;
import dal.SubmittedAssignmentDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Setting;
import model.SubmittedAssignment;
import model.User;
import utils.Validation;

/**
 *
 * @author win
 */
@WebServlet(name = "AssignmentGrading", urlPatterns = {"/assignment-grading"})
public class AssignmentGrading extends BasedRequiredAuthenticationController {

    AssignmentDAO adao = new AssignmentDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String action = request.getParameter("action");

        Validation valid = new Validation();
        switch (action) {
//            case "update":
//                int settingId = Integer.parseInt(request.getParameter("id"));               
//                String settingName = request.getParameter("settingName");
//                String settingGroup = request.getParameter("settingGroup");
//                String settingValue = request.getParameter("settingValue");
//                int status = Integer.parseInt(request.getParameter("statusrb"));
//                String description = request.getParameter("description");
//                sdao.updateSetting(settingGroup,settingName, settingValue, description, status, settingId);
//                request.getSession().setAttribute("isUpdateSuccess", true);
//                response.sendRedirect("system-setting?action=view");
//                break;
//            case "submit":
//                String msg = "success";
//                settingGroup = request.getParameter("settingGroup");
//                settingName = request.getParameter("settingName");
//                settingValue = request.getParameter("settingValue");
//                description = request.getParameter("description");
//                status = Integer.parseInt(request.getParameter("statusrb"));
//                if (valid.isColliedSetting(settingName)) {
//                    msg = "duplicated";
//                } else {
//                    sdao.addSetting(settingGroup, settingName, settingValue, description, status);
//                    request.getSession().setAttribute("isAddSuccess", true);
//                }
//                try ( PrintWriter out = response.getWriter()) {
//                    out.print(msg);
//                }
//                break;
            default:
                response.sendRedirect("view/general/error404.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        request.getRequestDispatcher("view/trainer/assignment-grading.jsp").forward(request, response);

        int assignmentId;
        SubmittedAssignmentDAO smdao = new SubmittedAssignmentDAO();
        String action = request.getParameter("action");
        try {
            switch (action) {
                case "view":
                    String keyword = request.getParameter("keyword");
                    int page = 1;
                    int recordsPerPage = 5;
                    if (keyword == null) {
                        keyword = "";
                    }
                    if (request.getParameter("page") != null) {
                        page = Integer.parseInt(request.getParameter("page"));
                    }
                    if (request.getParameter("assignmentId") == null) {
                        assignmentId = -1;
                    } else {
                        assignmentId = Integer.parseInt(request.getParameter("assignmentId"));
                    }
                    
                    String sortField = request.getParameter("field");
                    String sortOrder = request.getParameter("order");
                    List<SubmittedAssignment> smTemp = smdao.getSubmittedAssignments(
                            assignmentId
                    );
                    int noOfPages = (int) Math.ceil(smTemp.size() * 1.0 / recordsPerPage);
                    smTemp = smdao.paginateRecords(smTemp, page, 5);
                    List<SubmittedAssignment> sassignments = smdao.sortSubmittedAssignment(smTemp, sortField, sortOrder);
                    request.setAttribute("assignmentIdSaved", assignmentId);
                    request.setAttribute("noOfPages", noOfPages);
                    request.setAttribute("currentPage", page);
                    request.setAttribute("keywordSaved", keyword);
                    request.setAttribute("sassignments", sassignments);
                    request.getRequestDispatcher("view/trainer/assignment-grading.jsp").forward(request, response);
                    break;
//              
                default:
                    response.sendRedirect("view/general/error404.jsp");
            }
        } catch (NumberFormatException e) {
            System.out.println(e);
        }
    }

}
