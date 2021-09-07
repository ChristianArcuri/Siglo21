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
    public partial class MisPedidos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    ((Label)Master.FindControl("LblRuta")).Text = "Mis Pedidos";
                    if (Session["Cliente"] != null)
                    {
                        int idCliente = Convert.ToInt32(Session["Cliente"].ToString());
                        GetDetalleGrilla(idCliente);
                        
                    }
                    else
                    {
                        Response.Redirect("Login.aspx", false);
                    }
                }
            }
            catch(Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
        }
        public void GetDetalleGrilla(int idCliente)
        {
            try
            {
                string data = "";
                var Sucursales = new FuncionesGrales().GetSucursales();
                
                using (AntilopeWebDBEntities db = new AntilopeWebDBEntities())
                {
                    List<Pedidos> Lista = (from u in db.Pedidos where u.idCliente == idCliente select u).OrderByDescending(x=> x.IdPedido).ToList<Pedidos>();
                    foreach (Pedidos Ped in Lista)
                    {
                        var Sucursal = Sucursales.Where(x => x.Id == Ped.idSucursal).FirstOrDefault();
                        var PedEstado = new FuncionesGrales().GetEstadoById(Ped.IdEstado.Value);
                        data += "<tr> ";
                        data += "<td> " + Ped.IdPedido + " </td> ";
                        data += "<td> " + Sucursal.Direccion + " </td> ";
                        data += "<td> " + Ped.Fecha_Entrega.Value.ToString("dd/MM/yyyy") + " </td> ";
                        data += "<td> " + Ped.Hora_Desde + " </td> ";
                        data += "<td> " + Ped.Hora_Hasta + " </td> ";
                        data += "<td><span class='label " + PedEstado.CssLabel + "'>" + PedEstado.Descripcion + "</span></td> ";
                        data += "<td> " + Ped.Importe + " </td> ";
                        data += "<td><button type='button'  onclick='ImprimirRecibo(" + Ped.IdPedido + ");return false' class='btn btn-info'><i class='fa fa-print'></i></button></td> ";
                        data += "</tr> ";

                    }
                }
                LitGrillaPedidos.Text = data;
                
            }
            catch(Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
        }

        
    }
}