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
using mercadopago;
using System.Collections;
using System.Configuration;

namespace AntilopeWeb
{
    public partial class CheckOut : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Session["Cliente"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
                else
                {
                    if (!IsPostBack)
                    {
                        ((Label)Master.FindControl("LblRuta")).Text = "Realizar el pago";
                        GetDetalleGrilla();
                        GetDetalleDomicilio();
                        SetComboFormaPago();
                    }
                }
                

            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
        }

        public void GetDetalleGrilla()
        {
            string data = "";
            string dataPago = "";

            List<Carrito> ListaCarro = new List<Carrito>();
            Carrito carro = new Carrito();

            ListaCarro = carro.GetCarrito();
            foreach (Carrito c in ListaCarro)
            {
                data += "<tr><td><div class='o-pro-dec'> ";
                data += "<p>"+ c.Nombre +"</p> ";
                data += "</div></td><td><div class='o-pro-price'> ";
                data += "<p>$" + c.Precio + "</p> ";
                data += "</div></td><td><div class='o-pro-qty'> ";
                data += "<p>" + c.Cantidad + "</p> ";
                data += "</div></td><td><div class='o-pro-subtotal'> ";
                data += "<p>$" + c.SubTotal + "</p> ";
                data += "</div></td></tr> ";
                
            }
            LitGrillaPedido.Text = data;

            decimal Total = carro.CalcularTotal(ListaCarro);            
            dataPago += "<tr><td colspan='3'> Subtotal </td><td colspan='1'>$" + Total.ToString() + "</td> ";
            dataPago += "</tr><tr class='tr-f'><td colspan='3'> Costos de envío</td><td colspan='1'>$0.00</td></tr> ";
            dataPago += "<tr><td colspan='3'> Total </td><td colspan='1'>$" + Total.ToString() + "</td></tr> ";
            LitGrillaPedFooter.Text = dataPago;

            int idSucursal = 1;

            var Sucursales = new FuncionesGrales().GetSucursales();
            var Sucursal = Sucursales.Where(b => b.Id == idSucursal).FirstOrDefault();
            
                int PagoMinimo =100;
                bool AceptaTarjeta = (Sucursal.IdMercadoPago != null) ? true : false;
                if (Total < PagoMinimo)
                {
                    BtnPagoEfectivo.Enabled = false;
                    BtnPagoTarjeta.Enabled = false;
                }
                if (AceptaTarjeta)
                {
                    LitTerminarCompra.Text = "<a onclick='CallModalMedioPago(0);return false; ' style='cursor:pointer' class='add-tag-btn'>Terminar Compra</a>";
                }
                else
                {
                    LitTerminarCompra.Text = "<a onclick='CallModalMedioPago(2);return false; ' style='cursor:pointer' class='add-tag-btn'>Terminar Compra</a>";
                }
            
           
        }
        public void GetDetalleDomicilio()
        {            
            try
            {
                
                string data = "";
                if (Session["Cliente"] != null)
                {
                    int idCliente = Convert.ToInt32(Session["Cliente"].ToString());
                    using (AntilopeWebDBEntities db = new AntilopeWebDBEntities())
                    {
                        var cli = db.Clientes.First(i => i.Id == idCliente);
                        data += "<li>" + cli.Direccion + "</li> ";
                        data += "<li>Depto.: " + cli.Departamento + "</li> ";
                        data += "<li>Tel: " + cli.Telefono + "</li> ";

                        if (cli.Direccion == "")
                        {
                            HdnFaltaDireccion.Value = "1";
                        }
                    }
                }
                else
                {
                    data += "<li>-</li> ";
                    data += "<li>Depto.: -</li> ";
                    data += "<li>Tel: -</li> ";
                    HdnFaltaDireccion.Value = "1";
                }
                
                LitDireccionEntrega.Text = data;
                
                
            }
            catch
            {
                int i= 0;
            }
        }

