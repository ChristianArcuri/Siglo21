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
    public partial class RecuperarClave : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ((Label)Master.FindControl("LblRuta")).Text = "Recuperar Clave";
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
                    if (Session["SucursalCliente"] == null)
                    {
                        Response.Redirect("Home.aspx");
                    }
                    else
                    {
                        Response.Redirect("Default.aspx", false);
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
            using (AntilopeWebDBEntities db = new AntilopeWebDBEntities())
            {
                string UsuarioMail = TxbUsuarioEmail.Text;                
                var result = db.Clientes.SingleOrDefault(b => (b.Usuario == UsuarioMail || b.Mail == UsuarioMail));
                if (result != null)
                {
                    Session.Add("Cliente", result.Id);
                    if (Session["SucursalCliente"] == null)
                    {
                        Response.Redirect("Home.aspx");
                    }
                    else
                    {
                        Response.Redirect("Default.aspx", false);
                    }
                }
                else
                {
                    LiErrorLogin.Text = "<h2 style='color:red'>Usuario o Email incorrectos</h2>";
                }
            }
        }
    }
}