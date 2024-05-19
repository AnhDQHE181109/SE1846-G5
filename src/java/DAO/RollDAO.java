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

public class RollDAO extends MyDAO {

    public List<Roll> getRolls() {
        String sql = "SELECT * FROM Rolls";
        List<Roll> rollList = new ArrayList<>();
        try {
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                int rollID = rs.getInt("rollID");
                String rollName = rs.getString("roll_name");

                Roll roll = new Roll(rollID, rollName);
                rollList.add(roll);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rollList;
    }
}
