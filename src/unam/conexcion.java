/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package unam;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.swing.JOptionPane;

/**
 *
 * @author luisj
 */
public class conexcion {
    public static final String URL = "jdbc:mysql://127.0.0.1:3306/ventas_calzado";
    public static final String USERNAME = "root";
    public static final String PASSWORD = "";
    
    public static void coneccion(){
        
    }
    public static Connection getConection(){
        Connection con= null;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            con =(Connection)DriverManager.getConnection(URL,USERNAME, PASSWORD);
            System.out.println("conecta chido");
        }catch(Exception e){
            System.out.println("Error:"+e);
                
        }
        return con;
    }
}
