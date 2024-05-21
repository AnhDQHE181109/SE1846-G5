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

public class RoleDAO extends MyDAO {

    public List<Role> getRoles() {
        String sql = "SELECT * FROM Roles";
        List<Role> roleList = new ArrayList<>();
        try {
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                int roleID = rs.getInt("roleID");
                String roleName = rs.getString("role_name");

                Role role = new Role(roleID, roleName);
                roleList.add(role);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return roleList;
    }
}
