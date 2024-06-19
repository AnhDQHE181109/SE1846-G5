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
    import java.util.Scanner;

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

        public int getResidentID(int userID) {
            int residentID = -1;
            try {
                xSql = "SELECT residentID FROM Residents WHERE userID = ?";
                ps = con.prepareStatement(xSql);
                ps.setInt(1, userID);
                rs = ps.executeQuery();
                if (rs.next()) {
                    residentID = rs.getInt("residentID");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                closeResources();
            }
            return residentID;
        }



        public String getStatus(int billID) {
            String sql = "SELECT status FROM Bills WHERE billID = ?";
            String status = null;
            try {
                ps = con.prepareStatement(sql);
                ps.setInt(1, billID);
                rs = ps.executeQuery();
                if (rs.next()) {
                    status = rs.getString("status");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return status;
        }
        
        public int getBillID(int residentID) {
        int billID = -1;
        try {
            String sql = "SELECT billID FROM Bills WHERE residentID = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, residentID);
            rs = ps.executeQuery();
            if (rs.next()) {
                billID = rs.getInt("billID");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return billID;
    }
        
        public int getBillDetailID(int billID){
            String sql = "Select bd.billdetailID FROM Bills b JOIN Billdetails bd on b.billID = bd.billID where b.billID = ?";
            int billDetailID = -1;
            try {
                ps = con.prepareStatement(sql);
                ps.setInt(1, billID);
                rs = ps.executeQuery();
                if (rs.next()) {
                    billDetailID = rs.getInt("billDetailID");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return billDetailID;
        }

        public double getTotalAmount(int userID) {
            BillDetailDAO billDetailDAO = new BillDetailDAO();
            int billID = getBillID(userID);
            int billDetailID = getBillDetailID(billID);
            double totalAmount = billDetailDAO.getTotalBill(billDetailID);
            return totalAmount;
        }

        private void closeResources() {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        public static void main(String[] args) {
            Scanner scanner = new Scanner(System.in);

            // Ask the user for their user ID
            int userID = 0;

            // Create an instance of BillDAO
            BillDAO billDAO = new BillDAO();

            // Get the total amount of bills for the given user ID
            double totalAmount = billDAO.getTotalAmount(userID);
            String payStatus = billDAO.getStatus(userID);
            int billID = billDAO.getBillID(userID);

            // Print out the total amount
            System.out.println("BillID: "+ billID);
            System.out.println("Total amount of bills for user ID " + userID + " is: $" + totalAmount);
            System.out.println("Status:"+payStatus);

            // Close the scanner
            scanner.close();
        }
    }

