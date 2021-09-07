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

namespace AntilopeWeb.WebControls
{
    public partial class UCCampanaPedidos : System.Web.UI.UserControl
    {
        private AntilopeWebDBEntities db = new AntilopeWebDBEntities();
        protected void Page_Load(object sender, EventArgs e)
        {
            //GetPedidosPendientes();
        }
        
    }
}