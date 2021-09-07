<%@ Page Title="" Language="C#" MasterPageFile="~/MasterNew.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="AntilopeWeb.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CphJsSuperior" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBeginAndEndHandler" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CphSlider" runat="server">
    <div class="slider-area">
				<div class="container">
					<div class="row">
						<!-- slider start -->
						<div class="col-xs-12 col-sm-12 col-md-9">
							<div class="slider">
								<div id="mainSlider" class="nivoSlider">                                    
									<img src='../../img/home/slider1-lavado.jpg' alt='Descuentos increibles' title='#htmlcaption1'/>                                    
									<img src='../../img/home/slider2-informatica.jpg' alt='6 cuotas' title='#htmlcaption2'/>
                                    <img src='../../img/home/slider3-descuentos.jpg' alt='30 porciento descuento' title='#htmlcaption3'/>                                    
								</div>	
								<div id="htmlcaption1" class="nivo-html-caption progress-cap">
									    <div class="slider-progress"></div>
								    </div>
								<div id="htmlcaption2" class="nivo-html-caption progress-cap">
									<div class="slider-progress"></div>
								</div>
                                <div id="htmlcaption3" class="nivo-html-caption progress-cap">
									<div class="slider-progress"></div>
								</div>
							</div>
						</div>
						<!-- slider end -->
						<!-- block-img-add start -->
						<div class="col-xs-12 col-sm-12 col-md-3">
							<div class="block-img-add-2">
								<div class="single-image-add">
									<a href="ShopGrid?Categ=1">
                                        <img src="../../img/home/banner1.jpg" alt="Rebajas" />                                        
									</a>
								</div>
								<div class="single-image-add">
									<a href="ShopGrid?Categ=1">
                                        <img src="../../img/home/banner2.jpg" alt="Ahora12" />                                        
									</a>
								</div>
							</div>
						</div>
						<!-- block-img-add end -->							
					</div>
				</div>
			</div>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="CphSaleDay" runat="server">
    <div class="container">
					<div class="row">
						<div class="col-xs-12 col-sm-12  col-md-9">
							<!-- deal of day product area start -->
							<div class="block2 endofday-product-area">
								<div class="section-heading">
									<h2><span>Ofertas</span> del mes</h2>
								</div>
								<!-- deal-of-day-product start -->
								<div class="deal-of-day-product-h3">																	
									
									<asp:Literal ID="LitOfertaMes" runat="server"></asp:Literal>
									
								</div>
								
							</div>
							<!-- deal of day product area end -->	
							<!-- Bestseller products area start -->
							<div class="row Bestseller-h3">
								<div class="tab-product-area">
									<div class="bestseller-sec-heading section-heading">
										<h2><span>Artículos</span> más vendidos</h2>
										<div class="tab-carousel-menu">											
                                            <ul class="nav nav-tabs product-nav">
										        <asp:Literal ID="LitTitVendLiving" runat="server"></asp:Literal>
									        </ul>
										</div>
										<!-- tabs menu end -->							
									</div>
									<!-- tab content start -->
									<div class="tab-content">
										<asp:Literal ID="LitMasVendLiving" runat="server"></asp:Literal>
										
									</div>						
									<!-- tab content end -->
								</div>
							</div>
							<!-- Bestseller products area end -->
							<!-- block-img-add start -->
							<div class="block-img-add">
								<div class="row">
									<div class="col-xs-12 col-sm-4 col-md-4">
										<div class="single-image-add">
											<a href="ShopGrid?SubCateg=6">
                                                <img src="../../img/home/banner4.jpg" alt="Tablets" />                                                
											</a>
										</div>
									</div>
									<div class="col-xs-12 col-sm-8 col-md-8">
										<div class="single-image-add">
											<a href="ShopGrid?SubCateg=10">
                                                <img src="../../img/home/banner5.jpg" alt="Calefaccion" />                                                
											</a>
										</div>						
									</div>
								</div>
							</div>
							<!-- block-img-add end -->							
						</div>
						<div class="col-xs-12 col-sm-12 col-md-3">
							<div class="sidebar-area">
								<!-- block-img-add start -->
								<div class="block-img-add hidden-xs hidden-sm">
									<div class="single-image-add">
										<a href="ShopGrid?Categ=1">
                                            <img src="../../img/home/banner3.jpg" alt="GreenTech" />
                                            
										</a>
									</div>
								</div>
								<!-- block-img-add end -->
								<!-- featured-product start -->
								<div class="block4 sidebar-product">
									<div class="section-heading">
										<h2><span>Productos</span> Destacados</h2>
									</div>
									<div class="row">
										<div class="featured-product">											
											<div class="item">
												<asp:Literal ID="LitProdDestacados" runat="server"></asp:Literal>					
											</div>
											
										</div>
									</div>	
								</div>
								<!-- featured-product end -->
								<!-- shipping-add-image start -->
								<div class="block-img-add">
									<div class="single-shipping-image">
										<a href="#"><img src="img/shiping/banner_block0.jpg" alt="Soporte" /></a>
									</div>	
																	
								</div>
								<!-- shipping-add-image end -->
							</div>
						</div>						
					</div>
				</div>
</asp:Content>
<asp:Content ID="Content7" ContentPlaceHolderID="CphMostView" runat="server">
    <div class="container">
					<div class="row">
						<div class="tab-product-area">
							<div class="Mostview-sec-heading section-heading">
								<h2><span>Productos </span>más vistos</h2>
								<div class="tab-carousel-menu">
									<ul class="nav nav-tabs product-nav">
										<asp:Literal ID="LitTitMasVistos" runat="server"></asp:Literal>
									</ul>
								</div>
								<!-- tabs menu end -->							
							</div>
							
							<div class="tab-content">
								<asp:Literal ID="LitProdMasVistos" runat="server"></asp:Literal>
								
								
							</div>						
							
						</div>
					</div>
				</div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CphNewsProd" runat="server">
    <div class="container">
					<div class="section-heading">
						<h2><span>Nuevos</span> Productos</h2>
					</div>			
					<div class="row">
						<div class="col-xs-12 col-md-3 hidden-xs hidden-sm">
							<div class="single-image-add">
								<a href="ShopGrid?Categ=3">                                    
									<img src="../../img/home/banner7.png" alt="Cyber monday" />
								</a>
							</div>						
						</div>
						<div class="col-xs-12 col-md-9">
							<!-- new-product start -->
							<div class="block4 sidebar-product">
								<div class="row">
									<div class="new-product">										
										
										<asp:Literal ID="LitNewProducts" runat="server"></asp:Literal>
									</div>
								</div>
							</div>
							<!-- new-product end -->
						</div>
					</div>
				</div>
</asp:Content>
<asp:Content ID="Content8" ContentPlaceHolderID="CphCategories" runat="server">
    <div class="container">
				<div class="section-heading">
					<h2><span>Comprar por categorías</span></h2>
				</div>				
				    
                 <div class="row">						
                     <asp:Literal ID="LitCategInf" runat="server"></asp:Literal>
				</div>        
                    
                    
			</div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="CphJsInferior" runat="server">
</asp:Content>
