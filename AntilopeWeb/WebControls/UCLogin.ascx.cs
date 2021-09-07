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
    public partial class UCLogin : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            getDetalle();
        }
        
        public void getDetalle()
        {
            string data = "";
            
            if (Session["Cliente"] == null) //si la varialbe sesion no tiene nada es porque no vino del login, por eso vuelve a default.aspx
            {
                data += "<ul><li><a href='Login.aspx'><i class='fa glyphicon glyphicon-user'></i> Ingresá o registrate </a></li></ul> ";
            }
            else
            {
                int idCliente = Convert.ToInt32(Session["Cliente"].ToString());

                using (AntilopeWebDBEntities db = new AntilopeWebDBEntities())
                {
                    var result = db.Clientes.SingleOrDefault(b => b.Id == idCliente);
                    data += "<ul><li><a href> Hola! " + result.Nombre +" " +result.Apellido+ "</a><i class='fa fa-angle-down'></i> ";
                }
                data += "<ul> ";
                data += "<li><a href='MiCuenta.aspx'> Mi Cuenta</a></li> ";
                data += "<li><a href='MisPedidos.aspx'> Mis Pedidos</a></li> ";
                data += "<li><a href='Cart.aspx'> Mi Carrito </a></li> ";                
                data += "<li><a href='Home.aspx?logout=true' '>Salir</a></li> ";                
                data += "</ul> ";
                data += "</li></ul> ";
            }

            LitDetalleLogin.Text = data;
        }
        

       
    }
}