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

public class ApartmentDAO extends MyDAO {

    public List<Apartment> getApartments() {
        String sql = "SELECT * FROM Apartments";
        List<Apartment> apartmentList = new ArrayList<>();
        try {
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                int apartmentID = rs.getInt("apartmentID");
                int typeID = rs.getInt("typeID");
                boolean occupied = rs.getBoolean("occupied");

                Apartment apartment = new Apartment(apartmentID, typeID, occupied);
                apartmentList.add(apartment);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return apartmentList;
    }
}
