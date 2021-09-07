<%@ Page Title="" Language="C#" MasterPageFile="~/MasterAdminSuc.Master" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="DetallePedidos.aspx.cs" Inherits="AntilopeWeb.AdminSuc.DetallePedidos" %>

<asp:Content ID="Content4" ContentPlaceHolderID="CphJsSup" runat="server">
    <script type="text/javascript">
        function ImprimirRecibo() {
            var idPedido = $("#CphBody_HdnIdPedido").val();
            //window.location.href = "../ImprimirRecibo.aspx?Ped=" + idPedido;
            window.open('../ImprimirRecibo.aspx?Ped=' + idPedido +'','_blank');
        }
        function CambiarEstado(IdEstado) {
            var idPedido = $("#CphBody_HdnIdPedido").val();
            $.ajax({
                type: "POST",
                url: "DetallePedidos.aspx/CambiarEstado",
                data: "{IdPedido: " + idPedido + ",idEstado: " + IdEstado + "}",
                traditional: true,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var Resp = (typeof response.d) == 'string' ? eval('(' + response.d + ')') : response.d;
                    if (Resp == 1) {
                        //alert('Perfecto. El cambio se guardó correctamente');
                        $("#ModalOk").modal('show');
                        //AlertOK();
                    }
                    else {
                        //alert('Error. No se pudo guardar el cambio');
                        //AlertError();
                        $("#ModalError").modal('show');                        
                    }                    
                },
                error: function (result) {
                    alert('ERROR ' + result.status + ' ' + result.statusText);
                }
            });
        }
    </script>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentBeginAndEndHandler" runat="server">
    <script type="text/javascript" language="javascript">
        function BeginRequestHandler() {
            //Antes de ejecutar la peticion de AJAX ASP.Net                      
        }
        //Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
        function EndRequestHandler(sender, args) {
            if (args.get_error() == undefined) {
                $('#example1').DataTable();
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CphBody" runat="server">
    <section class="content-header">
      <h1>
        Pedidos
        <small>Detalle de Pedidos</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Inicio</a></li>
        <li><a href="#">Pedidos</a></li>
        <li class="active">Detalle de Pedidos</li>
      </ol>
    </section>
    <asp:HiddenField ID="HdnIdPedido" runat="server" Value="0" />

    <!-- Main content -->
    <section class="content">
        <div class="row">
        <div class="col-md-3 col-sm-6 col-xs-12">
          <div class="info-box bg-aqua">
            <span class="info-box-icon"><i class="fa fa-shopping-cart"></i></span>

            <div class="info-box-content">
                <asp:Literal ID="LitFramePedido" runat="server"></asp:Literal>                
            </div>
            <!-- /.info-box-content -->
          </div>
          <!-- /.info-box -->
        </div>
        <!-- /.col -->
        <div class="col-md-3 col-sm-6 col-xs-12">
          <div class="info-box bg-green">
            <span class="info-box-icon"><i class="ion ion-person"></i></span>

            <div class="info-box-content">
                <asp:Literal ID="LitFrameCliente" runat="server"></asp:Literal>                
              
            </div>
            <!-- /.info-box-content -->
          </div>
          <!-- /.info-box -->
        </div>
        <!-- /.col -->
        <div class="col-md-3 col-sm-6 col-xs-12">
          <div class="info-box bg-yellow">
            <span class="info-box-icon"><i class="fa fa-calendar"></i></span>

            <div class="info-box-content">
                <asp:Literal ID="LitFrameFechaEntrega" runat="server"></asp:Literal>                
                
            </div>
            <!-- /.info-box-content -->
          </div>
          <!-- /.info-box -->
        </div>
        <!-- /.col -->
        <div class="col-md-3 col-sm-6 col-xs-12">
          <div class="info-box bg-red">
            <span class="info-box-icon"><i class="fa fa-home"></i></span>

            <div class="info-box-content">
                <asp:Literal ID="LitDireccionEntrega" runat="server"></asp:Literal>                              
            </div>
            <!-- /.info-box-content -->
          </div>
          <!-- /.info-box -->
        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->
        <div class="row">
        <div class="col-xs-12">
             <div class="box">
            <div class="box-header">
              <h3 class="box-title">Productos Pedidos</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
                  <th>PLU</th>
                  <th>Producto</th>
                  <th>Precio</th>
                  <th>Cantidad</th>
                  <th>Subtotal</th>                  
                </tr>
                </thead>
                <tbody>
                    <asp:Literal ID="LitGrillaDetPedido" runat="server"></asp:Literal>                            
                </tbody>
                <tfoot>                
                </tfoot>
              </table>
            </div>
            <!-- /.box-body -->
          </div>
                <!-- /.box -->
        </div>
       </div>

        <div class="row no-print">
            <div class="col-xs-12">          
              <button type="button" onclick="ReturnPage()" class="btn btn-danger pull-right"><i class="fa fa-chevron-circle-left"></i> Volver
              </button>
              <a style="cursor:pointer;margin-right: 5px" onclick="ImprimirRecibo();return false" target="_blank" class="btn btn-default pull-right"><i class="fa fa-print"></i> Imprimir</a>
<%--              <button type="button" class="btn btn-info dropdown-toggle " data-toggle="dropdown" style="margin-right: 5px;" aria-expanded="false"><i class="fa fa-flag"></i> Cambiar Estado
                <span class="fa fa-caret-down"></span>
              </button>--%>
              <button runat="server" id="BtnCambiarEstado" class="btn btn-info dropdown-toggle " data-toggle="dropdown" style="margin-right: 5px;" aria-expanded="false" >
                  <i class="fa fa-flag"></i> Cambiar Estado <span class="fa fa-caret-down"></span>
              </button>              
              <ul class="dropdown-menu">
                    <li><a style="cursor:pointer;" onclick="CambiarEstado(8);return false" class="text-yellow"><i class="fa fa-hourglass-half"></i>Pedidos en Preparación</a></li>
                    <li><a style="cursor:pointer;" onclick="CambiarEstado(9);return false" class="text-aqua"><i class="fa fa-archive"></i>Pedidos para Entregar</a></li>
                    <li><a style="cursor:pointer;" onclick="CambiarEstado(10);return false" class="text-green"><i class="fa fa-thumbs-o-up"></i>Pedidos Entregados</a></li>  
                </ul>
            </div>
        </div>
    </section>
    
    <div class="modal modal-success fade" id="ModalOk" data-backdrop="static">
        <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title"><i class="fa fa-thumbs-o-up"></i> Perfecto</h4>
            </div>
            <div class="modal-body">
            <p>Registros OK</p>
            </div>
            <div class="modal-footer">
                <button type="button" onclick="window.location.href='ListaPedidos.aspx?Est=7'" class="btn btn-outline pull-left" data-dismiss="modal">Cerrar</button>
                <%--<button type="button" class="btn btn-outline">Save Changes</button>--%>
            </div>
        </div>
        <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->

    <div class="modal modal-danger fade" id="ModalError" data-backdrop="static">
        <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title"><i class="fa fa-times-circle"></i> Error!</h4>
            </div>
            <div class="modal-body">
            <p>No se pudo guardar el registro. Intente nuevamente</p>
            </div>
            <div class="modal-footer">
            <button type="button" class="btn btn-outline pull-left" data-dismiss="modal">Cerrar</button>
            <%--<button type="button" class="btn btn-outline">Save Changes</button>--%>
            </div>
        </div>
        <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="CphJsInf" runat="server">
    <script>
      $(function () {
        $('#example1').DataTable()
        $('#example2').DataTable({
          'paging'      : true,
          'lengthChange': false,
          'searching'   : false,
          'ordering'    : true,
          'info'        : true,
          'autoWidth'   : false
        })
      })
    </script>
</asp:Content>