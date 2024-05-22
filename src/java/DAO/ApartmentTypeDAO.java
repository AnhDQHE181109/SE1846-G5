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
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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

    public ApartmentType getApartmentTypeByID(int typeID) {
        String sql = "SELECT * FROM ApartmentTypes WHERE typeID = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, typeID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String size = rs.getString("size");
                double baseRent = rs.getDouble("base_rent");

                return new ApartmentType(typeID, size, baseRent);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public boolean updateApartmentType(ApartmentType apartmentType) {
        String sql = "UPDATE ApartmentTypes SET size = ?, base_rent = ? WHERE typeID = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, apartmentType.getSize());
            ps.setDouble(2, apartmentType.getBaseRent());
            ps.setInt(3, apartmentType.getTypeID());
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
