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

public class ApartmentTypeDAO extends MyDAO {

    public List<ApartmentType> getApartmentTypes() {
        String sql = "SELECT * FROM ApartmentTypes";
        List<ApartmentType> apartmentTypeList = new ArrayList<>();
        try {
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                int typeID = rs.getInt("typeID");
                String size = rs.getString("size");
                double baseRent = rs.getDouble("base_rent");

                ApartmentType apartmentType = new ApartmentType(typeID, size, baseRent);
                apartmentTypeList.add(apartmentType);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return apartmentTypeList;
    }
}