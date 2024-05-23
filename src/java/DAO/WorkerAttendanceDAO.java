/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

/**
 *
 * @author Long
 */
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.List;
import model.*;

public class WorkerAttendanceDAO extends MyDAO {

    public void addAttendance(WorkerAttendance attendance) {
        String sql = "INSERT INTO WorkerAttendance (userID, attendance_data) VALUES (?, ?)";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, attendance.getUserID());
            ps.setString(2, attendance.getAttendanceData());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<WorkerAttendance> getAllAttendance() {
        String sql = "SELECT * FROM WorkerAttendance";
        List<WorkerAttendance> attendanceList = new ArrayList<>();
        try {
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                int attendanceID = rs.getInt("attendanceID");
                int userID = rs.getInt("userID");
                String attendanceData = rs.getString("attendance_data");

                WorkerAttendance attendance = new WorkerAttendance(attendanceID, userID, attendanceData);
                attendanceList.add(attendance);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return attendanceList;
    }

    public WorkerAttendance getAttendance(int userID) {
        String sql = "SELECT * FROM WorkerAttendance where userID = ?";
        List<WorkerAttendance> attendanceList = new ArrayList<>();
        WorkerAttendance attendance = new WorkerAttendance();
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, userID);
            rs = ps.executeQuery();
            while (rs.next()) {
                int attendanceID = rs.getInt("attendanceID");
                String attendanceData = rs.getString("attendance_data");

                attendance = new WorkerAttendance(attendanceID, userID, attendanceData);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return attendance;
    }

    public void IntAttendance(int userID) {
        LocalDate currentDate = LocalDate.now();
        LocalDate firstDayOfMonth = currentDate.withDayOfMonth(1);
        DayOfWeek dayOfWeek = firstDayOfMonth.getDayOfWeek();
        int dayOfWeekInt = dayOfWeek.getValue();
        YearMonth currentYearMonth = YearMonth.from(currentDate);
        int daysInMonth = currentYearMonth.lengthOfMonth();

        int[] daysArray = new int[daysInMonth];
        for (int i = 7 - dayOfWeekInt; i < daysInMonth; i += 7) {
            daysArray[i] = 3;
        }
        String newa = "";
        for (int i = 0; i < daysInMonth; i++) {
            newa += daysArray[i] + " ";
        }

        String sql = "INSERT INTO WorkerAttendance (userID, attendance_data) VALUES (?, ?)";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, userID);
            ps.setString(2, newa);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void UpdateAttendance(int userID, int[] aar) {
        String sql = "UPDATE WorkerAttendance SET attendance_data = ? WHERE userID = ?";
        try {
            ps = con.prepareStatement(sql);
            String atd = "";
            for (int i = 0; i < aar.length; i++) {
                atd += aar[i] + " ";
            }
            ps.setString(1, atd);
            ps.setInt(2, userID);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
