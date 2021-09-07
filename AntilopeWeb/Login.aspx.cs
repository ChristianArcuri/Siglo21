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
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Net;  //Para mail
using System.Net.Mail; //Para mail
using System.Collections;
using System.IO;
using System.Net.Mime;



namespace AntilopeWeb
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ((Label)Master.FindControl("LblRuta")).Text = "Login";
        }
        

        protected void BtnIniciarSesion_Click(object sender, EventArgs e)
        {

            using (AntilopeWebDBEntities db = new AntilopeWebDBEntities())
            {
                string Usuario = TxbUsuario.Text;
                string Clave = TxbClave.Text;
                var result = db.Clientes.SingleOrDefault(b => (b.Usuario==Usuario || b.Mail==Usuario ) && b.Clave == Clave);
                if (result != null)
                {                    
                    Session.Add("Cliente", result.Id);
                    var ListaCarro = new Carrito().GetCarrito();
                    if (ListaCarro.Count > 0)
                    {
                        Response.Redirect("Checkout");
                    }
                    else
                    {
                        Response.Redirect("Home");
                    }
                                 
                }
                else
                {
                    LiErrorLogin.Text = "<h2 style='color:red'>Usuario o clave incorrectos</h2>";
                }
            }
        }
        protected void BtnRecuperarClave_Click(object sender, EventArgs e)
        {
            try
            {
                if (TxbUsuarioEmail.Text != "")
                {
                    using (AntilopeWebDBEntities db = new AntilopeWebDBEntities())
                    {
                        string UsuarioMail = TxbUsuarioEmail.Text;
                        //var result = db.Clientes.First(b => (b.Usuario == UsuarioMail || b.Mail == UsuarioMail));
                        var result = db.Clientes.SingleOrDefault(b => (b.Usuario == UsuarioMail || b.Mail == UsuarioMail));
                        if (result != null)
                        {
                            try
                            {
                                //Envio de mails //
                                string Mail = result.Mail;
                                string ClaveRecuperada = result.Clave;
                                EnvioMail envio = new EnvioMail();
                                string URL = ConfigurationManager.AppSettings["URL_PROD"] + "MiCuenta";
                                string Body = "Hola! La clave que pediste recuperar para la cuenta de:<br/> " + Mail + " es la siguiente: <b>" + ClaveRecuperada + "</b><br/>";
                                Body = Body + "Estamos para ayudarte! Gracias por confiar en nosotros";


                                if (envio.EnvioMailAltaUsuario("Recupero de Clave", Body, "Recupero de Clave", Mail, "", URL, true, "Ir a Mi Cuenta"))
                                {

                                    Response.Redirect("Mensajes.aspx?Mns=CustomOK&Mns1=Tu clave fue enviada al mail " + Mail + "&Mns2=Por favor verificá tu correo", false);
                                }
                                else
                                {
                                    Response.Redirect("Mensajes.aspx?Mns=CustomError&Error=No se pudo enviar el mail. Intente nuevamente.", false);
                                }

                            }
                            catch (Exception ex)
                            {                                
                                Response.Redirect("Mensajes.aspx?Mns=CustomError&Error=Error al enviar el mail. Intente nuevamente.", false);
                            }
                        }
                        else
                        {
                            LiErrorLogin.Text = "<h2 style='color:red'>Usuario o Email incorrectos</h2>";
                        }
                    }
                }
                else
                {
                    LiErrorLogin.Text = "<h2 style='color:red'>Debe ingresar el Usuario o Email</h2>";
                }
            }
            catch (Exception ex)
            {
                LiErrorLogin.Text = "<h2 style='color:red'>Error al recuperar la clave.</h2>";
            }
        }

        
       
    }
}