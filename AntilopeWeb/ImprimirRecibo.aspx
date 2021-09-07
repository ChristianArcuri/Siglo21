<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ImprimirRecibo.aspx.cs" Inherits="AntilopeWeb.ImprimirRecibo" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Antilope SA | Reportes</title>
  
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/font-awesome.min.css" rel="stylesheet" />
    <link href="css/ionicons.min.css" rel="stylesheet" />
    <link href="css/AdminLTE.min.css" rel="stylesheet" />
    <link rel="shortcut icon" type="image/x-icon" href="img/faviconmy.ico">
  
  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->


    <style type="text/css">           
        .ContinuarPago{
            margin-top: 5px;
        }

    </style>    
    <script src="js/jquery.min.js"></script>

    
</head>
<%--<body onload="window.print();">--%>
<body>
    <form id="form1" runat="server">
    <div class="wrapper">
      <!-- Main content -->
      <section class="invoice">
        <!-- title row -->
        <div class="row">
          <div class="col-xs-12">
            <h2 class="page-header">
                <img src="img/LogoAntilope1.png" style="width: 25%" alt="Antilope SA" />
              <small class="pull-right">Fecha: <%= DateTime.Now.ToLongTimeString() %></small>
            </h2>
          </div>
          <!-- /.col -->
        </div>
        <!-- info row -->
        <div class="row invoice-info">
          <div class="col-sm-4 invoice-col">
            DE   
            <address>
                <asp:Literal ID="LitAdressDe" runat="server"></asp:Literal>                
            </address>
          </div>
          <!-- /.col -->
          <div class="col-sm-4 invoice-col">
            A   
            <address>
                <asp:Literal ID="LitAdressA" runat="server"></asp:Literal>                              
            </address>
          </div>
            
                    
          <!-- /.col -->
          <div class="col-sm-4 invoice-col">
            <b>Recibo Generado</b><br>
            <br>
            <b>Pedido Nro:</b> <asp:Label ID="LblPedidoId" runat="server" Text="0"></asp:Label><br>
            <b>Fecha de Pago:</b> <asp:Label ID="LblFechaPago" runat="server" Text="0"></asp:Label><br>
            <b>Medio de Pago:</b> <asp:Label ID="LblMedioPago" runat="server" Text=""></asp:Label><br>
            <b>Forma de Entrega:</b> <asp:Label ID="LblFormaEntrega" runat="server" Text=""></asp:Label><br>
          </div>
          <!-- /.col -->
        </div>
        <!-- /.row -->

        <!-- Table row -->
        <div class="row">
          <div class="col-xs-12 table-responsive">
            <table class="table table-striped">
                <asp:Literal ID="LitTablaProductos" runat="server"></asp:Literal>
            </table>
          </div>
          <!-- /.col -->
        </div>
        <!-- /.row -->

        <div class="row">
          <div class="col-xs-6">            
          </div>
          <!-- /.col -->
            <div class="col-xs-1">
                <asp:HiddenField ID="HdnDesde" runat="server" />
                  <asp:HiddenField ID="HdnHasta" runat="server" />
            </div>
          <div class="col-xs-5">
            <p class="lead">Fecha de compra: <asp:Label ID="LblFechaCompra" runat="server" Text=""></asp:Label></p>

            <div class="table-responsive">
              <table class="table">
                  <asp:Literal ID="LitFooterTotalPedido" runat="server"></asp:Literal>                
              </table>
            </div>

            <p class="text-muted well well-sm no-shadow" style="margin-top: 10px;">
              Recibo generado desde Antilope SA. Por favor guarde este recibo como constancia de compra. Recibo no válido como factura.
            </p>
            
          </div>
          <!-- /.col -->
        </div>
        
      </section>
      <!-- /.content -->
    </div>
    <!-- ./wrapper -->


    </form>

    <script type="text/javascript">
	     window.onload = function () {
	         window.print();
	     }	     
    </script>
   
</body>
</html>
