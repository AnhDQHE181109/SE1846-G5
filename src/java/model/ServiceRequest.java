/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Long
 */
public class ServiceRequest {
    private int requestID;
    private int residentID;
    private int workerID;
    private String description;

    public ServiceRequest(int requestID, int residentID, int workerID, String description) {
        this.requestID = requestID;
        this.residentID = residentID;
        this.workerID = workerID;
        this.description = description;
    }

    // Getters and setters

    public int getRequestID() {
        return requestID;
    }

    public void setRequestID(int requestID) {
        this.requestID = requestID;
    }

    public int getResidentID() {
        return residentID;
    }

    public void setResidentID(int residentID) {
        this.residentID = residentID;
    }

    public int getWorkerID() {
        return workerID;
    }

    public void setWorkerID(int workerID) {
        this.workerID = workerID;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}