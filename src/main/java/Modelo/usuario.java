
package Modelo;

import ConexionBD.Conexion;
import MetodosGenericos.contrasenias;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
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
        String usuario = parametros.get("usuario");
        String password = parametros.get("password");

        // Encriptar el pass que el usuario mando desde el front
        String password_encriptada = pass.encriptar(password);

        // Verificar que el estatus sea activo, el usuario y contrasenia sean los de la base y que la fecha vigencia sea mayor o igual a la fecha login o que sea null
        String sql = "SELECT * FROM usuario "
                    + "WHERE login = ? "
                    + "AND password = ? "
                    + "AND (fecha_vigencia >= NOW() OR fecha_vigencia IS NULL) "
                    + "AND status = ? ";

        try{
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, usuario);
            ps.setString(2, password_encriptada);
            ps.setString(3, "A");
            rs = ps.executeQuery();
            if(rs.next()) {
                HashMap<String, String> datos = new HashMap<>();
                datos.put("usuario", "correcto");
                array_list.add(datos);
            }else{ // No existe el usuario, los datos son incorrectos, el usuario no esta activo o la fecha de vigencia paso
                HashMap<String, String> datos = new HashMap<>();
                datos.put("usuario", "incorrecto");
                array_list.add(datos);
            }

            // SUMAR +1 a los intentos de ese usuario
            String sql2 = "UPDATE usuario "
                    + "SET intentos = intentos + 1 "
                    + "WHERE login = ? ";
            try{
                con = cn.getConnection();
                ps = con.prepareStatement(sql2);
                ps.setString(1, usuario);
                ps.executeUpdate();

            } catch (SQLException ex) {
                Logger.getLogger(usuario.class.getName()).log(Level.SEVERE, null, ex);
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
                    + "SET status = ?, fecha_baja = NOW(), fecha_revocado = NOW() "
                    + "WHERE id_usuario = ? ";

        try{
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, "R");
            ps.setString(2, id_usuario);
            ps.executeUpdate();

            eliminado = true;

            con.close();
        } catch (SQLException ex) {
            Logger.getLogger(usuario.class.getName()).log(Level.SEVERE, null, ex);
        }

        return eliminado;
    }

    public boolean add_usuario(HashMap<String,String> parametros){

        boolean add = false;
        String nombre = parametros.get("nombre_usuario");
        String apellido_paterno = parametros.get("primer_apellido");
        String apellido_materno = parametros.get("segundo_apellido");
        String login = parametros.get("nombre_login");
        String email = parametros.get("correo");
        String password = parametros.get("password");
        String pass_encrypt = pass.encriptar(password);
        int cliente = Integer.parseInt(parametros.get("cliente"));

        String sql = "INSERT INTO usuario "
                    + "(nombre, apellido_paterno, apellido_materno, login, email, password, fecha_vigencia, cliente, area, status, fecha_alta) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW()) ";

        try{
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, nombre);
            ps.setString(2, apellido_paterno);
            ps.setString(3, apellido_materno);
            ps.setString(4, login);
            ps.setString(5, email);
            ps.setString(6, pass_encrypt);
            if(parametros.get("fecha_vigencia").equals("NaN-NaN-NaN")){
                ps.setNull(7, java.sql.Types.DATE); // insertar en null
            }else{
                ps.setString(7, parametros.get("fecha_vigencia"));
            }
            ps.setInt(8, cliente);
            if(parametros.get("area").equals("")){
                ps.setNull(9, Types.INTEGER); // insertar en null
            }else{
                ps.setInt(9, Integer.parseInt(parametros.get("area")));
            }
            ps.setString(10, "A");
            ps.executeUpdate();

            add = true;

            con.close();
        } catch (SQLException ex) {
            Logger.getLogger(usuario.class.getName()).log(Level.SEVERE, null, ex);
        }
        return add;
    }
    
    public List listar_uno(HashMap<String,String> parametros){

        int id_usuario = Integer.parseInt(parametros.get("id_usuario"));

        String sql = "SELECT * FROM usuario WHERE id_usuario = ?";
        try{
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id_usuario);
            rs = ps.executeQuery();
            while(rs.next()) {
                HashMap<String, String> datos = new HashMap<>();

                datos.put("id_usuario", parametros.get("id_usuario"));
                datos.put("nombre", rs.getString("nombre"));
                datos.put("apellido_paterno", rs.getString("apellido_paterno"));
                datos.put("apellido_materno", rs.getString("apellido_materno"));
                datos.put("login", rs.getString("login"));
                datos.put("email", rs.getString("email"));
                datos.put("password", pass.desencriptar(rs.getString("password")));
                datos.put("fecha_vigencia", rs.getString("fecha_vigencia"));
                datos.put("cliente", rs.getString("cliente"));
                datos.put("area", rs.getString("area"));

                array_list.add(datos);
            }
            con.close();
        } catch (SQLException ex) {
            Logger.getLogger(usuario.class.getName()).log(Level.SEVERE, null, ex);
        }
        return array_list;
    }

    public boolean edit_usuario(HashMap<String,String> parametros){

        boolean edit = false;

        int id_usuario = Integer.parseInt(parametros.get("edit_id_usuario"));
        String nombre = parametros.get("edit_nombre_usuario");
        String apellido_paterno = parametros.get("edit_primer_apellido");
        String apellido_materno = parametros.get("edit_segundo_apellido");
        String login = parametros.get("edit_nombre_login");
        String email = parametros.get("edit_correo");
        String password = parametros.get("edit_password");
        String pass_encrypt = pass.encriptar(password);
        int cliente = Integer.parseInt(parametros.get("edit_cliente"));

        String sql = "UPDATE usuario "
                    + "SET nombre = ?, apellido_paterno = ?, apellido_materno = ?, login = ?, email = ?, "
                    + "password = ?, fecha_vigencia = ?, cliente = ?, area = ?, fecha_modificacion = NOW() "
                    + "WHERE id_usuario = ? ";

        try{
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, nombre);
            ps.setString(2, apellido_paterno);
            ps.setString(3, apellido_materno);
            ps.setString(4, login);
            ps.setString(5, email);
            ps.setString(6, pass_encrypt);
            if(parametros.get("edit_fecha_vigencia").equals("NaN-NaN-NaN")){
                ps.setNull(7, java.sql.Types.DATE); // insertar en null
            }else{
                ps.setString(7, parametros.get("edit_fecha_vigencia"));
            }
            ps.setInt(8, cliente);
            if(parametros.get("edit_area").equals("")){
                ps.setNull(9, Types.INTEGER); // insertar en null
            }else{
                ps.setInt(9, Integer.parseInt(parametros.get("edit_area")));
            }
            ps.setInt(10, id_usuario);
            ps.executeUpdate();

            edit = true;

            con.close();
        } catch (SQLException ex) {
            Logger.getLogger(usuario.class.getName()).log(Level.SEVERE, null, ex);
        }
        return edit;
    }

    public boolean reactivar_usuario(HashMap<String,String> parametros){

        boolean reactivado = false;
        String id_usuario = parametros.get("id_usuario");

        String sql = "UPDATE usuario "
                    + "SET status = ?, fecha_vigencia = ? "
                    + "WHERE id_usuario = ? ";

        try{
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, "A");
            ps.setNull(2, java.sql.Types.DATE); // insertar en null
            ps.setString(3, id_usuario);
            ps.executeUpdate();

            reactivado = true;

            con.close();
        } catch (SQLException ex) {
            Logger.getLogger(usuario.class.getName()).log(Level.SEVERE, null, ex);
        }

        return reactivado;
    }

    public boolean comprobar_vigencia(){

        boolean completado = false;

        // Fecha actual
        java.sql.Date fecha_actual = new java.sql.Date(new java.util.Date().getTime());

        String sql = "SELECT * FROM usuario";
        try{
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while(rs.next()) {
                if(rs.getDate("fecha_vigencia") != null){
                    // Fecha actual mayor a fecha_vigencia
                    if(rs.getDate("fecha_vigencia").compareTo(fecha_actual) < 0){
                        String sql2 = "UPDATE usuario "
                                    + "SET status = ? "
                                    + "WHERE id_usuario = ? ";
                        try{
                            ps = con.prepareStatement(sql2);
                            ps.setString(1, "B");
                            ps.setString(2, rs.getString("id_usuario"));
                            ps.executeUpdate();
                        } catch (SQLException ex) {
                            Logger.getLogger(usuario.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                }
            }
            con.close();
            completado = true;
        } catch (SQLException ex) {
            Logger.getLogger(usuario.class.getName()).log(Level.SEVERE, null, ex);
        }
        return completado;
    }
}
