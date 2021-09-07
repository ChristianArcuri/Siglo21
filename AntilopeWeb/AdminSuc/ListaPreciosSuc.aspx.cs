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
    public partial class ListaPreciosSuc : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["Sucursal"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                try
                {
                    IniciarControles();
                    string Estado = Request.QueryString["Estado"];
                    int Sucursal = Convert.ToInt32(Session["Sucursal"]);
                    GetContadores(Sucursal);
                    GetDetalleGrilla(Estado, Sucursal);
                    GetDatosSucursal(Sucursal);
                }
                catch (Exception ex)
                {
                    Response.Redirect("Error.aspx");
                }
            }
            
            
        }
        public void GetDetalleGrilla(string Categoria, int idSucursal)
        {
            try
            {
                string data = "";
                var LstSubCategorias = new FuncionesGrales().GetSubCategorias();

                using (AntilopeWebDBEntities db = new AntilopeWebDBEntities())
                {

                    List<Articulos> Lista = new List<Articulos>();
                    switch (Categoria)
                    {                        
                        case "C": //Completos
                            {
                                Lista = (from u in db.Articulos where u.Habilitado == true select u).ToList<Articulos>();
                                break;
                            }                                            
                        default:
                            {
                                Lista = (from u in db.Articulos where  u.Habilitado==false select u).ToList<Articulos>();
                                break;
                            }

                    }

                    foreach (Articulos art in Lista)
                    {
                        var subCateg = LstSubCategorias.Where(x => x.Id == art.Id_SubCategoria).FirstOrDefault();

                        data += "<tr> ";
                        data += "<td> " + art.SKU + " </td> ";
                        data += "<td> " + art.Descripcion + " </td> ";
                        data += "<td> " + art.Medida + " </td> ";
                        data += "<td> " + art.Unidad + " </td> ";                        
                        data += "<td> " + subCateg.Nombre + " </td> ";
                        data += "<td> " + art.Precio_Venta + " </td> ";
                        data += "<td> " + art.Precio_Oferta + " </td> ";
                        data += "<td><button type='button' onclick='GetEditId(" + art.SKU + ");return false' class='btn btn-info'><i class='fa fa-search'></i></button></td> ";
                        data += "</tr> ";
                    }
                }
                LitGrillaDetPedido.Text = data;
            }
            catch(Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
        }

        public void GetContadores(int idSucursal)
        {
            int CantPreCarga = 0;
            int CantCompletos = 0;
            
            using (AntilopeWebDBEntities dbC = new AntilopeWebDBEntities())
            {
                CantPreCarga = (from u in dbC.Articulos where u.Habilitado == false select u).Count();
                CantCompletos = (from u in dbC.Articulos where u.Habilitado == true select u).Count();


            }
            LblCantPreCarga.Text = CantPreCarga.ToString();
            LblCantCompletos.Text = CantCompletos.ToString();
        }

        public void GetDatosSucursal(int idSucursal)
        {
            string data = "";
                            
                var Sucursales = new FuncionesGrales().GetSucursales();
                var item = Sucursales.Where(i => i.Id == idSucursal).FirstOrDefault();

                data += "<div class='info-box bg-aqua'> ";
                data += "<span class='info-box-icon'><i class='ion-home'></i></span> ";
                data += "<div class='info-box-content'> ";
                data += "<span class='info-box-text'>#" + item.Id + ". " + item.Nombre_Fantasia + "</span> ";
                data += "<span class='info-box-number'>" + item.Direccion + "</span> ";
                data += "</div></div> ";
            
            LitDatosSucursal.Text = data;
        }

        protected void BtnCancelar_Click(object sender, EventArgs e)
        {
            IniciarControles();
        }
        
        
        public void IniciarControles()
        {

            HdnIdArticulo.Value = "0";
            TxbDescripcion.Text = "";
            TxbUnidad.Text = "";
            TxbImagen.Text = "";            
            SetDlSubCategoria();
        }

        public void SetDlSubCategoria()
        {
            
                var LstSubCategorias = new FuncionesGrales().GetSubCategorias();
                var subcat = (from c in LstSubCategorias select new { c.Id, c.Nombre }).ToList();

                ListItem item1 = new ListItem("NINGUNO", "0");
                DlSubCategoria.DataValueField = "Id";
                DlSubCategoria.DataTextField = "Nombre";
                DlSubCategoria.DataSource = subcat;
                DlSubCategoria.DataBind();
                DlSubCategoria.Items.Insert(0, item1);
            
        }


    }
}