
package MetodosGenericos;

import java.util.Base64;

/**
 * @author javie
 */
public class contrasenias {

    public String encriptar(String pass_original){
        
        String originalInput = pass_original;
        String pass_encriptada = Base64.getEncoder().encodeToString(originalInput.getBytes());

        return pass_encriptada;
    }

    public String desencriptar(String pass_encriptada){
        
        byte[] bytes_desencriptados = Base64.getDecoder().decode(pass_encriptada);
        String pass_desencriptada = new String(bytes_desencriptados);

        return pass_desencriptada;
    }
    
}
