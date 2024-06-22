/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.DBContext;
import model.WorkerWithStatus;

/**
 *
 * @author ASUS
 */
public class LandlordDashboardDAO extends DBContext {

    public List<WorkerWithStatus> getWorkers() {

        List<WorkerWithStatus> list = new ArrayList<>();

        String sql = "select firstname, lastname, base_salary, salary_multi, job, last_login, status\n"
                + "from Workers wo, Accounts acc\n"
                + "where wo.userID = acc.userID";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String firstName = rs.getString("firstname");
                String lastName = rs.getString("lastname");
                Double baseSalary = rs.getDouble("base_salary");
                Double salaryMultiplier = rs.getDouble("salary_multi");
                String job = rs.getString("job");
                java.sql.Date lastLogin = rs.getDate("last_login");
                String status = rs.getString("status");
                
                WorkerWithStatus worker = new WorkerWithStatus(firstName, lastName, baseSalary, salaryMultiplier, job, lastLogin, status);

                list.add(worker);
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