        public void SetComboFormaPago()
        {
            DlFormaEntrega.Items.Insert(0, new ListItem("Retiro en sucursal", "RetiroSucursal"));
            DlFormaEntrega.Items.Insert(1, new ListItem("Entrega a domicilio", "EntregaDomicilio"));
            //if (TipoPlan ==3)
            //{
            //    DlFormaEntrega.Items.Insert(1, new ListItem("Entrega a domicilio", "EntregaDomicilio"));
            //}

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

        protected void BtnTerminarPagoTarjeta_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["Cliente"] == null)
                {
                    //Error                
                }
                else
                {
                    int idPedidoNuevo;
                    int idCliente = Convert.ToInt32(Session["Cliente"].ToString());
                    List<Carrito> ListaCarro = new List<Carrito>();
                    Carrito carro = new Carrito();

                    ListaCarro = carro.GetCarrito();
                    decimal PrecioTotal = carro.CalcularTotal(ListaCarro);
                    string idMP = "", ClaveMP = "";


                    using (AntilopeWebDBEntities db = new AntilopeWebDBEntities())
                    {
                        var ped = new Pedidos
                        {
                            idSucursal = 1,
                            idCliente = idCliente,
                            Fecha_Compra = DateTime.Now,
                            IdEstado = 12,
                            Importe = PrecioTotal,
                            Fecha_Entrega = DateTime.ParseExact(TxbFechaEntrega.Text, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture),
                            Hora_Desde = TxbHoraDesde.Text,
                            Hora_Hasta = TxbHoraHasta.Text,
                            IdTipoPago = 1,
                            FormaEntrega = DlFormaEntrega.SelectedValue
                        };
                        var p2 = db.Pedidos.Add(ped);

                        foreach (var item in ListaCarro)
                        {
                            var ped_detalle = new Pedidos_Detalle
                            {
                                idPedido = p2.IdPedido,
                                SKU = item.IdArticulo,
                                Precio = item.Precio,
                                Cantidad = item.Cantidad,
                                SubTotal = item.SubTotal
                            };
                            db.Pedidos_Detalle.Add(ped_detalle);
                        }

                        db.SaveChanges();
                        idPedidoNuevo = ped.IdPedido;
                        var Sucursales = new FuncionesGrales().GetSucursales();
                        var sucurs = Sucursales.Where(x => x.Id == 1).FirstOrDefault();
                        if (sucurs != null)
                        {
                            idMP = sucurs.IdMercadoPago;
                            ClaveMP = sucurs.ClaveMercadoPago;
                        }
                    }
                    //carro.VaciarCarrito();
                    CallMercadoPago(PrecioTotal.ToString(), idPedidoNuevo, idMP,ClaveMP);
                    
                }
            }
            catch(Exception ex)
            {
                Response.Redirect("Mensajes?Mns=CustomError&Error=No se pudo crear el pedido", false);
            }
        
        }

        protected void BtnTerminarPagoEfectivo_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["Cliente"] == null)
                {
                    //Error                
                }
                else
                {
                    int idPedidoNuevo;
                    int idCliente = Convert.ToInt32(Session["Cliente"].ToString());
                    List<Carrito> ListaCarro = new List<Carrito>();
                    Carrito carro = new Carrito();

                    ListaCarro = carro.GetCarrito();
                    decimal PrecioTotal = carro.CalcularTotal(ListaCarro);
                    
                    using (AntilopeWebDBEntities db = new AntilopeWebDBEntities())
                    {
                        var ped = new Pedidos
                        {
                            idSucursal = 1,
                            idCliente = idCliente,
                            Fecha_Compra = DateTime.Now,
                            IdEstado = 7,
                            Importe = PrecioTotal,
                            Fecha_Entrega = DateTime.ParseExact(TxbFechaEntrega.Text, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture),
                            Hora_Desde = TxbHoraDesde.Text,
                            Hora_Hasta = TxbHoraHasta.Text,
                            IdTipoPago = 2,
                            FormaEntrega = DlFormaEntrega.SelectedValue
                        };
                        var p2 = db.Pedidos.Add(ped);

                        foreach (var item in ListaCarro)
                        {
                            var ped_detalle = new Pedidos_Detalle
                            {
                                idPedido = p2.IdPedido,
                                SKU = item.IdArticulo,
                                Precio = item.Precio,
                                Cantidad = item.Cantidad,
                                SubTotal = item.SubTotal
                            };
                            db.Pedidos_Detalle.Add(ped_detalle);
                        }

                        db.SaveChanges();
                        idPedidoNuevo = ped.IdPedido;
                    }
                    carro.VaciarCarrito();
                    Response.Redirect("Mensajes?Mns=PagoEfectivo&idPedido=" + idPedidoNuevo + "", false);
                    
                }
            }
            catch (Exception ex)
            {                
                Response.Redirect("Mensajes?Mns=CustomError&Error=No se pudo crear el pedido", false);
            }

        }


        private void CallMercadoPago(string Precio, int idPedido, string idMP, string ClaveMP)
        {
            try
            {
                string Importe = Precio.Replace(',', '.');
                //MP mp = new MP("8491987968010427", "ZryiWYeA8CD0MH5igzqfcQrAe3PIwIOA");
                MP mp = new MP(idMP, ClaveMP);                
                string Producto = "Compra Online Antilope";
                string URL = ConfigurationManager.AppSettings["URL_PROD"];
          
                string PageSuccess = URL+ "Mensajes.aspx?Mns=PagoOk";
                string PagePending = URL + "Mensajes.aspx?Mns=PagoPend";
                string PageFailure = URL + "Mensajes.aspx?Mns=CustomError&Error=No se pudo procesar el pago";

                //Hashtable preference = mp.createPreference("{\"items\":[{\"title\":\"" + Producto + "\",\"quantity\":1,\"currency_id\":\"ARS\",\"unit_price\":" + Importe + ",\"back_url\":\"http://superya.somee.com/Login.aspx\",\"payer_email\":\"info@misuperchino.com\"}]}");
                System.Net.ServicePointManager.SecurityProtocol = System.Net.SecurityProtocolType.Tls12;
                Hashtable preference = mp.createPreference("{\"items\":[{\"title\":\"" + Producto + "\",\"id\":" + idPedido + ",\"quantity\":1,\"currency_id\":\"ARS\",\"unit_price\":" + Importe + "}],\"back_urls\":{\"success\":\"" + PageSuccess + "\",\"failure\":\"" + PageFailure + "\",\"pending\":\"" + PagePending + "\"}}");
                
                string urlPago = ((Hashtable)preference["response"])["init_point"].ToString();
                using (AntilopeWebDBEntities db = new AntilopeWebDBEntities())
                {
                    var result = db.Pedidos.SingleOrDefault(b => b.IdPedido == idPedido);
                    if (result != null)
                    {
                        result.preference_id = ((Hashtable)preference["response"])["id"].ToString();
                        db.SaveChanges();
                    }
                }

                Response.Redirect(urlPago, false);
            }
            catch (Exception ex)
            {                
                Response.Redirect("Mensajes?Mns=CustomError&Error=No se pudo crear el pedido", false);
            }
            
        }

        protected void lnkIngresarDirec_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["Cliente"] != null)
                {
                    int idCliente = Convert.ToInt32(Session["Cliente"].ToString());
                    using (AntilopeWebDBEntities db = new AntilopeWebDBEntities())
                    {
                        var client = db.Clientes.SingleOrDefault(b => b.Id == idCliente);
                        if (client != null)
                        {                            
                            client.Direccion = TxbDireccionAlta.Text;
                            client.Departamento = TxbDeptoAlta.Text;
                            db.SaveChanges();
                        }
                    }
                    Response.Redirect("Checkout.aspx", false);

                }
                else
                {
                    Response.Redirect("Mensajes.aspx?Mns=CustomError&Error=No se pudieron modificar los datos personales", false);
                }

            }
            catch (Exception ex)
            {
                Response.Redirect("Mensajes.aspx?Mns=CustomError&Error=No se pudieron modificar los datos personales", false);                
            }
        }
    }
}