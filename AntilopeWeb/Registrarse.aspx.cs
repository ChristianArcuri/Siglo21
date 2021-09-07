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
    public partial class Registrarse : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ((Label)Master.FindControl("LblRuta")).Text = "Registrarse";
        }
               

        protected void BtnAltaUsuario_Click(object sender, EventArgs e)
        {
            try
            {
                if (Page.IsValid)
                {
                    bool EsNuevo = false;
                    string token = new FuncionesGrales().RandomString(13);
                    using (AntilopeWebDBEntities db = new AntilopeWebDBEntities())
                    {
                        var result = db.Clientes.SingleOrDefault(b => (b.Usuario == TxbUsuarioAlta.Text || b.Mail == TxbMailAlta.Text));
                        if (result != null)
                        {
                            EsNuevo = false;
                            Response.Redirect("Mensajes.aspx?Mns=CustomError&Error=Usuario ya existente!. Si te olvidaste la clave, hacé click en 'Ingresa o registrate' y luego en ¿Te olvidaste la contraseña?. Así podés recuperarla.", false);
                        }
                        else
                        {
                            EsNuevo = true;
                            var cli = new Clientes
                            {
                                Usuario = TxbUsuarioAlta.Text,
                                Clave = TxbClaveAlta.Text,
                                DNI = Convert.ToInt32(TxbDniAlta.Text),
                                Nombre = TxbNombreAlta.Text,
                                Apellido = TxbApellidoAlta.Text,
                                Mail = TxbMailAlta.Text,
                                Telefono = TxbTelefonoAlta.Text,
                                Direccion = TxbDireccionAlta.Text,
                                Departamento = TxbDeptoAlta.Text,
                                Estado = "Pendiente",
                                Fecha_Solucitud = DateTime.Now,
                                Token = token,
                                Imagen = "hombre-de-negocios.png"
                            };
                            db.Clientes.Add(cli);
                            db.SaveChanges();
                        }

                    }
                    if (EsNuevo == true)
                    {
                        //Envio de mails //
                        EnvioMail envio = new EnvioMail();                        
                        string URL = ConfigurationManager.AppSettings["URL_PROD"] + "Mensajes.aspx?Mns=CheckUser&Token=" + token;
                        string Body = "Te agradecemos por registrarte en nuestro sitio - haciendo click en el siguiente boton vas a poder activar tu usuario.";

                        if (envio.EnvioMailAltaUsuario("Alta", Body, "Alta de usuario en Antilope SA", TxbMailAlta.Text, "", URL, true, "Activar Usuario"))
                        {
                            Response.Redirect("Mensajes.aspx?Mns=CreateUser", false);
                        }
                        else
                        {
                            Response.Redirect("Mensajes.aspx?Mns=CreateUserError", false);
                        }
                    }
                }

            }
            catch (Exception ex)
            {                
                string error = "No se pudo enviar el mail" + ex.ToString();
            }
        }

       
    }
}