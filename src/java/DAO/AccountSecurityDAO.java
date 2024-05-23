/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Account;

/**
 *
 * @author ASUS
 */
public class AccountSecurityDAO extends MyDAO {

    public void updatePassword(String username, String newPassword) {

        String sql = "update Accounts\n"
                + "set password = ?\n"
                + "where username = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, newPassword);

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

}
