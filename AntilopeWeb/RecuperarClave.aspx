<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGralNew.Master" enableEventValidation="false" AutoEventWireup="true" CodeBehind="RecuperarClave.aspx.cs" Inherits="AntilopeWeb.RecuperarClave" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CphJsSuperior" runat="server">
    <style type="text/css">
        .add-tag-btn {
        background-color: #383838;
        border-radius: 20px;
        color: #fff;
        display: inline-block;
        font-size: 12px;
        font-weight: 700;        
        text-transform: uppercase;
        line-height: 23px;
        padding: 8px 25px 7px;
        }
        .add-tag-btn:hover{
	        color:#fff;
        }
       
    </style>
    

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
			<%--<div class="checkout-main-area">--%>
				<h2>Registrarse en Mi SuperChino!</h2>
				<div class="checkout-area" style="margin-top:0px">
                    <div class="item-author col-xs-12 col-sm-12 col-md-6 col-lg-6">								
						<div class="item-a-info" style="min-height: 320px;">
							<h3><a href="#"><strong>Clientes Registrados</strong></a></h3>
                            <br />
							<p>Por favor ingresá tu usuario y contraseña </p>                                    
                            <form action="#">
								<div class="form-group">
									<label>Usuario o Email <sup>*</sup></label>													
                                    <asp:TextBox class="form-control" ID="TxbUsuario" runat="server"></asp:TextBox>
								</div>
								<div class="form-group">
									<label>Contraseña <sup>*</sup></label>
									<asp:TextBox class="form-control" type="password" ID="TxbClave" runat="server"></asp:TextBox>
								</div>
							</form>
							<div class="block-button-right">
								<a href="#">¿Te olvidaste la contraseña?</a>												
                                <asp:Button CssClass="add-tag-btn" ID="BtnIniciarSesion" runat="server" Text="Iniciar Sesión" OnClick="BtnIniciarSesion_Click" />
							</div>
						</div>
                        <asp:Literal ID="LiErrorLogin" runat="server"></asp:Literal>
					</div>
                    <div class="item-author col-xs-12 col-sm-12 col-md-6 col-lg-6">								
						<div class="item-a-info" style="min-height: 320px;">
							<h3><a href="#"><strong>Nuevos Clientes</strong></a></h3>
                            <br />
							<p>Si todavía no estás registrado, hacé click en Registrarse para ingresar tus datos y poder realizar compras. </p>									
                            <br /> 
                            <asp:Button CssClass="add-tag-btn" ID="BtnRegistrarse" runat="server" Text="Registrarse" PostBackUrl="~/Registrarse.aspx" />                                                      
						</div>
					</div>
                </div>
            <%--</div>--%>
        </div> 
        <br />   
    </div>
    <br />
    <div class="modal fade" id="ModalRecuperarClave" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <div class="row">
					<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                        <h5 class="modal-title" id="exampleModalLabel">Recuperar Clave!</h5>
                    </div>
                    <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
              </div>
              <div class="modal-body">
                Por favor ingresá tu usuario o Email y te enviaremos la clave a tu correo.
                <br /><br />
				    <div class="form-group">									
                        <label>Usuario/ Email <sup>*</sup></label>
                        <asp:TextBox class="form-control" ID="TxbUsuarioEmail" name="TxbUsuarioEmail" runat="server"></asp:TextBox>
				    </div>
              </div>
              <div class="modal-footer">                    
                  <asp:Button CssClass="btn btn-primary" ID="BtnRecuperarClave" runat="server" Text="Recuperar Clave" OnClick="BtnRecuperarClave_Click" />                    
              </div>
            </div>
          </div>
        </div>
        </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CphBrandClient" runat="server">
    
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="CphJsInferior" runat="server">
    <script type="text/javascript">
        
    </script>
</asp:Content>
