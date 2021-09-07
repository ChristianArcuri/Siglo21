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
using System.Configuration;


namespace AntilopeWeb
{
    public partial class Mensajes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                ((Label)Master.FindControl("LblRuta")).Text = "Mensajes";
                string Mensaje = (Request["Mns"] != null) ? Request["Mns"] : "";

                switch (Mensaje)
                {
                    case "CreateUser":
                        CreacionUsuarioOK();
                        break;
                    case "CreateUserError":
                        AltaUsuarioError();
                        break;
                    case "CheckUser":
                        string token = (Request["Token"] != null) ? Request["Token"] : "";
                        string idCliente = (Request["id"] != null) ? Request["id"] : "";
                        if (CheckUsuario(token))
                        {
                            AltaUsuarioOK();
                        }
                        else
                        {
                            AltaUsuarioError();
                        }
                        break;
                    case "PagoOk":
                        int Ped =PagoOK(Request["preference_id"]);
                        if (Ped > 0)
                        {
                            Response.Write("<script>");
                            Response.Write("window.open('ImprimirRecibo.aspx?Ped=" + Ped + "', '_blank')");
                            Response.Write("</script>");
                            Carrito carro = new Carrito();
                            carro.VaciarCarrito();
                            EnviarMailPedidoOK(Ped);
                        }
                        break;
                    case "PagoEfectivo":
                        PagoOKEfectivo();
                        string idPedido = (Request["idPedido"] != null) ? Request["idPedido"] : "";
                        if (idPedido !="")
                        {
                            Response.Write("<script>");
                            Response.Write("window.open('ImprimirRecibo.aspx?Ped=" + idPedido + "', '_blank')");
                            Response.Write("</script>");
                            EnviarMailPedidoOK(Convert.ToInt32(idPedido));
                        }
                        break;                    
                    case "CustomError":
                        CustomError(Request["Error"].ToString());
                        break;
                    case "CustomOK":
                        CustomOk(Request["Mns1"].ToString(), Request["Mns2"].ToString());
                        break;
                    case "PagoPend":
                        PagoPendiente();
                        break;
                    default:
                        
                        break;
                }
            }
            catch(Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
        }
        public void GetError404()
        {
            string data = "<div class='error-page-area'><div class='error-content'> ";
            data += "<div class='error-image wow bounceInUp'><h1>4<i class='fa fa-life-ring fa-spin'></i>4!</h1></div> ";
            data += "<div class='error-heading'><h2>Esta página no está disponible</h2><h3>Lo sentimos mucho.Estamos trabajando para solucionar el inconveniente</h3> ";
            data += "</div><div class='error-back-home'><a href='Home.aspx' class='add-tag-btn'><i class='fa fa-chevron-left'></i> Inicio</a> ";
            data += "</div></div></div> ";

            LitMensaje.Text = data;
        }
        public void CreacionUsuarioOK()
        {
            string data = "<div class='error-page-area'><div class='error-content'> ";
            data += "<div class='error-image wow bounceInUp'><h1><i class='fa fa-thumbs-o-up'></i> Perfecto!</h1></div> ";
            data += "<div class='error-heading'><h2>Por favor verificá tu casilla de correo</h2><h3>Tenés que hacer click en el link del mail para dar de alta el usuario</h3> ";
            data += "</div><div class='error-back-home'><a href='Home.aspx' class='add-tag-btn'><i class='fa fa-chevron-left'></i> Inicio</a> ";
            data += "</div></div></div> ";

            LitMensaje.Text = data;
        }
        
        public void AltaUsuarioOK()
        {
            string data = "<div class='error-page-area'><div class='error-content'> ";
            data += "<div class='error-image wow bounceInUp'><h1><i class='fa fa-thumbs-o-up'></i> Felicitaciones!</h1></div> ";
            data += "<div class='error-heading'><h2>Tu usuario se activó correctamente</h2><h3>Ya podés disfrutar de tus compras</h3> ";
            data += "</div><div class='error-back-home'><a href='Home.aspx' class='add-tag-btn'><i class='fa fa-chevron-left'></i> Inicio</a> ";
            data += "</div></div></div> ";

            LitMensaje.Text = data;
        }
        public void AltaUsuarioError()
        {
            string data = "<div class='error-page-area'><div class='error-content'> ";
            data += "<div class='error-image wow bounceInUp'><h1><i class='fa fa-thumbs-o-down'></i> Error!</h1></div> ";
            data += "<div class='error-heading'><h2>No se pudo activar tu usuario</h2><h3>Comunicate con el centro de atención</h3> ";
            data += "</div><div class='error-back-home'><a href='Home.aspx' class='add-tag-btn'><i class='fa fa-chevron-left'></i> Inicio</a> ";
            data += "</div></div></div> ";

            LitMensaje.Text = data;
        }
        public int PagoOK(string PreferenceId)
        {
            int Pedido = 0;
            using (AntilopeWebDBEntities db = new AntilopeWebDBEntities())
            {
                var result = db.Pedidos.SingleOrDefault(b => b.preference_id == PreferenceId);
                if (result != null)
                {
                    result.IdEstado = 7;
                    db.SaveChanges();
                    Pedido = result.IdPedido;
                }
            }

            string data = "<div class='error-page-area'><div class='error-content'> ";
            data += "<div class='error-image wow bounceInUp'><h1><i class='fa fa-thumbs-o-up'></i> Perfecto!</h1></div> ";
            data += "<div class='error-heading'><h2>Su pedido se ha generado correctamente</h2><h3>Imprima el voucher y espere la entrega en el horario pactado.</h3> ";
            data += "</div><div class='error-back-home'><a href='Home.aspx' class='add-tag-btn'><i class='fa fa-chevron-left'></i> Inicio</a> ";
            data += "</div></div></div> ";

            LitMensaje.Text = data;
            return Pedido;
        }
        public void PagoOKEfectivo()
        {            
            string data = "<div class='error-page-area'><div class='error-content'> ";
            data += "<div class='error-image wow bounceInUp'><h1><i class='fa fa-thumbs-o-up'></i> Perfecto!</h1></div> ";
            data += "<div class='error-heading'><h2>Su pedido se ha generado correctamente</h2><h3>Imprima el voucher y espere la entrega en el horario pactado.</h3> ";
            data += "</div><div class='error-back-home'><a href='Home.aspx' class='add-tag-btn'><i class='fa fa-chevron-left'></i> Inicio</a> ";
            data += "</div></div></div> ";

            LitMensaje.Text = data;         
        }
        public void PagoPendiente()
        {
            string data = "<div class='error-page-area'><div class='error-content'> ";
            data += "<div class='error-image wow bounceInUp'><h1><i class='fa fa-clock-o'></i> Correcto!</h1></div> ";
            data += "<div class='error-heading'><h2>El pagó se está procesando</h2><h3>Se te enviará un mail con la confirmación del pedido.</h3> ";
            data += "</div><div class='error-back-home'><a href='Home.aspx' class='add-tag-btn'><i class='fa fa-chevron-left'></i> Inicio</a> ";
            data += "</div></div></div> ";

            LitMensaje.Text = data;
        }
        public void CanjeOk()
        {
            string data = "<div class='error-page-area'><div class='error-content'> ";
            data += "<div class='error-image wow bounceInUp'><h1><i class='fa fa-thumbs-o-up'></i> Perfecto!</h1></div> ";
            data += "<div class='error-heading'><h2>Su canje se ha generado correctamente</h2><h3>Imprima el voucher y espere a que nos comuniquemos para coordinar el envío de su Canje.</h3> ";
            data += "</div><div class='error-back-home'><a href='Home.aspx' class='add-tag-btn'><i class='fa fa-chevron-left'></i> Inicio</a> ";
            data += "</div></div></div> ";

            LitMensaje.Text = data;
        }
        public void CustomError(string mensaje)
        {
            string data = "<div class='error-page-area'><div class='error-content'> ";
            data += "<div class='error-image wow bounceInUp'><h1><i class='fa fa-thumbs-o-down'></i> Error!</h1></div> ";
            data += "<div class='error-heading'><h2>"+ mensaje + "</h2><h3>Comunicate con el centro de atención</h3> ";
            data += "</div><div class='error-back-home'><a href='Home.aspx' class='add-tag-btn'><i class='fa fa-chevron-left'></i> Inicio</a> ";
            data += "</div></div></div> ";

            LitMensaje.Text = data;
        }
        public void CustomOk(string mensaje1, string mensaje2)
        {
            string data = "<div class='error-page-area'><div class='error-content'> ";
            data += "<div class='error-image wow bounceInUp'><h1><i class='fa fa-thumbs-o-up'></i> Felicitaciones!</h1></div> ";
            data += "<div class='error-heading'><h2>" + mensaje1 + "</h2><h3>"+mensaje2+"</h3> ";
            data += "</div><div class='error-back-home'><a href='Home.aspx' class='add-tag-btn'><i class='fa fa-chevron-left'></i> Inicio</a> ";
            data += "</div></div></div> ";

            LitMensaje.Text = data;
        }
        public bool CheckUsuario(string  Token)
        {
            try
            {
                using (AntilopeWebDBEntities db = new AntilopeWebDBEntities())
                {
                    var result = db.Clientes.SingleOrDefault(b => b.Estado == "Pendiente" && b.Token == Token);
                    if (result != null)
                    {
                        result.Fecha_Alta = DateTime.Now;
                        result.Estado = "Activo";
                        db.SaveChanges();

                        Session.Add("Cliente", result.Id);
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
            }
            catch(Exception ex)
            {
                return false;                
            }
            
        }
        private bool EnviarMailPedidoOK(int IdPedido)
        {
            bool Send = false;            
            string Mail = "", MailSucursal="";
            var Sucursales = new FuncionesGrales().GetSucursales();

            using (AntilopeWebDBEntities db = new AntilopeWebDBEntities())
            {
                var item = db.Pedidos.First(i => i.IdPedido == IdPedido);                
                if (item != null)
                {
                    var objSuc = Sucursales.Where(x => x.Id == item.idSucursal).FirstOrDefault();
                    Mail = item.Clientes.Mail;
                    if (objSuc.Email != "")
                    {
                        MailSucursal = objSuc.Email;
                    }
                }
                else
                {
                    return false;
                }

            }

            EnvioMail envio = new EnvioMail();            
            string URL = ConfigurationManager.AppSettings["URL_PROD"] + "MisPedidos";
            string Body = "Felicitaciones tu compra se generó correctamente. El supermercado está preparando la entrega.<br/> Para realizar el seguimiento de la entrega ingresá misuperya.com y seguí estos pasos: <br/>";
            Body = Body + "1) Ingresá con tu usuario y clave. <br/> 2) Hacé click en tu usuario y luego en 'Mis pedidos' <br/> 3) Allí verás una lista de tus pedidos y sus estados. Podés imprimir el voucher para controlar la entrega.";
            

            if (envio.EnvioMailAltaUsuario("Pedido Exitoso",Body ,"Pedido generado en Antilope SA", Mail, MailSucursal, URL, true, "Ver mis pedidos"))
            {
                Send = true;
            }
            return Send;            
        }

        
    }
}