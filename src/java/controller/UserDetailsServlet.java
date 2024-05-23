/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.UserDetailsDAO;
import DAO.UserDetailsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.lang.System.Logger;
import java.lang.System.Logger.Level;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import model.*;

/**
 *
 * @author ASUS
 */
public class UserDetailsServlet extends HttpServlet {

    /*
    For debugging purposes
     */
    public static void main(String[] args) {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
        Date date = null;
        try {
            date = formatter.parse("2024-05-27");
        } catch (ParseException ex) {
            System.out.println(ex);
        }
        System.out.println(date);
    }

    /*
    For debugging purposes
     */
    public static void main(String[] args) {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
        Date date = null;
        try {
            date = formatter.parse("2024-05-27");
        } catch (ParseException ex) {
            System.out.println(ex);
        }
        System.out.println(date);
    }

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
            out.println("<title>Servlet UserDetailsServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserDetailsServlet at " + request.getContextPath() + "</h1>");
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
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        Account account = (Account) request.getSession().getAttribute("account");
        if (account != null) {
            request.setAttribute("account", account);
            System.out.println(account);

            request.getRequestDispatcher("account_details.jsp").forward(request, response);
        } else {
            out.println("<h1>Invalid data!");
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
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        Account account = (Account) request.getSession().getAttribute("account");
        
        String inputUsername = request.getParameter("inputUsername").trim();
        String inputFirstName = request.getParameter("inputFirstName").trim();
        String inputLastName = request.getParameter("inputLastName").trim();
        String inputEmailAddress = request.getParameter("inputEmailAddress").trim();
        String inputPhone = request.getParameter("inputPhone").trim();
        String inputBirthday = request.getParameter("inputBirthday").trim();
        
        String button = request.getParameter("saveChanges").trim();
        
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
        Date date = null;
        try {
            date = formatter.parse(inputBirthday);
        } catch (ParseException ex) {
            System.out.println(ex);
        }
        Account tempAccount = new Account(inputUsername, inputFirstName, inputLastName,
                inputPhone, inputEmailAddress, new java.sql.Date(date.getTime()));
        
        UserDetailsDAO userDetailsOps = new UserDetailsDAO();
        
        if (account != null) {
            if (button != null) {
                if (!inputUsername.isBlank() && !inputFirstName.isBlank() && !inputLastName.isBlank()
                        && !inputEmailAddress.isBlank() && !inputPhone.isBlank() && !inputBirthday.isBlank()) {
                    if (userDetailsOps.isDuplicateUsername(inputUsername, account.getUsername())) {
                        out.print("<script>alert('This username is unavailable!')</script>");
                        request.setAttribute("account", tempAccount);
                        request.getRequestDispatcher("account_details.jsp").include(request, response);
                        return;
                    }
                    
                    if (userDetailsOps.checkIfUnchangedInfo(userDetailsOps.getAccountByUsernameForComparison(inputUsername), tempAccount))  {
                        out.print("<script>alert('Nothing was changed!')</script>");
                        request.setAttribute("account", tempAccount);
                        request.getRequestDispatcher("account_details.jsp").include(request, response);
                    } else {
                        
//                        System.out.println("From DB: " + userDetailsOps.getAccountByUsernameForComparison(inputUsername));
//                        System.out.println("From WI: " + tempAccount);
//                        System.out.println("Equals? " + userDetailsOps.getAccountByUsernameForComparison(inputUsername).equals(tempAccount));
                        
                        account.setFirstname(inputFirstName);
                        account.setLastname(inputLastName);
                        account.setEmail(inputEmailAddress);
                        account.setPhoneNumber(inputPhone);
                        
                        account.setBirthDate(new java.sql.Date(date.getTime()));
                        
                        userDetailsOps.updateAccountInfo(account, inputUsername);
                        
                        request.setAttribute("account", account);
                        
                        out.print("<script>alert('Successfully updated your info!')</script>");
                        request.getRequestDispatcher("account_details.jsp").include(request, response);
                        //request.getRequestDispatcher("account_details.jsp").forward(request, response);
                    }
                    
                } else {
                    out.print("<script>alert('None of the fields can be empty!')</script>");
                    request.setAttribute("account", tempAccount);
                    request.getRequestDispatcher("account_details.jsp").include(request, response);
                    return;
                }
                
            }
        } else {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Action forbidden");
        }
    }

//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//        PrintWriter out = response.getWriter();
//
//        String inputBirthday = request.getParameter("inputBirthday").trim();
//        System.out.println(inputBirthday);
//        String inputUsername = request.getParameter("inputUsername").trim();
//        System.out.println("Username blank? " + inputUsername.isBlank());
//        System.out.println("Username empty? " + inputUsername.isEmpty());
//        System.out.println("Username null? " + inputUsername.equals(null));
//        
//        out.print("<script>alert('aaaa')</script>");
//        request.getRequestDispatcher("account_details.jsp").include(request, response);
//    }
    
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
