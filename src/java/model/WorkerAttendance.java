/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Long
 */
public class WorkerAttendance {

    private int attendanceID;
    private int userID;
    private String attendanceData;

    public WorkerAttendance(int attendanceID, int userID, String attendanceData) {
        this.attendanceID = attendanceID;
        this.userID = userID;
        this.attendanceData = attendanceData;
    }

    public WorkerAttendance() {
    }

    public int getAttendanceID() {
        return attendanceID;
    }

    public void setAttendanceID(int attendanceID) {
        this.attendanceID = attendanceID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getAttendanceData() {
        return attendanceData;
    }

    public void setAttendanceData(String attendanceData) {
        this.attendanceData = attendanceData;
    }

    public int[] getAD() {
        String[] temp = this.attendanceData.split(" ");
        int[] out = new int[temp.length];
        for (int i = 0; i < temp.length; i++) {
            out[i] = Integer.parseInt(temp[i]);
        }
        return out;
    }
}
