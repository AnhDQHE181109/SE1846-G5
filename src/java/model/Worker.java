/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Long
 */
public class Worker {
    private int workerID;
    private int userID;
    private double baseSalary;
    private double salaryMultiplier;
    private String job;

    public Worker(int workerID, int userID, double baseSalary, double salaryMultiplier, String job) {
        this.workerID = workerID;
        this.userID = userID;
        this.baseSalary = baseSalary;
        this.salaryMultiplier = salaryMultiplier;
        this.job = job;
    }

    public Worker(){
    }

    public int getWorkerID() {
        return workerID;
    }

    public void setWorkerID(int workerID) {
        this.workerID = workerID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
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

}
