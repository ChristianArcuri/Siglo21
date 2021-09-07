<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGralNew.Master" AutoEventWireup="true" CodeBehind="ShopGrid.aspx.cs" Inherits="AntilopeWeb.ShopGrid" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CphJsSuperior" runat="server">
    <style type="text/css">
        .product-sgorting-bar {
            margin-top: -15px;
        }
        .ButonAddCart {
            background: transparent;
            border: 2px solid #00a9e0;
            border-radius: 50px;
            display: inline-block;
            font-size: 11px;
            font-weight: 700;
            line-height: 15px;
            padding: 7px 22px 4px;
            text-transform: uppercase;
        }
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
    
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="CphBody" runat="server">
    
    <div class="row">

       
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <div class="right-main-product">
                <!-- product-sgorting start -->
                <div class="product-sgorting-bar">
                    <!-- view-systeam start -->
                    <div class="view-systeam">

                    </div>
                    <!-- view-systeam end -->
                    <!-- show-page start -->
                    <div class="show-page">
                        <label>Mostrar</label>
                        <div class="per-page short-select-option">                            
                            <asp:DropDownList ID="DlMostrarProd" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DlMostrarProd_SelectedIndexChanged">
                                <asp:ListItem>8</asp:ListItem>
                                <asp:ListItem>10</asp:ListItem>
                                <asp:ListItem>12</asp:ListItem>
                                <asp:ListItem>16</asp:ListItem>
                                <asp:ListItem>20</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <span>por página</span>
                    </div>
                    <!-- show-page end -->
                    <!-- shoort-by start -->
                    <div class="shoort-by">
                        <label>Ordenar por</label>
                        <div class="short-select-option">
                            <asp:DropDownList ID="DlOrdenar" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DlOrdenar_SelectedIndexChanged">
                                <asp:ListItem Value="">Seleccionar</asp:ListItem>
                                <asp:ListItem Value="MenorPrecio">Precio más Bajo</asp:ListItem>
                                <asp:ListItem Value="MayorPrecio">Precio más Alto</asp:ListItem>
                                <asp:ListItem Value="NombreA">Nombre A-Z</asp:ListItem>
                                <asp:ListItem Value="NombreZ">Nombre Z-A</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <!-- shoort-by end -->
                </div>
                <!-- product-sgorting end -->
                <!-- all-product start -->
                

                 <div class="row all-grid-product">
                    <!-- single-product-item start -->
                     
                     <asp:ListView ID="productList" runat="server" DataKeyNames="SKU" GroupItemCount="5" ItemType="AntilopeWeb.Models.Articulos" SelectMethod="GetProducts">
                        <EmptyDataTemplate>
                            <table><tr><td>No hay artículos para esta búsqueda.</td></tr></table>
                        </EmptyDataTemplate>
                        <EmptyItemTemplate>
                            <td/>
                        </EmptyItemTemplate>    
                        <GroupTemplate>
                            <tr id="itemPlaceholderContainer" runat="server">
                                <td id="itemPlaceholder" runat="server"></td>
                            </tr>
                        </GroupTemplate>                    
                        <ItemTemplate>
                            <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
                                <div class="single-product-item">
                                    <div class="product-image">
                                        <a href="ShopProd?SKU=<%#:Item.SKU%>" title="">
                                            <img src='<%#:Item.StrImagen%>' alt="product image" />
                                        </a>
                                        <div class="single-product-overlay">
                                            <div class="product-quick-view">
                                                <ul>
                                                    <li><a href="ShopProd?SKU=<%#:Item.SKU%>"><i class="fa fa-search"></i></a></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="single-product-text">                                        
                                        <h2><a class="product-title" href="ShopProd?SKU=<%#:Item.SKU%>" title=""><%#:Item.Descripcion.Substring(0, Math.Min(Item.Descripcion.Length, 39))%></a></h2>
                                        <div class="product-price">
                                            <%--<span class="old-price"><%#:Item.PrecioAnt%></span>--%>
                                            <span class="regular-price">$<%#:Item.Precio_Oferta%></span></div>
                                        <div class="pro-add-to-cart">
                                            <p>  
                                                
                                              <%--  <% if(System.Web.HttpContext.Current.Session["Cliente"] != null) { %>
                                                    <a style="cursor:pointer;" onclick="AddCarrito(<%#:Item.SKU %>);">Agregar</a>   
                                                 <% }
                                                else { %>
                                                    <a style="cursor:pointer;" onclick="MensajeParaloguearse();">Agregar</a>   
                                                <% } %>--%>
                                                  <a style="cursor:pointer;" onclick="AddCarrito(<%#:Item.SKU %>);">Agregar</a>   
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>       
                        </ItemTemplate>
                        <LayoutTemplate>
                            <table style="width:100%;">
                                <tbody>
                                    <tr>
                                        <td>
                                            <table id="groupPlaceholderContainer" runat="server" style="width:100%">
                                                <tr id="groupPlaceholder"></tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                    </tr>
                                    <tr></tr>
                                </tbody>
                            </table>
                        </LayoutTemplate>
                    </asp:ListView>     
                </div>
                

                <!-- all-product end -->
                <!-- product-sgorting start -->
                <div class="product-sgorting-bar bar-2">
                    <!-- view-systeam start -->
                    <div class="view-systeam">
                    </div>
                    <!-- view-systeam end -->
                    <!-- show-page start -->
<%--                    <div class="pagination-bar">
                        <label>Página:</label>
                        <ul>
                            <li><a href="#">1</a></li>
                            <li class="active"><a href="#">2</a></li>
                            <li><a href="#">3</a></li>
                            <li><a href="#">4</a></li>
                            <li><a href="#">5</a></li>
                            <li><a href="#"><i class="fa fa-arrow-right"></i></a></li>
                        </ul>
                        
                    </div>--%>
                    <div class="pagination-bar">
                        <%--<label>Página:</label>--%>
                        <asp:DataPager ID="DataPager1" style="line-height: 33px; padding-left: 5px;" runat="server" PagedControlID="productList" PageSize="8">                        
                            <Fields>                                
                                <asp:NextPreviousPagerField ButtonType="Link" ShowFirstPageButton="false" ShowPreviousPageButton="true" ShowNextPageButton="false" />
                                <asp:NumericPagerField ButtonType="Link" />
                                <asp:NextPreviousPagerField ButtonType="Link" ShowNextPageButton="true" ShowLastPageButton="false" ShowPreviousPageButton = "false" />
                            </Fields>
                        </asp:DataPager>
                    </div>
                    <!-- show-page end -->                    
                </div>
                <!-- product-sgorting end -->
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CphBrandClient" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CphJsInferior" runat="server">

</asp:Content>
