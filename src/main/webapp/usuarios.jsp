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
        <title>Usuaarios AdeA</title>
        <!---------- CSS ---------->
        <link rel="icon" type="image/png" sizes="16x16 32x32" href="vistas/img/favicon.ico">
        <!-- Google Font: Source Sans Pro -->
<!--        <link rel="stylesheet"
            href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">-->
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
                <!-- Contenido principal -->
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
                                <div class="card-body">
                                    <!-- BOTONES DE FILTRO Y ADICION DE USUARIO -->
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
                                        <!<!-- REVOCADOS -->
                                        <div class="col-md-2 col-sm-12 text-left" style="padding: 10px .5rem;">
                                        </div>
                                        <!<!-- ADD USUARIO -->
                                        <div class="col-md-2 col-sm-12 text-right" style="padding: 10px .5rem;">
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
                cargar_tabla();
            });
            
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
                                // botones editar y eliminar
                                if(row.status == "R"){ // deshabilitar boton de eliminar si es estatus R
                                    var boton = "<td>"
                                            + "<button type='button' title='Editar' data-toggle='tooltip' class='btn btn-info block editar-usuario' id-usuario='" + row.id_usuario + "'>"
                                            + "<i class='fas fa-edit' aria-hidden='true'></i>"
                                            + "</button> "
                                            + "<button type='button' title='Baja' data-toggle='tooltip' class='btn btn-danger block eliminar-usuario' onclick='eliminar_usuario(" + row.id_usuario + " )' id-usuario='" + row.id_usuario + "' disabled>"
                                            + "<i class='fas fa-trash-alt' aria-hidden='true'></i>"
                                            + "</button>"
                                        + "</td>";
                                }else if (row.status == "A" || row.status == "B"){ // boton eliminar activo
                                    var boton = "<td>"
                                            + "<button type='button' title='Editar' data-toggle='tooltip' class='btn btn-info block editar-usuario' id-usuario='" + row.id_usuario + "'>"
                                            + "<i class='fas fa-edit' aria-hidden='true'></i>"
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
                                // botones editar y eliminar
                                if(row.status == "R"){ // deshabilitar boton de eliminar si es estatus R
                                    var boton = "<td>"
                                            + "<button type='button' title='Editar' data-toggle='tooltip' class='btn btn-info block editar-usuario' id-usuario='" + row.id_usuario + "'>"
                                            + "<i class='fas fa-edit' aria-hidden='true'></i>"
                                            + "</button> "
                                            + "<button type='button' title='Baja' data-toggle='tooltip' class='btn btn-danger block eliminar-usuario' onclick='eliminar_usuario(" + row.id_usuario + " )' id-usuario='" + row.id_usuario + "' disabled>"
                                            + "<i class='fas fa-trash-alt' aria-hidden='true'></i>"
                                            + "</button>"
                                        + "</td>";
                                }else if (row.status == "A" || row.status == "B"){ // boton eliminar activo
                                    var boton = "<td>"
                                            + "<button type='button' title='Editar' data-toggle='tooltip' class='btn btn-info block editar-usuario' id-usuario='" + row.id_usuario + "'>"
                                            + "<i class='fas fa-edit' aria-hidden='true'></i>"
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
            
            // ANIADIR USUARIO
            $("#add_usuario").on('click', function(){
                console.log("aniadir usu");
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
                            cargar_tabla()
                        });
                        
                    }
                });
            };
            
        </script>
        
        <!<!-- MODAL -->
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
