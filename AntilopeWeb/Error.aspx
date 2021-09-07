<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGralNew.Master" enableEventValidation="false" AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="AntilopeWeb.Error" %>
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
				<h3 class="blog-title"><a href="#">ERROR </a></h3>							
				<div class="blog-description">
					<p>
                        Se generó un error. Vuelva a intentar nuevamente.
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
