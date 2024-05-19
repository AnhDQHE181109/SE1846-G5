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

public class BillDetailDAO extends MyDAO {

    public List<BillDetail> getBillDetails() {
        String sql = "SELECT * FROM Billdetails";
        List<BillDetail> billDetailList = new ArrayList<>();
        try {
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                int billDetailID = rs.getInt("billdetailID");
                int billID = rs.getInt("billID");
                double baseRent = rs.getDouble("base_rent");
                double waterBill = rs.getDouble("water_bill");
                double electricityBill = rs.getDouble("electricity_bill");
                double serviceBill = rs.getDouble("service_bill");

                BillDetail billDetail = new BillDetail(billDetailID, billID, baseRent, waterBill, electricityBill, serviceBill);
                billDetailList.add(billDetail);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return billDetailList;
    }
}
