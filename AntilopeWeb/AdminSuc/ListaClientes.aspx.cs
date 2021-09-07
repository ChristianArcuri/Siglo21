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
    public partial class ListaClientes : System.Web.UI.Page
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
                    GetDetalleGrilla(Convert.ToInt32(Session["Sucursal"]));
                }                

            }
        }
        public void GetDetalleGrilla(int Sucursal)
        {
            try
            {
                string data = "";
                using (AntilopeWebDBEntities db = new AntilopeWebDBEntities())
                {   
                    var query = from p in db.Pedidos
                                join c in db.Clientes on p.idCliente equals c.Id
                                where p.idSucursal== Sucursal
                                group p by new { c.Id, c.Direccion,c.Nombre, c.Apellido, c.Telefono } into g
                                select new
                                {
                                    idCliente = g.Key.Id,
                                    Nombre = g.Key.Nombre + g.Key.Apellido,
                                    Direccion = g.Key.Direccion,
                                    Tel = g.Key.Telefono,
                                    CantCompras = g.Count(),
                                    Importe = g.Sum(p => p.Importe)
                                };
                                    

                    foreach (var item in query)
                    {
                        data += "<tr> ";
                        data += "<td> " + item.idCliente + " </td> ";
                        data += "<td> " + item.Nombre + " </td> ";
                        data += "<td> " + item.Direccion + " </td> ";
                        data += "<td> " + item.Tel + " </td> ";
                        data += "<td> " + item.CantCompras + " </td> ";
                        data += "<td> " + item.Importe + " </td> ";                        
                        data += "</tr> ";                        
                    }
                }
                LitGrillClientes.Text= data;
            }
            catch(Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
        }
    }
}