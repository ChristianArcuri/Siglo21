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
using System.Configuration;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Net;  //Para mail
using System.Net.Mail; //Para mail
using System.Collections;
using System.IO;
using System.Net.Mime;





namespace AntilopeWeb
{
    public partial class Politicas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            ((Label)Master.FindControl("LblRuta")).Text = "Términos y condiciones de uso";
            
        }
    }
}