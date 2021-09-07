<%@ Page Title="" Language="C#" MasterPageFile="~/MasterAdminSuc.Master" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="OfertaArticulosSuc.aspx.cs" Inherits="AntilopeWeb.AdminSuc.OfertaArticulosSuc" %>


<asp:Content ID="Content4" ContentPlaceHolderID="CphJsSup" runat="server">    
    <link href="../css/components/bootstrap-datepicker.min.css" rel="stylesheet" />
    <script type="text/javascript">
        function VerDetalle(PLU) {
            window.location.href = "DetalleArticulos.aspx?PLU=" + PLU;
        }
        function CallGetEdit() {
            var PLU = $("#CphBody_TxbCodPLU").val();
            GetEditId(PLU);            
        }
        function CallGetEditPreCarga() {
            var PLU = $("#CphBody_TxbCodPLU").val();
            var NombrePLU = $("#CphBody_TxbNombrePlu").val();
            if (PLU != "") {
                GetEditId(PLU);
            }
            else if (NombrePLU != "") {
                SetGrillaModal(NombrePLU);
            }

        }
        function GetEditIdModal(id) {
            $('#myModalABM').modal('hide');
            GetEditId(id);
        }

        function GetEditId(id) {
            $("[id$=HdnIdArticulo]").val(id);
            var idSucur = $("[id$=HdnIdSucursal]").val();
            $.ajax({
                type: "POST",
                url: "OfertaArticulosSuc.aspx/IniModalEdit",
				data: "{Id:'" + id + "',IdSucursal: " + idSucur + "}",
                traditional: true,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var ListaMC = (typeof response.d) == 'string' ? eval('(' + response.d + ')') : response.d;
                    if (ListaMC[0] == null) {
                        alert('No exiten datos');
                    }
                    else {                        
                        $("#CphBody_ChkOferta").prop('checked', true);
                        $("#TxbPLU").val(ListaMC[0].PLU);
                        $("#TxbDescripcion").val(ListaMC[0].Descripcion);
                        $("#TxbMedida").val(ListaMC[0].Medida);
                        $("#TxbUnidad").val(ListaMC[0].Unidad);
                        $("#TxbSubCategoria").val(ListaMC[0].Id_SubCategoria);                        
                        $("#TxbStrImagen").val(ListaMC[0].StrImagen);
                        $("#ImgProducto").attr("src", ListaMC[0].StrImagen);
                        $("#CphBody_ChkTemporal").prop('checked', ListaMC[0].Temporal);
                        $("#TxbFechaDesde").val(ListaMC[0].FechaInicio);
                        $("#TxbFechaHasta").val(ListaMC[0].FechaFin);


                        $("#TxbPLU").focus();
                    }
                },
                error: function (result) {
                    alert('ERROR ' + result.status + ' ' + result.statusText);
                }
            });
        }
        function GrabarArticulo() {            
            var vPlu = $("[id$=HdnIdArticulo]").val();
            var idSucur = $("[id$=HdnIdSucursal]").val();
            var chkOferta = $("[id$=ChkOferta]").prop('checked');
            var NombrePLU = $("#TxbDescripcion").val();
            var chkTemporal = $("[id$=ChkTemporal]").prop('checked');
            var fechaIni = $("#TxbFechaDesde").val();
            var fechaFin = $("#TxbFechaHasta").val();
                        
            $.ajax({
                type: "POST",
                url: "OfertaArticulosSuc.aspx/GrabarArticulo",
                data: "{PLU:" + vPlu + ", IdSucursal:" + idSucur + ",OfertaVigente:'" + chkOferta + "',Temporal:'" + chkTemporal + "',FecInicio:'" + fechaIni + "',FecFin:'" + fechaFin + "'}",
                //data: JSON.stringify({ 'art': Articulo }),
                traditional: true,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var resp = (typeof response.d) == 'string' ? eval('(' + response.d + ')') : response.d;
                    if (resp==1)
                    {   
                        //window.location.href = "HabilitaArticulosSuc.aspx";
                        NotyOK('El articulo se grabó correctamente.');
                        LimpiarControles();
                    }
                    else {
                        AlertError();
                    }
                },
                error: function (result) {
                    alert('ERROR ' + result.status + ' ' + result.statusText);
                }
            });
        }
        function SetGrillaModal(DescPlu) {
            $.ajax({
                type: "POST",
                url: "OfertaArticulosSuc.aspx/GetGrillaModal",
                data: "{DescPlu:'" + DescPlu + "'}",
                traditional: true,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    //var ListaMC = (typeof response.d) == 'string' ? eval('(' + response.d + ')') : response.d;
                    var ListaMC = response.d
                    if (ListaMC == null) {
                        alert('No exiten datos');
                    }
                    else {
                        $("#BodyGrillaModal").html(ListaMC);
                        $('#myModalABM').modal('show');

                    }
                },
                error: function (result) {
                    alert('ERROR ' + result.status + ' ' + result.statusText);
                }
            });
        }

        function LimpiarControles() {            
            $("#CphBody_ChkOferta").prop('checked', false);
            $("#TxbPLU").val('');
            $("#TxbDescripcion").val('');
            $("#TxbMedida").val('');
            $("#TxbUnidad").val('');
            $("#TxbSubCategoria").val('');
            $("#TxbStrImagen").val('');
            $("#ImgProducto").attr("src", '../img/articulos/ImgNoDisponible2.jpg');
            $("#CphBody_TxbCodPLU").val('');
            $("#CphBody_TxbNombrePlu").val('');
            $("#CphBody_ChkTemporal").prop('checked', false);
            $("#TxbFechaDesde").val('');
            $("#TxbFechaHasta").val('');
            HabilitaFecha(false);
        }
    </script>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentBeginAndEndHandler" runat="server">
    <script type="text/javascript" language="javascript">
        function BeginRequestHandler() {
            //Antes de ejecutar la peticion de AJAX ASP.Net                      
        }
        Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
        function EndRequestHandler(sender, args) {
            if (args.get_error() == undefined) {                
                
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CphBody" runat="server">
     <section class="content-header">
      <h1> Articulos<small>Ofertas de Articulos</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Inicio</a></li>
        <li><a href="#">Articulos</a></li>
        <li class="active">Ofertas de Articulos</li>
      </ol>
    </section>
    <asp:HiddenField ID="HdnIdArticulo" runat="server" Value="0" />
    <asp:HiddenField ID="HdnIdSucursal" runat="server" Value="0" />

    <!-- Main content -->
    <section class="content">        
      <!-- /.row -->
        <div class="row">
            <div class="col-md-4">  
                
                <asp:Literal ID="LitDatosSucursal" runat="server"></asp:Literal>
                              
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title">Búsqueda Articulos </h3>
                    </div>
                <!-- /.box-header -->
                <!-- form start -->
                    <div role="form">
                        <asp:Panel ID="panelCarga" runat="server" DefaultButton="BtnBuscarPorPLU">
                            <div class="box-body">
                                <div class="form-group">
                                    <label for="TxbCodPLU">PLU</label>                  
                                    <asp:TextBox ID="TxbCodPLU" class="form-control" runat="server" placeholder="PLU" Height="22px"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label for="TxbNombrePlu">Por Nombre</label>                  
                                    <asp:TextBox ID="TxbNombrePlu" class="form-control" runat="server" placeholder="Nombre" Height="22px"></asp:TextBox>
                                </div>
                                
                            </div>
                            <div class="box-footer">                
                                <asp:Button class="btn btn-primary" ID="BtnBuscarPorPLU" runat="server" Text="<%$Resources:Resource, BuscarPlu %>" OnClientClick="CallGetEditPreCarga();return false" />
                            </div>
                        </asp:Panel>
                    </div>
                </div>
            </div>
            <!-- /.col -->
            <div class="col-md-8">
             <div class="box">
            <div class="box-header">
              <h3 class="box-title">Oferta Articulos</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">                
                <div class="form-horizontal form-label-left col-md-8 col-sm-8 col-xs-12">  
                    <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">PLU</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">                                                
                            <asp:TextBox class="form-control" ClientIDMode="Static" style="width:100%"  Enabled="true" ID="TxbPLU" onKeyDown="TocarKey(event)" runat="server"></asp:TextBox>
                        </div>
                    </div>                  
                    <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Descripcion</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">                                                
                            <asp:TextBox class="form-control" ClientIDMode="Static" style="width:100%"  Enabled="false"  ID="TxbDescripcion" runat="server" MaxLength="50"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Medida</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">                                                
                            <asp:TextBox class="form-control" ClientIDMode="Static" style="width:100%"  Enabled="false" ID="TxbMedida" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Unidad</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">                                                
                            <asp:TextBox class="form-control" ClientIDMode="Static" style="width:100%"  Enabled="false" ID="TxbUnidad" runat="server"></asp:TextBox>
                        </div>
                    </div>                    
                    <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">SubCategoria</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">                                                
                            <asp:TextBox class="form-control" ClientIDMode="Static" style="width:100%"  Enabled="false" ID="TxbSubCategoria" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Imagen</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">                                                
                            <asp:TextBox class="form-control" ClientIDMode="Static" style="width:100%"  Enabled="false" ID="TxbStrImagen" runat="server"></asp:TextBox>                            
                        </div>
                    </div> 
                    <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Temporizador</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">                                                
                            <asp:CheckBox ID="ChkTemporal" onclick="HabilitaFecha(this);" runat="server" />
                        </div>
                    </div> 
                    <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Fecha Desde</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">                                                
                            <asp:TextBox class="form-control" ClientIDMode="Static" style="width:100%"  Enabled="false" ID="TxbFechaDesde" runat="server"></asp:TextBox>
                        </div>
                    </div> 
                    <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Fecha Hasta</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">                                                
                            <asp:TextBox class="form-control" ClientIDMode="Static" style="width:100%"  Enabled="false" ID="TxbFechaHasta" runat="server"></asp:TextBox>
                        </div>
                    </div> 
                    <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Oferta</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">                                                
                            <asp:CheckBox ID="ChkOferta" runat="server" />
                        </div>
                    </div>                    
                </div>

                <div class="box-body col-md-4 col-sm-4 col-xs-12">
                    <img class="img-responsive pad" id="ImgProducto" src="../img/articulos/ImgNoDisponible2.jpg" alt="Imagen">
                </div>
            </div>
            <!-- /.box-body -->
            <div class="box-footer">              
                <asp:Button ID="BtnCancelar" class="btn btn-danger" runat="server" Text="<%$Resources:Resource, Cancelar %>" OnClick="BtnCancelar_Click1" />
              <asp:Button ID="BtnAceptar" class="btn btn-primary" runat="server" Text="<%$Resources:Resource, Aceptar %>" OnClientClick="GrabarArticulo(); return false"  />
            </div>

          </div>
                <!-- /.box -->
        </div>
       </div>

        
    </section>
    
    <div class="modal fade" id="myModalABM"  data-backdrop="static"  data-keyboard="false" aria-hidden="true" role="dialog">    
        <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title"><i class="fa fa-pencil"></i> Lista de Articulos</h4>
            </div>
            <div class="modal-body">
                <table id="example1" class="table table-bordered table-hover">
                <thead>
                <tr>
                    <th>PLU</th>
                    <th>Descripcion</th>                    
                    <th>Subcategoria</th>                                        
                    <th>Ver Detalle</th>
                </tr>
                </thead>
                <tbody id="BodyGrillaModal">
                    <asp:Literal ID="LitGrillaModal" runat="server"></asp:Literal>                            
                </tbody>
                <tfoot>                
                </tfoot>
              </table>
            </div>
            <div class="modal-footer">                
                <button type="button" ID="BtnCerrarModal" class="btn btn-danger" data-dismiss="modal">Cancelar</button>                
            </div>
        </div>
        <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="CphJsInf" runat="server">    
    <script src="../js/bootstrap-datepicker.min.js"></script>
    <script>
      $(function () {
          $('#example1').DataTable({
              'paging': true,
              'lengthChange': false,
              'searching': false,
              'ordering': true,
              'info': true,
              'autoWidth': false
          });
        $('.select2').select2();
        $('#TxbFechaDesde').datepicker({ autoclose: true, format: 'dd/mm/yyyy' });
        $('#TxbFechaHasta').datepicker({ autoclose: true, format: 'dd/mm/yyyy' });
      })

      var _URL = window.URL || window.webkitURL;
      $("#f_UploadImage").on('change', function () {          
          var file, img;
          if ((file = this.files[0])) {
              img = new Image();
              img.onload = function () {
                  sendFile(file);
              };
              img.onerror = function () {
                  alert("Not a valid file:" + file.type);
              };
              img.src = _URL.createObjectURL(file);
          }
      });
      
      $('#myModalABM').on('shown.bs.modal', function () {
          $('#TxbDescripcion').focus();
      })
      
      function TocarKey(event) {
          if (event.which == 120) {
              GrabarArticulo();
          }
      };
      function HabilitaFecha(check)
      {
          $("#TxbFechaDesde").prop("disabled", !check.checked)
          $("#TxbFechaHasta").prop("disabled", !check.checked)
      }


      
    </script>
</asp:Content>