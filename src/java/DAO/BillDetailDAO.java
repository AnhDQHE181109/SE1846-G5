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
import java.util.Scanner;

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
    
    
     public double getTotalBill(int billdetailID) {
        String sql = "SELECT SUM(base_rent + water_bill + electricity_bill + service_bill) AS total FROM Billdetails WHERE billdetailID = ?";
        double total = 0;
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, billdetailID);
            rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getDouble("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // Ask the user for the bill ID
        int billID = 1;

        // Create an instance of BillDetailDAO
        BillDetailDAO billDetailDAO = new BillDetailDAO();

        // Get the total amount for the given bill ID
        double totalAmount = billDetailDAO.getTotalBill(billID);

        // Print out the total amount
        System.out.println("Total amount of bills for bill ID " + billID + " is: $" + totalAmount);

        // Close the scanner
        scanner.close();
    }
}
