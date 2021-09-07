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
    public partial class BusquedaArticulos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {            
            if (!IsPostBack)
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
                        Int64 SKU = (Request["SKU"] != null) ? Convert.ToInt64(Request["SKU"]) : 0;
                        string DescSKU = (Request["DESC"] != null) ? Request["DESC"] : "";
                        GetDetalleGrilla(SKU, DescSKU);
                        

                        
                    }
                    catch (Exception ex)
                    {
                        Response.Redirect("Error.aspx");
                    }
                }
            }
            
        }
        public void GetDetalleGrilla(Int64 CodPlu, string DescSKU)
        {
            try
            {
                string data = "";

                using (AntilopeWebDBEntities db = new AntilopeWebDBEntities())
                {
                    List<Articulos> Lista = new List<Articulos>();
                    if(CodPlu >0)
                        Lista = (from u in db.Articulos where u.SKU == CodPlu select u).ToList<Articulos>();
                    if(DescSKU != "")
                        Lista = (from u in db.Articulos where u.Descripcion.Contains(DescSKU) select u).ToList<Articulos>();

                    foreach (Articulos art in Lista)
                    {
                        var SubCategoria = new FuncionesGrales().GetSubCategById(art.Id_SubCategoria.Value);
                        
                        data += "<tr> ";
                        data += "<td> " + art.SKU + " </td> ";
                        data += "<td> " + art.Descripcion + " </td> ";
                        data += "<td> " + art.Medida + " </td> ";
                        data += "<td> " + art.Unidad + " </td> ";
                        data += "<td> " + SubCategoria.Nombre + " </td> ";                                                                      
                        data += "<td><button type='button' onclick='GetEditId(" + art.SKU + ");return false' class='btn btn-info'><i class='fa fa-search'></i></button></td> ";
                        data += "</tr> ";
                    }
                }
                LitGrillaDetPedido.Text = data;
                TxbCodPLU.Text = "";
                TxbNombrePLU.Text = "";                
            }
            catch(Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
        }

        [WebMethod]
        public static List<Articulos> IniModalEdit(string Id)
        {
            
            List<Articulos> lista = new List<Articulos>();
            try
            {
                if (Id != "0")
                {
                    Int64 IdSKU = Convert.ToInt64(Id);
                    using (AntilopeWebDBEntities db = new AntilopeWebDBEntities())
                    {
                        Articulos Edit = db.Articulos.Single(m => m.SKU == IdSKU);
                        lista.Add(new Articulos
                        {
                            SKU = Edit.SKU,
                            Descripcion = Edit.Descripcion,
                            Medida = Edit.Medida,
                            Unidad = Edit.Unidad,
                            Id_SubCategoria = Edit.Id_SubCategoria,
                            StrImagen = Edit.StrImagen,
                            Oferta = Edit.Oferta,
                            Precio_Venta = Edit.Precio_Venta,
                            Precio_Oferta = Edit.Precio_Oferta,
                            Stock = Edit.Stock,
                            Habilitado = Edit.Habilitado
                        });
                    }


                }
            }
            catch
            {
                int sss = 0;
            }
                return lista;
            
           
        }

        [WebMethod]
        public static int GrabarArticulo(Articulos art, int EsNuevo)
        {
            try
            {
                if (art != null)
                {
                    using (AntilopeWebDBEntities newCtx = new AntilopeWebDBEntities())
                    {
                        ////newCtx.Attach(art);
                        ////newCtx.Entry(art).State = System.Data.Entity.EntityState.Modified;
                        ////if (art.StrImagen == null) //Para que no modifique esta propiedad.
                        ////{
                        ////    newCtx.Entry(art).Property("StrImagen").IsModified = false;
                        ////    newCtx.Entry(art).Property("StrImagenBig").IsModified = false;
                        ////}
                        ////newCtx.SaveChanges();
                        ////return 1;
                        
                        if (EsNuevo == 0)
                        {
                            newCtx.Articulos.Attach(art);
                            newCtx.Entry(art).State = System.Data.Entity.EntityState.Modified;
                            if (art.StrImagen == null) //Para que no modifique esta propiedad.
                            {
                                newCtx.Entry(art).Property("StrImagen").IsModified = false;
                                newCtx.Entry(art).Property("StrImagenBig").IsModified = false;
                            }
                            newCtx.SaveChanges();
                            return 1;
                        }
                        else
                        {
                            newCtx.Articulos.Add(art);
                            newCtx.SaveChanges();
                            return 1;
                        }
                    }
                }
                else
                {
                    return 0;
                }
            }
            catch(Exception ex)
            {                
                return 0;
            }
            
        }
        
        [WebMethod]
        public static string GetCategoriasByDepto(string depto)
        {
            AntilopeWebDBEntities db1 = new AntilopeWebDBEntities();
            System.Text.StringBuilder stringBuilder = new System.Text.StringBuilder();
            if (!string.IsNullOrEmpty(depto))
            {
                int IdDepto = Convert.ToInt32(depto);
                var lista = new FuncionesGrales().GetCategorias();                

                stringBuilder.Append("<option value=\"0\">Seleccionar</option>");
                foreach (var item in lista)
                    stringBuilder.Append("<option value=\"" + item.Id + "\">" + item.Nombre + "</option>");
            }
            return stringBuilder.ToString();
        }

        [WebMethod]
        public static string GetSubCategoriasByCateg(string categ)
        {
            AntilopeWebDBEntities db1 = new AntilopeWebDBEntities();
            System.Text.StringBuilder stringBuilder = new System.Text.StringBuilder();
            if (!string.IsNullOrEmpty(categ))
            {
                int IdCateg = Convert.ToInt32(categ);
                var LstSubCategorias = new FuncionesGrales().GetSubCategorias();
                var lista = LstSubCategorias.Where(x => x.Id_Categoria == IdCateg).ToList();

                stringBuilder.Append("<option value=\"0\">Seleccionar</option>");
                foreach (var item in lista)
                    stringBuilder.Append("<option value=\"" + item.Id + "\">" + item.Nombre + "</option>");
            }
            return stringBuilder.ToString();
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
            TxbCodPLU.Text = "";
            SetDlSubCategoria();            
            TxbCodPLU.Focus();            

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

        protected void BtnBuscarPLU_Click(object sender, EventArgs e)
        {
            try
            {
                string data = "";
                Int64 CodSKU = 0;                

                string URL = Page.Request.Url.ToString();
                int index = URL.IndexOf("?");
                if (index > 0)
                    URL = URL.Substring(0, index);

                if (TxbCodPLU.Text != "")
                {
                    CodSKU = Convert.ToInt64(TxbCodPLU.Text);
                    Response.Redirect(URL + "?SKU=" + CodSKU, true);
                }
                else
                {
                    string DescSKU = TxbNombrePLU.Text;
                    Response.Redirect(URL + "?DESC=" + DescSKU, false);
                }

                
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
        }
        
    }
}