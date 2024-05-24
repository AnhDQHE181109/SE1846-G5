/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.AccountDAO;
import DAO.WorkerAttendanceDAO;
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        double baseSalary = Double.parseDouble(request.getParameter("baseSalary"));
        double salaryMultiplier = Double.parseDouble(request.getParameter("salaryMultiplier"));
        String job = request.getParameter("job");
        Date lastLoginDay = Date.valueOf(request.getParameter("lastLoginDay"));

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String phoneNumber = request.getParameter("phoneNumber");
        String email = request.getParameter("email");
        String profilePictureLink = request.getParameter("profilePictureLink");
        Date birthdate = Date.valueOf(request.getParameter("birthdate"));
        int rollID = Integer.parseInt(request.getParameter("rollID"));
        
        AccountDAO accountDAO = new AccountDAO();
        accountDAO.addWorkerAccount(username, password, firstname, lastname, phoneNumber, email, profilePictureLink, birthdate, rollID);
        Account account = accountDAO.getUser(username);
        
        WorkerDAO workerDAO = new WorkerDAO();
        workerDAO.addWorker(account.getUserID(), baseSalary, salaryMultiplier, job, lastLoginDay);
        WorkerAttendanceDAO wadao = new WorkerAttendanceDAO();
        wadao.IntAttendance(account.getUserID());
        response.sendRedirect("landlord.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
