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

namespace AntilopeWeb.WebControls
{
    public partial class UCCarritoDisplay : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                getDetalle();                
                if (Session["Cliente"]!=null)
                {
                    if (!IsPostBack)
                    {
                        int idCliente = Convert.ToInt32(Session["Cliente"].ToString());
                    }
                }
                
            }
            catch(Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
        }
        
        public void getDetalle()
        {
            string data = "";

            List<Carrito> ListaCarro = new List<Carrito>();
            Carrito carro = new Carrito();

            ListaCarro = carro.GetCarrito();            
            decimal PrecioTotal = carro.CalcularTotal(ListaCarro);
            LblPrecioSubTotalCarro.Text = PrecioTotal.ToString();
            
            LitCantYTotal.Text = "<span> (" + ListaCarro.Count.ToString() + ") item: <strong>$" + PrecioTotal.ToString() + " </strong></span> ";

            foreach (Carrito c in ListaCarro)
            {
                data += "<div class='single-mycart-item'><div class='mycart-item-pro'> ";
                data += "<div class='mycart-item-img'><a href='Cart.aspx' ><img src='" + c.Imagen + "' /></a></div> ";
                data += "<div class='mycart-item-text'> ";
                data += "<p><a class='mycart-title' href='Cart.aspx'>" + c.Nombre + "</a></p> ";
                data += "<a href='#' class='cart-price'><strong>" + c.Cantidad + "</strong><sub>x</sub> <span>$" + c.Precio + "</span></a> ";
                data += "</div></div><div class='mycart-item-edit'> ";                
                data += "<button  class='item-delete' style='border-radius:15px; border:1px solid;' onclick='DeleteCarrito(" + c.IdArticulo + ")'>Eliminar</button></div></div> ";
                
            }

            LitDetalleCarro.Text = data;
        }




    }
}