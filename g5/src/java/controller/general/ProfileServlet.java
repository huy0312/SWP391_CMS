/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.general;

import dal.ProfileDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.regex.Pattern;
import model.User;

/**
 *
 * @author Admin
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 5 * 5)
@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
public class ProfileServlet extends HttpServlet {

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
        HttpSession session = request.getSession();
        ProfileDAO profileDAO = new ProfileDAO();
        User user = (User) session.getAttribute("user");
        request.setAttribute("user", user);

        User d = profileDAO.getOneUser(user.getUserId());
        session.setAttribute("imgU", d.getAvatarImg());
        session.setAttribute("user", d);
        request.getRequestDispatcher("view/general/profile.jsp").forward(request, response);
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

        String type = request.getParameter("type");
        User user = new User();
        ProfileDAO profileDAO = new ProfileDAO();
        int userId = Integer.parseInt(request.getParameter("userId"));
        switch (type) {
            case "changePhoto": {
                HttpSession session = request.getSession();
                String uploadDirectory = request.getServletContext().getRealPath("view");
                uploadDirectory = uploadDirectory + File.separator + "assets\\img\\profiles";
                Part filePart = request.getPart("file");
                System.out.println(filePart);
                String image = getFileName(filePart);

                if (!image.equals("")) {

                    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("HHmmyyyyMMdd");
                    LocalDateTime now = LocalDateTime.now();
                    String timenow = dtf.format(now);

                    String filePath = uploadDirectory + File.separator + timenow + ".png";
                    File file = new File(filePath);

                    OutputStream out = null;
                    InputStream fileContent = null;
                    final PrintWriter writer = response.getWriter();

                    try {
                        out = new FileOutputStream(file);
                        fileContent = filePart.getInputStream();

                        int read;
                        final byte[] bytes = new byte[1024];

                        while ((read = fileContent.read(bytes)) != -1) {
                            out.write(bytes, 0, read);
                        }
                        String avatarFileName = "view/assets/img/profiles/" + timenow + ".png";

                        System.out.println(avatarFileName);
                        System.out.println(userId);
                        user.setAvatarImg(avatarFileName);
                        request.setAttribute("userCur", user);
                        profileDAO.changePhoto(userId, avatarFileName);

                        response.sendRedirect("profile");

                    } catch (FileNotFoundException fne) {
                        System.out.println(fne.getMessage());
                    } finally {
                        if (out != null) {
                            out.close();
                        }
                        if (fileContent != null) {
                            fileContent.close();
                        }
                        if (writer != null) {
                            writer.close();
                        }
                    }
                } else {
//                request.getRequestDispatcher("ProductServlet?type=" + type).forward(request, response);
                    response.sendRedirect("profile");
                }
                break;
            }
            case "changePassword": {
                PrintWriter out = response.getWriter();
                HttpSession session = request.getSession();
                String oldPass = request.getParameter("oldPass");
                String newPass = request.getParameter("newPass");
                String reNewPass = request.getParameter("reNewPass");
                String msg = "";

                if (!oldPass.equals(profileDAO.getOneUser(userId).getPassword())) {
                    msg = "Old Password is wrong";
                } else {
                    if (newPass.equals(oldPass)) {
                        msg = "New password and Old password is equal. Please try again!";
                    } else {
                        if (!newPass.equals(reNewPass)) {
                            msg = "New and confirm password is not equal. Please try again!";
                        } else {
                            boolean isChangePasswordSucces = profileDAO.changePassword(userId, newPass);
                            user.setPassword(newPass);
                            request.setAttribute("userCur", user);
                            if (isChangePasswordSucces) {
                                msg = "Change password success";
                            } else {
                                msg = "Change password fail";
                            }
                        }
                    }
                }
                out.println("<script type=\"text/javascript\">");
                out.println("alert('" + msg + "');");
                out.println("location='profile'");
                out.println("</script>");

                break;
            }
            case "updateInformation": {
                String fullname = capitalizeString(request.getParameter("fullname").toLowerCase().trim());
                String msg = "Your fullname information is blank. Please try again";
                PrintWriter out = response.getWriter();
                if (fullname.length()!=0){
                    profileDAO.updateInformation(userId, fullname);
                response.sendRedirect("profile");  
                }
                out.println("<script type=\"text/javascript\">");
                out.println("alert('" + msg + "');");
                out.println("location='profile'");
                out.println("</script>");
                break;
            }
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

    public static String capitalizeString(String string) {
        char[] chars = string.toLowerCase().toCharArray();
        boolean found = false;
        for (int i = 0; i < chars.length; i++) {
            if (!found && Character.isLetter(chars[i])) {
                chars[i] = Character.toUpperCase(chars[i]);
                found = true;
            } else if (Character.isWhitespace(chars[i]) || chars[i] == '.' || chars[i] == '\'') { // You can add other chars here
                found = false;
            }
        }
        return String.valueOf(chars);
    }

    private String getFileName(final Part part) {
        final String partHeader = part.getHeader("content-disposition");
        for (String content : partHeader.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}
