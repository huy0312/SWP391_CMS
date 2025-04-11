/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import controller.auth.BasedRequiredAdminAuthenticationController;
import dal.SettingDAO;
import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.List;
import model.Setting;
import model.User;
import utils.Utils;
import utils.Validation;

/**
 *
 * @author win
 */
@WebServlet(name = "user_list", urlPatterns = {"/user-list"})
public class UserListServlet extends BasedRequiredAdminAuthenticationController {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String action = request.getParameter("action");
        Validation valid = new Validation();
        Utils utils = new Utils();
        UserDAO udao = new UserDAO();
        switch (action) {
            case "update":
                int userId = Integer.parseInt(request.getParameter("id"));
                String fullName = request.getParameter("fullName");
                String email = request.getParameter("email");
                String mobile = request.getParameter("mobile");
                int roleId = Integer.parseInt(request.getParameter("role"));
                int status = Integer.parseInt(request.getParameter("statusrb"));
                String description = request.getParameter("description");
                udao.updateUser(fullName, email, mobile, status, roleId, userId, description);
                request.getSession().setAttribute("isUpdateSuccess", true);
                response.sendRedirect("user-list?action=view");
                break;
            case "add":
                String msg = "success";
                fullName = request.getParameter("fullName");
                email = request.getParameter("email");
                mobile = request.getParameter("mobile");
                status = Integer.parseInt(request.getParameter("statusrb"));
                if (valid.isColliedUser(email, mobile)) {
                    msg = "duplicated";
                } else {
                    String password = utils.generateRandomPassword(8);
                    utils.sendEmail(
                            email,
                            "Your new CMSLVL10 account",
                            "Email: " + email + "\n"
                            + "Mobile: " + mobile + "\n"
                            + "Password: " + password
                            + "\nYou can login into CMSLVL10 by either email or phone number."
                            + "\nThanks for choosing our services!");
                    udao.addUser(fullName, password, email, mobile, status);
                    request.getSession().setAttribute("isAddSuccess", true);
                }
                try ( PrintWriter out = response.getWriter()) {
                    out.print(msg);
                }
                break;
            case "updateStatus":
                userId = Integer.parseInt(request.getParameter("userId"));

                Boolean newStatus = Boolean.parseBoolean(request.getParameter("status"));
                udao.updateUserStatus(newStatus, userId);
                try ( PrintWriter out = response.getWriter()) {
                    out.print("success");
                }
                request.getSession().setAttribute("isUpdateStatusSuccess", true);
                break;
            default:
                response.sendRedirect("view/general/error404.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        int status, roleId;
        UserDAO udao = new UserDAO();
        SettingDAO sdao = new SettingDAO();
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
                    if (request.getParameter("status") == null) {
                        status = -1;
                    } else {
                        status = Integer.parseInt(request.getParameter("status"));
                    }

                    if (request.getParameter("role") == null) {
                        roleId = -1;
                    } else {
                        roleId = Integer.parseInt(request.getParameter("role"));
                    }
                    String sortField = request.getParameter("field");
                    String sortOrder = request.getParameter("order");
                    List<User> usersTemp = udao.getUsers(
                            keyword,
                            status,
                            roleId);
                    int noOfPages = (int) Math.ceil(usersTemp.size() * 1.0 / recordsPerPage);
                    usersTemp = udao.paginateRecords(usersTemp, page, 5);
                    List<User> users = udao.sortUsers(usersTemp, sortField, sortOrder);
                    request.setAttribute("statusSaved", status);
                    request.setAttribute("roleIdSaved", roleId);
                    request.setAttribute("roles", sdao.getSettingByRole());
                    request.setAttribute("users", users);
                    request.setAttribute("noOfPages", noOfPages);
                    request.setAttribute("currentPage", page);
                    request.setAttribute("keywordSaved", keyword);
                    request.getRequestDispatcher("view/admin/user-list.jsp").forward(request, response);
                    break;
                case "update":
                    int userId = Integer.parseInt(request.getParameter("id"));
                    List<Setting> roles = new SettingDAO().getSettingByRole();
                    request.setAttribute("user", udao.getUserById(userId));
                    request.setAttribute("roles", roles);
                    request.getRequestDispatcher("view/admin/user-details.jsp").forward(request, response);
                    break;
                default:
                    response.sendRedirect("view/general/error404.jsp");
            }
        } catch (NumberFormatException e) {
            System.out.println(e);
        }
    }
}
