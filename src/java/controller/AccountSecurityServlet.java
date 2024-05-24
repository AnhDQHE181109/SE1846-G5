/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.AccountSecurityDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Account;

/**
 *
 * @author ASUS
 */
public class AccountSecurityServlet extends HttpServlet {

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
            out.println("<title>Servlet AccountSecurityServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AccountSecurityServlet at " + request.getContextPath() + "</h1>");
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
            //System.out.println(account);

            request.getRequestDispatcher("account_security.jsp").forward(request, response);
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

        String currentPassword = request.getParameter("currentPassword").trim();
        String newPassword = request.getParameter("newPassword").trim();
        String confirmPassword = request.getParameter("confirmPassword").trim();

        String button = request.getParameter("savePassword").trim();

        AccountSecurityDAO accountSecurityOps = new AccountSecurityDAO();

        if (account != null) {
            if (button != null) {
                if (!currentPassword.isBlank() && !newPassword.isBlank() && !confirmPassword.isBlank()) {
                    if (currentPassword.equalsIgnoreCase(account.getPassword())) {
                        if (newPassword.equalsIgnoreCase(confirmPassword)) {
                            accountSecurityOps.updatePassword(account.getUsername(), newPassword);
                            account.setPassword(newPassword);
                            out.print("<script>alert('Successfully changed your password!')</script>");
                            request.setAttribute("account", account);
                            request.getRequestDispatcher("account_security.jsp").include(request, response);
                            return;
                        } else {
                            out.print("<script>alert('Please retype your new password!')</script>");
                            request.setAttribute("account", account);
                            request.getRequestDispatcher("account_security.jsp").include(request, response);
                            return;
                        }
                    } else {
                        out.print("<script>alert('Your current password is incorrect!')</script>");
                        request.setAttribute("account", account);
                        request.getRequestDispatcher("account_security.jsp").include(request, response);
                        return;
                    }
                } else {
                    out.print("<script>alert('None of the fields can be empty!')</script>");
                    request.setAttribute("account", account);
                    request.getRequestDispatcher("account_security.jsp").include(request, response);
                    return;
                }
            }
        } else {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Action forbidden");
        }

    }

}
