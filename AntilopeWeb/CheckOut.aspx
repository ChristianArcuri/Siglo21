<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGralNew.Master" enableEventValidation="false" AutoEventWireup="true" CodeBehind="CheckOut.aspx.cs" Inherits="AntilopeWeb.CheckOut" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CphJsSuperior" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/places.js@1.4.14"></script>        
    <style type="text/css">
        .paymentmethod-visa.paymentmethod-large {
            height: 21px;
            width: 63px;
        }
        .paymentmethod-visa, .paymentmethod-visa.paymentmethod-large {
            background-position: 0 -49px;
        }
        .paymentmethod-large {
            background-image: url(https://http2.mlstatic.com/secure/org-img/ui/payment-methods/1.6.9/ar/payment-methods-large.png);
            margin: 5px;
        }
        [class*='paymentmethod'] {
            background-repeat: no-repeat;
            display: inline-block;
            margin: 2px;
            overflow: hidden;
            text-indent: 100%;
            vertical-align: middle;
            white-space: nowrap;
        }
        .paymentmethod-master.paymentmethod-large {
            height: 36px;
            width: 46px;
        }
        .paymentmethod-master, .paymentmethod-master.paymentmethod-large {
            background-position: 0 -100px;
        }        
        .paymentmethod-amex.paymentmethod-large {
            height: 27px;
            width: 26px;
        }

        .paymentmethod-amex, .paymentmethod-amex.paymentmethod-large {
            background-position: 0 -150px;
        }
        
        .paymentmethod-naranja.paymentmethod-large {
            height: 30px;
            width: 25px;
        }
        .paymentmethod-naranja, .paymentmethod-naranja.paymentmethod-large {
            background-position: 0 -300px;
        }
        .paymentmethod-tarshop.paymentmethod-large {
            width: 42px;
            height: 27px;
        }
        .paymentmethod-tarshop, .paymentmethod-tarshop.paymentmethod-large {
            background-position: 0 -400px;
        }
        .paymentmethod-nativa.paymentmethod-large {
            width: 58px;
            height: 27px;
        }
        .paymentmethod-nativa, .paymentmethod-nativa.paymentmethod-large {
            background-position: 0 -350px;
        }
        .paymentmethod-cabal.paymentmethod-large {
            width: 27px;
            height: 28px;
        }

        .paymentmethod-cabal, .paymentmethod-cabal.paymentmethod-large {
            background-position: 0 -500px;
        }
        .paymentmethod-cencosud.paymentmethod-large {
            width: 41px;
            height: 27px;
        }
        .paymentmethod-cencosud, .paymentmethod-cencosud.paymentmethod-large {
            background-position: 0 -450px;
        }
        .paymentmethod-argencard.paymentmethod-large {
    height: 32px;
    width: 117px;
}
        
    </style>
    <script type="text/javascript">
        function DeleteCarrito(IdArt) {
            $.ajax({
                type: "POST",
                url: "CheckOut.aspx/DeleteItemCarrito",
                data: "{Id: " + IdArt + "}",
                traditional: true,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var Resp = (typeof response.d) == 'string' ? eval('(' + response.d + ')') : response.d;
                    if (Resp == 1) {
                        RefrescarUpCarro();
                    }
                },
                error: function (result) {
                    alert('ERROR ' + result.status + ' ' + result.statusText);
                }
            });
        }
        function AbrirPanel(idPanel) {            
            $('.panel-collapse').collapse('hide');
            if (idPanel==2)
            {
                var FormaEntrega = $("#CphBody_DlFormaEntrega").val();
                if (FormaEntrega=="EntregaDomicilio")
                    $("#collapseTwo").collapse('show');
                else
                    $("#collapseThree").collapse('show');
            }
            else if (idPanel == 3) {
                $("#collapseThree").collapse('show');
            }
        }
        function CallModalMedioPago(MedioPago) {
            if (MedioPago == 2) {
                $("#ModalPagoEfectivo").modal('show');
            }
            else {
                $("#ModalMedioPago").modal('show');
            }
        }
    </script>
    <style type="text/css">
        input.add-tag-btn:hover
        {
            background-color: #00A9E0;
        }
    </style>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">    
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
    <asp:HiddenField ID="HdnFaltaDireccion" runat="server" Value="0" />
    <div class="row">
		<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
			<div class="checkout-main-area">
				<h2>Realizar el Pago</h2>
				<div class="checkout-area">
					<div class="panel-group greentech-panel-group greentech-panel-icon" id="greentechaccordion">
						<!-- START SINGLE PANEL -->
						<div class="greentech-panel panel panel-default">
							<div class="panel-heading greentech-heading" id="headingOne">
								<h4 class="panel-title greentech-title">									
                                    <a data-toggle="collapse" data-parent="#greentechaccordion" href="#collapseOne" class="accordion-toggle">
										<span>1</span> Forma de Entrega
									</a>
								</h4>
							</div>
							<div id="collapseOne" class="panel-collapse collapse in">
								<div class="panel-body greentech-panel-body">
									<div class="left-info ship-info">
                                        <h2>Forma de Entrega</h2>
										<p>Elija la forma en que le entregaremos la compra</p>										
										<div class="use-billing-add">
											<div class="country-select">
												&nbsp;<asp:DropDownList ID="DlFormaEntrega" runat="server">
                                                </asp:DropDownList>													
											</div>	                                            
										</div>
										<div class="block-button-right">											
											<a onclick="AbrirPanel(2);" style="cursor:pointer" class="add-tag-btn">Continuar</a>                                            
										</div>														
									</div>
								</div>
							</div>
						</div> <!--/ END SINGLE PANEL -->
                        <!-- START SINGLE PANEL -->
						<div class="greentech-panel panel panel-default">
							<div class="panel-heading greentech-heading" id="headingTwo"> 
								<h4 class="panel-title greentech-title">
									<a class="collapsed accordion-toggle" data-toggle="collapse" data-parent="#greentechaccordion" href="#collapseTwo">
										<span>2</span> Dirección de entrega
									</a>
								</h4>
							</div>
							<div id="collapseTwo" class="panel-collapse collapse">
								<div class="panel-body greentech-panel-body">
									<div class="checkout-method">
										<div class="method-left col-xs-12 col-sm-6">
											<h2>Domicilio</h2>
											<p>En esta dirección se va a entregar el Pedido</p>
											<ul>
                                                <asp:Literal ID="LitDireccionEntrega" runat="server"></asp:Literal>															
											</ul>
                                            <a href="#">Modificar Domicilio</a>														
										</div>
										<div class="method-right col-xs-12 col-sm-6">
											<h2>Horario de Entrega</h2>
											<label>¿En qué horario querés recibir el pedido?</label>	
                                            <div class="billing-info">
												<div class="form-group col-sm-12">
													<label>Fecha entrega</label>
													<asp:TextBox ID="TxbFechaEntrega" type="text" runat="server"></asp:TextBox>
                                                                
												</div>	
                                                <div class="form-group col-sm-6" style="padding-right: 10px;">
													<label>Hora desde</label>														        
                                                    <asp:TextBox ID="TxbHoraDesde" runat="server" TextMode="Time">11:00</asp:TextBox>
												</div>
												<div class="form-group col-sm-6" style="padding-right: 10px;">
													<label>Hora hasta</label>														        
                                                    <asp:TextBox ID="TxbHoraHasta" runat="server" TextMode="Time">13:00</asp:TextBox>
												</div>
                                            </div>
											<div class="block-button-right">															
												<a onclick="AbrirPanel(3);" style="cursor:pointer" class="add-tag-btn">Continuar</a>
											</div>
										</div>
												
                                    </div>
                                </div>											
							</div>
						</div> <!--/ END SINGLE PANEL -->	                        
						<!-- START SINGLE PANEL -->
						<div class="greentech-panel panel panel-default">
							<div class="panel-heading greentech-heading" id="headingThree">
								<h4 class="panel-title greentech-title">
									<a class="collapsed accordion-toggle" data-toggle="collapse" data-parent="#greentechaccordion" href="#collapseThree">
											<span>3</span> Revisar el Pedido
									</a>
								</h4>
							</div>
							<div id="collapseThree" class="panel-collapse collapse">
								<div class="panel-body greentech-panel-body">
									<div class="order-review">
										<div class="table-responsive">
											<table class="table">
												<thead>
													<tr>
														<th class="width-1">Producto</th>
														<th class="width-2">Precio</th>
														<th class="width-3">Cantidad</th>
														<th class="width-4">Subtotal</th>
													</tr>
												</thead>
												<tbody>
                                                    <asp:Literal ID="LitGrillaPedido" runat="server"></asp:Literal>
												</tbody>
												<tfoot>
                                                    <asp:Literal ID="LitGrillaPedFooter" runat="server"></asp:Literal>																
												</tfoot>
											</table>
										</div>
										<div class="block-button-right">
											<a class="o-back-to" href="Cart.aspx"><span> Modificar Carrito</span></a>
                                            <%--<a onclick="CallModalMedioPago(); return false;" style="cursor:pointer" class="add-tag-btn">Terminar Compra</a>--%>
                                            <asp:Literal ID="LitTerminarCompra" runat="server"></asp:Literal>
										</div>													
									</div>
								</div>
							</div>
						</div><!--/ END SINGLE PANEL -->
						
					</div>
				</div>
			</div>
		</div>
		<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
			<!-- checkout-side-area start -->
			<div class="checkout-side-area single-sidebar">
				<h2>Progreso de Compra</h2>	
				<div class="Checkout-sidebar">
					<ul>												
						<li>Dirección de entrega</li>						
                        <li>Forma de entrega</li>
						<li>Revisar el Pedido</li>
                        <li>Terminar Compra</li>
					</ul>									
				</div>
			</div>
			<!-- checkout-side-area end -->
	
		</div>

	</div>
   <div class="modal modal-success fade" id="ModalMedioPago" data-backdrop="static">
        <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title"><i class="fa fa-shopping-cart"></i> Elija el Medio de Pago</h4>
            </div>
            <div class="modal-body">
                <div class="row">
		            <div class="col-lg-6">
                        <p>Tarjeta de Débito y Crédito hasta 12 cuotas.</p>                        
                        <asp:LinkButton runat="server" ID="BtnPagoTarjeta" OnClick="BtnTerminarPagoTarjeta_Click" CssClass="btn btn-lg btn-success col-xs-12">
                            <i class="glyphicon glyphicon-credit-card pull-left" aria-hidden="true"></i> Pagar con Tarjeta
                        </asp:LinkButton>
                        <br /><br /><br />
                        <ul>
                        <li class="paymentmethod-visa paymentmethod-large">Visa</li>
                        <li class="paymentmethod-master paymentmethod-large">Mastercard</li>
                        <li class="paymentmethod-amex paymentmethod-large">American Express</li>
                        <li class="paymentmethod-naranja paymentmethod-large">Naranja</li>
                        <li class="paymentmethod-tarshop paymentmethod-large">Tarjeta Shopping</li>                        
                        <li class="paymentmethod-cencosud paymentmethod-large">Cencosud</li>
                        <li class="paymentmethod-cabal paymentmethod-large">Cabal</li>
                        <li class="paymentmethod-argencard paymentmethod-large">MercadoPago</li>                        
                        </ul>       
                    </div>
                    <div class="col-lg-6">
                        <p>Pagá en efectivo cuando te entregan los productos.</p>                        
                        <asp:LinkButton runat="server" ID="BtnPagoEfectivo" OnClick="BtnTerminarPagoEfectivo_Click" CssClass="btn btn-lg btn-info col-xs-12">
                            <i class="glyphicon glyphicon-usd pull-left" aria-hidden="true"></i> Pagar en Efectivo
                        </asp:LinkButton>
                        <br /><br /><br />   
                        <div id="wrapper" style="width:100%; text-align:center">
                            <img src="img/icon/PagoEfectivo2.png" style="height: 120px; width: 120px"/>
                        </div>                  
                        
                    </div>
                </div>                
            </div>
            <div class="modal-footer">                
                <%--<button type="button" class="btn btn-outline">Save Changes</button>--%>
            </div>
        </div>
        <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>

    <div class="modal modal-success fade" id="ModalPagoEfectivo" data-backdrop="static">
        <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title"><i class="fa fa-shopping-cart"></i> Elija el Medio de Pago</h4>
            </div>
            <div class="modal-body">
                <div class="row">             
                    <div class="col-lg-10">
                        <p>Pagá en efectivo cuando te entregan los productos.</p>                        
                        <asp:LinkButton runat="server" ID="LinkButton2" OnClick="BtnTerminarPagoEfectivo_Click" CssClass="btn btn-lg btn-info col-xs-12">
                            <i class="glyphicon glyphicon-usd pull-left" aria-hidden="true"></i> Pagar en Efectivo
                        </asp:LinkButton>
                        <br /><br /><br />   
                        <div id="wrapper" style="width:100%; text-align:center">
                            <img src="img/icon/PagoEfectivo2.png" style="height: 120px; width: 120px"/>
                        </div>                  
                        
                    </div>
                </div>                
            </div>
            <div class="modal-footer">                
                <%--<button type="button" class="btn btn-outline">Save Changes</button>--%>
            </div>
        </div>
        <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>

    <div class="modal modal-success fade" id="ModalCargaDomicilio" data-backdrop="static">
        <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title"><i class="fa fa-home"></i> Completá tu dirección de entrega.</h4>
            </div>
            <div class="modal-body">
                <div class="row">             
                    <div class="col-lg-12">                        
                        <div id="wrapper" style="width:100%; text-align:center">
                            <img src="img/Casa.png" style="height: 160px; width: 160px"/>
                        </div>                  
                        <br />
                        <div class="form-group">                                                        
                            <label for="TxbDireccionAlta">Dirección de Entrega</label>
							<asp:TextBox class="form-control" ID="TxbDireccionAlta" placeholder="Dirección" runat="server" ></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="TxbDeptoAlta">Piso/ Depto</label>
                            <asp:TextBox class="form-control" ID="TxbDeptoAlta" placeholder="Departamento" runat="server"></asp:TextBox>
                        </div>
                    </div>
                </div>                
            </div>
            <div class="modal-footer">                
                <asp:LinkButton runat="server" ID="lnkIngresarDirec" CssClass="btn btn-lg btn-info col-xs-12" OnClick="lnkIngresarDirec_Click">
                    <i class="glyphicon glyphicon-home pull-left" aria-hidden="true"></i> Actualizar Dirección
                </asp:LinkButton>
            </div>
        </div>
        <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>

    <!-- /.modal -->
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CphBrandClient" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="CphJsInferior" runat="server">
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?key=AIzaSyCHCQomohspEbZpQ_vzraZMDn4heHmCook"></script>
    <script type="text/javascript">                
        $("#CphBody_TxbFechaEntrega").datepicker({ dateFormat: 'dd/mm/yy' }).datepicker("setDate", new Date());
    
        function DirGoogle() {
            var placesAutocomplete = places({ container: document.querySelector('#CphBody_TxbDireccionAlta'), countries: ['ar'] });    
        }
        $(document).ready(function () {
            var bFaltaDirec = $("#CphBody_HdnFaltaDireccion").val();
            if (bFaltaDirec == "1") {
                $("#ModalCargaDomicilio").modal('show');
                DirGoogle();
            }
        });
    </script>
</asp:Content>
