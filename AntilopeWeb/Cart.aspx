<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGralNew.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="AntilopeWeb.Cart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CphJsSuperior" runat="server">
    <style type="text/css">
        table.cart-table {            
            margin-top: 10px;            
        }

        .Prueba {
            background: url(img/icon/btn_trash.gif) no-repeat scroll 0 0;
            display: inline-block;
            height: 10px;
            text-indent: -99999px;
            width: 9px;
        }
    </style>
    <script type="text/javascript">
        function DeleteCarrito(IdArt) {
            $.ajax({
                type: "POST",
                url: "Cart.aspx/DeleteItemCarrito",
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
        function VaciarCarrito() {
            $.ajax({
                type: "POST",
                url: "Cart.aspx/VaciarCarrito",
                data: "{}",
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
        function CambiarCantCarro(IdArt, Cantidad) {
            $.ajax({
                type: "POST",
                url: "Cart.aspx/CambiarCantItemCarrito",
                data: "{idArt: " + IdArt + ",Cant: " + Cantidad + "}",
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
        
        function MaxMinButton() {
            /*----- cart-plus-minus-button -----*/
            $(".cart-plus-minus").append('<div class="dec qtybutton">-</div><div class="inc qtybutton">+</div>');
            $(".qtybutton").on("click", function () {
                var $button = $(this);
                var oldValue = $button.parent().find("input").val();
                if ($button.text() == "+") {
                    var newVal = parseFloat(oldValue) + 1;
                } else {
                    // Don't allow decrementing below zero
                    if (oldValue > 0) {
                        var newVal = parseFloat(oldValue) - 1;
                    } else {
                        newVal = 0;
                    }
                }
                $button.parent().find("input").val(newVal);
            });
            $(document).ready(function () {                
                $(".qtybutton").on('click', function () {
                    //var tot = $('#price').val() * this.value;
                    //$('#total').val(tot);
                    var Cant = $(this).parent().find("input[name=qtybutton]").val();
                    var IdArt = $(this).parent().parent().find("input[name=idArticulo]").val();
                    //alert('Cant:' + Cant + 'PLU:' +IdArt);
                    CambiarCantCarro(IdArt, Cant);
                });

            });
        }

        function RealizarPago() {                       
            var TotalPago = parseFloat($('#CphBody_HdnTotalPago').val());
            var PagoMin = parseFloat($('#CphBody_HdnPagoMinimo').val());            
            if (TotalPago >= PagoMin) {
                window.location.href = "CheckOut.aspx";
            }
            else {                
                AlertCustomError('ATENCIÓN!<br/> La compra no supera el importe mínimo de $' + PagoMin + '.');
            }
        }
    </script>

    

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBeginAndEndHandler" runat="server">
    <script type="text/javascript" language="javascript">        
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
        function EndRequestHandler(sender, args) {
            if (args.get_error() == undefined) {
                //Despues de ejecutar la peticion de AJAX ASP.Net
                MaxMinButton();                
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CphBody" runat="server">
    <div class="row">
		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<!-- cart table start -->
			<div class="cart-page-main-area">
				<h2>Carrito de Compras</h2>
                <div class="row">
		            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-9">
				        <div class="table-responsive">
					        <table class="table cart-table">
						        <thead>
							        <tr>
								        <th class="width-1">Eliminar</th>
								        <th class="width-2">Imagen</th>
								        <th class="width-3">Producto</th>								
								        <th class="width-6">Precio </th>	
								        <th class="width-7">Cantidad</th>	
								        <th class="width-8">Subtotal</th>	
							        </tr>														
						        </thead>
						        <tbody>
                                    <asp:Literal ID="LitDetalleGrilla" runat="server"></asp:Literal>
						        </tbody>									
					        </table>
				        </div>
				        <div class="cartpage-button">
					        <div class="button-left">
						        <a href="ShopGrid.aspx" class="add-tag-btn cartpage-btn-1">Seguir Comprando</a>
					        </div>
					        <div class="button-right">
						        <a href="#" onclick="VaciarCarrito();return false;" class="add-tag-btn cartpage-btn-2">Vaciar Carrito</a>						
					        </div>	
				        </div>		
                    </div>
                    <div class="col-xs-12 col-sm-12 col-md-6 col-lg-3">
			            <!-- total-amount start -->
			            <div class="cart-page-single-area cartpage-total-amount" style="margin-top: 10px;">
                            <h2 class="cartpage-title">Realizar pago</h2>
				            <div class="cartpage-total-price">
					            <div class="total-price-box">
                                    <asp:Literal ID="LitTotalPago" runat="server"></asp:Literal>						            
					            </div>
					            <a onclick="RealizarPago();return false" style="cursor:pointer;" class="add-tag-btn">Pagar</a>	
                                <asp:HiddenField ID="HdnTotalPago" runat="server" Value="0" />
                                <asp:HiddenField ID="HdnPagoMinimo" runat="server" Value="0" />
				            </div>
			            </div>
			            <!-- total-amount end -->	
                        				
		            </div>
                </div>					
			</div>            
			<!-- cart table end -->
		</div>
        
	</div>	
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CphBrandClient" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="CphJsInferior" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $("input[name=qtybutton]").on('keyup', function () {            
                //var tot = $('#price').val() * this.value;
                //$('#total').val(tot);
                alert(this.value);

            });
            $(".qtybutton").on('click', function () {
                //var tot = $('#price').val() * this.value;
                //$('#total').val(tot);
                var Cant = $(this).parent().find("input[name=qtybutton]").val();
                var IdArt = $(this).parent().parent().find("input[name=idArticulo]").val();
                //alert('Cant:' + Cant + 'PLU:' +IdArt);
                CambiarCantCarro(IdArt, Cant);
            });
            
        });
    </script>
</asp:Content>
