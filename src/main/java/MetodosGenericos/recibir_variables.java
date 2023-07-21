
package MetodosGenericos;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;

/**
 * @author javie
 */
public class recibir_variables {
    /*@serialData recibir permite recibir los diferentes tipos de variables */
    public HashMap<String, HashMap> recibir(HttpServletRequest request) throws FileUploadException, UnsupportedEncodingException{

        FileItemFactory file_factory = new DiskFileItemFactory();

        ServletFileUpload servlet_up = new ServletFileUpload(file_factory);
        servlet_up.setHeaderEncoding("UTF-8"); 

            
            HashMap<String,String> parametros=new HashMap<String,String>();
            HashMap<String, FileItem> archivos = new HashMap<String,FileItem>();
            HashMap<String, HashMap> datos = new HashMap<String,HashMap>();

        try{
            List items = servlet_up.parseRequest(request);
            for(int i = 0;i < items.size(); i++){

                FileItem item = (FileItem) items.get(i);
                String valor = "";

                if (item.isFormField()){
                    valor = new String(item.getString().getBytes("ISO-8859-15"), "UTF-8");
                }else{
                    valor = item.getName();
                }
                String varible = item.getFieldName();
                
                String ext = FilenameUtils.getExtension(valor);
                if(!ext.equals("")){
                    archivos.put(valor, item);        
                }

                parametros.put(varible, valor);
            }
        }catch(Exception e){
            for (Map.Entry<String, String[]> entry : request.getParameterMap().entrySet()) {
                parametros.put(entry.getKey(), entry.getValue()[0]);
            }
        }
        datos.put("parametros", parametros);
        datos.put("archivos", archivos);
        
        return datos;
    }
}
