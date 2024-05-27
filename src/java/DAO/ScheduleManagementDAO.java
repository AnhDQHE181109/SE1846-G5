/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import model.WorkersWorkInDay;

/**
 *
 * @author ASUS
 */
public class ScheduleManagementDAO extends MyDAO {
    
    public static void main(String[] args) {
        ScheduleManagementDAO smDAO = new ScheduleManagementDAO();
        List<Integer> workDays = smDAO.getWorkAvailableDays();
        for (int workDay : workDays) {
            System.out.println(workDay);
        }
    }

    public Boolean isWorkAvailableOn(Date queryDate) {

        String sql = "select firstname, lastname, phone_number, profile_picture_link, assign_date, title\n"
                + "from Accounts acc, Workers wo, Service_Requests sr\n"
                + "where acc.userID = wo.userID and wo.workerID = sr.workerID and assign_date = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setDate(1, queryDate);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return true;
            }

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (Exception e) {
            System.out.println(e);
        }

        return false;
    }

    public List<WorkersWorkInDay> getWorkersWorkOn(Date queryDate) {

        List<WorkersWorkInDay> list = new ArrayList<>();

        String sql = "select firstname, lastname, phone_number, profile_picture_link, assign_date, title\n"
                + "from Accounts acc, Workers wo, Service_Requests sr\n"
                + "where acc.userID = wo.userID and wo.workerID = sr.workerID and assign_date = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setDate(1, queryDate);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String firstName = rs.getString("firstname");
                String lastName = rs.getString("lastname");
                String phoneNum = rs.getString("phone_number");
                String profilePictureLink = rs.getString("profile_picture_link");
                Date assignDate = rs.getDate("assign_date");
                String title = rs.getString("title");

                WorkersWorkInDay wwid = new WorkersWorkInDay(firstName, lastName, phoneNum,
                        profilePictureLink, assignDate, title);

                list.add(wwid);
            }

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (Exception e) {
            System.out.println(e);
        }

        return list;
    }

    public List<Integer> getWorkAvailableDays() {

        List<Integer> list = new ArrayList<>();

        String sql = "select assign_date\n"
                + "from Service_Requests";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                java.sql.Date inDate = rs.getDate("assign_date");
                int day = inDate.getDate();

                list.add(day);
            }

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (Exception e) {
            System.out.println(e);
        }

        return list;
    }

}
