<%-- 
    Document   : usuarios
    Created on : 21/07/2023, 11:11:05 AM
    Author     : javie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Usuarios AdeA</title>
        <!---------- CSS ---------->
        <link rel="icon" type="image/png" sizes="16x16 32x32" href="vistas/img/favicon.ico">
        <!-- Font Awesome Icons -->
        <link rel="stylesheet" href="vistas/plugins/fontawesome/css/all.min.css">
        <!-- Theme style -->
        <link rel="stylesheet" href="vistas/plugins/adminlte/css/adminlte.min.css">
        <!-- Libreria CSS para alertas SweetAlert-->
        <link rel="stylesheet" type="text/css" href="vistas/plugins/sweetalert2/sweetalert2.min.css">
        <!-- Libreria CSS para alertas toast -->
        <link rel="stylesheet" type="text/css" href="vistas/plugins/toastr/toastr.css" /> 
        <!-- Libreria para DataTables -->
        <link rel="stylesheet" type="text/css" href="vistas/plugins/DataTables/DataTables-1.11.3/css/dataTables.bootstrap5.min.css">
        <style>
            .noHover{
                pointer-events: none;
            }
            body {
                background-position: center center;
                background-repeat: no-repeat;
                background-color: #C7C9FF;
                background-attachment: fixed;
                background-size: cover;
            }
        </style>
    </head>
    <body>
        <div class="wrapper">
            <section class="content" style="padding: 10px .5rem;">
                <!-- CONTENIDO PRINCIPAL -->
                <div class="container">
                    <div class="row">
                        <div class="col-12">
                            <div class="card card-primary">
                                <!-- ENCABEZADO -->
                                <div class="card-header" style="background-color: #465385;">
                                    <div class="content-header" style="padding: 0px .5rem;">
                                        <div class="container-fluid">
                                            <div class="row">
                                                <div class="col-sm-3">
                                                    <!-- TITULO -->
                                                    <h1 class="m-0" style="font-size: 22px;">
                                                        <i class="fas fa-user"></i> Usuarios
                                                    </h1>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- BOTONES DE FILTRO Y ADICION DE USUARIO -->
                                <div class="card-body">
                                    <div class="row col-12">
                                        <!<!-- TODOS -->
                                        <div class="col-md-2 col-sm-12 text-center" style="padding: 10px .5rem;">
                                            <button type="button" class="btn btn-info" data-toggle='tooltip' title="Listar todos los usuarios" id="listar_todos">
                                                Todos
                                            </button>
                                        </div>
                                        <!<!-- ACTIVOS -->
                                        <div class="col-md-2 col-sm-12 text-center" style="padding: 10px .5rem;">
                                            <button type="button" class="btn btn-success filtro" value="A" data-toggle='tooltip' title="Listar usuarios activos" id="listar_activos">
                                                Activos
                                            </button>
                                        </div>
                                        <!<!-- INACTIVOS -->
                                        <div class="col-md-2 col-sm-12 text-center" style="padding: 10px .5rem;">
                                            <button type="button" class="btn btn-secondary filtro" value="B" data-toggle='tooltip' title="Listar usuarios inactivos" id="listar_inactivos">
                                                Inactivos
                                            </button>
                                        </div>
                                        <!<!-- REVOCADOS -->
                                        <div class="col-md-2 col-sm-12 text-center" style="padding: 10px .5rem;">
                                            <button type="button" class="btn btn-danger filtro" value="R" data-toggle='tooltip' title="Listar usuarios revocados" id="listar_revocados">
                                                Revocados
                                            </button>
                                        </div>
                                        <!<!-- ADD USUARIO -->
                                        <div class="col-md-4 col-sm-12 text-right" style="padding: 10px .5rem;">
                                            <button type="button" class="btn btn-info" value="ADD" data-toggle='tooltip' title="A{adir usuario" id="add_usuario">
                                                <i class="fas fa-plus"></i> Añadir Usuario
                                            </button>
                                        </div>
                                    </div>
                                    <!-- TABLA -->
                                    <div class="table-responsive" id="div_tabla_usuarios">
                                        <!-- Contenido Tabla Tarimas -->
                                        <table class="table table-hover table-striped table-bordered dt-responsive nowrap" id="tabla_usuarios" style="width:100%">
                                            <thead style="color: #FFF; background-color: #465385; text-align: center;">
                                                <tr>
                                                    <th class="text-center">#</th>
                                                    <th>Nombre</th>
                                                    <th>Login</th>
                                                    <th>Fecha alta</th>
                                                    <th>Estatus</th>
                                                    <th>Acciones</th>
                                                </tr>
                                            </thead>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
        
        <!-- MODAL AGREGAR USUARIO -->    
        <div class="modal fade" id="modal_usuario" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="myLargeModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl">
                <div class="modal-content">
                    <!-- ENCABEZADO -->
                    <div class="modal-header" style="background-color:#465385">
                        <h5 class="modal-title" id="titulo_modal" style="color: white;">Añadir usuario</h5>
                        <button type="button" class="close" onclick="$('#modal_usuario').modal('hide')" aria-label="Close" style="color: white;">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form id="formNuevoUsuario">
                        <div class="card-body">
                            <!-- DIV DATOS GENERALES DEL USUARIO -->
                            <div class="row mb-2 match-height">
                                <!-- NOMBRE -->
                                <div class="col-sm-12 col-md-12 col-lg-3">
                                    <label>Nombre</label>
                                    <input type="text" onkeyup="return (this.value = this.value.replace(/[^a-zA-Z0-9]/,''))" autocomplete="off" class="form-control nom_usuario" id="nombre_usuario" name="nombre_usuario" required>
                                </div>
                                <!-- PRIMER APELLIDO -->
                                <div class="col-sm-12 col-md-12 col-lg-3">
                                    <label>Primer Apellido</label>
                                    <input type="text" onkeyup="return (this.value = this.value.replace(/[^a-zA-Z0-9]/,''))" autocomplete="off" class="form-control nom_usuario" id="primer_apellido" name="primer_apellido" required>
                                </div>
                                <!-- SEGUNDO APELLIDO -->
                                <div class="col-sm-12 col-md-12 col-lg-3">
                                    <label>Segundo Apellido</label>
                                    <input type="text" onkeyup="return (this.value = this.value.replace(/[^a-zA-Z0-9]/,''))" autocomplete="off" class="form-control" id="segundo_apellido" name="segundo_apellido">
                                    </select>
                                </div>
                                <!-- LOGIN DE USUARIO -->
                                <div class="col-sm-12 col-md-12 col-lg-3">
                                    <label>Nombre de usuario</label>
                                    <input type="text" autocomplete="off" class="form-control" id="nombre_login" name="nombre_login" readonly>
                                </div>
                            </div>
                            <div class="row mb-2 match-height">
                                <!-- EMAIL -->
                                <div class="col-sm-12 col-md-12 col-lg-3">
                                    <label>Email</label>
                                    <input type="email" autocomplete="off" class="form-control" id="correo" name="correo">
                                </div>
                                <!-- CONTRASENIA -->
                                <div class="col-sm-12 col-md-12 col-lg-3">
                                    <label>Constraseña</label>
                                    <input type="password" autocomplete="off" class="form-control" id="password" name="password" required>
                                </div>
                                <!-- FECHA VIGENCIA -->
                                <div class="col-sm-12 col-md-12 col-lg-3">
                                    <label>Fecha vigencia</label>
                                    <input type="date" class="form-control" id="fecha_vigencia">
                                </div>
                            </div>
                            <div class="row mb-2 match-height">
                                <!-- CLIENTE -->
                                <div class="col-sm-12 col-md-12 col-lg-3">
                                    <label>Cliente</label>
                                    <input type="number" autocomplete="off" class="form-control" id="cliente" name="cliente" required>
                                </div>
                                <!-- AREA -->
                                <div class="col-sm-12 col-md-12 col-lg-3">
                                    <label>Área</label>
                                    <input type="number" autocomplete="off" class="form-control" id="area" name="area">
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" id="boton_guardar" class="btn btn-success mt-1 waves-effect waves-light">Guardar</button>
                                <button type="button" class="btn btn-danger" onclick="$('#modal_usuario').modal('hide')">Cerrar</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <!-- MODAL EDITAR USUARIO -->    
        <div class="modal fade" id="modal_editar_usuario" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="myLargeModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl">
                <div class="modal-content">
                    <!-- ENCABEZADO -->
                    <div class="modal-header" style="background-color:#465385">
                        <h5 class="modal-title" id="titulo_modal_edit_user" style="color: white;">Editar usuario</h5>
                        <button type="button" class="close" onclick="$('#modal_editar_usuario').modal('hide')" aria-label="Close" style="color: white;">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form id="formEditUsuario">
                        <div class="card-body">
                            <!-- DIV DATOS GENERALES DEL USUARIO -->
                            <div class="row mb-2 match-height">
                                <!-- CAMPO ID_USUARIO OCULTO -->
                                <input type="text" autocomplete="off" class="form-control" id="edit_id_usuario" name="edit_id_usuario" hidden>
                                <!-- NOMBRE -->
                                <div class="col-sm-12 col-md-12 col-lg-3">
                                    <label>Nombre</label>
                                    <input type="text" onkeyup="return (this.value = this.value.replace(/[^a-zA-Z0-9]/,''))" autocomplete="off" class="form-control nom_usuario" id="edit_nombre_usuario" name="edit_nombre_usuario" required>
                                </div>
                                <!-- PRIMER APELLIDO -->
                                <div class="col-sm-12 col-md-12 col-lg-3">
                                    <label>Primer Apellido</label>
                                    <input type="text" onkeyup="return (this.value = this.value.replace(/[^a-zA-Z0-9]/,''))" autocomplete="off" class="form-control nom_usuario" id="edit_primer_apellido" name="edit_primer_apellido" required>
                                </div>
                                <!-- SEGUNDO APELLIDO -->
                                <div class="col-sm-12 col-md-12 col-lg-3">
                                    <label>Segundo Apellido</label>
                                    <input type="text" onkeyup="return (this.value = this.value.replace(/[^a-zA-Z0-9]/,''))" autocomplete="off" class="form-control" id="edit_segundo_apellido" name="edit_segundo_apellido">
                                    </select>
                                </div>
                                <!-- LOGIN DE USUARIO -->
                                <div class="col-sm-12 col-md-12 col-lg-3">
                                    <label>Nombre de usuario</label>
                                    <input type="text" autocomplete="off" class="form-control" id="edit_nombre_login" name="edit_nombre_login" readonly>
                                </div>
                            </div>
                            <div class="row mb-2 match-height">
                                <!-- EMAIL -->
                                <div class="col-sm-12 col-md-12 col-lg-3">
                                    <label>Email</label>
                                    <input type="email" autocomplete="off" class="form-control" id="edit_correo" name="edit_correo">
                                </div>
                                <!-- CONTRASENIA -->
                                <div class="col-sm-12 col-md-12 col-lg-3">
                                    <label>Constraseña</label>
                                    <input type="password" autocomplete="off" class="form-control" id="edit_password" name="edit_password" required>
                                </div>
                                <!-- FECHA VIGENCIA -->
                                <div class="col-sm-12 col-md-12 col-lg-3">
                                    <label>Fecha vigencia</label>
                                    <input type="date" class="form-control" id="edit_fecha_vigencia">
                                </div>
                            </div>
                            <div class="row mb-2 match-height">
                                <!-- CLIENTE -->
                                <div class="col-sm-12 col-md-12 col-lg-3">
                                    <label>Cliente</label>
                                    <input type="number" autocomplete="off" class="form-control" id="edit_cliente" name="edit_cliente" required>
                                </div>
                                <!-- AREA -->
                                <div class="col-sm-12 col-md-12 col-lg-3">
                                    <label>Área</label>
                                    <input type="number" autocomplete="off" class="form-control" id="edit_area" name="edit_area">
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" id="boton_guardar_edicion" class="btn btn-success mt-1 waves-effect waves-light">Guardar</button>
                                <button type="button" class="btn btn-danger" onclick="$('#modal_editar_usuario').modal('hide')">Cerrar</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <!-- MODAL CARGANDO -->
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
        
        <!---------- JS ---------->
        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!-- Bootstrap -->
        <script src="vistas/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
        <!-- AdminLTE App -->
        <script src="vistas/plugins/adminlte/js/adminlte.min.js"></script>
        <!-- Libreria JS para alertas SweetAlert-->
        <script type="text/javascript" src="vistas/plugins/sweetalert2/sweetalert2.min.js"></script>
        <!-- Libreria JS para alertas toast -->
        <script type="text/javascript" src="vistas/plugins/toastr/toastr.min.js"></script>
        <!-- Libreria JS para alertas toast -->
        <script type="text/javascript" src="vistas/plugins/DataTables/DataTables-1.11.3/js/jquery.dataTables.min.js"></script>
        <!-- Libreria DataTable-->
        <script type="text/javascript" src="vistas/plugins/DataTables/DataTables-1.11.3/js/dataTables.bootstrap5.min.js"></script>
        
        <script>
            // AL CARGAR LA PAGINA
            $(document).ready(function(){
                comprobar_vigencia();
            });
            
            // COMPRUEBA SI HAY USUARIOS CON VIGENCIA VENCIDA Y LOS CAMBIA DE STATUS
            function comprobar_vigencia(){
                $.ajax({
                    url: "usuario/comprobarVigencia",
                    cache: false,
                    contentType: false,
                    processData: false
                }).done(function (res) {
                    cargar_tabla();
                });
            }
            
            //-- CARGAR TABLA USUARIOS - TODOS LOS USUARIOS  
            var tabla_principal = "";
            function cargar_tabla() {

                abrir_modal("modal_cargando");
                var contador = 0;

                tabla_principal = $('#tabla_usuarios').DataTable({
                    "iDisplayStart": 0,
                    "iDisplayLength": 10,
                    "bPaginate": true,
                    "bSort": true,
                    "scrollX": true,
                    "language": {
                        "emptyTable": "No hay datos disponibles en la tabla",
                        "lengthMenu": "Mostrar _MENU_ entradas",
                        "search": "Buscar:",
                        "info": "Mostrando _START_ a _END_ de _TOTAL_ registros",
                        "infoEmpty": "Mostrando _START_ a _END_ de _TOTAL_ registros",
                        "infoFiltered": "(filtrado de _MAX_ entradas totales)",
                        "zeroRecords": "No se encontraron registros coincidentes",
                        "paginate": {
                            "next": "Siguiente",
                            "previous": "Anterior"
                        }
                    },
                    "preDrawCallback": function (settings) {
                        contador = 1;
                    },
                    "rowCallback": function (row, data) {
                        $(row).find('td:eq(0), td:eq(1), td:eq(2), td:eq(3), td:eq(4), td:eq(5)').addClass('text-center');
                    },
                    ajax: {
                        url: "usuario/listarTodos",
                        method: "POST",
                        error: function (d) {
                            efecto_error("No fue posible cargar la tabla, por favor, intente de nuevo.");
                            cerrar_modal("modal_cargando");
                        }
                    },
                    columns: [
                        {
                            "defaultContent": "",
                            "render": function (data, type, row) {
                                return contador++;
                            }, visible: true
                        },
                        {"data": "nombre"},
                        {"data": "login"},
                        {"data": "fecha_alta"},
                        {"data": "status"},
                        {
                            "defaultContent": "",
                            "render": function (data, type, row) {
                                // BOTONES EDITAR, REACTIVAR Y ELIMINAR
                                var boton = "";
                                if(row.status == "R"){ // USUARIO REVOCADO
                                    boton = "<td>"
                                            + "<button type='button' title='Editar' data-toggle='tooltip' class='btn btn-info block editar-usuario' onclick='editar_usuario(" + row.id_usuario + " )' id-usuario='" + row.id_usuario + "'>"
                                            + "<i class='fas fa-edit' aria-hidden='true'></i>"
                                            + "</button> "
                                            + "<button type='button' title='Reactivar usuario' data-toggle='tooltip' class='btn btn-success block reactivar-usuario' onclick='reactivar_usuario(" + row.id_usuario + " )' id-usuario='" + row.id_usuario + "'>"
                                            + "<i class='fas fa-trash-restore' aria-hidden='true'></i>"
                                            + "</button>"
                                        + "</td>";
                                }else if (row.status == "A"){ // USUARIO ACTIVO
                                    boton = "<td>"
                                            + "<button type='button' title='Editar' data-toggle='tooltip' class='btn btn-info block editar-usuario' onclick='editar_usuario(" + row.id_usuario + " )' id-usuario='" + row.id_usuario + "'>"
                                            + "<i class='fas fa-edit' aria-hidden='true'></i>"
                                            + "</button> "
                                            + "<button type='button' title='Baja' data-toggle='tooltip' class='btn btn-danger block eliminar-usuario' onclick='eliminar_usuario(" + row.id_usuario + " )' id-usuario='" + row.id_usuario + "'>"
                                            + "<i class='fas fa-trash-alt' aria-hidden='true'></i>"
                                            + "</button>"
                                        + "</td>";
                                }else if(row.status == "B"){ // USUARIO INACTIVO
                                    boton = "<td>"
                                            + "<button type='button' title='Editar' data-toggle='tooltip' class='btn btn-info block editar-usuario' onclick='editar_usuario(" + row.id_usuario + " )' id-usuario='" + row.id_usuario + "'>"
                                            + "<i class='fas fa-edit' aria-hidden='true'></i>"
                                            + "</button> "
                                            + "<button type='button' title='Reactivar usuario' data-toggle='tooltip' class='btn btn-success block reactivar-usuario' onclick='reactivar_usuario(" + row.id_usuario + " )' id-usuario='" + row.id_usuario + "'>"
                                            + "<i class='fas fa-trash-restore' aria-hidden='true'></i>"
                                            + "</button> "
                                            + "<button type='button' title='Baja' data-toggle='tooltip' class='btn btn-danger block eliminar-usuario' onclick='eliminar_usuario(" + row.id_usuario + " )' id-usuario='" + row.id_usuario + "'>"
                                            + "<i class='fas fa-trash-alt' aria-hidden='true'></i>"
                                            + "</button>"
                                        + "</td>";
                                }
                                return boton;
                            }
                        }
                    ],
                    "destroy": true
                }).on("draw", function () {
                    cerrar_modal("modal_cargando");
                });
            };
            
            // RECARGAR TABLA USUARIOS POR FILTRO
            $(".filtro").on('click', function(){

                abrir_modal("modal_cargando");
                var contador = 0;
                var filtro = $(this).attr("value");
                
                tabla_principal = $('#tabla_usuarios').DataTable({
                    "iDisplayStart": 0,
                    "iDisplayLength": 10,
                    "bPaginate": true,
                    "bSort": true,
                    "scrollX": true,
                    "language": {
                        "emptyTable": "No hay datos disponibles en la tabla",
                        "lengthMenu": "Mostrar _MENU_ entradas",
                        "search": "Buscar:",
                        "info": "Mostrando _START_ a _END_ de _TOTAL_ registros",
                        "infoEmpty": "Mostrando _START_ a _END_ de _TOTAL_ registros",
                        "infoFiltered": "(filtrado de _MAX_ entradas totales)",
                        "zeroRecords": "No se encontraron registros coincidentes",
                        "paginate": {
                            "next": "Siguiente",
                            "previous": "Anterior"
                        }
                    },
                    "preDrawCallback": function (settings) {
                        contador = 1;
                    },
                    "rowCallback": function (row, data) {
                        $(row).find('td:eq(0), td:eq(1), td:eq(2), td:eq(3), td:eq(4), td:eq(5)').addClass('text-center');
                    },
                    ajax: {
                        url: "usuario/listarPorFiltro",
                        method: "POST",
                        data: function(d){
                            d.filtro = filtro;
                        },
                        error: function (d) {
                            efecto_error("No fue posible cargar la tabla, por favor, intente de nuevo.");
                            cerrar_modal("modal_cargando");
                        }
                    },
                    columns: [
                        {
                            "defaultContent": "",
                            "render": function (data, type, row) {
                                return contador++;
                            }, visible: true
                        },
                        {"data": "nombre"},
                        {"data": "login"},
                        {"data": "fecha_alta"},
                        {"data": "status"},
                        {
                            "defaultContent": "",
                            "render": function (data, type, row) {
                                // BOTONES EDITAR, REACTIVAR Y ELIMINAR
                                var boton = "";
                                if(row.status == "R"){ // USUARIO REVOCADO
                                    boton = "<td>"
                                            + "<button type='button' title='Editar' data-toggle='tooltip' class='btn btn-info block editar-usuario' onclick='editar_usuario(" + row.id_usuario + " )' id-usuario='" + row.id_usuario + "'>"
                                            + "<i class='fas fa-edit' aria-hidden='true'></i>"
                                            + "</button> "
                                            + "<button type='button' title='Reactivar usuario' data-toggle='tooltip' class='btn btn-success block reactivar-usuario' onclick='reactivar_usuario(" + row.id_usuario + " )' id-usuario='" + row.id_usuario + "'>"
                                            + "<i class='fas fa-trash-restore' aria-hidden='true'></i>"
                                            + "</button>"
                                        + "</td>";
                                }else if (row.status == "A"){ // USUARIO ACTIVO
                                    boton = "<td>"
                                            + "<button type='button' title='Editar' data-toggle='tooltip' class='btn btn-info block editar-usuario' onclick='editar_usuario(" + row.id_usuario + " )' id-usuario='" + row.id_usuario + "'>"
                                            + "<i class='fas fa-edit' aria-hidden='true'></i>"
                                            + "</button> "
                                            + "<button type='button' title='Baja' data-toggle='tooltip' class='btn btn-danger block eliminar-usuario' onclick='eliminar_usuario(" + row.id_usuario + " )' id-usuario='" + row.id_usuario + "'>"
                                            + "<i class='fas fa-trash-alt' aria-hidden='true'></i>"
                                            + "</button>"
                                        + "</td>";
                                }else if(row.status == "B"){ // USUARIO INACTIVO
                                    boton = "<td>"
                                            + "<button type='button' title='Editar' data-toggle='tooltip' class='btn btn-info block editar-usuario' onclick='editar_usuario(" + row.id_usuario + " )' id-usuario='" + row.id_usuario + "'>"
                                            + "<i class='fas fa-edit' aria-hidden='true'></i>"
                                            + "</button> "
                                            + "<button type='button' title='Reactivar usuario' data-toggle='tooltip' class='btn btn-success block reactivar-usuario' onclick='reactivar_usuario(" + row.id_usuario + " )' id-usuario='" + row.id_usuario + "'>"
                                            + "<i class='fas fa-trash-restore' aria-hidden='true'></i>"
                                            + "</button> "
                                            + "<button type='button' title='Baja' data-toggle='tooltip' class='btn btn-danger block eliminar-usuario' onclick='eliminar_usuario(" + row.id_usuario + " )' id-usuario='" + row.id_usuario + "'>"
                                            + "<i class='fas fa-trash-alt' aria-hidden='true'></i>"
                                            + "</button>"
                                        + "</td>";
                                }
                                return boton;
                            }
                        }
                    ],
                    "destroy": true
                }).on("draw", function () {
                    cerrar_modal("modal_cargando");
                });
            });
            
            // VOLVER A LISTAR TODOS LOS USUARIOS EN LA TABLA PRINCIPAL
            $("#listar_todos").on('click', function(){
                cargar_tabla();
            });
            
            // ANIADIR USUARIO (ABRIR MODAL)
            $("#add_usuario").on('click', function(){
                $('#formNuevoUsuario')[0].reset();
                $("#modal_usuario").modal('show');
            });
            
            // ANIADIR USUARIO (SUBMIT MODAL)
            $("#formNuevoUsuario").submit(function(e){
                e.preventDefault(); 
                
                var form_datos = new FormData(document.getElementById("formNuevoUsuario"));
                var fecha = new Date($("#fecha_vigencia").val());
                var dia = fecha.getDate();
                var mes = fecha.getMonth()+1;
                var anio = fecha.getFullYear();
                form_datos.append("fecha_vigencia", anio+"-"+mes+"-"+dia);
                
                abrir_modal("modal_cargando");
                $.ajax({
                    url: "usuario/addUsuario",
                    type: "POST",
                    dataType: "JSON",
                    data: form_datos,
                    cache: false,
                    contentType: false,
                    processData: false
                }).done(function (res) {
                    
                    if(res.data == true){
                        cerrar_modal("modal_cargando");
                        $("#modal_usuario").modal('hide');
                        Swal.fire({
                            icon: 'success',
                            title: '¡Éxito!',
                            text: 'El usuario ha sido creado satisfactoriamente.'
                        });
                        cargar_tabla();
                    }
                });
            });
            
            // OBTENER NOMBRE DE USUARIO CON LOS INPUTS NOMBRE Y APELLIDO (AL ANIADIR Y EDITAR USUARIO)
            $(".nom_usuario").on('keyup', function(){
                
                //-------- PARA NUEVO USUARIO ---------
                var nombre_usuario = $("#nombre_usuario").val().toLowerCase();
                var inicial_nombre = nombre_usuario.substr(0, 1);
                var primer_apellido = $("#primer_apellido").val().toLowerCase();
                $("#nombre_login").val(inicial_nombre+primer_apellido);
                
                //-------- PARA EDITAR USUARIO ---------
                var edit_nombre_usuario = $("#edit_nombre_usuario").val().toLowerCase();
                var edit_inicial_nombre = edit_nombre_usuario.substr(0, 1);
                var edit_primer_apellido = $("#edit_primer_apellido").val().toLowerCase();
                $("#edit_nombre_login").val(edit_inicial_nombre+edit_primer_apellido);
            });
            
            // EDITAR USUARIO (ABRIR MODAL PARA CARGAR SUS DATOS)
            function editar_usuario(id){
                
                abrir_modal("modal_cargando");
                $('#formEditUsuario')[0].reset();
                
                var form_datos = new FormData();
                form_datos.append("id_usuario", id);
                
                $.ajax({
                    url: "usuario/listarUno",
                    type: "POST",
                    dataType: "JSON",
                    data: form_datos,
                    cache: false,
                    contentType: false,
                    processData: false
                }).done(function (res) {
                    cerrar_modal("modal_cargando");
                    
                    // Setear datos de la consulta en los input
                    $("#edit_id_usuario").val(res.data[0].id_usuario);
                    $("#edit_nombre_usuario").val(res.data[0].nombre);
                    $("#edit_primer_apellido").val(res.data[0].apellido_paterno);
                    $("#edit_segundo_apellido").val(res.data[0].apellido_materno);
                    $("#edit_nombre_login").val(res.data[0].login);
                    $("#edit_correo").val(res.data[0].email);
                    $("#edit_password").val(res.data[0].password);
                    $("#edit_fecha_vigencia").val(res.data[0].fecha_vigencia);
                    $("#edit_cliente").val(res.data[0].cliente);
                    $("#edit_area").val(res.data[0].area);
                     
                    $("#modal_editar_usuario").modal('show');
                });
            } 
            
            // EDITAR USUARIO (SUBMIT MODAL)
            $("#formEditUsuario").submit(function(e){
                e.preventDefault(); 
                
                var form_datos = new FormData(document.getElementById("formEditUsuario"));
                var fecha = new Date($("#edit_fecha_vigencia").val());
                var dia = fecha.getDate();
                var mes = fecha.getMonth()+1;
                var anio = fecha.getFullYear();
                form_datos.append("edit_fecha_vigencia", anio+"-"+mes+"-"+dia);
                
                abrir_modal("modal_cargando");
                $.ajax({
                    url: "usuario/editUsuario",
                    type: "POST",
                    dataType: "JSON",
                    data: form_datos,
                    cache: false,
                    contentType: false,
                    processData: false
                }).done(function (res) {
                    
                    if(res.data == true){
                        cerrar_modal("modal_cargando");
                        $("#modal_editar_usuario").modal('hide');
                        Swal.fire({
                            icon: 'success',
                            title: '¡Éxito!',
                            text: 'El usuario ha sido modificaado satisfactoriamente.'
                        });
                        cargar_tabla();
                    }
                });
            });
            
            // ELIMINAR USUARIO
            function eliminar_usuario(id){
                
                Swal.fire({
                    icon: 'warning',
                    title: '¡Atención!',
                    text: 'Está a punto de eliminar esta cuenta de usuario ¿Desea continuar?',
                    showDenyButton: true,
                    confirmButtonText: 'Continuar',
                    denyButtonText: 'Cancelar'
                }).then((result) => {
                    if (result.isConfirmed){
                        
                        var form_datos = new FormData();
                        form_datos.append("id_usuario", id);

                        abrir_modal("modal_cargando");
                        $.ajax({
                            url: "usuario/eliminarUsuario",
                            type: "POST",
                            dataType: "JSON",
                            data: form_datos,
                            cache: false,
                            contentType: false,
                            processData: false
                        }).done(function (res) {
                            
                            cerrar_modal("modal_cargando");
                            Swal.fire({
                                icon: 'success',
                                title: '¡Correcto!',
                                text: 'El usuario ha sido eliminado satisfactoriamente.'
                            });
                            cargar_tabla();
                        });
                    }
                });
            };
            
            // REACTIVAR USUARIO ELIMINADO SETEANDO SU FECHA_VIGENCIA EN NULL Y ESTATUS = A
            function reactivar_usuario(id){
                
                Swal.fire({
                    icon: 'warning',
                    title: '¡Atención!',
                    text: 'Está a punto de activar un usuario eliminado anteriormente. ¿Desea continuar?',
                    showDenyButton: true,
                    confirmButtonText: 'Continuar',
                    denyButtonText: 'Cancelar'
                }).then((result) => {
                    if (result.isConfirmed){
                        
                        var form_datos = new FormData();
                        form_datos.append("id_usuario", id);

                        abrir_modal("modal_cargando");
                        $.ajax({
                            url: "usuario/reactivarUsuario",
                            type: "POST",
                            dataType: "JSON",
                            data: form_datos,
                            cache: false,
                            contentType: false,
                            processData: false
                        }).done(function (res) {
                            
                            cerrar_modal("modal_cargando");
                            Swal.fire({
                                icon: 'success',
                                title: '¡Correcto!',
                                text: 'El usuario ha sido reactivado satisfactoriamente.'
                            });
                            cargar_tabla();
                        });
                    }
                });
            };
            
        </script>
        
        <!-- MODAL -->
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
