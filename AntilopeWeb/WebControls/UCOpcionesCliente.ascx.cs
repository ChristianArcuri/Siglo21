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
    public partial class UCOpcionesCliente : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Cliente"] != null)
                {
                    int idCliente = Convert.ToInt32(Session["Cliente"].ToString());
                    //int Sucursal = Convert.ToInt32(Session["SucursalCliente"]);
                    Carrito carro = new Carrito();
                    string StrImagen = "../img/usuarios/";

                    LblCantCarrito.Text = carro.GetCarrito().Count.ToString();                    
                    using (AntilopeWebDBEntities db = new AntilopeWebDBEntities())
                    {
                        int CantPedidos = (from u in db.Pedidos where u.idCliente == idCliente && u.idSucursal == 1 select u).Count();
                        var Cliente = db.Clientes.First(i => i.Id == idCliente);
                        LblCantPedidos.Text = CantPedidos.ToString();
                        //LblCantPuntos.Text = (Cliente.Puntos!=null) ? Cliente.Puntos.Value.ToString(): "0";
                        LblNombre.Text = Cliente.Nombre.ToString() +""+ Cliente.Apellido.ToString();
                        LblDireccion.Text = Cliente.Direccion.Split(',')[0].ToString();
                        StrImagen = StrImagen + Cliente.Imagen;


                    }
                    LitImagenCliente.Text = "<img class='img-circle' src="+ StrImagen + " /> ";

                }
                    

            }

        }
       
    }
}