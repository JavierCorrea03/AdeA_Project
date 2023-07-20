
package ConexionBD;

/**
 * @author javie
 */

import java.sql.Connection;
import java.sql.DriverManager;

public class Conexion {

    Connection con;
    public Conexion(){

        String username = "root";
        String password = "";
        String hostname = "localhost";
        String port = "3306";
        String database = "adea";
        String classname = "com.mysql.cj.jdbc.Driver";

        String url = "jdbc:mysql://"+hostname+":"+port+"/"+database+"?serverTimezone=UTC&autoReconnect=true&useSSL=false";


        try{
            Class.forName(classname);
            con = (Connection) DriverManager.getConnection(url, username, password);
            //System.out.println("Conexión a: "+con);
        }catch(Exception e){
            System.err.println(e.getMessage());
        }
    }

    public Connection getConnection(){
        return con;
    }
}
