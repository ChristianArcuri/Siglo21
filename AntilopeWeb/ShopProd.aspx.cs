using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AntilopeWeb.Models;
using System.Web.Services;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;

namespace AntilopeWeb
{
    public partial class ShopProd : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                int idSucursal = 1;
                ((Label)Master.FindControl("LblRuta")).Text = "Ficha del Producto";
                string IdArt = Request.QueryString["SKU"];
                if (IdArt != null)
                {
                    Int64 IdSKU = Convert.ToInt64(IdArt);
                    int idSubCategoria = 0;
                    var LstArticulos = new FuncionesGrales().GetArticulos();
                    var item = LstArticulos.Where(i => i.SKU == IdSKU && i.Habilitado == true).FirstOrDefault();
                    
                    LblDescCortaPLU.Text = item.Descripcion;
                    LblDescLargaPLU.Text = item.Descripcion + "PLU.: " + item.SKU.ToString();
                    LitImagenPLU.Text = "<img id='optima_zoom' src='" + item.StrImagenBig + "' data-zoom-image= '" + item.StrImagenBig + "' alt='optima' />";
                    LblPrecioPLU.Text = item.Precio_Oferta.ToString();
                    idSubCategoria = item.Id_SubCategoria.Value;

                    //if (System.Web.HttpContext.Current.Session["Cliente"] != null)
                    //{
                    //    LkbAgregar.OnClientClick = "AddCarrito(" + item.SKU + ");return false;";
                    //}
                    //else
                    //{
                    //    LkbAgregar.OnClientClick = "MensajeParaloguearse();";
                    //}
                    LkbAgregar.OnClientClick = "AddCarrito(" + item.SKU + ");return false;";
                    
                    GetProductosRelacionados(idSubCategoria, idSucursal);

                }                
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }

        }
        public void GetProductosRelacionados(int idSubCategoria, int idSucursal)
        {
            if (idSubCategoria > 0)
            {
                string data = "";
                var LstArticulos = new FuncionesGrales().GetArticulos();
                var ListaRelac = LstArticulos.Where(i => i.Id_SubCategoria == idSubCategoria && i.Habilitado == true).Take(8);

                foreach (var art in ListaRelac)
                {
                    data += "<div class='single-product-item'><div class='product-image'> ";
                    data += "<a href='ShopProd?SKU=" + art.SKU + "'><img src='" + art.StrImagen + "'/></a> ";
                    data += "<div class='single-product-overlay'><div class='product-quick-view'><ul><li><a href='ShopProd?SKU=" + art.SKU + "'><i class='fa fa-search'></i></a></li></ul></div></div></div> ";
                    data += "<div class='single-product-text'><h2><a class='product-title' href='ShopProd?SKU=" + art.SKU + "'>" + art.Descripcion + "</a></h2> ";                        
                    data += "<div class='product-price'><span class='regular-price'>$" + art.Precio_Oferta + "</span></div> ";
                   
                    data += "<div class='pro-add-to-cart'><p><a style='cursor:pointer;' onclick='AddCarrito(" + art.SKU + ");'> Agregar </a></p></div></div></div> ";
                }
                

                LitProducRelacionados.Text = data;
            }
        }

        [WebMethod]
        public static int AddCarrito(Int64 Id, int Cant)
        {
            try
            {
                int SucursalId = Convert.ToInt32(HttpContext.Current.Session["SucursalCliente"]);
                Carrito carro = new Carrito();
                var LstArticulos = new FuncionesGrales().GetArticulos();
                var item = LstArticulos.Where(i => i.SKU == Id).FirstOrDefault();
                carro.AddCarrito(item.SKU, item.Descripcion, Convert.ToDecimal(item.Precio_Oferta), item.StrImagen, Cant, false, false);
                return 1;
            }
            catch(Exception ex)
            {                
                return 0;
            }
        }
        [WebMethod]
        public static int DeleteItemCarrito(Int64 Id)
        {
            try
            {
                Carrito carro = new Carrito();
                carro.DeleteItem(Id);
                return 1;
            }
            catch(Exception ex)
            {                
                return 0;
            }
        }
    }
}