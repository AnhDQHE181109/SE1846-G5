/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Long
 */
public class Roll {
    private int rollID;
    private String rollName;

    public Roll(int rollID, String rollName) {
        this.rollID = rollID;
        this.rollName = rollName;
    }

    // Getters and setters

    public int getRollID() {
        return rollID;
    }

    public void setRollID(int rollID) {
        this.rollID = rollID;
    }

    public String getRollName() {
        return rollName;
    }

    public void setRollName(String rollName) {
        this.rollName = rollName;
    }
}
