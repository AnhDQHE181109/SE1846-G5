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

public class AccountDAO extends MyDAO {

    /*
    Method used only for debugging
     */
    public static void main(String[] args) {
        AccountDAO accDao = new AccountDAO();
        Account acc = accDao.getUser("resident");
        System.out.println(acc);
        System.out.println(acc.getBirthDate());
    }

    public List<Account> getAccounts() {
        String sql = "SELECT * FROM Accounts";
        List<Account> accountList = new ArrayList<>();
        try {
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                int userID = rs.getInt("userID");
                String username = rs.getString("username");
                String password = rs.getString("password");
                String firstname = rs.getString("firstname");
                String lastname = rs.getString("lastname");
                String phoneNumber = rs.getString("phone_number");
                String email = rs.getString("email");
                String profilePictureLink = rs.getString("profile_picture_link");
                java.sql.Date birthdate = rs.getDate("birthdate");
                int roleID = rs.getInt("roleID");

                Account account = new Account(userID, username, password, firstname, lastname, phoneNumber, email, profilePictureLink, birthdate, roleID);
                accountList.add(account);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return accountList;
    }

    public Account getUser(String username) {
        String sql = "SELECT * FROM Accounts where username = ?";
        Account account = null;
        try {
            ps = con.prepareStatement(sql);
            ps.setString(1, username);
            rs = ps.executeQuery();
            while (rs.next()) {
                int userID = rs.getInt("userID");
                String password = rs.getString("password");
                String firstname = rs.getString("firstname");
                String lastname = rs.getString("lastname");
                String phoneNumber = rs.getString("phone_number");
                String email = rs.getString("email");
                String profilePictureLink = rs.getString("profile_picture_link");
                java.sql.Date birthdate = rs.getDate("birthdate");
                int roleID = rs.getInt("roleID");

                account = new Account(userID, username, password, firstname, lastname, phoneNumber, email, profilePictureLink, birthdate, roleID);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return account;
    }

    public int validateUser(String username, String password, int role) {
        String query = "SELECT * FROM Accounts WHERE username = ?";
        try {
            ps = con.prepareStatement(query);
            ps.setString(1, username);
            rs = ps.executeQuery();
            if (rs.next()) {
                String storedPasswordHash = rs.getString("password");
                if (storedPasswordHash.equals(password)) {
                    if (role == 3) {
                        return 1;
                    }
                    int storedRole = rs.getInt("roleID");
                    if (storedRole != role) {
                        return 2;
                    } else {
                        return 1;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 3;
    }

    public boolean isUsernameTaken(String username) {
        String sql = "SELECT COUNT(*) FROM Accounts WHERE username = ?";
        try {
            ps = con.prepareStatement(sql);
            ps.setString(1, username);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Method to add a worker account

    public boolean addWorkerAccount(String username, String password, String firstname, String lastname, String phoneNumber, String email, String profilePictureLink, Date birthdate, int rollID) {
        String sql = "INSERT INTO Accounts (username, password, firstname, lastname, phone_number, email, profile_picture_link, birthdate, roleID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, firstname);
            ps.setString(4, lastname);
            ps.setString(5, phoneNumber);
            ps.setString(6, email);
            ps.setString(7, profilePictureLink);
            ps.setDate(8, (java.sql.Date) birthdate);
            ps.setInt(9, rollID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

}
