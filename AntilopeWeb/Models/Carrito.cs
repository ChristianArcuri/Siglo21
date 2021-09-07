using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Web.Security;
using System.Web.UI;
using System.Data;

namespace AntilopeWeb.Models
{
    public class Carrito
    {
        public Int64 IdArticulo{get;set;}
        public string Nombre { get; set; }        
        public string Imagen { get; set; }        
        public decimal SubTotal { get; set; }
        public bool EsDescuento { get; set; }
        public bool EsDescPorc { get; set; }
        private int cantidad;
        public int Cantidad
        {
            get { return cantidad; }
            set
            {
                cantidad = value;                
                SubTotal = CalcularSubtotal(value);
            }
        }        
        private decimal precio;
        public decimal Precio
        {
            get { return precio; }
            set
            {
                precio = value;                
                SubTotal = CalcularSubtotal(value);
            }
        }
        
        private decimal CalcularSubtotal(decimal precio)
        {
            return this.precio * Cantidad;
        }
        public decimal CalcularTotal(List<Carrito> Lcarrito)
        {
            return Lcarrito.Sum(item => item.SubTotal);            
        }

        public List<Carrito> GetCarrito()
        {            
            List<Carrito> lista = new List<Carrito>();
            if (System.Web.HttpContext.Current.Session["SesCarrito"] == null)
            {
                return lista;
            }
            else
            {
                var list = System.Web.HttpContext.Current.Session["SesCarrito"] as List<Carrito>;
                
                
                return list;
            }
        }
        public void AddCarrito(Int64 Id, string nombre, decimal precio, string imagen, int cantidad, bool esDescuento, bool esDescPorc)
        {
            List<Carrito> list = new List<Carrito>();
            if (System.Web.HttpContext.Current.Session["SesCarrito"] != null)            
            {
                list = System.Web.HttpContext.Current.Session["SesCarrito"] as List<Carrito>;                
            }
            bool Existente = list.Any(x => x.IdArticulo == Id);
            if (Existente == true)
            {
                list.First(d => d.IdArticulo == Id).Cantidad += 1;
            }
            else
            {
                Carrito item = new Carrito();
                item.IdArticulo = Id;
                item.Nombre = nombre;
                item.Precio = precio;
                item.Imagen = imagen;
                item.Cantidad = cantidad;
                item.EsDescuento = esDescuento;
                item.EsDescPorc = esDescPorc;
                list.Add(item);
            }                        
            System.Web.HttpContext.Current.Session["SesCarrito"] = list;
            //return list;
        }
        public void DeleteItem(Int64 Id)
        {
            List<Carrito> lista = new List<Carrito>();
            if (System.Web.HttpContext.Current.Session["SesCarrito"] != null)
            {
                var list = System.Web.HttpContext.Current.Session["SesCarrito"] as List<Carrito>;
                var itemToRemove = list.Single(r => r.IdArticulo == Id);
                list.Remove(itemToRemove);
                System.Web.HttpContext.Current.Session["SesCarrito"] = list;
            }
        }
        public void VaciarCarrito()
        {
            List<Carrito> lista = new List<Carrito>();
            if (System.Web.HttpContext.Current.Session["SesCarrito"] != null)
            {                
                System.Web.HttpContext.Current.Session["SesCarrito"] = null;
            }
        }
        public void CambiarCantItemCarrito(Int64 Id, int Cant)
        {
            List<Carrito> list = new List<Carrito>();
            if (System.Web.HttpContext.Current.Session["SesCarrito"] != null)
            {
                list = System.Web.HttpContext.Current.Session["SesCarrito"] as List<Carrito>;
            }
            list.Where(d => d.IdArticulo == Id).First().Cantidad = Cant;
            System.Web.HttpContext.Current.Session["SesCarrito"] = list;
            //return list;
        }
        
    }
}