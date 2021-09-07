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
    
    public partial class ImprimirRecibo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string idPedido = Request.QueryString["Ped"];                
                if (idPedido != null)
                {
                    GetTablaProductos(Convert.ToInt32(idPedido));
                    GetDatosCliente(Convert.ToInt32(idPedido));
                }
                
            }
        }
        public void GetTablaProductos(int idPedido)
        {
            try
            {
                string data = "";
                string dataPago = "";

                data += "<thead><tr> ";
                data += "<th> PLU </th> ";
                data += "<th> Producto </th> ";
                data += "<th> Precio </th> ";
                data += "<th> Cantidad </th> ";
                data += "<th> Subtotal </th> ";
                data += "</tr></thead><tbody> ";

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
                    data += "</tbody> ";

                    //string Total = db.Pedidos.First(i => i.IdPedido == idPedido).Importe.ToString();                    
                    var Pedido = db.Pedidos.First(i => i.IdPedido == idPedido);
                    string Total = Pedido.Importe.ToString();
                    string MedioPago = (Pedido.IdTipoPago == 1) ? "Mercardopago" : "Efectivo";
                    string FormaPago = (Pedido.FormaEntrega !=null) ? Pedido.FormaEntrega.ToString(): "";
                    dataPago += "<tr><th style='width:50 % '> Subtotal:</th><td>$"+ Total + " </td></tr> ";
                    dataPago += "<tr><th> Costos de envío</th><td>$0 </td></tr> ";
                    dataPago += "<tr><th> Total:</th><td>$" + Total + " </td></tr> ";

                    LitFooterTotalPedido.Text = dataPago;
                    LblMedioPago.Text = MedioPago;
                    LblFormaEntrega.Text = FormaPago;
                }
                LitTablaProductos.Text = data;                
            }
            catch
            {
            }
            
        }
        public void GetDatosCliente(int idPedido)
        {
            try
            {
                string dataDe = "";
                string dataA = "";
                var Sucursales = new FuncionesGrales().GetSucursales();
                using (AntilopeWebDBEntities db = new AntilopeWebDBEntities())
                {
                    var Pedidos = db.Pedidos.First(i => i.IdPedido == idPedido);
                    var Sucursal = Sucursales.Where(x => x.Id == Pedidos.idSucursal).FirstOrDefault();

                    dataDe += "Razon Social: <strong>" + Sucursal.Razon_Social+ "</strong><br> ";
                    dataDe += "Nombre: " + Sucursal.Nombre_Fantasia + "<br> ";
                    dataDe +=  "CUIT: "+ Sucursal.Cuit + "<br> ";
                    dataDe += "Direccion: " + Sucursal.Direccion + "<br> ";
                    dataDe += "Telefono: " + Sucursal.Telefono + "<br> ";

                    dataA += "Cliente: <strong>" + Pedidos.Clientes.Nombre + Pedidos.Clientes.Apellido + "</strong><br> ";
                    dataA += "Direccion: " + Pedidos.Clientes.Direccion + "<br> ";
                    dataA += "Telefono: " + Pedidos.Clientes.Telefono + "<br> ";
                    dataA += "Mail: " + Pedidos.Clientes.Mail + "<br> ";

                    LblPedidoId.Text = idPedido.ToString();
                    LblFechaPago.Text = Pedidos.Fecha_Compra.ToString();
                    LblFechaCompra.Text = Pedidos.Fecha_Compra.ToString();

                    HdnDesde.Value = Sucursal.Direc_Gmap;//Pedidos.Sucursales.Direccion;
                    HdnHasta.Value = Pedidos.Clientes.Direccion;
                }
                LitAdressDe.Text = dataDe;
                LitAdressA.Text = dataA;

            }
            catch
            {
            }

        }



    }
}
