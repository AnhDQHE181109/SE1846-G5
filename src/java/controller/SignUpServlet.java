/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import Util.EncryptionHelper;
import java.io.IOException;
import java.time.LocalDate;
import java.time.Period;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import DAO.AccountDAO;
import Util.Validator;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet(name = "SignUpServlet", urlPatterns = {"/SignUpServlet"})
public class SignUpServlet extends HttpServlet {

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
            request.setAttribute("error_password", "true");
        }
        if (firstname == null || firstname.isEmpty() || !firstname.matches("^[a-zA-Z]+$")) {
            hasErrors = true;
            request.setAttribute("error_firstname", "true");
        }
        if (lastname == null || lastname.isEmpty() || !lastname.matches("^[a-zA-Z]+$")) {
            hasErrors = true;
            request.setAttribute("error_lastname", "true");
        }
        if (email == null || email.isEmpty() || !email.matches("^[A-Za-z][A-Za-z0-9+_.-]*@(.+)$")) {
            hasErrors = true;
            request.setAttribute("error_email", "true");
        }
        if (adao.isEmailTaken(email)) {
            hasErrors = true;
            request.setAttribute("error_emailtaken", "true");
        }
        if (birthdate == null || birthdate.isEmpty()) {
            hasErrors = true;
            request.setAttribute("error_birthdate", "true");
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
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        } else {
            String salt = EncryptionHelper.generateSalt();
            String hashedPassword = "";
            
            Date birthDate = null;
            try {
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                birthDate = dateFormat.parse(birthdate);
            } catch (Exception e) {
                e.printStackTrace();
            }
            try {
                hashedPassword = EncryptionHelper.hashPassword(password, salt);
            } catch (Exception e) {
            }
            
            java.sql.Date sqlBirthDate = new java.sql.Date(birthDate.getTime());
            adao.addAccount(username, hashedPassword, firstname, lastname, phoneNumber, email, "img_link", sqlBirthDate, 1, salt);
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }

    public String getServletInfo() {
        return "Short description";
    }
}
