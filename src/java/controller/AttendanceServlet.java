/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.WorkerAttendanceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.*;
import model.Worker;
import model.WorkerAttendance;


/**
 *
 * @author Long
 */
@WebServlet(name = "AttendanceServlet", urlPatterns = {"/AttendanceServlet"})
public class AttendanceServlet extends HttpServlet {

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
            out.println("<title>Servlet AttendanceServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AttendanceServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        Worker worker = (Worker) session.getAttribute("worker");
        LocalDate currentDate = LocalDate.now();
        LocalDate firstDayOfMonth = currentDate.withDayOfMonth(1);
        DayOfWeek dayOfWeek = firstDayOfMonth.getDayOfWeek();
        int dayOfWeekInt = dayOfWeek.getValue();
        session.setAttribute("x", dayOfWeekInt - 1);
        YearMonth currentYearMonth = YearMonth.from(currentDate);
        int daysInMonth = currentYearMonth.lengthOfMonth();
        session.setAttribute("dim", daysInMonth);
        WorkerAttendanceDAO wadao = new WorkerAttendanceDAO();
        WorkerAttendance wa = wadao.getAttendance(worker.getUserID());
        
        int[] daysArray = wa.getAD();
        /*
        new int[daysInMonth];
        for (int i = 7 - dayOfWeekInt; i < daysInMonth; i += 7) {
            daysArray[i] = 3;
        }
        */
        Date lastLoginDate = worker.getLlogin();
        System.out.println(lastLoginDate);
        if (lastLoginDate != null) {
            Calendar lastLoginCalendar = Calendar.getInstance();
            lastLoginCalendar.setTime(lastLoginDate);
            int lastLoginMonth = lastLoginCalendar.get(Calendar.MONTH) + 1;
            int lastLoginYear = lastLoginCalendar.get(Calendar.YEAR);
            int currentMonth = currentDate.getMonthValue();
            int currentYear = currentDate.getYear();
            if (lastLoginMonth != currentMonth || lastLoginYear != currentYear) {
                int currentDay = currentDate.getDayOfMonth();
                daysArray = new int[daysInMonth];
                for (int i = 7 - dayOfWeekInt; i < daysInMonth; i += 7) {
                    daysArray[i] = 3;
                }
                for (int i = 0; i < currentDay - 1; i++) {
                    if (daysArray[i] != 3) {
                        daysArray[i] = 1;
                    }
                }
                daysArray[currentDay - 1] = 2;
            } else {
                int lastLoginDay = lastLoginCalendar.get(Calendar.DAY_OF_MONTH);
                int currentDay = currentDate.getDayOfMonth();
                if (lastLoginDay == currentDay) {
                    daysArray[currentDay - 1] = 2;
                } else if (lastLoginDay == currentDay - 1) {
                    daysArray[currentDay - 1] = 2;
                } else {
                    for (int i = lastLoginDay - 1; i <= currentDay - 1; i++) {
                        if (daysArray[i] != 3) {
                            daysArray[i] = 1;
                        }
                    }
                }
            }
            wadao.UpdateAttendance(worker.getUserID(), daysArray);
            wadao.updateLastLogin(worker.getUserID());
        }

        session.setAttribute(
                "atarray", daysArray);
        response.sendRedirect(
                "worker.jsp");
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
        HttpSession session = request.getSession();      
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
