using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.IO;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.WebControls;
using AntilopeWeb.Models;
using System.Web.Services;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D;
using Google.Maps;
using Google.Maps.Direction;
using Google.Maps.DistanceMatrix;
using Google.Maps.Geocoding;
using Newtonsoft.Json;

namespace AntilopeWeb.Models
{
    public class FuncionesGrales
    {
        private static Random random = new Random((int)DateTime.Now.Ticks);//thanks to McAden
        public string RandomString(int size)
        {
            StringBuilder builder = new StringBuilder();
            char ch;
            for (int i = 0; i < size; i++)
            {
                ch = Convert.ToChar(Convert.ToInt32(Math.Floor(26 * random.NextDouble() + 65)));
                builder.Append(ch);
            }

            return builder.ToString();
        }
        public string RemoveSpecialCharacters(string str)
        {
            //return Regex.Replace(str, "[^a-zA-Z0-9_.- ]+", "", RegexOptions.Compiled);
            return Regex.Replace(str, @"[^\w\.@-]", "", RegexOptions.None);
        }
        
        public System.Drawing.Image RezizeImage(System.Drawing.Image img, int maxWidth, int maxHeight)
        {
            if (img.Height < maxHeight && img.Width < maxWidth) return img;
            using (img)
            {
                Double xRatio = (double)img.Width / maxWidth;
                Double yRatio = (double)img.Height / maxHeight;
                Double ratio = Math.Max(xRatio, yRatio);
                int nnx = (int)Math.Floor(img.Width / ratio);
                int nny = (int)Math.Floor(img.Height / ratio);
                Bitmap cpy = new Bitmap(nnx, nny, PixelFormat.Format32bppArgb);
                using (Graphics gr = Graphics.FromImage(cpy))
                {
                    gr.Clear(Color.Transparent);

                    // This is said to give best quality when resizing images
                    gr.InterpolationMode = InterpolationMode.HighQualityBicubic;

                    gr.DrawImage(img,
                        new Rectangle(0, 0, nnx, nny),
                        new Rectangle(0, 0, img.Width, img.Height),
                        GraphicsUnit.Pixel);
                }
                return cpy;
            }

        }

        private MemoryStream BytearrayToStream(byte[] arr)
        {
            return new MemoryStream(arr, 0, arr.Length);
        }
        
        public List<CategoriasVM> GetCategorias()
        {
            string PathJson = HttpContext.Current.Server.MapPath("~/JsonData/Categorias.json");
            var jsonData = File.ReadAllText(PathJson);
            List<CategoriasVM> LstCategorias = JsonConvert.DeserializeObject<List<CategoriasVM>>(jsonData);
            return LstCategorias;
        }
        public List<SubCategoriasVM> GetSubCategorias()
        {
            string PathJson = HttpContext.Current.Server.MapPath("~/JsonData/Subcategorias.json");
            var jsonData = File.ReadAllText(PathJson);
            List<SubCategoriasVM> LstSubCategorias = JsonConvert.DeserializeObject<List<SubCategoriasVM>>(jsonData);
            return LstSubCategorias;
        }
        public SubCategoriasVM GetSubCategById(int IdSubCategoria)
        {
            var SubCat = new FuncionesGrales().GetSubCategorias();
            var objSubCateg = SubCat.Where(x => x.Id == IdSubCategoria).FirstOrDefault();
            return objSubCateg;
        }
        public List<PedidoEstadoVM> GetPedidosEstados()
        {
            string PathJson = HttpContext.Current.Server.MapPath("~/JsonData/Pedidos_Estados.json");
            var jsonData = File.ReadAllText(PathJson);
            List<PedidoEstadoVM> LstPedEstados = JsonConvert.DeserializeObject<List<PedidoEstadoVM>>(jsonData);
            return LstPedEstados;
        }
        public PedidoEstadoVM GetEstadoById(int IdEstado)
        {
            var Estados = new FuncionesGrales().GetPedidosEstados();
            var PedEstado = Estados.Where(x => x.Id == IdEstado).FirstOrDefault();
            return PedEstado;
        }

        public List<SucursalesVM> GetSucursales()
        {
            string PathJson = HttpContext.Current.Server.MapPath("~/JsonData/Sucursales.json");
            var jsonData = File.ReadAllText(PathJson);
            List<SucursalesVM> LstSucursales = JsonConvert.DeserializeObject<List<SucursalesVM>>(jsonData);
            return LstSucursales;
        }
        
        public List<Articulos> GetArticulos()
        {
            using (AntilopeWebDBEntities db = new AntilopeWebDBEntities())
            {
                var result = db.Articulos.Where(x=> x.Habilitado==true && x.Stock>0).ToList();
                return result;
            }
        }
        public MenuSuperiorVM GetMenuSuperior()
        {
            string data = "", dataMob = "";
            MenuSuperiorVM menuSupVM = new MenuSuperiorVM();

            data += "<ul> ";
            dataMob += "<ul> ";
            var Categorias = new FuncionesGrales().GetCategorias();
            var LstSubCategorias = new FuncionesGrales().GetSubCategorias();

            foreach (var itemCateg in Categorias)
            {                
                data += "<li><a href='ShopGrid?Categ=" + itemCateg.Id + "'>" + itemCateg.Nombre + "</a><i class='fa fa-angle-down'></i>";
                dataMob += "<li><a href='ShopGrid?Categ=" + itemCateg.Id + "'>" + itemCateg.Nombre + "</a><ul>";


                var LstSubCategByCategoria = LstSubCategorias.Where(x => x.Id_Categoria == itemCateg.Id).ToList();

                data += (LstSubCategByCategoria.Count > 3) ? " <div class='mega-menu mega-menu-1'> " : " <div class='mega-menu mega-menu-4'> ";
                data += "<div class='single-mega-menu'> ";
                foreach (var itemSubCategorias in LstSubCategByCategoria)
                {
                    
                    data += " <div class='single-mega-menu-item'><a href='ShopGrid?SubCateg=" + itemSubCategorias.Id + "' class='single-megamenu-title'>" + itemSubCategorias.Nombre + "</a> ";
                    dataMob += "<li><a href='ShopGrid?SubCateg=" + itemSubCategorias.Id + "'>" + itemSubCategorias.Nombre + "</a></li>";
                    data += " </div> ";
                }
                data += " </div> ";
                data += "<div class='single-mega-menu'><div class='mega-img single-mega-menu-item'> ";
                data += "<a href='ShopGrid?Categ=" + itemCateg.Id + "'><img src='" + itemCateg.Imagen + "' alt=" + itemCateg.Nombre + " /></a></div></div> ";
                data += " </div></li> ";

                dataMob += "</ul></li>";
            }
            data += "</ul> ";
            dataMob += "</ul> ";

            menuSupVM.MenuSup = data;
            menuSupVM.MenuSupMobile = dataMob;
            return menuSupVM;
        }
    }
}