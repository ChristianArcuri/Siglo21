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
    public partial class MiPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ((Label)Master.FindControl("LblRuta")).Text = "Mi Cuenta";
                if (Session["Cliente"] == null)
                {
                    Response.Redirect("Login.aspx", false);
                }
                
            }
        }
        
        
        public bool ValidarClaveActual(string ClaveActual, string ClaveNueva)
        {
            bool resp = false;
            if (ClaveActual == ClaveNueva)
            {
                resp = true;
            }
            return resp;
        }
                
        protected void BtnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("MiCuenta.aspx", false);
        }
        
        protected void BtnAceptar_Click(object sender, EventArgs e)
        {
            try
            {
                if (Page.IsValid)
                {
                    if (Session["Cliente"] != null)
                    {
                        int idCliente = Convert.ToInt32(Session["Cliente"].ToString());
                        string ClaveActual = TxbClaveActual.Text;
                        string ClaveNueva = TxbClaveNueva.Text;
                        using (AntilopeWebDBEntities db = new AntilopeWebDBEntities())
                        {
                            var client = db.Clientes.SingleOrDefault(b => b.Id == idCliente);
                            if (client != null)
                            {
                                if (ValidarClaveActual(client.Clave, ClaveActual))
                                {
                                    client.Clave = ClaveNueva;

                                    db.SaveChanges();
                                    Response.Redirect("Mensajes.aspx?Mns=CustomOK&Mns1=La clave se modificó correctamente.&Mns2=Podés seguir disfrutando de tus compras.", false);
                                }
                                else
                                {
                                    Response.Redirect("Mensajes.aspx?Mns=CustomError&Error=Los datos ingresados no son válidos. No se pudo cambiar la clave", false);
                                }
                            }
                            else
                            {
                                Response.Redirect("Mensajes.aspx?Mns=CustomError&Error=Error con el usuario. No se pudo cambiar la clave", false);
                            }
                        }


                    }
                    else
                    {
                        Response.Redirect("Mensajes.aspx?Mns=CustomError&Error=No se pudieron modificar los datos personales", false);
                    }
                }

            }
            catch (Exception ex)
            {                
                Response.Redirect("Mensajes.aspx?Mns=CustomError&Error=No se pudieron modificar los datos personales", false);
                string error = "No se pudo enviar el mail" + ex.ToString();
            }
        }
    }
}