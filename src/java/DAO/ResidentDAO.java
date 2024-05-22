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
import java.util.Date;
import java.util.List;

public class ResidentDAO extends MyDAO {

    public List<Resident> getResidents() {
        String sql = "SELECT * FROM Residents";
        List<Resident> residentList = new ArrayList<>();
        try {
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                int residentID = rs.getInt("residentID");
                int userID = rs.getInt("userID");
                int apartmentID = rs.getInt("apartmentID");
                Date billingDate = rs.getDate("billingdate");

                Resident resident = new Resident(residentID, userID, apartmentID, billingDate);
                residentList.add(resident);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return residentList;
    }
    public Resident getResident(int userID){
        String sql = "SELECT * FROM Residents where userID = ?";
        Resident resident = new Resident();
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, userID);
            rs = ps.executeQuery();
            while (rs.next()) {
                int residentID = rs.getInt("residentID");
                int apartmentID = rs.getInt("apartmentID");
                Date billingDate = rs.getDate("billingdate");

                resident = new Resident(residentID, userID, apartmentID, billingDate);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resident;
    }
}
