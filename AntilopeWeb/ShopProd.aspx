<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGralNew.Master" AutoEventWireup="true" CodeBehind="ShopProd.aspx.cs" Inherits="AntilopeWeb.ShopProd" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CphJsSuperior" runat="server">
    <script type="text/javascript">
        function AddCarrito(IdArt) {
            var Cantidad = $("input[name=qtybutton]").val();
            $.ajax({
                type: "POST",
                url: "ShopProd.aspx/AddCarrito",
                data: "{Id: " + IdArt + ",Cant: " + Cantidad + "}",
                traditional: true,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var Resp = (typeof response.d) == 'string' ? eval('(' + response.d + ')') : response.d;
                    if (Resp == 1) {
                        AlertOK();
                    }
                    else
                    {
                        AlertError();
                    }
                    RefrescarUpCarro();
                },
                error: function (result) {
                    alert('ERROR ' + result.status + ' ' + result.statusText);
                }
            });
        }
        function DeleteCarrito(IdArt) {
            $.ajax({
                type: "POST",
                url: "ShopProd.aspx/DeleteItemCarrito",
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
        function docReady() {
            $(".product-carousel-1, .product-carousel-2, .product-carousel-3, .product-carousel-4, .product-carousel-5, .product-carousel-6, .product-carousel-7").owlCarousel({
                slideSpeed: 1000,
                items: 5,
                itemsDesktop: [1199, 4],
                itemsDesktopSmall: [991, 2],
                itemsTablet: [767, 1],
                itemsMobile: [480, 1],
                autoPlay: false,
                navigation: true,
                pagination: false,
                navigationText: ['<i class="fa fa-caret-left owl-prev-icon"></i>', '<i class="fa fa-caret-right owl-next-icon"></i>']
            });
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
            /*----- Para que en la ShopProd.aspx funcionen las imágenes 240X240 -----*/
            //$('.zoomWrapper').css('height', '456px');
            //$('.zoomWrapper').css('width', '456px');
        }
    </script>

    <style type="text/css">        
        @media (max-width: 768px) {
            .single-product-text{
	            background: #fff none repeat scroll 0 0;
	            display: block;
	            height: auto;
	            left: 0;
	            margin-bottom: 0px;
	            overflow: hidden;
	            padding: 10px;
	            position: relative;
	            width: 100%;
	            bottom: 0;
            }
        }        

    </style> 
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ContentBeginAndEndHandler" runat="server">
    <script type="text/javascript" language="javascript">                
                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
                function EndRequestHandler(sender, args) {
                    if (args.get_error() == undefined) {
                        //Despues de ejecutar la peticion de AJAX ASP.Net
                        docReady();                        
                    }
                }
             </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CphBody" runat="server">
    				<div class="single-product-page-area">
					<div class="row">
						<div class="col-xs-12 col-sm-5 col-md-5 col-lg-5">
							<div class="single-product-image">
								<div class="single-pro-main-image">
									<a href="">                                        
                                        <asp:Literal ID="LitImagenPLU" runat="server"></asp:Literal>
									</a>
								</div>								
							</div>							
						</div>
						<div class="col-xs-12 col-sm-7 col-md-7 col-lg-7">
							<div class="single-product-description">
								<div class="pro-desc">
									<h2>
                                        <asp:Label ID="LblDescCortaPLU" runat="server" Text=""></asp:Label>
									</h2>

									<div class="pro-availability">
										<p class="availability">Disponibilidad :<span> En stock</span></p>					
									</div>
									<span class="regular-price">$<asp:Label ID="LblPrecioPLU" runat="server" Text=""></asp:Label></span>									
									<div class="product-content">
										<p>
                                            
                                            <asp:Label ID="LblDescLargaPLU" runat="server" Text=""></asp:Label>
										</p>
									</div>
								</div>
								<div class="product-variation">
									<div class="product-quantity">
										<div class="cart-plus-minus">
											<label>Cantidad:</label>
											<input class="cart-plus-minus-box" type="text" disabled name="qtybutton" value="1">
										</div>
										<div class="pro-add-to-cart">
											<p>
                                                <asp:LinkButton runat="server" id="LkbAgregar" >Agregar</asp:LinkButton>                                                
											</p>

										</div>
									</div>
									<div class="product-cart-option">
										<ul>
											<li><a href="#"><i class="fa fa-heart"></i></a></li>
											<li><a href="#"><i class="fa fa-retweet"></i></a></li>
											<li><a href="#"><i class="fa fa-envelope"></i></a></li>
										</ul>
									</div>
								</div>	
								<div class="single-product-social-share">
									<img src="img/social-share.jpg" alt="" />
								</div>										
							</div>	
						</div>
					</div>
				</div>
				<!-- single page product information end -->
				<!-- related product start -->
				<div class="row related-product">
					<div class="section-heading">
						<h2><span>Productos</span> Relacionados</h2>
					</div>	
					<div class="product-carousel-5">
                        <asp:Literal ID="LitProducRelacionados" runat="server"></asp:Literal>
					</div>					
				</div>
				<!-- related product end -->				
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CphBrandClient" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CphJsInferior" runat="server">
   
</asp:Content>
