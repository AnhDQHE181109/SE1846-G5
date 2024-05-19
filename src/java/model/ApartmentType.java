/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Long
 */
public class ApartmentType {
    private int typeID;
    private String size;
    private double baseRent;

    public ApartmentType(int typeID, String size, double baseRent) {
        this.typeID = typeID;
        this.size = size;
        this.baseRent = baseRent;
    }

    public int getTypeID() {
        return typeID;
    }

    public void setTypeID(int typeID) {
        this.typeID = typeID;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public double getBaseRent() {
        return baseRent;
    }

    public void setBaseRent(double baseRent) {
        this.baseRent = baseRent;
    }
}
