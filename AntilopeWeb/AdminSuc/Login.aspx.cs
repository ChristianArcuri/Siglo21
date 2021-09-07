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
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                string Logout = (Request["logout"] != null) ? Request["logout"] : "";
                if (Logout == "true")
                {
                    Session["Sucursal"] = null;
                }                
            }
        }

        protected void BtnIngresar_Click(object sender, EventArgs e)
        {
            var Sucursales = new FuncionesGrales().GetSucursales();
            string Usuario = TxbUsuario.Text;
            string Clave = TxbClave.Text;
            var objSuc = Sucursales.SingleOrDefault(b => b.Usuario == Usuario && b.Clave == Clave);
            if (objSuc != null)
            {
                Session.Add("Sucursal", objSuc.Id);
                Response.Redirect("DefaultSuc.aspx", false);
            }
            else
            {
                LblError.Text = "Usuario incorrecto.";
            }
        }
    }
}