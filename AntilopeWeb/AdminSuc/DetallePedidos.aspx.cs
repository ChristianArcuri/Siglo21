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
using System.Threading;
using System.Globalization;

namespace AntilopeWeb.AdminSuc
{
    public partial class DetallePedidos : System.Web.UI.Page
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
                    string idPedido = Request.QueryString["Ped"];
                    if (idPedido != null)
                    {
                        HdnIdPedido.Value = idPedido;
                        GetDetalleGrilla(Convert.ToInt32(idPedido));
                        GetDatosCliente(Convert.ToInt32(idPedido));
                    }

                }
            }
        }
        public void GetDetalleGrilla(int idPedido)
        {
            try
            {
                string data = "";

                using (AntilopeWebDBEntities db = new AntilopeWebDBEntities())
                {
                    List<Pedidos_Detalle> ListaDet = (from u in db.Pedidos_Detalle where u.idPedido == idPedido select u).ToList<Pedidos_Detalle>();

                    foreach (Pedidos_Detalle Ped_Det in ListaDet)
                    {

                        data += "<tr> ";
                        data += "<td> " + Ped_Det.Articulos.SKU + " </td> ";
                        data += "<td> " + Ped_Det.Articulos.Descripcion + " </td> ";
                        data += "<td> " + Ped_Det.Precio + " </td> ";
                        data += "<td> " + Ped_Det.Cantidad + " </td> ";
                        data += "<td> " + Ped_Det.SubTotal + " </td> ";                        
                        data += "</tr> ";
                    }
                }
                LitGrillaDetPedido.Text = data;
            }
            catch(Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
        }
        public void GetDatosCliente(int idPedido)
        {
            try
            {
                string dataPedido = "";
                string dataCliente = "";
                string dataFechaEntrega = "";
                string dataDirEntrega = ""; 
                using (AntilopeWebDBEntities db = new AntilopeWebDBEntities())
                {
                    //var Pedido = (from u in db.Pedidos where u.IdPedido == idPedido select u).First();
                    var Pedido = db.Pedidos.First(i => i.IdPedido == idPedido);
                    var Estado = new FuncionesGrales().GetEstadoById(Pedido.IdEstado.Value);

                    dataPedido += "<span class='info-box-text'>PEDIDO N°<b> " + Pedido.IdPedido+"</b></span> ";
                    dataPedido += "<span class='info-box-number'>Importe $" + Pedido.Importe+"</span> ";
                    dataPedido += "<span class='progress-description'>Estado: " + Estado.Descripcion+"</span> ";                    

                    dataCliente += "<span class='info-box-text'>Cliente</span>";
                    dataCliente += "<span class='info-box-text'>"+ Pedido.Clientes.Nombre + " " +Pedido.Clientes.Apellido+ "</span> ";
                    dataCliente += "<span class=progress-description0><b>Telefono:</b> " + Pedido.Clientes.Telefono+" </span> ";
                    dataCliente += "<span class='progress-description'><b>Mail:</b>  " + Pedido.Clientes.Mail + "</span> ";

                    dataFechaEntrega += "<span class='info-box-text'>Fecha Entrega: <b>" + Pedido.Fecha_Entrega.Value.ToString("dd/MM/yyyy")+"</b></span> ";
                    dataFechaEntrega += "<span class='progress-description'><b>Desde:</b> " + Pedido.Hora_Desde+" </span> ";
                    dataFechaEntrega += "<span class='progress-description'><b>Hasta:</b> " + Pedido.Hora_Hasta + " </span> ";
                    string DescPago = (Pedido.IdTipoPago == 1) ? "Mercardopago" : "Efectivo";
                    dataFechaEntrega += "<span class='progress-description'><b>Pago:</b> " + DescPago + " </span> ";

                    dataDirEntrega += "<span class='info-box-text'>DIRECCION DE ENTREGA</span> ";
                    dataDirEntrega += "<span class='info-box-number'>"+Pedido.Clientes.Direccion.Split(',')[0]+"</span> ";
                    dataDirEntrega += "<span class='progress-description'>"+ Pedido.Clientes.Departamento+ ""+ Pedido.Clientes.Direccion.Split(',')[1] + "</span> ";

                    if (Pedido.IdEstado == 10 || Pedido.IdEstado == 13) //No se puede cambiar el estado si ya está finalizado.
                        BtnCambiarEstado.Visible = false;

                }
                LitFramePedido.Text = dataPedido;
                LitFrameCliente.Text = dataCliente;
                LitFrameFechaEntrega.Text = dataFechaEntrega;
                LitDireccionEntrega.Text = dataDirEntrega;
            }
            catch(Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
        }
        [WebMethod]
        public static int CambiarEstado(int IdPedido, int idEstado)
        {
            try
            {                
                using (AntilopeWebDBEntities db = new AntilopeWebDBEntities())
                {
                    var result = db.Pedidos.SingleOrDefault(b => b.IdPedido == IdPedido);
                    if (result != null)
                    {
                        result.IdEstado = idEstado;                        
                        db.SaveChanges();
                    }
                }
                return 1;
            }
            catch(Exception ex)
            {
                return 0;

            }
        }
    }
}