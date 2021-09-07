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
    public partial class ShopGrid : System.Web.UI.Page
    {
        private AntilopeWebDBEntities db = new AntilopeWebDBEntities();
        protected void Page_Load(object sender, EventArgs e)
        {
            ((Label)Master.FindControl("LblRuta")).Text = "Artículos";
            if (!this.IsPostBack)
            {
                
            }
        }
        
        public IQueryable<Articulos> GetProducts()
        {
            try
            {
                
                int Categ = (Request["Categ"] != null) ? Convert.ToInt32(Request["Categ"]) : 0;
                int SubCateg = (Request["SubCateg"] != null) ? Convert.ToInt32(Request["SubCateg"]) : 0;
                string NombreProd = (Request["Nombre"] != null) ? Request["Nombre"] : "";
                string Orden = (Request["Order"] != null) ? Request["Order"] : "";
                                
                IQueryable<Articulos> query = db.Articulos.Where(p => p.Habilitado == true && p.Precio_Venta>0 && p.Stock > 0);
                var LstSubCategorias = new FuncionesGrales().GetSubCategorias();

                if (Categ > 0)
                {                    
                    var LstSub = LstSubCategorias.Where(x => x.Id_Categoria == Categ).Select(z=> z.Id).ToList();
                    query = query.Where(p => LstSub.Contains(p.Id_SubCategoria.Value));                    
                }
                else if(SubCateg > 0)
                {
                    query = query.Where(p => p.Id_SubCategoria == SubCateg);
                }
                else if (NombreProd != "")
                {
                    query = query.Where(p => p.Descripcion.Contains(NombreProd));
                }

                if (Orden != "")
                {
                    switch (Orden)
                    {
                        case "MenorPrecio":
                            query = query.OrderBy(c => c.Precio_Venta);
                            break;
                        case "MayorPrecio":
                            query = query.OrderByDescending(c => c.Precio_Venta);
                            break;
                        case "NombreA":
                            query = query.OrderBy(c => c.Descripcion);
                            break;
                        case "NombreZ":
                            query = query.OrderByDescending(c => c.Descripcion);
                            break;
                        default:
                            // Do Something
                            break;
                    }
                }
                return query;                
            }
            catch(Exception ex)
            {                
                return null;                
            }
        }


        [WebMethod]
        public static int AddCarrito(Int64 Id)
        {
            try
            {
                Carrito carro = new Carrito();
                var LstArticulos = new FuncionesGrales().GetArticulos();
                var item = LstArticulos.Where(i => i.SKU == Id).FirstOrDefault();
                carro.AddCarrito(item.SKU, item.Descripcion, Convert.ToDecimal(item.Precio_Oferta), item.StrImagen, 1, false, false);
                return 1;
                
            }
            catch(Exception ex)
            {                
                return 0;
            }
        }
        [WebMethod]
        public static int DeleteItemCarrito(Int64 Id)
        {
            try
            {
                Carrito carro = new Carrito();
                carro.DeleteItem(Id);
                return 1;
            }
            catch(Exception ex)
            {                
                return 0;
            }
        }

        protected void DlMostrarProd_SelectedIndexChanged(object sender, EventArgs e)
        {

            DataPager1.PageSize = Convert.ToInt32(DlMostrarProd.SelectedValue);
            DataPager1.SetPageProperties(0, DataPager1.MaximumRows, true);
        }

        protected void DlOrdenar_SelectedIndexChanged(object sender, EventArgs e)
        {
            
            string Orden = DlOrdenar.SelectedValue;
            
            switch (Orden)
            {
                case "MenorPrecio":
                    productList.Sort("Precio_Venta", SortDirection.Ascending);
                    break;
                case "MayorPrecio":
                    productList.Sort("Precio_Venta", SortDirection.Descending);
                    break;
                case "NombreA":
                    productList.Sort("Descripcion", SortDirection.Ascending);
                    break;
                case "NombreZ":
                    productList.Sort("Descripcion", SortDirection.Descending);
                    break;                    
            }
            
        }
    }
}