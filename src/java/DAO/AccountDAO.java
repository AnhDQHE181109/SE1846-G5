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
                Date birthdate = rs.getDate("birthdate");
                int rollID = rs.getInt("rollID");

                Account account = new Account(userID, username, password, firstname, lastname, phoneNumber, email, profilePictureLink, birthdate, rollID);
                accountList.add(account);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return accountList;
    }
    public Account getUser(String username){
     String sql = "SELECT * FROM Account where username = ?";
     Account account = new Account();
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
                Date birthdate = rs.getDate("birthdate");
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
                if (storedPasswordHash.equals(password)){
                int storedRole = rs.getInt("roleID");
                if(storedRole != role){return 2;}else{return 1;}
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 3;
    }
}
