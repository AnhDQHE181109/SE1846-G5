/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author ASUS
 */
public class WorkerWithStatus {
    
    private String firstname;
    private String lastname;
    private double baseSalary;
    private double salaryMultiplier;
    private String job;
    private java.sql.Date lastLogin;
    private String status;

    public WorkerWithStatus(String firstname, String lastname, double baseSalary, double salaryMultiplier, String job, Date lastLogin, String status) {
        this.firstname = firstname;
        this.lastname = lastname;
        this.baseSalary = baseSalary;
        this.salaryMultiplier = salaryMultiplier;
        this.job = job;
        this.lastLogin = lastLogin;
        this.status = status;
    }
    
    public WorkerWithStatus() {
        
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public double getBaseSalary() {
        return baseSalary;
    }

    public void setBaseSalary(double baseSalary) {
        this.baseSalary = baseSalary;
    }

    public double getSalaryMultiplier() {
        return salaryMultiplier;
    }

    public void setSalaryMultiplier(double salaryMultiplier) {
        this.salaryMultiplier = salaryMultiplier;
    }

    public String getJob() {
        return job;
    }

    public void setJob(String job) {
        this.job = job;
    }

    public Date getLastLogin() {
        return lastLogin;
    }

    public void setLastLogin(Date lastLogin) {
        this.lastLogin = lastLogin;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
    
}
