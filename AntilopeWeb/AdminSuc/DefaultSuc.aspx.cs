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
    public partial class DefaultSuc : System.Web.UI.Page
    {
        public class ContadoresSup
        {
            public string PedidosPendientes { get; set; }
            public string EntregasOK { get; set; }
            public string ClientesFrec { get; set; }
            public string VentasRealizadas { get; set; }
            public string PedidosPendPagos { get; set; }
            public string PedidosEnPrep { get; set; }
            public string PedidosEnDesp { get; set; }
            public string PedidosSinEntregar { get; set; }
            public string TotalEfectivo { get; set; }
            public string TotalTarjetas { get; set; }            
        }

        private AntilopeWebDBEntities db = new AntilopeWebDBEntities();
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
                    GetSucursales(Convert.ToInt32(Session["Sucursal"]));
                    //GetPedidosPendientes();
                }
            }
            
        }
        [WebMethod]
        public static string GetPedidosPendientes()
        {
            try
            {
                
                string data = "";
                if (HttpContext.Current.Session["Sucursal"] != null)
                {

                    int Sucursal = Convert.ToInt32(HttpContext.Current.Session["Sucursal"]);
                    using (AntilopeWebDBEntities db1 = new AntilopeWebDBEntities())
                    {
                        data += "<tbody><tr> ";
                        data += "<th style='width: 10px'>#</th> ";
                        data += "<th> Cliente </th> ";
                        data += "<th> Dirección </th> ";
                        data += "<th> Fecha Entrega </th> ";
                        data += "<th> Desde </th> ";
                        data += "<th> Hasta </th> ";
                        data += "<th> Estado </th> ";
                        data += "<th> Importe </th> ";
                        data += "<th> Ver Detalle </th> ";
                        data += "</tr> ";

                        List<Pedidos> Lista = (from u in db1.Pedidos where u.IdEstado == 7 && u.idSucursal == Sucursal select u).Take(5).ToList<Pedidos>();
                        foreach (Pedidos Ped in Lista)
                        {
                            var Estado = new FuncionesGrales().GetEstadoById(Ped.IdEstado.Value);
                            data += "<tr> ";
                            data += "<td> " + Ped.IdPedido + " </td> ";
                            data += "<td> " + Ped.Clientes.Nombre + " " + Ped.Clientes.Apellido + " </td> ";
                            data += "<td> " + Ped.Clientes.Direccion.Split(',')[0] + " </td> ";
                            data += "<td> " + Ped.Fecha_Entrega.Value.ToString("dd/MM/yyyy") + " </td> ";
                            data += "<td> " + Ped.Hora_Desde + " </td> ";
                            data += "<td> " + Ped.Hora_Hasta + " </td> ";
                            data += "<td><span class='label label-danger'>" + Estado.Descripcion + "</span></td> ";
                            data += "<td> " + Ped.Importe + " </td> ";
                            data += "<td><button type='button' onclick='VerDetalle(" + Ped.IdPedido + ");return false' class='btn btn-info'><i class='fa fa-search'></i></button></td> ";
                            data += "</tr> ";
                        }
                        data += "</tbody> ";
                    }
                }
                return data;

            }
            catch(Exception ex)
            {                
                return "ERROR";
            }
        }

        [WebMethod]
        public static List<ContadoresSup> GetContadores(int IdSucursal)
        {
            try
            {
                var estPendientes = new int[] { 7, 8, 9 };
                decimal? VentasTot = 0, TotEfectivo = 0, TotTarjetas = 0;
                using (AntilopeWebDBEntities dbC = new AntilopeWebDBEntities())
                {
                    var CantPedidosP = (from u in dbC.Pedidos where estPendientes.Contains(u.IdEstado.Value) select u).Count();
                    var CantPedidosPendPagos = (from u in dbC.Pedidos where u.IdEstado == 12 select u).Count();
                    var CantPedidosOK = (from u in dbC.Pedidos where u.IdEstado == 10 select u).Count();
                    var CantPedEnPrep = (from u in dbC.Pedidos where u.IdEstado == 8 select u).Count();
                    var CantPedEnDesp = (from u in dbC.Pedidos where u.IdEstado == 9 select u).Count();
                    var CantPedPendientes = (from u in dbC.Pedidos where u.IdEstado == 7 select u).Count();

                    var CantClientesFre = (from u in dbC.Pedidos where u.idSucursal == IdSucursal select u.Clientes).Distinct().Count();
                    VentasTot = (from u in dbC.Pedidos select u.Importe).Sum();
                    TotEfectivo = (from u in dbC.Pedidos where u.IdTipoPago == 2 select u.Importe).Sum();
                    TotTarjetas = (from u in dbC.Pedidos where u.IdTipoPago == 1 select u.Importe).Sum();
                    
                    List<ContadoresSup> Lista = new List<ContadoresSup>();
                    //Lista.Add(new ContadoresSup { PedidosSinEntregar = CantPedidosP.ToString(), EntregasOK = CantPedidosOK.ToString(), ClientesFrec = CantClientesFre.ToString(), VentasRealizadas = VentasTot.ToString(), PedidosPendPagos = CantPedidosPendPagos.ToString(), PedidosPendientes = CantPedPendientes.ToString(), PedidosEnPrep = CantPedEnPrep.ToString(), PedidosEnDesp = CantPedEnDesp.ToString() });
                    Lista.Add(new ContadoresSup
                    {
                        PedidosSinEntregar = CantPedidosP.ToString(),
                        EntregasOK = CantPedidosOK.ToString(),
                        ClientesFrec = CantClientesFre.ToString(),
                        VentasRealizadas = VentasTot.ToString(),
                        PedidosPendPagos = CantPedidosPendPagos.ToString(),
                        PedidosPendientes = CantPedPendientes.ToString(),
                        PedidosEnPrep = CantPedEnPrep.ToString(),
                        PedidosEnDesp = CantPedEnDesp.ToString(),
                        TotalEfectivo = "$" + TotEfectivo.ToString(),
                        TotalTarjetas = "$" + TotTarjetas.ToString()                        
                    });

                    return Lista;
                }
            }
            catch
            {
                return null;
            }

        }

        [WebMethod]
        public static string GetDataCampana(int Sucursal)
        {
            try
            {
                string data = "";
                string ColorPorc = "progress-bar progress-bar-green ";

                using (AntilopeWebDBEntities db1 = new AntilopeWebDBEntities())
                {
                    var estPendientes = new int[] { 7, 8, 9 };
                    List<Pedidos> Lista = (from u in db1.Pedidos where estPendientes.Contains(u.IdEstado.Value) && u.idSucursal == Sucursal select u).ToList<Pedidos>();
                    string Cantidad = Lista.Count.ToString();

                    ///////////////
                    data += "<a href='#' class='dropdown-toggle' data-toggle='dropdown'> ";
                    data += "<i class='fa fa-bell-o'></i><span class='label label-warning'>" + Cantidad + "</span> ";
                    data += "</a><ul class='dropdown-menu'><li class='header'>Tiene " + Cantidad + " pedidos pendientes</li> ";
                    data += "<li><ul class=menu> ";

                    //////////
                    foreach (Pedidos Ped in Lista)
                    {
                        //int Porc = GetPorcentajePorEstado(Ped.IdEstado.Value, ref ColorPorc);
                        int Porc = 0;
                        switch (Ped.IdEstado.Value)
                        {
                            case 7: //Pendiente
                                Porc = 25;
                                ColorPorc = "progress-bar progress-bar-red";
                                break;
                            case 8: //En Preparacion
                                Porc = 50;
                                ColorPorc = "progress-bar progress-bar-yellow";
                                break;
                            case 9: //En Despacho
                                Porc = 75;
                                ColorPorc = "progress-bar progress-bar-aqua";
                                break;
                        }

                        //////////////
                        data += "<li><a href='DetallePedidos.aspx?Ped=" + Ped.IdPedido + "'> ";
                        data += "<h3> " + Ped.Clientes.Direccion.Split(',')[0] + " <small class='pull-right'>" + Porc + "%</small></h3> ";
                        data += "<div class='progress xs'> ";
                        data += "<div class='" + ColorPorc + "' style='width:" + Porc + "%' role='progressbar' aria-valuenow='" + Porc + "' aria-valuemin='0' aria-valuemax='100'> ";
                        data += "<span class='sr-only'>" + Porc + "% Completo</span>	";
                        data += "</div></div></a> ";
                    }
                    /////
                    data += "</ul></li><li class='footer'><a href='ListaPedidos.aspx?Est=7'> Ver todos</a> ";
                    data += "</li></ul></li> ";
                }
                return data;

            }
            catch
            {
                return "0";
            }
        }


        [WebMethod]
        public static string GetDataSucursal(int Sucursal)
        {
            try
            {
                string data = "";
                var Sucursales = new FuncionesGrales().GetSucursales();
                var suc = Sucursales.Where(x => x.Id == Sucursal).FirstOrDefault();
                data += suc.Nombre_Fantasia + "<small> " + suc.Direccion + " </small> ";
                return data;

            }
            catch
            {
                return "0";
            }
        }

        private void GetSucursales(int IdSucursal)
        {
            var Sucursales = new FuncionesGrales().GetSucursales();
            string data = "";
            data += "<div class='box-body box-profile'> ";
            //using (AntilopeWebDBEntities db = new AntilopeWebDBEntities())
            //{
            
            var Sucursal = Sucursales.Where(x => x.Id == IdSucursal).FirstOrDefault();
                string FechaVencePlan = "", labelPlan= "label-primary";
                
                data += "<img src='../"+Sucursal.StrImagen+"' style='margin: 0 auto; width:50%' class='img-responsive'/> ";
                data += "<h3 class='profile-username text-center'>"+Sucursal.Nombre_Fantasia+"</h3> ";
                data += "<p class='text-muted text-center'><i class='fa fa-map-marker margin-r-5'></i> "+Sucursal.Direccion+"</p> ";
                data += "<ul class='list-group list-group-unbordered'> <li class='list-group-item'> ";
                data += "<b>Razon Social</b> <a class='pull-right'>" + Sucursal.Razon_Social + "</a> ";
                data += "</li><li class='list-group-item'> ";
                data += "<b>Telefono</b> <a class='pull-right'>" + Sucursal.Telefono + "</a> ";
                data += "</li><li class='list-group-item'> ";
                data += "<b>Mail</b> <a class='pull-right'>" + Sucursal.Email + "</a> ";
                data += "</li><li class='list-group-item'> ";
                data += "</li></ul> ";                
                
            //}
            data += "</div> ";
            LitDatosSucursal.Text = data;
        }
    }
}