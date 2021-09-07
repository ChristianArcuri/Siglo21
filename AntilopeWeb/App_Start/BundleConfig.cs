using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.UI;

namespace AntilopeWeb
{
    public class BundleConfig
    {
        // Para obtener más información sobre la unión, visite http://go.microsoft.com/fwlink/?LinkID=303951
        public static void RegisterBundles(BundleCollection bundles)
        {
            /*
            bundles.Add(new ScriptBundle("~/bundles/WebFormsJs").Include(
                            "~/Scripts/WebForms/WebForms.js",
                            "~/Scripts/WebForms/WebUIValidation.js",
                            "~/Scripts/WebForms/MenuStandards.js",
                            "~/Scripts/WebForms/Focus.js",
                            "~/Scripts/WebForms/GridView.js",
                            "~/Scripts/WebForms/DetailsView.js",
                            "~/Scripts/WebForms/TreeView.js",
                            "~/Scripts/WebForms/WebParts.js"));
*/
            // El orden es muy importante para el funcionamiento de estos archivos ya que tienen dependencias explícitas
            /*
            bundles.Add(new ScriptBundle("~/bundles/MsAjaxJs").Include(
                    "~/Scripts/WebForms/MsAjax/MicrosoftAjax.js",
                    "~/Scripts/WebForms/MsAjax/MicrosoftAjaxApplicationServices.js",
                    "~/Scripts/WebForms/MsAjax/MicrosoftAjaxTimer.js",
                    "~/Scripts/WebForms/MsAjax/MicrosoftAjaxWebForms.js"));
                    */
            // Use la versión de desarrollo de Modernizr para desarrollar y aprender. Luego, cuando esté listo
            // para la producción, use la herramienta de creación en http://modernizr.com para elegir solo las pruebas que necesite
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                            "~/Scripts/modernizr-*"));

            //bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
            //                "~/Scripts/modernizr-*"));

            bundles.Add(new StyleBundle("~/bundles/MasterAdmCss").Include(
                //"~/css/jquery.fancybox.css",
                "~/css/meanmenu.min.css",
                //"~/css/jquery-ui-slider.css",
                "~/css/nivo-slider.css",
                "~/css/owl.transitions.css",
                "~/css/owl.theme.css",
                "~/css/owl.carousel.css",
                "~/css/animate.css",
                "~/css/font.google.css",                 
                "~/css/font-awesome.min.css",
                "~/css/bootstrap.min.css",                
                "~/css/style.css",
                "~/css/responsive.css",
                "~/css/components/noty.css"));

            bundles.Add(new StyleBundle("~/bundles/MasterAdmSucCss").Include(
                "~/css/bootstrap.min.css",
                "~/css/font-awesome.min.css",
                "~/css/ionicons.min.css",
                "~/css/components/dataTables.bootstrap.min.css",
                "~/css/AdminLTE.min.css",
                "~/css/skins/_all-skins.min.css",
                "~/css/components/morris.css",
                "~/css/components/select2.min.css",
                "~/css/components/jquery-jvectormap.css",
                "~/css/components/bootstrap-datepicker.min.css",
                "~/css/components/daterangepicker.css",
                "~/css/bootstrap3-wysihtml5.min.css",
                "~/css/components/noty.css"));
            

            bundles.Add(new ScriptBundle("~/bundles/ScriptsFootAdmin").Include(
                "~/js/vendor/jquery-1.11.3.min.js",
                "~/js/jqueryui.js",
                "~/js/jquery.meanmenu.js",
                "~/js/jquery.fancybox.js",
                "~/js/jquery.elevatezoom.js",
                "~/js/bootstrap.min.js",
                "~/js/owl.carousel.min.js",
                "~/js/jquery.nivo.slider.pack.js",
                "~/js/jquery.counterup.min.js",
                "~/js/wow.js",                
                "~/js/main.js",
                "~/js/noty.js"));

            bundles.Add(new ScriptBundle("~/bundles/ScriptsFootAdminSuc").Include(
                "~/js/v337/bootstrap.min.js",
                "~/js/jquery.dataTables.min.js",
                "~/js/dataTables.bootstrap.min.js",
                "~/js/select2.full.min.js",
                "~/js/raphael.min.js",
                "~/js/Chart.js",
                "~/js/jquery.sparkline.min.js",
                "~/js/jquery-jvectormap-1.2.2.min.js",
                "~/js/jquery-jvectormap-world-mill-en.js",
                "~/js/jquery.knob.min.js",
                "~/js/moment.min.js",
                "~/js/daterangepicker.js",
                "~/js/bootstrap-datepicker.min.js",
                "~/js/bootstrap3-wysihtml5.all.min.js",
                "~/js/jquery.slimscroll.min.js",
                "~/js/fastclick.js",
                "~/js/adminlte.min.js",
                "~/js/dashboard.js",
                "~/js/demo.js",
                "~/js/noty.js"));


            ScriptManager.ScriptResourceMapping.AddDefinition("respond",
                new ScriptResourceDefinition
                {
                    Path = "~/Scripts/respond.min.js",
                    DebugPath = "~/Scripts/respond.js",
                });


        }
    }
}