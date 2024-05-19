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
                int rollID = rs.getInt("rollID");

                Account account = new Account(userID, username, password, firstname, lastname, phoneNumber, email, profilePictureLink, rollID);
                accountList.add(account);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return accountList;
    }
}

