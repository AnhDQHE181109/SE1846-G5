/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

/**
 *
 * @author Long
 */
import model.*;
import java.util.ArrayList;
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

                ServiceRequest serviceRequest = new ServiceRequest(requestID, residentID, workerID, description);
                serviceRequestList.add(serviceRequest);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return serviceRequestList;
    }
}
