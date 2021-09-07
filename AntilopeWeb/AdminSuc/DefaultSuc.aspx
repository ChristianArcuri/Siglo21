<%@ Page Title="" Language="C#" MasterPageFile="~/MasterAdminSuc.Master" EnableEventValidation="false" AutoEventWireup="true" CodeBehind="DefaultSuc.aspx.cs" Inherits="AntilopeWeb.AdminSuc.DefaultSuc" %>

<asp:Content ID="Content2" ContentPlaceHolderID="CphJsSup" runat="server">
    <style type="text/css">
        .pagination-ys {
            /*display: inline-block;*/
            padding-left: 0;
            margin: 20px 0;
            border-radius: 4px;
        }
 
        .pagination-ys table > tbody > tr > td {
            display: inline;
        }
 
        .pagination-ys table > tbody > tr > td > a,
        .pagination-ys table > tbody > tr > td > span {
            position: relative;
            float: left;
            padding: 8px 12px;
            line-height: 1.42857143;
            text-decoration: none;
            color: #dd4814;
            background-color: #ffffff;
            border: 1px solid #dddddd;
            margin-left: -1px;
        }
 
        .pagination-ys table > tbody > tr > td > span {
            position: relative;
            float: left;
            padding: 8px 12px;
            line-height: 1.42857143;
            text-decoration: none;    
            margin-left: -1px;
            z-index: 2;
            color: #aea79f;
            background-color: #f5f5f5;
            border-color: #dddddd;
            cursor: default;
        }
 
        .pagination-ys table > tbody > tr > td:first-child > a,
        .pagination-ys table > tbody > tr > td:first-child > span {
            margin-left: 0;
            border-bottom-left-radius: 4px;
            border-top-left-radius: 4px;
        }
 
        .pagination-ys table > tbody > tr > td:last-child > a,
        .pagination-ys table > tbody > tr > td:last-child > span {
            border-bottom-right-radius: 4px;
            border-top-right-radius: 4px;
        }
 
        .pagination-ys table > tbody > tr > td > a:hover,
        .pagination-ys table > tbody > tr > td > span:hover,
        .pagination-ys table > tbody > tr > td > a:focus,
        .pagination-ys table > tbody > tr > td > span:focus {
            color: #97310e;
            background-color: #eeeeee;
            border-color: #dddddd;
        }
    </style>
    
    <script type="text/javascript">

    function VerDetalle(idPedido) {            
            window.location.href = "DetallePedidos.aspx?Ped=" + idPedido;
    }
    
    setInterval(function () { GetPedidosPendientes() }, 30000);
        setInterval(function () { GetContadores('<%= Session["Sucursal"] %>') }, 30000);
    function GetPedidosPendientes() {
        $.ajax({
            type: "POST",
            url: "DefaultSuc.aspx/GetPedidosPendientes",
            data: "{}",
            traditional: true,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                var Resp = response.d;
                if (Resp != 0) {
                    $('#TableGrillaPedPendientes').html(Resp);
                }
                else {
                    $('#TableGrillaPedPendientes').html('Error!!!!');
                }
            },
            error: function (result) {
                alert('ERROR ' + result.status + ' ' + result.statusText);
            }
        });
    }

    
    </script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentBeginAndEndHandler" runat="server">
    <script type="text/javascript" language="javascript">
                function BeginRequestHandler() {
                    //Antes de ejecutar la peticion de AJAX ASP.Net                      
                }
                //Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);
                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
                function EndRequestHandler(sender, args) {
                    if (args.get_error() == undefined) {                        
                        //alert('qweqweq');
                    }
                }
             </script>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="CphBody" runat="server">
    <asp:HiddenField ID="HdnPlanVence" runat="server" Value="" />
    
     <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>Inicio <small>Admin</small></h1>
        <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Inicio</a></li>
        <li class="active">Admin</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <!-- Small boxes (Stat box) -->
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
        <!-- Main row -->
        <div class="row">
        <!-- Left col -->
        <section class="col-lg-7 connectedSortable">
            
          <div class="box">
                <div class="box-header">
                  <h3 class="box-title pull-left header"><i class="fa fa-shopping-cart"></i> Últimos Pedidos</h3>
                </div>
                <!-- /.box-header -->
                
                        <div class="box-body no-padding">
                            <table id="TableGrillaPedPendientes" class="table table-striped">                                                          
                            </table>                    
                        </div>
                        <!-- /.box-body -->
                        <div class="box-footer text-center">
                            <a href="ListaPedidos.aspx?Est=7" class="uppercase"><i class="fa fa-arrow-circle-right"></i> Pedidos Pendientes</a>
                        </div>    
                
              </div>

          <!-- /.box -->    

        </section>
        <!-- /.Left col -->
        <!-- right col (We are only adding the ID to make the widgets sortable)-->
        <section class="col-lg-5 connectedSortable">            
            <div class="box box-primary">                
                <asp:Literal ID="LitDatosSucursal" runat="server"></asp:Literal>
              </div>  
            
            <div class="box box-primary">                
              <!-- Info Boxes Style 2 -->
              <div class="info-box bg-yellow">
                <span class="info-box-icon"><i class="fa fa-money"></i></span>

                <div class="info-box-content">
                  <span class="info-box-text">Ventas Efectivo</span>
                  <span class="info-box-number TotalEfectivo">$0</span>

                  <div class="progress">
                    <div class="progress-bar" style="width: 50%"></div>
                  </div>
                  <span class="progress-description">
                        <a href="ListaPedidos.aspx?Est=10" style="color: #ffffff;" >Ver Detalle <i class="fa fa-arrow-circle-right"></i></a>
                      </span>
                </div>
                <!-- /.info-box-content -->
              </div>
              <!-- /.info-box -->
              <div class="info-box bg-green">
                <span class="info-box-icon"><i class="fa fa-credit-card"></i></span>

                <div class="info-box-content">
                  <span class="info-box-text">Ventas Tarjetas</span>
                  <span class="info-box-number TotalTarjetas">$0</span>

                  <div class="progress">
                    <div class="progress-bar" style="width: 20%"></div>
                  </div>
                  <span class="progress-description">
                        <a href="ListaPedidos.aspx?Est=10" style="color: #ffffff;" >Ver Detalle <i class="fa fa-arrow-circle-right"></i></a>
                      </span>
                </div>
                <!-- /.info-box-content -->
              </div>              
            </div>
                 
        </section>
        <!-- right col -->
        </div>
        <!-- /.row (main row) -->

    </section>
    <!-- /.content -->
          
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="CphJsInf" runat="server">
    <script>
        $(function () {

            var areaChartData = {
                labels: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio'],
                datasets: [                  
                  {
                      label: 'Digital Goods',
                      fillColor: 'rgba(60,141,188,0.9)',
                      strokeColor: 'rgba(60,141,188,0.8)',
                      pointColor: '#3b8bba',
                      pointStrokeColor: 'rgba(60,141,188,1)',
                      pointHighlightFill: '#fff',
                      pointHighlightStroke: 'rgba(60,141,188,1)',
                      data: [28000, 48000, 40000, 19000, 86000, 27500, 90300]
                  }
                ]
            }
            var areaChartOptions = {      
                showScale               : true,      
                scaleShowGridLines      : false,      
                scaleGridLineColor      : 'rgba(0,0,0,.05)',      
                scaleGridLineWidth      : 1,      
                scaleShowHorizontalLines: true,      
                scaleShowVerticalLines  : true,      
                bezierCurve             : true,      
                bezierCurveTension      : 0.3,                
                pointDot                : false,                
                pointDotRadius          : 4,                
                pointDotStrokeWidth     : 1,                
                pointHitDetectionRadius : 20,                
                datasetStroke           : true,                
                datasetStrokeWidth      : 2,                
                datasetFill             : true,                
                maintainAspectRatio     : true,                
                responsive              : true
            }
            
    // LINE CHART
        var lineChartCanvas = $('#lineChart').get(0).getContext('2d')
        var lineChart = new Chart(lineChartCanvas)
        var lineChartOptions = areaChartOptions
        lineChartOptions.datasetFill = false
        lineChart.Line(areaChartData, lineChartOptions)
        });

        $(document).ready(function () {
            var idSucursal = '<%= Session["Sucursal"] %>';
            GetPedidosPendientes();
            GetContadores(idSucursal);           
            var PlanVence = $("[id$=HdnPlanVence]").val();
            if (PlanVence != "") {
                AlertErrorCustom(' Vencimiento del Plan', ' Tu plan vence en ' + PlanVence + ' días. Comunicate con atención al cliente para actualizar el servicio.');
            }
    
        });
    </script>
</asp:Content>
