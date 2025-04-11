/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.User;

/**
 *
 * @author admin
 */
public abstract class BasedRequiredTrainerAuthenticationController extends HttpServlet {

    private boolean isAuthenticated(HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        if(user != null){
                if(user.getRole().getSettingId()==3){
                return true;
            }
        }
        return false;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(isAuthenticated(request))
        {
            //do business
            doPost(request, response, (User) request.getSession().getAttribute("user"));
        }
        else
        {
            response.sendRedirect("auth?action=login");
        }
    }
    
     protected abstract void doPost(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(isAuthenticated(request))
        {
            //do business
            doGet(request, response, (User) request.getSession().getAttribute("user"));
        }
        else
        {
            response.sendRedirect("auth?action=login");
        }
    }
    protected abstract void doGet(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException;

}