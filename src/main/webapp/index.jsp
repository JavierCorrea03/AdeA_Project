<%-- 
    Document   : login
    Created on : 19/07/2023, 09:53:43 PM
    Author     : javie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AdeA JSP Page</title>
        <link rel="icon" type="image/png" sizes="16x16 32x32" href="vistas/img/favicon.ico">
        <link rel="stylesheet" href="vistas/plugins/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="vistas/plugins/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="vistas/css/sweetalert2.min.css">
        <style>
            .div1, .div2
            {
                display:inline;
            }

            .texto-borde {
                text-shadow: -2px 0 white, 0 2px white,
                    2px 0 white, 0 -2px white
            }
            .bordes{
                background-color: transparent;
                border:none;
            }
            .borde-cerrar{
                border-bottom:none;
            }
            .cerrar{
                box-sizing: content-box;
                width: 1em;
                height: 1em;
                padding: .25em .25em;
                color: #000;
                border: 0;
                border-radius: .25rem;
                opacity: .5;
                background: transparent;
                padding: .5rem .5rem;
                margin: -.5rem -.5rem -.5rem auto;
                font-size: 30px;
            }
            .modal-header{
                padding: 0rem 1rem;
            }
            .puntero{
                cursor: pointer;
            }
            .borde-card{
                border:none;
            }
            body {
                background-position: center center;
                background-repeat: no-repeat;
                background-color: #465385; /* Color de la empresa */
                background-attachment: fixed;
                background-size: cover;
            }
        </style>
    </head>
    <body>
        <div class="container w-50 bg-white mt-5 mb-5 rounded shadow">
            <div class="row align-items-stretch">
                <div class="col bg-light p-5 rounded-end">
                    
                    <!-- IMAGEN ADEA -->
                    <div class="text-center imagen">
                        <img class="img-fluid" src="vistas/img/ADEA-Mx-Logo.png" height="auto" max-width:100%>
                    </div>
                    
                    <!-- TITULO -->
                    <h2 class="fw-bold text-center py-4">Iniciar sesión</h2>

                    <!-- FORMULARIO LOGIN -->
                    <form id="validar_usuario">
                        <!-- USUARIO -->
                        <label for="email" class="form-label">Correo electrónico</label>
                        <div class="input-group mb-4">
                            <span class="input-group-text btn-primary" id="user_icon"><i class="fas fa-user"></i></span>
                            <input type="email" class="form-control" name="correo" aria-label="email" aria-describedby="user_icon" required>
                        </div>
                        <!-- CONTRASENIA -->
                        <label for="password" class="form-label">Contraseña</label>
                        <div class="input-group mb-4">
                            <span class="input-group-text btn-primary" id="password_icon"><i class="fas fa-lock"></i></span>
                            <input type="password" class="form-control " name="password" aria-label="password" aria-describedby="password_icon" required>
                        </div>
                        <!-- SUBMIT -->
<!--                        <div class="mb-4 div1">
                            <span><a href="vistas/forgotPassword.jsp">Forgot your password?</a></span>
                        </div>-->
                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">Log-in</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <!<!-- MODAL CARGANDO -->
        <div id="modal_cargando" class="modal fade" tabindex="-5" style="opacity: 0.4; background-color: black;" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog" style="margin-top: 25%;">
                <div style="display: flex; justify-content: center; align-items: center;">
                    <center>
                        <span class="spinner-border text-white"></span>
                        <strong>
                            <div style='#FFFFFF'>Cargando...</div>
                        </strong>
                    </center>
                </div>
            </div>
        </div>
        
        <!<!-- SCRIPTS -->
        <script src="vistas/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script type="text/javascript" src="vistas/plugins/toastr/toastr.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/morris.js/0.5.1/morris.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/11.3.6/sweetalert2.min.js"></script>
        
        <script>
            $("#validar_usuario").submit(function (e) {
                e.preventDefault(); 
                
                var form_datos = new FormData(document.getElementById("validar_usuario"));
                abrir_modal("modal_cargando");
                $.ajax({
                    url: "usuario/validarUsuario",
                    type: "POST",
                    dataType: "JSON",
                    data: form_datos,
                    cache: false,
                    contentType: false,
                    processData: false
                }).done(function (res) {
console.log("res"+JSON.stringify(res));
                    cerrar_modal("modal_cargando");
                });
            });
            
        </script>
        
        <!<!-- MODAL  -->
        <script>
            function abrir_modal(div) {
                $('#' + div).css("display", "block");
            }

            function cerrar_modal(div) {
                $('#' + div).css("display", "none");
            }
        </script>
        
    </body>
</html>
