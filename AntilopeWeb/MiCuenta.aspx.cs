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
    public partial class MiCuenta : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ((Label)Master.FindControl("LblRuta")).Text = "Mi Cuenta";
                if (Session["Cliente"] != null)
                {
                    int idCliente = Convert.ToInt32(Session["Cliente"].ToString());                    
                    GetDatosCliente(idCliente);
                    //HabilitaTextbox(false);
                }
                else
                {
                    Response.Redirect("Login.aspx", false);
                }
            }
        }
        public void GetDatosCliente(int idCliente)
        {
            try
            {
                using (AntilopeWebDBEntities db = new AntilopeWebDBEntities())
                {
                    var Cliente = db.Clientes.First(i => i.Id == idCliente);
                    TxbNombre.Text = Cliente.Nombre;
                    TxbApellido.Text = Cliente.Apellido; 
                    TxbDni.Text = Cliente.DNI.ToString();
                    TxbTelefono.Text = Cliente.Telefono;
                    TxbDireccion.Text = Cliente.Direccion;
                    TxbDepto.Text = Cliente.Departamento;
                    TxbMail.Text = Cliente.Mail;
                    TxbUsuario.Text = Cliente.Usuario;
                    TxbImagen.Text = Cliente.Imagen;
                }
                //LitGrillaPedidos.Text = data;
            }
            catch(Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
        }
        public void HabilitaTextbox(bool habilita)
        {
            
            TxbUsuario.Enabled = habilita;            
            TxbDni.Enabled = habilita;
            //TxbNombre.Enabled = habilita;
            //TxbApellido.Enabled = habilita;
            TxbMail.Enabled = habilita;
            TxbDireccion.Enabled = habilita;
            TxbDepto.Enabled = habilita;
            TxbTelefono.Enabled = habilita;


        }
        protected void BtnAltaUsuario_Click(object sender, EventArgs e)
        {
            try
            {
                if (Page.IsValid)
                {
                    if (Session["Cliente"] != null)
                    {
                        int idCliente = Convert.ToInt32(Session["Cliente"].ToString());
                        using (AntilopeWebDBEntities db = new AntilopeWebDBEntities())
                        {
                            var client = db.Clientes.SingleOrDefault(b => b.Id == idCliente);
                            if (client != null)
                            {
                                client.Usuario = TxbUsuario.Text;
                                client.DNI = Convert.ToInt32(TxbDni.Text);
                                client.Mail = TxbMail.Text;
                                client.Direccion = TxbDireccion.Text;
                                client.Departamento = TxbDepto.Text;
                                client.Telefono = TxbTelefono.Text;
                                client.Imagen = TxbImagen.Text;
                                db.SaveChanges();
                            }
                        }
                        Response.Redirect("Mensajes.aspx?Mns=CustomOK&Mns1=Los datos personales se actualizaron correctamente.&Mns2=Podés seguir disfrutando de tus compras.", false);
                        
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

        protected void BtnEditar_Click(object sender, EventArgs e)
        {
            HabilitaTextbox(true);
        }

        protected void BtnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("MiCuenta.aspx", false);
        }

        protected void BtnGuardarClave_Click(object sender, EventArgs e)
        {

        }
    }
}