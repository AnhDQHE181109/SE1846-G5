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

public class BillDAO extends MyDAO {

    public List<Bill> getBills() {
        String sql = "SELECT * FROM Bills";
        List<Bill> billList = new ArrayList<>();
        try {
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                int billID = rs.getInt("billID");
                int residentID = rs.getInt("residentID");
                String status = rs.getString("status");
                double total = rs.getDouble("total");
                Date billDate = rs.getDate("billdate");

                Bill bill = new Bill(billID, residentID, status, total, billDate);
                billList.add(bill);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return billList;
    }
}
