<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGralNew.Master" enableEventValidation="false" AutoEventWireup="true" CodeBehind="Nosotros.aspx.cs" Inherits="AntilopeWeb.Nosotros" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CphJsSuperior" runat="server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBeginAndEndHandler" runat="server">    
    <script type="text/javascript">
        function BeginRequestHandler() {                
            OpenLoading();            
        }
        Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
        function EndRequestHandler(sender, args) {
            if (args.get_error() == undefined) {                
                HideLoading();
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CphBody" runat="server">
    <div class="row">
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">						
            
            <div class="single-blog">							
				<h3 class="blog-title"><a href="#">QUIENES SOMOS </a></h3>							
				<div class="blog-description">
					<p>
                        Somos una empresa de Córdoba que se dedica a comercializar productos para el hogar (electrodomésticos, electrónica, etc.). Desde el año 2003 comenzamos con un comercio en el barrio San Vicente. Hoy contamos con seis sucursales, tres de ellas ubicadas en la provincia de Córdoba (Córdoba, Villa María y Río Cuarto), una en Santiago del Estero, una en Rosario y una en Mendoza.
					</p>
				</div>				
			</div>
            <div class="single-blog">							
				<h3 class="blog-title"><a href="#">NUESTRA PROPUESTA </a></h3>							
				<div class="blog-description">
					<p>
                        Nuestro sueño es llegar a los hogares de todos los argentinos, con la mejor atención y garantía de calidad en todos los productos. Por eso estamos activos en los canales digitales para que recibir todas tus consultas y realizar las entregas en el menor tiempo posible.
					</p>
				</div>				
			</div>            
        </div> 
        <br />   
    </div>
    <br />

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CphBrandClient" runat="server">
    
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="CphJsInferior" runat="server">
    <script type="text/javascript">
        
    </script>
</asp:Content>
