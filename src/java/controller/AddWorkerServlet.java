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
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

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
        Map<String, String> validInputs = new HashMap<>();

        // Input validation
        double baseSalary = 0;
        double salaryMultiplier = 0;
        int rollID = 2;
        Date birthdate = null;
        Date lastLoginDay = null;

        try {
            baseSalary = Double.parseDouble(baseSalaryStr);
            if (baseSalary > 0) {
                validInputs.put("baseSalary", baseSalaryStr);
            } else {
                errorMsg.append("Base salary must be greater than 0.<br>");
            }
        } catch (NumberFormatException e) {
            errorMsg.append("Invalid base salary format.<br>");
        }

        try {
            salaryMultiplier = Double.parseDouble(salaryMultiplierStr);
            if (salaryMultiplier > 0) {
                validInputs.put("salaryMultiplier", salaryMultiplierStr);
            } else {
                errorMsg.append("Salary multiplier must be greater than 0.<br>");
            }
        } catch (NumberFormatException e) {
            errorMsg.append("Invalid salary multiplier format.<br>");
        }

        try {
            birthdate = Date.valueOf(birthdateStr);
            LocalDate today = LocalDate.now();
            LocalDate birthLocalDate = birthdate.toLocalDate();
            int age = today.getYear() - birthLocalDate.getYear();
            if (today.isBefore(birthLocalDate.plusYears(age))) {
                age--;
            }
            if (age > 18) {
                validInputs.put("birthdate", birthdateStr);
            } else {
                errorMsg.append("Age must be greater than 18.<br>");
            }
        } catch (IllegalArgumentException e) {
            errorMsg.append("Invalid birthdate format.<br>");
        }

        try {
            lastLoginDay = Date.valueOf(lastLoginDayStr);
            validInputs.put("lastLoginDay", lastLoginDayStr);
        } catch (IllegalArgumentException e) {
            errorMsg.append("Invalid last login day format.<br>");
        }

        if (username != null && !username.trim().isEmpty()) {
            validInputs.put("username", username);
        } else {
            errorMsg.append("Username is required.<br>");
        }

        if (password != null && password.length() > 8 && password.length() < 20) {
            validInputs.put("password", password);
        } else {
            errorMsg.append("Password must be between 8 and 20 characters long.<br>");
        }

        if (firstname != null && !firstname.trim().isEmpty()) {
            validInputs.put("firstname", firstname);
        } else {
            errorMsg.append("First name is required.<br>");
        }

        if (lastname != null && !lastname.trim().isEmpty()) {
            validInputs.put("lastname", lastname);
        } else {
            errorMsg.append("Last name is required.<br>");
        }

        if (phoneNumber != null && phoneNumber.length() == 8 && Pattern.matches("\\d{8}", phoneNumber)) {
            validInputs.put("phoneNumber", phoneNumber);
        } else {
            errorMsg.append("Phone number must be 8 digits.<br>");
        }

        if (email != null && Pattern.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$", email)) {
            validInputs.put("email", email);
        } else {
            errorMsg.append("Invalid email format.<br>");
        }

        if (profilePictureLink != null && !profilePictureLink.trim().isEmpty()) {
            if (Pattern.matches("^(http|https)://.*\\.(jpg|jpeg|png|gif)$", profilePictureLink)) {
                validInputs.put("profilePictureLink", profilePictureLink);
            } else {
                errorMsg.append("Invalid profile picture link format. Must be a valid URL ending with jpg, jpeg, png, or gif.<br>");
            }
        }

        AccountDAO accountDAO = new AccountDAO();
        if (accountDAO.getUser(username) != null) {
            errorMsg.append("Username is already taken.<br>");
        }

        if (errorMsg.length() > 0) {
            request.setAttribute("errorMsg", errorMsg.toString());
            request.setAttribute("validInputs", validInputs);
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
