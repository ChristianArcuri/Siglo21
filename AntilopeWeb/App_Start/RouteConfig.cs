using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Routing;
using Microsoft.AspNet.FriendlyUrls;

namespace AntilopeWeb
{
    public static class RouteConfig
    {
		
		public static void RegisterRoutes(RouteCollection routes)
        {
            routes.MapPageRoute(
                "suc-browse",
                "suc/{dominio}",
                "~/suc.aspx"    
            );

            var settings = new FriendlyUrlSettings();
            settings.AutoRedirectMode = RedirectMode.Off;
            routes.EnableFriendlyUrls(settings);
        }
    }
}
