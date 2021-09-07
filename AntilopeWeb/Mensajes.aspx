<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGralNew.Master" enableEventValidation="false" AutoEventWireup="true" CodeBehind="Mensajes.aspx.cs" Inherits="AntilopeWeb.Mensajes" %>
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
		<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12 col-sm-offset-1">
            <asp:Literal ID="LitMensaje" runat="server"></asp:Literal>
		</div>						
	</div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CphBrandClient" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="CphJsInferior" runat="server">
</asp:Content>
