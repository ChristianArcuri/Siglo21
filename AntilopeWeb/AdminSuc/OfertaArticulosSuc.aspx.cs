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
    public class OfertaArticulo
    {
        public Int64 PLU { get; set; }
        public string Descripcion { get; set; }
        public string Medida { get; set; }
        public string Unidad { get; set; }
        public int Id_SubCategoria { get; set; }
        public string StrImagen { get; set; }
        public bool Temporal { get; set; }
        public string FechaInicio { get; set; }
        public string FechaFin { get; set; }

    }

    public partial class OfertaArticulosSuc : System.Web.UI.Page
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
                        int Sucursal = Convert.ToInt32(Session["Sucursal"]);
                        HdnIdSucursal.Value = Sucursal.ToString();
                        GetDatosSucursal(Sucursal);
                    }
                    catch (Exception ex)
                    {
                        Response.Redirect("Error.aspx");
                    }
                }
            }

        }


        [WebMethod]
        public static List<OfertaArticulo> IniModalEdit(string Id, int IdSucursal)
        {
            List<OfertaArticulo> lista = new List<OfertaArticulo>();
            try
            {
                if (Id != "0")
                {
                    Int64 IdSKU = Convert.ToInt64(Id);
                    using (AntilopeWebDBEntities db = new AntilopeWebDBEntities())
                    {
                        //Articulos Edit = db.Articulos.Single(m => m.SKU == IdPLU);                        
                        var ListaP = db.Articulos.SingleOrDefault(i => i.SKU == IdSKU);
                        if (ListaP != null)
                        {
                            string dbFechaIni = "", dbFechaFin = "";
                            bool dbTemporal = false;
                            if (ListaP.Oferta_Vigente.Value)
                            {                                
                                dbFechaIni = (ListaP.Oferta_FechaInicio != null) ? ListaP.Oferta_FechaInicio.Value.ToString("dd/MM/yyyy") : "";
                                dbFechaFin = (ListaP.Oferta_FechaFin != null) ? ListaP.Oferta_FechaFin.Value.ToString("dd/MM/yyyy") : "";

                            }

                            lista.Add(new OfertaArticulo
                            {
                                //SKU = ListaP.SKU,
                                Descripcion = ListaP.Descripcion,
                                Medida = ListaP.Medida,
                                Unidad = ListaP.Unidad,
                                Id_SubCategoria = ListaP.Id_SubCategoria.Value,
                                StrImagen = ListaP.StrImagen,
                                FechaInicio = dbFechaIni,
                                FechaFin = dbFechaFin,
                            });
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                int sss = 0;
            }
            return lista;
        }

        [WebMethod]
        public static int GrabarArticulo(Int64 PLU, Int64 IdSucursal, bool OfertaVigente, bool Temporal, string FecInicio, string FecFin)
        {
            try
            {
                if (PLU > 0)
                {
                    DateTime? FechaInicio = null;
                    DateTime? FechaFin = null;
                    if (FecInicio != "")
                        FechaInicio = Convert.ToDateTime(FecInicio);
                    if (FecFin != "")
                        FechaFin = Convert.ToDateTime(FecFin);

                    using (AntilopeWebDBEntities db = new AntilopeWebDBEntities())
                    {
                        var result = db.Articulos.SingleOrDefault(b => b.SKU == PLU);
                        if (result != null)
                        {
                            result.Oferta_Vigente = OfertaVigente;
                            result.Oferta_FechaInicio = FechaInicio;
                            result.Oferta_FechaFin = FechaFin;
                            db.SaveChanges();
                        }
                        else //Es un articulo nuevo para la sucursal
                        {
                            var suc = new Articulos
                            {
                                SKU = PLU,
                                Oferta_Vigente = OfertaVigente,                                
                                Oferta_FechaInicio = FechaInicio,
                                Oferta_FechaFin = FechaFin
                            };
                            db.Articulos.Add(suc);
                            db.SaveChanges();
                        }
                    }
                    return 1;
                }
                else
                {
                    return 0;
                }
            }
            catch (Exception ex)
            {                
                return 0;
            }

        }


        [WebMethod]
        public static string GetGrillaModal(string DescSKU)
        {
            string data = "";
            var LstSubCategorias = new FuncionesGrales().GetSubCategorias();
            try
            {
                using (AntilopeWebDBEntities db = new AntilopeWebDBEntities())
                {
                    List<Articulos> Lista = new List<Articulos>();
                    if (DescSKU != "")
                        Lista = (from u in db.Articulos where (u.Descripcion.Contains(DescSKU) && u.Habilitado == true) select u).ToList<Articulos>();

                    foreach (Articulos art in Lista)
                    {
                        var subcateg = LstSubCategorias.Where(x => x.Id == art.Id_SubCategoria).FirstOrDefault();
                        data += "<tr> ";
                        data += "<td> " + art.SKU + " </td> ";
                        data += "<td> " + art.Descripcion + " </td> ";
                        data += "<td> " + subcateg.Nombre + " </td> ";
                        data += "<td><button type='button' onclick='GetEditIdModal(" + art.SKU + ");return false' class='btn btn-info'><i class='fa fa-check'></i></button></td> ";
                        data += "</tr> ";
                    }
                }
            }
            catch (Exception ex)
            {
                
            }
            return data;

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
            TxbStrImagen.Text = "";
            TxbCodPLU.Text = "";
            TxbNombrePlu.Text = "";
            TxbCodPLU.Focus();

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
                    Response.Redirect(URL + "?PLU=" + CodSKU, true);
                }
                else
                {
                    string DescSKU = "sad";
                    Response.Redirect(URL + "?DESCPLU=" + DescSKU, true);
                }


            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
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

        protected void BtnCancelar_Click1(object sender, EventArgs e)
        {
            IniciarControles();
        }

    }
}