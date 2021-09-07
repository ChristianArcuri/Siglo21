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

namespace AntilopeWeb.AdminSuc
{
    public partial class ListaPedidos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Sucursal"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    string idEstado = Request.QueryString["Est"];
                    string idLiquid = Request.QueryString["Liquid"];
                    if (idEstado != null)
                    {                        
                        GetDetalleGrilla(Convert.ToInt32(idEstado), Convert.ToInt32(Session["Sucursal"]));
                    }                    
                }
            }
        }
        public void GetDetalleGrilla(int idEstado, int Sucursal)
        {
            try
            {
                string data = "";                
                switch (idEstado)
                {
                    case 7: //Pendiente                        
                        LblTituloGrilla.Text = "Listado de Pedidos Pendientes";
                        break;
                    case 8: //En Preparacion                        
                        LblTituloGrilla.Text = "Listado de Pedidos En Preparación";
                        break;
                    case 9: //En Despacho                        
                        LblTituloGrilla.Text = "Listado de Pedidos En Despacho";
                        break;
                    case 10: //Entregado                        
                        LblTituloGrilla.Text = "Listado de Pedidos Entregados";
                        break;
                }
                
                
                using (AntilopeWebDBEntities db = new AntilopeWebDBEntities())
                {
                    List<Pedidos> Lista = (from u in db.Pedidos where u.IdEstado == idEstado && u.idSucursal == Sucursal select u).ToList<Pedidos>();
                    foreach (Pedidos Ped in Lista)
                    {
                        var Estado = new FuncionesGrales().GetEstadoById(Ped.IdEstado.Value);                        
                        string MedioPago = (Ped.IdTipoPago == 1) ? "Mercardopago" : "Efectivo";

                        data += "<tr> ";
                        data += "<td><button type='button' onclick='VerDetalle(" + Ped.IdPedido + ");return false' class='btn btn-info'><i class='fa fa-search'></i></button></td> ";
                        data += "<td> " + Ped.IdPedido + " </td> ";
                        data += "<td> " + Ped.Clientes.Nombre +Ped.Clientes.Apellido + " </td> ";
                        data += "<td> " + Ped.Clientes.Direccion + " </td> ";
                        data += "<td> " + Ped.Fecha_Entrega.Value.ToString("dd/MM/yyyy") + " </td> ";
                        data += "<td> " + Ped.Hora_Desde + " </td> ";
                        data += "<td> " + Ped.Hora_Hasta + " </td> ";
                        data += "<td><span class='label "+ Estado.CssLabel + "'>" + Estado.Descripcion + "</span></td> ";
                        data += "<td> " + Ped.Importe + " </td> ";
                        data += "<td> " + MedioPago + " </td> ";                        
                        data += "</tr> ";
                    }
                }
                LitGrillPedidos.Text= data;
            }
            catch(Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
        }
        
    }
}