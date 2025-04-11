/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import controller.auth.BasedRequiredAdminAuthenticationController;
import dal.SettingDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.List;
import model.Setting;
import model.User;
import utils.Validation;


/**
 *
 * @author minhf
 */
@WebServlet(name = "system_setting", urlPatterns = {"/system-setting"})
public class SystemSettingServlet extends BasedRequiredAdminAuthenticationController {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String action = request.getParameter("action");
        SettingDAO sdao = new SettingDAO();
        Validation valid = new Validation();
        switch (action) {
            case "update":
                int settingId = Integer.parseInt(request.getParameter("id"));
                String settingName = request.getParameter("settingName");
                String settingGroup = request.getParameter("settingGroup");
                String settingValue = request.getParameter("settingValue");
                int status = Integer.parseInt(request.getParameter("statusrb"));
                String description = request.getParameter("description");
                sdao.updateSetting(settingGroup, settingName, settingValue, description, status, settingId);
                request.getSession().setAttribute("isUpdateSuccess", true);
                response.sendRedirect("system-setting?action=view");
                break;
            case "add":
                String msg = "success";
                settingGroup = request.getParameter("settingGroup");
                settingName = request.getParameter("settingName");
                settingValue = request.getParameter("settingValue");
                description = request.getParameter("description");
                status = Integer.parseInt(request.getParameter("statusrb"));
                if (valid.isColliedSetting(settingName)) {
                    msg = "duplicated";
                } else {
                    sdao.addSetting(settingGroup, settingName, settingValue, description, status);
                    request.getSession().setAttribute("isAddSuccess", true);
                }
                try ( PrintWriter out = response.getWriter()) {
                    out.print(msg);
                }
                break;
            default:
                response.sendRedirect("view/general/error404.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        int status, settingId;
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
                    if (request.getParameter("settingId") == null) {
                        settingId = -1;
                    } else {
                        settingId = Integer.parseInt(request.getParameter("settingId"));
                    }
                    String sortField = request.getParameter("field");
                    String sortOrder = request.getParameter("order");
                    List<Setting> settingsTemp = sdao.getSettings(
                            keyword,
                            status,
                            settingId);
                    int noOfPages = (int) Math.ceil(settingsTemp.size() * 1.0 / recordsPerPage);
                    settingsTemp = sdao.paginateRecords(settingsTemp, page, 5);
                    List<Setting> settings = sdao.sortSettings(settingsTemp, sortField, sortOrder);
                    request.setAttribute("statusSaved", status);
                    request.setAttribute("settingIdSaved", settingId);
                    request.setAttribute("noOfPages", noOfPages);
                    request.setAttribute("currentPage", page);
                    request.setAttribute("keywordSaved", keyword);
                    request.setAttribute("settings", settings);
                    request.getRequestDispatcher("view/admin/system-setting.jsp").forward(request, response);
                    break;
                case "update":
                    settingId = Integer.parseInt(request.getParameter("id"));
                    request.setAttribute("setting", sdao.getSettingById(settingId));
                    request.getRequestDispatcher("view/admin/system-detail.jsp").forward(request, response);
                    break;
                default:
                    response.sendRedirect("view/general/error404.jsp");
            }
        } catch (NumberFormatException e) {
            System.out.println(e);
        }
    }
}
