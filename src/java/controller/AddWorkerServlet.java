/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.AccountDAO;
import DAO.WorkerDAO;
import model.Account;
import model.Worker;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;

/**
 *
 * @author Admin
 */
@WebServlet(name = "AddWorkerServlet", urlPatterns = {"/AddWorkerServlet"})
public class AddWorkerServlet extends HttpServlet {

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
            out.println("<title>Servlet AddWorkerServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddWorkerServlet at " + request.getContextPath() + "</h1>");
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
        int userID;
        try {
            userID = Integer.parseInt(request.getParameter("userID"));
            if (userID < 0) {
                request.setAttribute("errorMessage", "User ID must be a positive number.");
                request.getRequestDispatcher("addWorker.jsp").forward(request, response);
                return;
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid User ID format.");
            request.getRequestDispatcher("addWorker.jsp").forward(request, response);
            return;
        }

        double baseSalary;
        try {
            baseSalary = Double.parseDouble(request.getParameter("baseSalary"));
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid Base Salary format.");
            request.getRequestDispatcher("addWorker.jsp").forward(request, response);
            return;
        }

        double salaryMultiplier;
        try {
            salaryMultiplier = Double.parseDouble(request.getParameter("salaryMultiplier"));
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid Salary Multiplier format.");
            request.getRequestDispatcher("addWorker.jsp").forward(request, response);
            return;
        }

        String job = request.getParameter("job");

        Date llogin;
        try {
            llogin = Date.valueOf(request.getParameter("llogin"));
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", "Invalid Last Login Date format.");
            request.getRequestDispatcher("addWorker.jsp").forward(request, response);
            return;
        }

        WorkerDAO workerDAO = new WorkerDAO();
        if (workerDAO.isUserIDTaken(userID)) {
            request.setAttribute("errorMessage", "User ID is already taken.");
            request.getRequestDispatcher("addworker.jsp").forward(request, response);
            return;
        }

        String username = request.getParameter("username");
        AccountDAO accountDAO = new AccountDAO();
        if (accountDAO.isUsernameTaken(username)) {
            request.setAttribute("errorMessage", "Username is already taken.");
            request.getRequestDispatcher("addworker.jsp").forward(request, response);
            return;
        }

        String password = request.getParameter("password");
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String phoneNumber = request.getParameter("phoneNumber");
        String email = request.getParameter("email");
        Date birthdate = Date.valueOf(request.getParameter("birthdate"));
        int roleID = 2; // Assuming 2 is the roleID for workers

        Worker worker = new Worker(0, userID, baseSalary, salaryMultiplier, job, llogin);
        workerDAO.addWorker(worker);

        Account account = new Account(userID, username, password, firstname, lastname, phoneNumber, email, null, birthdate, roleID);
        accountDAO.addAccount(account);

        response.sendRedirect("landlord.jsp");
    }

        @Override
        public String getServletInfo
        
            () {
        return "Short description";
        }// </editor-fold>

    }
