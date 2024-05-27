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
public class ServiceRequest {
    private int requestID;
    private int residentID;
    private int workerID;
    private String description;
    private Date requestdate;
    private Date assigndate;
    private Date finishdate;
    private String title;
    private String type;
    
    public ServiceRequest() {
    }

    public String getType() {
        return type;
    }

    public ServiceRequest(int requestID, int residentID, int workerID, String description, Date requestdate, Date assigndate, Date finishdate, String title, String type) {
        this.requestID = requestID;
        this.residentID = residentID;
        this.workerID = workerID;
        this.description = description;
        this.requestdate = requestdate;
        this.assigndate = assigndate;
        this.finishdate = finishdate;
        this.title = title;
        this.type = type;
    }

    public void setType(String type) {
        this.type = type;
    }

    

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
    
    
    
    public void setRequestdate(Date requestdate) {
        this.requestdate = requestdate;
    }

    public void setAssigndate(Date assigndate) {
        this.assigndate = assigndate;
    }

    public void setFinishdate(Date finishdate) {
        this.finishdate = finishdate;
    }

    public Date getRequestdate() {
        return requestdate;
    }

    public Date getAssigndate() {
        return assigndate;
    }

    public Date getFinishdate() {
        return finishdate;
    }

    

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