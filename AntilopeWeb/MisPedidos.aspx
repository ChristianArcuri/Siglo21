<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGralNew.Master" AutoEventWireup="true" CodeBehind="MisPedidos.aspx.cs" Inherits="AntilopeWeb.MisPedidos" %>

<%@ Register Src="~/WebControls/UCOpcionesCliente.ascx" TagPrefix="uc1" TagName="UCOpcionesCliente" %>


<asp:Content ID="Content1" ContentPlaceHolderID="CphJsSuperior" runat="server">
    <link href="../css/ionicons.min.css" rel="stylesheet" />
    <link href="../css/AdminLTE.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
    <script type="text/javascript">
        function ImprimirRecibo(idPedido) {                
                window.open('ImprimirRecibo.aspx?Ped=' + idPedido +'','_blank');
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBeginAndEndHandler" runat="server">
    <script type="text/javascript">
            function BeginRequestHandler() {                
                OpenLoading();            
            }
            Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
            function EndRequestHandler(sender, args) {
                if (args.get_error() == undefined) {                                        
                    HideLoading();
                }
            }
        </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CphBody" runat="server">
    <div class="row">
        <div class="col-md-4">
          <uc1:UCOpcionesCliente runat="server" id="UCOpcionesCliente" />
        </div>
        <div class="col-md-8">
            <div class="box-header">
              <h3 class="box-title">Mis Pedidos</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body no-padding">
              <table class="table table-striped">
                <tr>
                  <th style="width: 10px">#</th>
                  <th>Sucursal</th>
                  <th>Fecha Entrega</th>                    
                    <th>Desde</th>
                    <th>Hasta</th>
                    <th>Estado</th>                    
                    <th>Importe</th>
                    <th>Imprimir</th>
                </tr>
                <asp:Literal ID="LitGrillaPedidos" runat="server"></asp:Literal>
              </table>
            </div>
            <!-- /.box-body -->
        </div>
    </div>    
    <!-- /.box -->
    


</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CphBrandClient" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="CphJsInferior" runat="server">
    <script src="../js/adminlte.min.js"></script>
    
</asp:Content>
