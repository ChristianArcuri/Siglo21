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
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ((Label)Master.FindControl("LblRuta")).Text = "Carrito de Compras";
            GetDetalleGrilla();
            HdnPagoMinimo.Value = "100";
        }
        public void GetDetalleGrilla()
        {
            try
            {
                string data = "";
                string dataPago = "";

                List<Carrito> ListaCarro = new List<Carrito>();
                Carrito carro = new Carrito();

                ListaCarro = carro.GetCarrito();
                foreach (Carrito c in ListaCarro)
                {
                    data += "<tr class='carttr_1'> ";
                    data += "<td><div class='cartpage-item-remove'><a href='#' onclick='DeleteCarrito(" + c.IdArticulo + ")' title='Remove'> Remove </a></div><td> ";
                    data += "<div class='cartpage-image'><a href='#'><img src='" + c.Imagen + "' alt='' /></a> ";
                    data += "</div></td> ";
                    data += "<td><div class='cartpage-pro-dec'><p><a href='#'> " + c.Nombre + "</a></p> ";
                    data += "</div></td> ";
                    data += "<td><div class='cart-pro-price'><p>$" + c.Precio + "</p> ";
                    data += "</div></td> ";
                    data += "<td><div class='cart-plus-minus'> ";
                    data += "<input class='cart-plus-minus-box' disabled type='text' name='qtybutton' value=" + c.Cantidad + "> ";
                    data += "</div> ";
                    data += "<input type='hidden' name='idArticulo' value=" + c.IdArticulo + " > ";
                    data += "</td> ";
                    data += "<td><div class='cart-pro-price'><p>$" + c.SubTotal + "</p> ";
                    data += "</div></td></tr> ";
                }
                LitDetalleGrilla.Text = data;

                string Total = carro.CalcularTotal(ListaCarro).ToString();
                dataPago += "<p><span class='sub-t'>Subtotal<span class='sub-t-p'>$" + Total + "</span></span></p> ";
                dataPago += "<p><span class='grand-t'>Total<span class='grand-t-p'>$" + Total + "</span></span></p>	";
                HdnTotalPago.Value = Total;
                LitTotalPago.Text = dataPago;
            }
            catch(Exception ex)
            {
                Response.Redirect("Error.aspx");
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
            catch (Exception ex)
            {
                return 0;
            }
        }
        [WebMethod]
        public static int VaciarCarrito()
        {
            try
            {
                Carrito carro = new Carrito();
                carro.VaciarCarrito();
                return 1;
            }
            catch (Exception ex)
            {
                return 0;
            }
        }
        [WebMethod]
        public static int CambiarCantItemCarrito(Int64 idArt, int Cant)
        {
            try
            {
                Carrito carro = new Carrito();
                carro.CambiarCantItemCarrito(idArt, Cant);
                return 1;
            }
            catch (Exception ex)
            {
                return 0;
            }
        }
        
    }
}