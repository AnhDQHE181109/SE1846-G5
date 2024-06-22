/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

/**
 *
 * @author Long
 */
import java.security.Timestamp;
import model.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ServiceRequestDAO extends MyDAO {

    public List<ServiceRequest> getServiceRequests() {
        String sql = "SELECT * FROM Service_Requests";
        List<ServiceRequest> serviceRequestList = new ArrayList<>();
        try {
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                int requestID = rs.getInt("requestID");
                int residentID = rs.getInt("residentID");
                int workerID = rs.getInt("workerID");
                String description = rs.getString("description");
                Date requestdate = rs.getDate("request_date");
                Date assigndate = rs.getDate("assign_date");
                Date finishdate = rs.getDate("finish_date");
                String title = rs.getString("title");
                String type = rs.getString("type");
                ServiceRequest serviceRequest = new ServiceRequest(requestID, residentID, workerID, description, requestdate, assigndate, finishdate, title, type);
                serviceRequestList.add(serviceRequest);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return serviceRequestList;
    }

    public void addRequest(int residentID, int workerID, String description, Date requestdate, Date assigndate, Date finishdate, String title, String type) {
        String sql = "INSERT INTO Service_Requests (residentID, workerID, description, request_date, assign_date, finish_date, title, type) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, residentID);
            ps.setInt(2, workerID);
            ps.setString(3, description);
            ps.setDate(4, (java.sql.Date) requestdate);
            ps.setDate(5, (java.sql.Date) assigndate);
            ps.setDate(6, (java.sql.Date) finishdate);
            ps.setString(7, title);
            ps.setString(8, type);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void addInitialRequest(int residentID, String description, String title, String type) {
        String sql = "INSERT INTO Service_Requests (residentID, workerID, description, request_date, assign_date, finish_date, title, type) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, residentID);
            ps.setNull(2, java.sql.Types.INTEGER);
            ps.setString(3, description);
            Date utilDate = new Date();
            java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
            ps.setDate(4, sqlDate);
            ps.setNull(5, java.sql.Types.DATE);
            ps.setNull(6, java.sql.Types.DATE);
            ps.setString(7, title);
            ps.setString(8, type);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<ServiceRequest> getResidentServiceRequests(int rid) {
        String sql = "SELECT * FROM Service_Requests where residentID = ?";
        List<ServiceRequest> serviceRequestList = new ArrayList<>();
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, rid);
            rs = ps.executeQuery();
            while (rs.next()) {
                int requestID = rs.getInt("requestID");
                int residentID = rs.getInt("residentID");
                int workerID = rs.getInt("workerID");
                String description = rs.getString("description");
                Date requestdate = rs.getDate("request_date");
                Date assigndate = rs.getDate("assign_date");
                Date finishdate = rs.getDate("finish_date");
                String title = rs.getString("title");
                String type = rs.getString("type");
                ServiceRequest serviceRequest = new ServiceRequest(requestID, residentID, workerID, description, requestdate, assigndate, finishdate, title, type);
                serviceRequestList.add(serviceRequest);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return serviceRequestList;
    }

    public List<ServiceRequest> getUnAssignedServiceRequests() {
        String sql = "SELECT * FROM Service_Requests where assign_date IS NULL";
        List<ServiceRequest> serviceRequestList = new ArrayList<>();
        try {
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                int requestID = rs.getInt("requestID");
                int residentID = rs.getInt("residentID");
                int workerID = rs.getInt("workerID");
                String description = rs.getString("description");
                Date requestdate = rs.getDate("request_date");
                Date assigndate = rs.getDate("assign_date");
                Date finishdate = rs.getDate("finish_date");
                String title = rs.getString("title");
                String type = rs.getString("type");
                ServiceRequest serviceRequest = new ServiceRequest(requestID, residentID, workerID, description, requestdate, assigndate, finishdate, title, type);
                serviceRequestList.add(serviceRequest);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return serviceRequestList;
    }

    public List<ServiceRequest> getAssignedServiceRequests(int wID) {
        String sql = "SELECT * FROM Service_Requests where workerID = ?";
        List<ServiceRequest> serviceRequestList = new ArrayList<>();
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, wID);
            rs = ps.executeQuery();
            while (rs.next()) {
                int requestID = rs.getInt("requestID");
                int residentID = rs.getInt("residentID");
                int workerID = rs.getInt("workerID");
                String description = rs.getString("description");
                Date requestdate = rs.getDate("request_date");
                Date assigndate = rs.getDate("assign_date");
                Date finishdate = rs.getDate("finish_date");
                String title = rs.getString("title");
                String type = rs.getString("type");
                ServiceRequest serviceRequest = new ServiceRequest(requestID, residentID, workerID, description, requestdate, assigndate, finishdate, title, type);
                serviceRequestList.add(serviceRequest);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return serviceRequestList;
    }

    public void finishService(int rID) {
        String sql = "UPDATE Service_Requests set finish_date = ? where requestid = ?";
        try {
            ps = con.prepareStatement(sql);
            Date utilDate = new Date();
            java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
            ps.setDate(1, sqlDate);
            ps.setInt(2, rID);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
