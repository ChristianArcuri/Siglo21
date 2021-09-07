<%@ Page Title="" Language="C#" MasterPageFile="~/MasterAdminSuc.Master" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="ListaClientes.aspx.cs" Inherits="AntilopeWeb.AdminSuc.ListaClientes" %>

<asp:Content ID="Content4" ContentPlaceHolderID="CphJsSup" runat="server">
    
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
        Cliente<small>Clientes Frecuentes</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Inicio</a></li>
        <li><a href="#">Clientes</a></li>
        <li class="active">Clientes Frecuentes</li>
      </ol>
    </section>
    

    <!-- Main content -->
    <section class="content">
        <div class="row">
            
            <div class="col-lg-3 col-xs-6">
                <!-- small box -->
                <div class="small-box bg-aqua">
                <div class="inner">
                    <h3 class="PedidosPendientes">                        
                    </h3>
                    <p>Pedidos Pendientes</p>
                </div>
                <div class="icon">
                    <i class="fa fa-shopping-cart"></i>
                </div>
                <a href="ListaPedidos.aspx?Est=7" class="small-box-footer">Ver Detalle<i class="fa fa-arrow-circle-right"></i></a>
                </div>
            </div>
            <!-- ./col -->
            <div class="col-lg-3 col-xs-6">
                <!-- small box -->
                <div class="small-box bg-green">
                <div class="inner">
                    <h3 class="CantEntregasOk">
                    </h3>
                    <p>Entregas Realizadas</p>
                </div>
                <div class="icon">
                    <i class="fa fa-thumbs-o-up"></i>
                </div>
                <a href="ListaPedidos.aspx?Est=10" class="small-box-footer">Ver Detalle <i class="fa fa-arrow-circle-right"></i></a>
                </div>
            </div>
            <!-- ./col -->
            <div class="col-lg-3 col-xs-6">
                <!-- small box -->
                <div class="small-box bg-yellow">
                <div class="inner">
                    <h3 class="CantClientesFrec"></h3>
                    <p>Clientes Frecuentes</p>
                </div>
                <div class="icon">
                    <i class="fa fa-users"></i>
                </div>
                <a href="ListaClientes.aspx" class="small-box-footer">Ver Detalle <i class="fa fa-arrow-circle-right"></i></a>
                </div>
            </div>
            <!-- ./col -->
            <div class="col-lg-3 col-xs-6">
                <!-- small box -->
                <div class="small-box bg-red">
                <div class="inner">
                    <h3 class="VentasRealiz"><sup style="font-size: 20px">$</sup></h3>
                    <p>Ventas Realizadas</p>
                </div>
                <div class="icon">
                    <i class="fa fa-credit-card"></i>
                </div>
                <a href="ListaPedidos.aspx?Est=10" class="small-box-footer">Ver Detalle <i class="fa fa-arrow-circle-right"></i></a>
                </div>
            </div>
            
        </div>
      <!-- /.row -->
        <div class="row">
        <div class="col-xs-12">
             <div class="box">
            <div class="box-header">
              <h3 class="box-title">
                  <i class="fa fa-users"></i> <asp:Label ID="LblTituloGrilla" runat="server" Text="Clientes Frecuentes"></asp:Label>
              </h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
                    <th style="width: 10px">#</th>
                    <th>Cliente</th>
                    <th>Direccion</th>
                    <th>Telefono</th>
                    <th>Cantidad Compras</th>
                    <th>Importe</th>                    
                </tr>
                </thead>
                <tbody>
                    <asp:Literal ID="LitGrillClientes" runat="server"></asp:Literal>                            
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
          <button type="button" class="btn btn-danger pull-right"><i class="fa fa-chevron-circle-left"></i> Volver
          </button>          
        </div>
      </div>
    </section>
    
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
      $(document).ready(function () {
          var idSucursal = '<%= Session["Sucursal"] %>';
          GetContadores(idSucursal);
      });
    </script>
</asp:Content>