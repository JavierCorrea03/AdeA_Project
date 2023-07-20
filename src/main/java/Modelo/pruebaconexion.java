
package Modelo;

/**
 * @author javie
 */

import ConexionBD.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class pruebaconexion {
    public static void main (String[]args){
        prueba();
    }

    public static List prueba(){
        ArrayList< HashMap<String,String> >list = new ArrayList<>();

        Conexion cn = new Conexion();
        Connection con;
        PreparedStatement ps;
        ResultSet rs;
           
        String sql = "SELECT * FROM usuario";
        try {
            con = cn.getConnection();            
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                HashMap<String, String> datos = new HashMap<>();
                datos.put("password", rs.getString("password"));
                list.add(datos);
            }
            con.close();
        }
        catch(SQLException e){
            e.printStackTrace();
        }
        System.out.println("Lista de contrasenias: "+list);
        return list;
    }
}
