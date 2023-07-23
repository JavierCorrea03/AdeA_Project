
package Controlador;

import MetodosGenericos.recibir_variables;
import Modelo.usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileUploadException;
import org.json.simple.JSONObject;

/**
 * @author javie
 */
@WebServlet(name = "usuarioControl", urlPatterns = {"/usuarioControl"})
public class usuarioControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, FileUploadException {
        response.setContentType("text/html;charset=UTF-8");

        String accion = request.getParameter("accion");

        try (PrintWriter out = response.getWriter()) {
            // Acciones a ejecutar
            switch (accion) {
                case "validarUsuario":
                    out.print(validar_usuario(request).toJSONString());
                    break;
                case "listarTodos":
                    out.print(listar_todos(request).toJSONString());
                    break;
                case "listarPorFiltro":
                    out.print(listar_por_filtro(request).toJSONString());
                    break;
                case "eliminarUsuario":
                    out.print(eliminar_usuario(request).toJSONString());
                    break;
                default:
                    break;
            }
            out.flush();
            out.close();
        } catch (Exception ex) {
            Logger.getLogger(usuarioControl.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected JSONObject validar_usuario(HttpServletRequest request) throws FileUploadException, UnsupportedEncodingException{

        recibir_variables rv = new recibir_variables();
        HashMap<String, String> parametros = new HashMap();
        parametros = rv.recibir(request).get("parametros");

        JSONObject json = new JSONObject();
        usuario u = new usuario();
        try {
            json.put("data", u.validar_usuario(parametros));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return json;
    }

    protected JSONObject listar_todos(HttpServletRequest request) throws FileUploadException, UnsupportedEncodingException{

        JSONObject json = new JSONObject();
        usuario u = new usuario();
        try {
            json.put("data", u.listar_todos());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return json;
    }

    protected JSONObject listar_por_filtro(HttpServletRequest request) throws FileUploadException, UnsupportedEncodingException{

        recibir_variables rv = new recibir_variables();
        HashMap<String, String> parametros = new HashMap();
        parametros = rv.recibir(request).get("parametros");

        JSONObject json = new JSONObject();
        usuario u = new usuario();
        try {
            json.put("data", u.listar_por_filtro(parametros));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return json;
    }

    protected JSONObject eliminar_usuario(HttpServletRequest request) throws FileUploadException, UnsupportedEncodingException{

        recibir_variables rv = new recibir_variables();
        HashMap<String, String> parametros = new HashMap();
        parametros = rv.recibir(request).get("parametros");

        JSONObject json = new JSONObject();
        usuario u = new usuario();
        try {
            json.put("data", u.eliminar_usuario(parametros));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return json;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(usuarioControl.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(usuarioControl.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
