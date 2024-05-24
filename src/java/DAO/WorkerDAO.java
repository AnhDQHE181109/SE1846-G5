/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

/**
 *
 * @author Long
 */
import java.sql.PreparedStatement;
import model.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class WorkerDAO extends MyDAO {

    public List<Worker> getWorkers() {
        String sql = "SELECT * FROM Workers";
        List<Worker> workerList = new ArrayList<>();
        try {
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                int workerID = rs.getInt("workerID");
                int userID = rs.getInt("userID");
                double baseSalary = rs.getDouble("base_salary");
                double salaryMultiplier = rs.getDouble("salary_multi");
                String job = rs.getString("job");
                java.sql.Date llogin = rs.getDate("last_login");
                Worker worker = new Worker(workerID, userID, baseSalary, salaryMultiplier, job, llogin);
                workerList.add(worker);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return workerList;
    }

    public Worker getWorker(int userID) {
        String sql = "SELECT * FROM Workers where userID = ?";
        Worker worker = new Worker();
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, userID);
            rs = ps.executeQuery();
            while (rs.next()) {
                int workerID = rs.getInt("workerID");
                double baseSalary = rs.getDouble("base_salary");
                double salaryMultiplier = rs.getDouble("salary_multi");
                String job = rs.getString("job");
                java.sql.Date llogin = rs.getDate("last_login");
                worker = new Worker(workerID, userID, baseSalary, salaryMultiplier, job, llogin);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return worker;
    }

    public boolean isUserIDTaken(int userID) {
        String sql = "SELECT COUNT(*) FROM Workers WHERE userID = ?";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, userID);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Method to add a worker


    /**
     *
     * @param workerID
     * @param baseSalary
     * @param salaryMultiplier
     * @param job
     * @param lastLoginDay
     * @return
     */
    public boolean addWorker(int userID, double baseSalary, double salaryMultiplier, String job, Date lastLoginDay) {
        String sql = "INSERT INTO Workers (userID, base_salary, salary_multi, job, last_login) VALUES (?, ?, ?, ?, ?)";
        try {
             ps = con.prepareStatement(sql);
            ps.setInt(1, userID);
            ps.setDouble(2, baseSalary);
            ps.setDouble(3, salaryMultiplier);
            ps.setString(4, job);
            ps.setDate(5, (java.sql.Date) lastLoginDay);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();

        }

        return false;
    }

}
