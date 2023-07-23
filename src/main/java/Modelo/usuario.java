
package Modelo;

import ConexionBD.Conexion;
import MetodosGenericos.contrasenias;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * @author javie
 */
public class usuario {

    // Conexion a wms
    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    // Objeto de clase contrasenias (metodos code and decode)
    contrasenias pass = new contrasenias();

    ArrayList<HashMap<String, String>> array_list = new ArrayList<>();
    

    public List validar_usuario(HashMap<String,String> parametros){
    
        // Guardar los parametros en variables
        String correo = parametros.get("correo");
        String password = parametros.get("password");

        // Encriptar el pass que el usuario mando desde el front
        String password_encriptada = pass.encriptar(password);

        // Fecha actual
        java.sql.Date fecha_actual = new java.sql.Date(new java.util.Date().getTime());

        String sql = "SELECT * FROM usuario "
                    + "WHERE email = ? "
                    + "AND password = ? ";
        try{
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, correo);
            ps.setString(2, password_encriptada);
            rs = ps.executeQuery();
            if(rs.next()) {
                HashMap<String, String> datos = new HashMap<>();
                // Verificar que el usuario y contrasenia sean los de la base. Que la fecha vigencia sea mayor o igual a la fecha login
                if(correo.equals(rs.getString("email")) && password_encriptada.equals(rs.getString("password")) && (rs.getDate("fecha_vigencia").compareTo(fecha_actual) > 0 || rs.getDate("fecha_vigencia").compareTo(fecha_actual) == 0)){
                    datos.put("usuario", "correcto");
                }else if(correo.equals(rs.getString("email")) && password_encriptada.equals(rs.getString("password")) && rs.getDate("fecha_vigencia").compareTo(fecha_actual) < 0){ // fecha_actual mayor a fecha_vigencia 
                    datos.put("usuario", "vencido");
                }
                array_list.add(datos);
            }else{ // No existe el usuario o los datos son incorrectos
                HashMap<String, String> datos = new HashMap<>();
                datos.put("usuario", "incorrecto");
                array_list.add(datos);
            }
            con.close();
        } catch (SQLException ex) {
            Logger.getLogger(usuario.class.getName()).log(Level.SEVERE, null, ex);
        }


        return array_list;
    }

    public List listar_todos(){

        String sql = "SELECT id_usuario, nombre, login, fecha_alta, status FROM usuario";
        try{
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while(rs.next()) {
                HashMap<String, String> datos = new HashMap<>();

                datos.put("id_usuario", Integer.toString(rs.getInt("id_usuario")));
                datos.put("nombre", rs.getString("nombre"));
                datos.put("login", rs.getString("login"));
                datos.put("fecha_alta", rs.getString("fecha_alta"));
                datos.put("status", rs.getString("status"));

                array_list.add(datos);
            }
            con.close();
        } catch (SQLException ex) {
            Logger.getLogger(usuario.class.getName()).log(Level.SEVERE, null, ex);
        }


        return array_list;
    }

    public List listar_por_filtro(HashMap<String,String> parametros){

        String status = parametros.get("filtro");
        String sql = "SELECT id_usuario, nombre, login, fecha_alta, status, fecha_vigencia "
                    + "FROM usuario "
                    + "WHERE status = ? ";

        try{
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, status);
            rs = ps.executeQuery();
            while(rs.next()) {
                HashMap<String, String> datos = new HashMap<>();

                datos.put("id_usuario", Integer.toString(rs.getInt("id_usuario")));
                datos.put("nombre", rs.getString("nombre"));
                datos.put("login", rs.getString("login"));
                datos.put("fecha_alta", rs.getString("fecha_alta"));
                datos.put("status", rs.getString("status"));

                array_list.add(datos);
            }
            con.close();
        } catch (SQLException ex) {
            Logger.getLogger(usuario.class.getName()).log(Level.SEVERE, null, ex);
        }


        return array_list;
    }

    public boolean eliminar_usuario(HashMap<String,String> parametros){

        boolean eliminado = false;
        String id_usuario = parametros.get("id_usuario");

        String sql = "UPDATE usuario "
                    + "SET status = 'R' "
                    + "WHERE id_usuario = ? ";
        try{
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, id_usuario);
            ps.executeUpdate();

            eliminado = true;

            con.close();
        } catch (SQLException ex) {
            Logger.getLogger(usuario.class.getName()).log(Level.SEVERE, null, ex);
        }

        return eliminado;
    }
    
}
