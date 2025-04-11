/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import controller.auth.BasedRequiredManagerAuthenticationController;
import dal.DimensionDAO;
import dal.SubjectDAO;
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
import model.User;
import model.Dimension;
import model.Subject;
import utils.Validation;

/**
 *
 * @author minhf
 */
@WebServlet(name = "DimensionListServlet", urlPatterns = {"/dimension-list"})
public class DimensionListServlet extends BasedRequiredManagerAuthenticationController {

    Validation valid = new Validation();
    DimensionDAO cdao = new DimensionDAO();
    SubjectDAO sdao = new SubjectDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "update":
                int dimensionId = Integer.parseInt(request.getParameter("dimensionId"));
                Boolean newStatus = Boolean.parseBoolean(request.getParameter("status"));
                new DimensionDAO().updateDimensionStatus(dimensionId, newStatus, user.getUserId());
                try ( PrintWriter out = response.getWriter()) {
                    out.print("success");
                }
                break;
            case "add":
                String dimensionType = request.getParameter("dimensionType");
                String dimensionName = request.getParameter("dimensionName");
                String description = request.getParameter("description");
                int subjectId = Integer.parseInt(request.getParameter("subjectId"));
                try {
                    if (!valid.isColliedDimension(dimensionType, dimensionName)) {
                        cdao.addDimension(dimensionType, dimensionName, description, subjectId);
                        try ( PrintWriter out = response.getWriter()) {
                            out.print("success");
                        }
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(DimensionListServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            default:
                throw new AssertionError();

        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "view":
                int status,
                 subjectId;
                if (request.getParameter("status") == null) {
                    status = -1;
                } else {
                    status = Integer.parseInt(request.getParameter("status"));
                }
                if (request.getParameter("subject") == null) {
                    subjectId = -1;
                } else {
                    subjectId = Integer.parseInt(request.getParameter("subject"));
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
                List<Dimension> dimensionTemp;
                dimensionTemp = cdao.getAllDimension(user.getUserId(), subjectId, status, keyword, keyword);
                List<Dimension> dimension = cdao.paginateDimension(dimensionTemp, page, 5);
                List<Subject> subjects = sdao.getAllSubjects(user.getUserId());

                int noOfPages = (int) Math.ceil(dimensionTemp.size() * 1.0 / 5);
                //Properties saved for filter search
                request.setAttribute("statusSaved", status);
                request.setAttribute("subjectIdSaved", subjectId);

                request.setAttribute("keywordSaved", keyword);
                request.setAttribute("subjects", subjects);

                //Properties for pagination
                request.setAttribute("noOfPages", noOfPages);
                request.setAttribute("currentPage", page);

                //Properties for viewing list
                request.setAttribute("dimension", dimension);
                request.getRequestDispatcher("view/manager/subjectsetting/dimension-list.jsp").forward(request, response);
                break;
            case "add":
                if (request.getParameter("status") == null) {
                    status = -1;
                } else {
                    status = Integer.parseInt(request.getParameter("status"));
                }
                if (request.getParameter("subject") == null) {
                    subjectId = -1;
                } else {
                    subjectId = Integer.parseInt(request.getParameter("subject"));
                }
                subjects = sdao.getAllSubjects(user.getUserId());
                request.setAttribute("subjectIdSaved", subjectId);
                request.setAttribute("subjects", subjects);
                request.getRequestDispatcher("view/manager/subjectsetting/add-dimension.jsp").forward(request, response);
                break;
        }
    }

}
