using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using AntilopeWeb.Models;

namespace AntilopeWeb.AdminSuc
{
    /// <summary>
    /// Descripción breve de fileUploader1
    /// </summary>
    public class fileUploader1 : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            try
            {   
                string str_image = "";
                string DirSave = "";
                string CName = "";
                string Path = "", pathToSave_100="";

                foreach (string s in context.Request.Files)
                {
                    HttpPostedFile file = context.Request.Files[s];
                    string fileName = file.FileName;
                    string fileExtension = file.ContentType;
                    //str_image = fileName;                    
                    int IdSubCateg = Convert.ToInt32(context.Request.Form["idSubCategoria"]);
                    string Sku = context.Request.Form["SKU"].ToString();
                    if (IdSubCateg > 0)  // Para la fotos de los articulos
                    {
                        var objSubCateg = new FuncionesGrales().GetSubCategorias().First(i => i.Id == IdSubCateg); 
                        var objCateg = new FuncionesGrales().GetCategorias().First(i => i.Id == objSubCateg.Id_Categoria); 
                        
                        DirSave = objCateg.Nombre + "/" + objSubCateg.Nombre;

                        if (!string.IsNullOrEmpty(Sku) && !string.IsNullOrEmpty(fileName))
                        {
                            string FileSKU = fileName.Replace(fileName.Substring(0, fileName.Length - 4), Sku);
                            Path = HttpContext.Current.Server.MapPath("~/img/articulos/" + DirSave + "/");
                            pathToSave_100 = Path + FileSKU;
                            if (!Directory.Exists(Path))
                                System.IO.Directory.CreateDirectory(Path);
                            file.SaveAs(pathToSave_100);
                            str_image = DirSave + "/" + FileSKU;

                            using (var srcImage = Image.FromFile(pathToSave_100))
                            {
                                var newWidth = (int)(600);
                                var newHeight = (int)(600);
                                using (var newImage = new Bitmap(newWidth, newHeight))
                                using (var graphics = Graphics.FromImage(newImage))
                                {
                                    graphics.SmoothingMode = SmoothingMode.AntiAlias;
                                    graphics.InterpolationMode = InterpolationMode.HighQualityBicubic;
                                    graphics.PixelOffsetMode = PixelOffsetMode.HighQuality;
                                    graphics.DrawImage(srcImage, new Rectangle(0, 0, newWidth, newHeight));
                                    if (!Directory.Exists(Path.Replace("articulos", "articulos_big")))
                                        System.IO.Directory.CreateDirectory(Path.Replace("articulos", "articulos_big"));
                                    newImage.Save(pathToSave_100.Replace("articulos", "articulos_big"));
                                }
                            }
                        }
                    }
                    
                    //Imagen_Home
                    else if (context.Request.Form["idTipoImagen"] != null)
                    {                        
                        if (!string.IsNullOrEmpty(fileName))
                        {
                            Path = HttpContext.Current.Server.MapPath("~/img/home/");
                            str_image = "../../img/home/" + fileName;                            
                            pathToSave_100 = Path + fileName;
                            if (!Directory.Exists(Path))
                                System.IO.Directory.CreateDirectory(Path);

                            file.SaveAs(pathToSave_100);

                        }
                    }
                }
                context.Response.Write(str_image);
            }
            catch (Exception ex)
            {

                throw new Exception("Error al guardar el archivo", ex);
            }
        }

        

        private Bitmap ResizeBitmap(Bitmap b, int nWidth, int nHeight)
        {
            Bitmap result = new Bitmap(nWidth, nHeight);
            using (Graphics g = Graphics.FromImage((System.Drawing.Image)result))
                g.DrawImage(b, 0, 0, nWidth, nHeight);
            return result;
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}