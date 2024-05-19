/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Long
 */
public class BillDetail {
    private int billDetailID;
    private int billID;
    private double baseRent;
    private double waterBill;
    private double electricityBill;
    private double serviceBill;

    public BillDetail(int billDetailID, int billID, double baseRent, double waterBill, double electricityBill, double serviceBill) {
        this.billDetailID = billDetailID;
        this.billID = billID;
        this.baseRent = baseRent;
        this.waterBill = waterBill;
        this.electricityBill = electricityBill;
        this.serviceBill = serviceBill;
    }

    // Getters and setters

    public int getBillDetailID() {
        return billDetailID;
    }

    public void setBillDetailID(int billDetailID) {
        this.billDetailID = billDetailID;
    }

    public int getBillID() {
        return billID;
    }

    public void setBillID(int billID) {
        this.billID = billID;
    }

    public double getBaseRent() {
        return baseRent;
    }

    public void setBaseRent(double baseRent) {
        this.baseRent = baseRent;
    }

    public double getWaterBill() {
        return waterBill;
    }

    public void setWaterBill(double waterBill) {
        this.waterBill = waterBill;
    }

    public double getElectricityBill() {
        return electricityBill;
    }

    public void setElectricityBill(double electricityBill) {
        this.electricityBill = electricityBill;
    }

    public double getServiceBill() {
        return serviceBill;
    }

    public void setServiceBill(double serviceBill) {
        this.serviceBill = serviceBill;
    }
}
