using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AntilopeWeb.Models;
using System.Web.Services;

namespace AntilopeWeb
{
    public partial class MasterNew : System.Web.UI.MasterPage
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                var MenuSup = new FuncionesGrales().GetMenuSuperior();
                LitMenuSuperior.Text = MenuSup.MenuSup;
                LitMenuSupMobile.Text = MenuSup.MenuSupMobile;
            }
        }
        

    }
}