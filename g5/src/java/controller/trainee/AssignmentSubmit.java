/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.trainee;

import controller.auth.BasedRequiredAuthenticationController;
import dal.AssignmentDAO;
import dal.SubmittedAssignmentDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import model.Assignment;
import model.User;

/**
 *
 * @author win
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 50, // 50MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
@WebServlet(name = "AssignmentSubmit", urlPatterns = {"/assignment-submit"})
public class AssignmentSubmit extends BasedRequiredAuthenticationController {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String action = request.getParameter("action");
        SubmittedAssignmentDAO smdao = new SubmittedAssignmentDAO();
        AssignmentDAO adao = new AssignmentDAO();

        switch (action) {
            case "submit":

                String description = request.getParameter("description");
                int assignmentId = Integer.parseInt(request.getParameter("assignmentId"));
                System.out.println(description + "\t" + assignmentId);
                String fileName = request.getParameter("attachedFile");
                System.out.println(fileName);
                String assignmentFolder = "assignment" + assignmentId; // Replace with your logic to determine the chapter folder
                String uploadPath = getServletContext().getRealPath("view") + File.separator + "assets\\sm\\assignments" + File.separator + assignmentFolder;
                System.out.println(uploadPath);
                File folder = new File(uploadPath);
                if (!folder.exists()) {
                    folder.mkdirs();
                }
                String filePath = uploadPath + File.separator + fileName;
                try ( InputStream input = request.getPart("attachedFile").getInputStream();  OutputStream output = new FileOutputStream(filePath)) {
                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = input.read(buffer)) != -1) {
                        output.write(buffer, 0, bytesRead);
                    }
                }
                smdao.addAssignment(description,assignmentId);
                break;

        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String action = request.getParameter("action");
        AssignmentDAO adao = new AssignmentDAO();
//        int assignemntId = Integer.parseInt(request.getParameter("assignmentId"));
        switch (action) {
            case "view":
                
                request.getRequestDispatcher("view/trainee/assignment-submit.jsp").forward(request, response);
                break;
//            case "submit":
////                assignemntId = Integer.parseInt(request.getParameter("assignmentId"));
////                Assignment assignment = adao.getAssignmentById(assignemntId);
////                request.setAttribute("assignment", assignment);
//                request.getRequestDispatcher("view/trainee/assignment-submit.jsp");
                
                

        }

    }
}
