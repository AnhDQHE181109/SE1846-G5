/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author Long
 */
public class NotificationAlert {

    private int notiID;
    private int userID;
    private Date notiDate;
    private String notiMessage;
    private boolean notiStatus;

    public NotificationAlert(int notiID, int userID, Date notiDate, String notiMessage, boolean notiStatus) {
        this.notiID = notiID;
        this.userID = userID;
        this.notiDate = notiDate;
        this.notiMessage = notiMessage;
        this.notiStatus = notiStatus;
    }

    public int getNotiID() {
        return notiID;
    }

    public void setNotiID(int notiID) {
        this.notiID = notiID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public Date getNotiDate() {
        return notiDate;
    }

    public void setNotiDate(Date notiDate) {
        this.notiDate = notiDate;
    }

    public String getNotiMessage() {
        return notiMessage;
    }

    public void setNotiMessage(String notiMessage) {
        this.notiMessage = notiMessage;
    }

    public boolean isNotiStatus() {
        return notiStatus;
    }

    public void setNotiStatus(boolean notiStatus) {
        this.notiStatus = notiStatus;
    }

    @Override
    public String toString(){
        return this.getNotiDate() + ": " + this.getNotiMessage();
    }
}
