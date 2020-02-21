/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package unam.app;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


/**
 *
 * @author luisj
 */
public class prueba {
    public static void main(String[] args) throws SQLException {
        Connection con=unam.conexcion.getConection();
        PreparedStatement ps;
        ResultSet rs;
        ps= con.prepareStatement("SELECT * FROM modelotro");
        rs = ps.executeQuery();
        while (rs.next()) {
            System.out.println(rs.getString("marca"));
            
        }
            
        
    }
}