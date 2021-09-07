using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AntilopeWeb.Models;
using System.Net.Http;


namespace AntilopeWeb
{
    public partial class Home : System.Web.UI.Page
    {        
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!this.IsPostBack)
            {
                string Logout = (Request["logout"] != null) ? Request["logout"] : "";
                if (Logout == "true")
                {
                    Session["Cliente"] = null;
                    Session["SesCarrito"] = null;
                    Session["SucursalCliente"] = null;
                    Session["SucLocalidad"] = null;
                    Session["SucDireccion"] = null;
                    Session["SucAprox"] = null;
                }
                
                Session["FiltrosSucursales"] = null;
                GetMasVendidos();
                GetMasVistos();
                GetNuevosProductos();
                GetCategoriasInferior();
                GetOfertaMes();
                GetProductosDestacados();
            }
        }
        

        public void GetMasVendidos()
        {

            string data = "", dataTitle="";
            int CantDeptos = 0;
            
            var LstCategorias = new FuncionesGrales().GetCategorias();
            LstCategorias = LstCategorias.Where(x => x.Id == 1 || x.Id == 2 || x.Id == 4).ToList();
            var LstSubCategorias = new FuncionesGrales().GetSubCategorias();
            var LstArticulos = new FuncionesGrales().GetArticulos();

            foreach (var itemDepto in LstCategorias)
            {
                string panelActivo = (CantDeptos==0)? "active":"" ;
                dataTitle += "<li class='" + panelActivo + "'><p><a href='#destac-" + itemDepto.Nombre + "' data-toggle='tab'>" + itemDepto.Nombre + "</a></p></li> ";

                data += "<div role='tabpanel' class='tab-pane "+ panelActivo + "' id='destac-"+itemDepto.Nombre+"'>";
                data += "<div class='tab-content-area tab-carousel-1'><div class='carousel-p-b'><div class='product-carousel-1-h3'>";

                var LstSubCategByCategoria = LstSubCategorias.Where(x => x.Id_Categoria == itemDepto.Id).Select(y=>y.Id).ToList();
                var ArticulosLiving = LstArticulos.Where(o => LstSubCategByCategoria.Contains(o.Id_SubCategoria.Value)).ToList();
                CantDeptos += 1;
                int CantCateg = 0;
                foreach (var itemLiving in ArticulosLiving)
                {

                    data += "<div class='item'> ";
                    data += "<div class='single-product-item'> ";
                    data += " <div class='product-image'><div class='sale-stiker product-sticker'><img src='img/product/sale1.png' alt='product sticker' /></div>";
                    data += " <div class='product-sticker'><img src='img/product/new4.png' alt='product sticker' /></div>		 ";
                    data += " <a href='single-product.html'><img src='" + itemLiving.StrImagen + "' alt='product image' /></a> ";
                    data += " <div class='single-product-overlay'><div class='rating-box'><a title='1 star' class='rated' href='#'><i class='fa fa-star-o'></i></a><a title='2 star' class='rated' href='#'><i class='fa fa-star-o'></i></a><a title='3 star' class='rated' href='#'><i class='fa fa-star-o'></i></a><a title='4 star' href='#'><i class='fa fa-star-o'></i></a><a title='5 star' href='#'><i class='fa fa-star-o'></i></a></div> ";
                    data += " <div class='product-quick-view'><ul><li><a href='ShopProd?SKU="+ itemLiving.SKU+ "'><i class='fa fa-search'></i></a></li></ul></div> ";
                    data += " </div></div> ";
                    data += " <div class='single-product-text'> ";
                    data += " <h2><a class='product-title' href='single-product.html' title='" + itemLiving.Descripcion + "'>" + itemLiving.Descripcion + "</a></h2> ";
                    data += " <div class='product-price'><span class='old-price'>$" + itemLiving.Precio_Venta + "</span><span class='regular-price'>$" + itemLiving.Precio_Oferta + "</span></div> ";
                    data += " <div class='pro-add-to-cart'><p><a style='cursor:pointer;' onclick='AddCarrito(" + itemLiving.SKU + ")'>Agregar</a></p></div> ";

                    data += " </div></div> ";
                    data += " </div> ";
                    CantCateg += 1;

                }
                data += "</div></div></div></div> ";
            }
            LitTitVendLiving.Text = dataTitle;
            LitMasVendLiving.Text = data;
        }

        public void GetMasVistos()
        {

            string data = "", dataTitle="";
            int CantDeptos = 0;
            
            var LstCategorias = new FuncionesGrales().GetCategorias();
            LstCategorias = LstCategorias.Where(x => x.Id == 2 || x.Id == 4).ToList();
            var LstSubCategorias = new FuncionesGrales().GetSubCategorias();
            var LstArticulos = new FuncionesGrales().GetArticulos();

            foreach (var itemDepto in LstCategorias)
            {
                string panelActivo = (CantDeptos == 0) ? "active" : "";
                
                dataTitle += "<li class='" + panelActivo + "'><p><a href='#more-" + itemDepto.Nombre + "' data-toggle='tab'>" + itemDepto.Nombre + "</a></p></li> ";
                
                data += "<div role='tabpanel' class='tab-pane " + panelActivo + "' id='more-" + itemDepto.Nombre + "'>";
                data += "<div class='tab-content-area tab-carousel-5'><div class='carousel-p-b'><div class='product-carousel-5'>";

                var LstSubCategByCategoria = LstSubCategorias.Where(x => x.Id_Categoria == itemDepto.Id).Select(y => y.Id).ToList();
                var ArticulosLiving = LstArticulos.Where(o => LstSubCategByCategoria.Contains(o.Id_SubCategoria.Value)).ToList();

                CantDeptos += 1;
                int CantCateg = 0;
                foreach (var itemLiving in ArticulosLiving)
                {


                    
                    data += "<div class='single-product-item'> ";
                    data += " <div class='product-image'><div class='sale-stiker product-sticker'><img src='img/product/sale1.png' alt='product sticker' /></div>";
                    data += " <div class='product-sticker'><img src='img/product/new4.png' alt='product sticker' /></div>		 ";
                    data += " <a href='single-product.html'><img src='" + itemLiving.StrImagen + "' alt='product image' /></a> ";
                    data += " <div class='single-product-overlay'><div class='rating-box'><a title='1 star' class='rated' href='#'><i class='fa fa-star-o'></i></a><a title='2 star' class='rated' href='#'><i class='fa fa-star-o'></i></a><a title='3 star' class='rated' href='#'><i class='fa fa-star-o'></i></a><a title='4 star' href='#'><i class='fa fa-star-o'></i></a><a title='5 star' href='#'><i class='fa fa-star-o'></i></a></div> ";
                    data += " <div class='product-quick-view'><ul><li><a href='ShopProd?SKU=" + itemLiving.SKU + "'><i class='fa fa-search'></i></a></li></ul></div> ";
                    data += " </div></div> ";
                    data += " <div class='single-product-text'> ";
                    data += " <h2><a class='product-title' href='single-product.html' title='" + itemLiving.Descripcion + "'>" + itemLiving.Descripcion + "</a></h2> ";
                    data += " <div class='product-price'><span class='old-price'>$" + itemLiving.Precio_Venta + "</span><span class='regular-price'>$" + itemLiving.Precio_Oferta + "</span></div> ";
                    data += " <div class='pro-add-to-cart'><p><a style='cursor:pointer;' onclick='AddCarrito(" + itemLiving.SKU + ")'>Agregar</a></p></div> ";

                    data += " </div></div> ";
                    
                    
                    CantCateg += 1;

                }
                data += "</div></div></div></div> ";
            }



            LitTitMasVistos.Text = dataTitle;
            LitProdMasVistos.Text = data;
        }


        public void GetNuevosProductos()
        {

            string data = "";
            int CantCateg = 0;

            var LstArticulos = new FuncionesGrales().GetArticulos();
            var ArticulosNew = (LstArticulos.Count > 12) ? LstArticulos.Take(12) : LstArticulos;


            foreach (var itemLiving in ArticulosNew)
            {

                if ((CantCateg % 3) == 0)  //Para 2 renglones.
                {
                    data += "<div class='item'> ";
                }
                string DesProducto = (itemLiving.Descripcion.Length > 36) ? itemLiving.Descripcion.Substring(0, 35) : itemLiving.Descripcion;
                data += "<div class='block4-single-item'> ";
                data += "<div class='block4-pro-img'> ";
                data += "<a href='ShopProd?SKU="+ itemLiving.SKU+ "' title='" + itemLiving.Descripcion + "'><img src='" + itemLiving.StrImagen + "' alt='product image' /></a> ";
                data += "</div><div class='block4-pro-text'> ";
                data += "<a class='product-title' href='ShopProd?SKU=" + itemLiving.SKU + "' title='" + itemLiving.Descripcion + "'>" + DesProducto + "</a> ";
                data += " <div class='product-price' style='margin-top: 18px !important;'><span class='regular-price'>$" + itemLiving.Precio_Oferta + "</span></div> ";
                data += " </div></div> ";
                

                if (((CantCateg+1) % 3) == 0)
                {
                    data += " </div> ";
                }

                CantCateg += 1;

            }
                

            LitNewProducts.Text = data;
        }
        public void GetCategoriasInferior()
        {

            string data = "";
            int CantCateg = 0;
            var LstCategorias = new FuncionesGrales().GetCategorias();
            var LstSubCategorias = new FuncionesGrales().GetSubCategorias();

            foreach (var itemCateg in LstCategorias)
            {
                data += "<div class='col-xs-12 col-sm-6 col-md-4'><div class='single-category-box'><div class='shop-category-item'> ";
                data += "<h2><a href='ShopGrid?Categ=" + itemCateg.Id+"'>" + itemCateg.Nombre+ "</a></h2><ul> ";
                var LstSubCateg = LstSubCategorias.Where(x => x.Id_Categoria == itemCateg.Id).ToList();
                foreach (var itemSubCateg in LstSubCateg)
                {
                    data += " <li><a href='ShopGrid?SubCateg=" + itemSubCateg.Id+ "'>" + itemSubCateg.Nombre+ "</a></li> ";
                }

                data += " </ul></div> ";
                data += " <div class='shop-category-image'><img src='"+ itemCateg.Imagen+ "' alt='" + itemCateg.Nombre + "' /></div> ";
                data += " </div></div> ";

                CantCateg += 1;
            }
            LitCategInf.Text = data;
        }

        public void GetOfertaMes()
        {

            string data = "";
            var LstArticulos = new FuncionesGrales().GetArticulos().Where(x => x.Oferta_Vigente == true);

            foreach (var item in LstArticulos)
            {
                data += "<div class='block2-single-item'><div class='product-border'> <div class='block2-pro-img'> <a href=ShopProd?SKU=" + item.SKU + "><img src='" + item.StrImagen + "'/></a> </div><div class='block2-pro-text'> 	<h2><a class='product-title' href=ShopProd?SKU=" + item.SKU + ">" + item.Descripcion + "</a></h2><div class='rating-box'><a title='1 star' class='rated' href='#'><i class='fa fa-star-o'></i></a> 		<a title='2 star' class='rated' href='#'><i class='fa fa-star-o'></i></a> 		<a title='3 star' href='#'><i class='fa fa-star-o'></i></a><a title='4 star' href='#'><i class='fa fa-star-o'></i></a> 		<a title='5 star' href='#'><i class='fa fa-star-o'></i></a> 	</div> 	<div class='product-price'>  <span class='regular-price'>$" + item.Precio_Oferta + "</span> 		<span class='old-price'>$" + item.Precio_Venta + "</span> 	</div> 	<div class='product-description'> 		<p>" + item.Descripcion + " PLU.: " + item.SKU.ToString() + "</p></div> 	<div class='box-timer'><div class='timer'><div data-countdown='" + item.Oferta_FechaFin.Value.ToString("yyyy/MM/dd") + "'></div></div></div></div></div></div>";

            }
            LitOfertaMes.Text = data;
        }

        public void GetProductosDestacados()
        {

            string data = "";
            var LstArticulos = new FuncionesGrales().GetArticulos().Take(4);

            foreach (var item in LstArticulos)
            {
                //data += "<div class='block2-single-item'><div class='product-border'> <div class='block2-pro-img'> <a href=ShopProd?SKU=" + item.SKU + "><img src='" + item.StrImagen + "'/></a> </div><div class='block2-pro-text'> 	<h2><a class='product-title' href=ShopProd?SKU=" + item.SKU + ">" + item.Descripcion + "</a></h2><div class='rating-box'><a title='1 star' class='rated' href='#'><i class='fa fa-star-o'></i></a> 		<a title='2 star' class='rated' href='#'><i class='fa fa-star-o'></i></a> 		<a title='3 star' href='#'><i class='fa fa-star-o'></i></a><a title='4 star' href='#'><i class='fa fa-star-o'></i></a> 		<a title='5 star' href='#'><i class='fa fa-star-o'></i></a> 	</div> 	<div class='product-price'>  <span class='regular-price'>$" + item.Precio_Oferta + "</span> 		<span class='old-price'>$" + item.Precio_Venta + "</span> 	</div> 	<div class='product-description'> 		<p>" + item.Descripcion + " PLU.: " + item.SKU.ToString() + "</p></div> 	<div class='box-timer'><div class='timer'><div data-countdown='" + item.Oferta_FechaFin.Value.ToString("yyyy/MM/dd") + "'></div></div></div></div></div></div>";
                data += "<div class='block4-single-item'><div class='block4-pro-img'><a href='ShopProd?SKU="+item.SKU+"' ><img src='"+item.StrImagen+"'  /></a></div><div class='block4-pro-text'><a class='product-title' href='ShopProd?SKU="+item.SKU+"'>"+item.Descripcion+ "</a><div class='product-price' style='margin-top: 20px !important;'><span class='regular-price'>$" + item.Precio_Oferta+"</span><span class='old-price'>$"+item.Precio_Venta+"</span></div></div></div>";
            }
            LitProdDestacados.Text = data;
        }
    }
}