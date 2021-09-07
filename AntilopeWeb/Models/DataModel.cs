using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AntilopeWeb.Models
{
    public class DataModel
    {
    }

    #region ViewModels
    public class PedidoEstadoVM
    {
        public int Id { get; set; }
        public string Descripcion { get; set; }
        public string CssLabel { get; set; }
    }
    public class CategoriasVM
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        public string Imagen { get; set; }

    }
    public class SubCategoriasVM
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        public Nullable<int> Id_Categoria { get; set; }
    }
    public class ArticulosVM
    {
        public long SKU { get; set; }
        public string Descripcion { get; set; }
        public string Medida { get; set; }
        public string Unidad { get; set; }
        public Nullable<int> Id_SubCategoria { get; set; }
        public string StrImagen { get; set; }
        public Nullable<bool> Oferta { get; set; }
        public string StrImagenBig { get; set; }
        public string StrImagenSec1 { get; set; }
        public string StrImagenSec2 { get; set; }
        public string StrImagenSec3 { get; set; }
        public string StrImagenSec4 { get; set; }
        public string StrImagenSec5 { get; set; }
        public Nullable<int> Stock { get; set; }
        public Nullable<decimal> Precio_Venta { get; set; }
        public Nullable<decimal> Precio_Oferta { get; set; }
        public Nullable<bool> Habilitado { get; set; }
        public Nullable<bool> PreCarga { get; set; }
        public Nullable<System.DateTime> FechaUltModif { get; set; }
        public Nullable<System.DateTime> Oferta_FechaInicio { get; set; }
        public Nullable<System.DateTime> Oferta_FechaFin { get; set; }
        public Nullable<bool> Oferta_Vigente { get; set; }
        public Nullable<bool> Oferta_Temporal { get; set; }
    }
    public class SucursalesVM
    {
        public int Id { get; set; }
        public string Cuit { get; set; }
        public string Razon_Social { get; set; }
        public string Nombre_Fantasia { get; set; }
        public string Direccion { get; set; }
        public string Localidad { get; set; }
        public string Cod_Postal { get; set; }
        public string Responsable { get; set; }
        public string Telefono { get; set; }
        public string Email { get; set; }
        public string Usuario { get; set; }
        public string Clave { get; set; }
        public string StrImagen { get; set; }
        public string IdMercadoPago { get; set; }
        public string ClaveMercadoPago { get; set; }
        public string Direc_Gmap { get; set; }
    }
    public class MenuSuperiorVM
    {
        public string MenuSup { get; set; }
        public string MenuSupMobile { get; set; }        
    }



    #endregion
}