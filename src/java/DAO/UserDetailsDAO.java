/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import model.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author ASUS
 */
public class UserDetailsDAO extends MyDAO {

    /*
    Method used only for debugging
     */
    public static void main(String[] args) {
        UserDetailsDAO udDAO = new UserDetailsDAO();
        System.out.println(udDAO.getAccountByUsername("resident"));
    }

    public Account getAccountByUsername(String username) {

        String sql = "select userID, username, firstname, lastname, phone_number, email, profile_picture_link, birthdate, roleID\n"
                + "from Accounts\n"
                + "where username = ?";

        Account account = null;

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                account = new Account(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7),
                        rs.getDate(8), rs.getInt(9));
            }

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (Exception e) {
            System.out.println(e);
        }

        return account;
    }
    
    public Account getAccountByUsernameForComparison(String username) {

        String sql = "select username, firstname, lastname, phone_number, email, birthdate\n"
                + "from Accounts\n"
                + "where username = ?";

        Account account = null;

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                account = new Account(rs.getString(1), rs.getString(2),
                        rs.getString(3), rs.getString(4), rs.getString(5),
                        rs.getDate(6));
            }

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (Exception e) {
            System.out.println(e);
        }

        return account;
    }

    public void updateAccountInfo(Account account, String updateUsername) {

        String sql = "update Accounts \n"
                + "set username = ?, firstname = ?, lastname = ?, phone_number = ?, email = ?, profile_picture_link = ?, birthdate = ?\n"
                + "where username = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, updateUsername);
            ps.setString(2, account.getFirstname());
            ps.setString(3, account.getLastname());
            ps.setString(4, account.getPhoneNumber());
            ps.setString(5, account.getEmail());
            ps.setString(6, account.getProfilePictureLink());
            ps.setDate(7, account.getBirthDate());
            ps.setString(8, account.getUsername());

            ResultSet rs = ps.executeQuery();

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public Boolean isDuplicateUsername(String username) {

        String sql = "select username\n"
                + "from Accounts\n"
                + "where username != ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                if (username.equalsIgnoreCase(rs.getString("username"))) {
                    return true;
                }
            }

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (Exception e) {
            System.out.println(e);
        }

        return false;
    }

}
