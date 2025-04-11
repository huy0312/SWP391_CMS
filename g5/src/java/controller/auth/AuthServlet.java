/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.auth;

import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Random;
import model.User;
import utils.Utils;
import utils.Validation;

/**
 *
 * @author win
 */
@WebServlet(name = "AuthServlet", urlPatterns = {"/auth"})
public class AuthServlet extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        switch (request.getParameter("action")) {
            case "login":
                request.getRequestDispatcher("view/auth/login.jsp").forward(request, response);
                break;
            case "register":
                request.getRequestDispatcher("view/auth/register.jsp").forward(request, response);
                break;
            case "forgot-password":
                request.getRequestDispatcher("view/auth/forgot-password.jsp").forward(request, response);
                break;
            case "confirm":
                request.getRequestDispatcher("view/auth/otp-confirm.jsp").forward(request, response);
                break;
            case "reset-pass":
                request.getRequestDispatcher("view/auth/reset-password.jsp").forward(request, response);
                break;
            case "logout":
                HttpSession session = request.getSession();
                session.invalidate();
                request.getRequestDispatcher("auth?action=login").forward(request, response);
                break;
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO udao = new UserDAO();
        Utils utils = new Utils();
        switch (request.getParameter("action")) {
            case "login":
                User user = udao.checkLogin(request.getParameter("email"), request.getParameter("password"));
                if (user != null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("user", user);
                    if (user.getRole().getSettingId() == 1) {
                        response.sendRedirect("admin-dashboard");
                    } else if (user.getRole().getSettingId() == 2) {
                        response.sendRedirect("home");
                    } else if (user.getRole().getSettingId() == 3) {
                        response.sendRedirect("homepage");
                    } else if (user.getRole().getSettingId() == 4) {
                        response.sendRedirect("homepage");
                    }
                } else {
                    response.sendRedirect("auth?action=login&error=Invalid username or password.");
                }
                break;
            case "register":
                String password = request.getParameter("password");
                String rePassword = request.getParameter("rePassword");
                String fullName = request.getParameter("fullName");
                String email = request.getParameter("email");
                if (!password.equals(rePassword)) {
                    response.sendRedirect("auth?action=register&error=Password confirm is incorrect");
                } else {
                    if (new Validation().isColliedRegister(email)) {
                        response.sendRedirect("auth?action=register&error=Email has existed");
                    } else {
                        udao.addUser(fullName, password, email, null, 1);
                        response.sendRedirect("auth?action=login");
                    }
                }
                break;
            case "forgot-password":
                email = request.getParameter("email");
                if (new Validation().isColliedRegister(email)) {
                    int otpCode = new Random().nextInt(1255650);
                    // Set OTP code and expiration timestamp in the session
                    HttpSession session = request.getSession();
                    session.setAttribute("email", email);
                    session.setAttribute("otpCode", otpCode);
                    session.setAttribute("otpExpiration", System.currentTimeMillis() + (5 * 60 * 1000)); // Set to expire in 5 minutes
                    utils.sendEmail(email, "CMSLVL10: Verify your email", "OTP Code: " + otpCode);
                    request.getRequestDispatcher("view/auth/otp-confirm.jsp").forward(request, response);
                } else {
                    response.sendRedirect("auth?action=forgot-password&error=Email is wrong");
                }
                break;
            case "confirm":
                HttpSession session = request.getSession();
                String otpParam = request.getParameter("otp");
                email = request.getParameter("email");
                try {
                    int otp = Integer.parseInt(otpParam);
                    int storedOtp = (int) session.getAttribute("otpCode");
                    long otpExpiration = (long) session.getAttribute("otpExpiration");
                    // Check if the OTP has expired
                    if (System.currentTimeMillis() > otpExpiration) {
                        response.sendRedirect("auth?action=confirm&error=OTP has expired");
                    } else if (otp == storedOtp) {
                        response.sendRedirect("auth?action=reset-pass&email=" + email);
                    } else {
                        response.sendRedirect("auth?action=confirm&error=Wrong OTP Code");
                    }
                } catch (NumberFormatException e) {
                    // Handle the case where the input is not a valid integer (e.g., text)
                    response.sendRedirect("auth?action=confirm&error=Invalid OTP Format");
                }
                break;
            case "reset-pass":
                session = request.getSession();
                email = (String) session.getAttribute("email");
                password = request.getParameter("password");
                rePassword = request.getParameter("rePassword");
                if (!password.equals(rePassword)) {
                    response.sendRedirect("auth?action=reset-pass&error=Confirm password is incorrect");
                } else {
                    int user_id = udao.getUserIdByEmail(email);
                    udao.resetPassword(password, user_id);
                    response.sendRedirect("auth?action=login");
                }
                break;
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
