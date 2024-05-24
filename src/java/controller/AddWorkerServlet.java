package controller;

import DAO.AccountDAO;
import DAO.WorkerAttendanceDAO;
import DAO.WorkerDAO;
import model.Account;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;

@WebServlet(name = "AddWorkerServlet", urlPatterns = {"/AddWorkerServlet"})
public class AddWorkerServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String baseSalaryStr = request.getParameter("baseSalary");
        String salaryMultiplierStr = request.getParameter("salaryMultiplier");
        String job = request.getParameter("job");
        String lastLoginDayStr = request.getParameter("lastLoginDay");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String phoneNumber = request.getParameter("phoneNumber");
        String email = request.getParameter("email");
        String profilePictureLink = request.getParameter("profilePictureLink");
        String birthdateStr = request.getParameter("birthdate");
        String rollIDStr = request.getParameter("rollID");

        StringBuilder errorMsg = new StringBuilder();

        // Input validation
        double baseSalary = 0;
        double salaryMultiplier = 0;
        int rollID = 0;
        Date birthdate = null;
        Date lastLoginDay = null;

        try {
            baseSalary = Double.parseDouble(baseSalaryStr);
            if (baseSalary <= 0) {
                errorMsg.append("Base salary must be greater than 0.<br>");
            }
        } catch (NumberFormatException e) {
            errorMsg.append("Invalid base salary format.<br>");
        }

        try {
            salaryMultiplier = Double.parseDouble(salaryMultiplierStr);
            if (salaryMultiplier <= 0) {
                errorMsg.append("Salary multiplier must be greater than 0.<br>");
            }
        } catch (NumberFormatException e) {
            errorMsg.append("Invalid salary multiplier format.<br>");
        }

        try {
            rollID = Integer.parseInt(rollIDStr);
            if (rollID <= 0) {
                errorMsg.append("Role ID must be greater than 0.<br>");
            }
        } catch (NumberFormatException e) {
            errorMsg.append("Invalid role ID format.<br>");
        }

        try {
            birthdate = Date.valueOf(birthdateStr);
        } catch (IllegalArgumentException e) {
            errorMsg.append("Invalid birthdate format.<br>");
        }

        try {
            lastLoginDay = Date.valueOf(lastLoginDayStr);
        } catch (IllegalArgumentException e) {
            errorMsg.append("Invalid last login day format.<br>");
        }

        if (errorMsg.length() > 0) {
            request.setAttribute("errorMsg", errorMsg.toString());
            request.getRequestDispatcher("addworker.jsp").forward(request, response);
            return;
        }

        AccountDAO accountDAO = new AccountDAO();
        if (accountDAO.getUser(username) != null) {
            errorMsg.append("Username is already taken.<br>");
        }

        if (errorMsg.length() > 0) {
            request.setAttribute("errorMsg", errorMsg.toString());
            request.getRequestDispatcher("addworker.jsp").forward(request, response);
            return;
        }
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
        return "AddWorkerServlet handles the addition of a new worker and their account.";
    }
}
