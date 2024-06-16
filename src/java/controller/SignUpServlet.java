/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Util.*;
import java.time.LocalDate;
import java.time.Period;

/**
 *
 * @author Long
 */
@WebServlet(name = "SignUpServlet", urlPatterns = {"/SignUpServlet"})
public class SignUpServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SignUpServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SignUpServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

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
        processRequest(request, response);
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
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String phoneNumber = request.getParameter("phone_number");
        String email = request.getParameter("email");
        String birthdate = request.getParameter("birthdate");
        

        boolean hasErrors = false;
        AccountDAO adao = new AccountDAO();

        if (username == null || username.isEmpty()) {
            hasErrors = true;
            request.setAttribute("error_username", "true");
        }
        if (adao.isUsernameTaken(username)) {
            hasErrors = true;
            request.setAttribute("error_usernametaken", "true");
        }
        if (!Validator.validatePassword(password)) {
            hasErrors = true;
            request.setAttribute("password", "true");
        }

        if (firstname == null || firstname.isEmpty() || !firstname.matches("^[a-zA-Z]+$")) {
            hasErrors = true;
            request.setAttribute("error_firstname", "true");
        }

        // Last name validation
        if (lastname == null || lastname.isEmpty() || !lastname.matches("^[a-zA-Z]+$")) {
            hasErrors = true;
            request.setAttribute("error_lastname", "true");
        }

        if (email == null || email.isEmpty() || !email.matches("^[A-Za-z][A-Za-z0-9+_.-]*@(.+)$")) {
            hasErrors = true;
            request.setAttribute("error_email", "true");
        }

        if (birthdate == null || birthdate.isEmpty()) {
            hasErrors = true;
            request.setAttribute("birthdateError", "Birthdate is required.");
        } else {
            LocalDate birthdateDate = LocalDate.parse(birthdate);
            if (Period.between(birthdateDate, LocalDate.now()).getYears() < 18) {
                hasErrors = true;
                request.setAttribute("error_date", "true");
            }
        }
        
        
        if (hasErrors) {
            request.setAttribute("username", username);
            request.setAttribute("password", password);
            request.setAttribute("firstname", firstname);
            request.setAttribute("lastname", lastname);
            request.setAttribute("phone_number", phoneNumber);
            request.setAttribute("email", email);
            request.setAttribute("birthdate", birthdate);
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
        }else
        {}
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
