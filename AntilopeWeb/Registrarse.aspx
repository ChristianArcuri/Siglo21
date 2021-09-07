<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGralNew.Master" AutoEventWireup="true" enableEventValidation="false" CodeBehind="Registrarse.aspx.cs" Inherits="AntilopeWeb.Registrarse" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CphJsSuperior" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/places.js@1.4.14"></script>         
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
                    DirGoogle();
                    HideLoading();
                }
            }
        </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CphBody" runat="server">
    <div class="row">
		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<div class="checkout-main-area">
				<h2>Registrarse en Antilope SA!</h2>
				<div class="checkout-area">
										
						<!-- START SINGLE PANEL -->
						<div class="greentech-panel panel panel-default col-xs-12 col-lg-12">
							<div class="panel-heading greentech-heading" id="headingTwo">
								<h4 class="panel-title greentech-title">
									<a class="collapsed accordion-toggle" >
										Nuevos Clientes
									</a>
								</h4>
							</div>
							<div id="collapseTwo" class="panel-collapse collapse in">
								<div class="panel-body greentech-panel-body">
									<div class="billing-info">                                                                        
										<div class="form-group col-sm-6">											
                                            <label>Nombre <sup>*</sup> <asp:RequiredFieldValidator ID="RqvNombre" runat="server" ErrorMessage="Campo Requerido" ControlToValidate="TxbNombreAlta" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator></label>									
                                            <asp:TextBox class="form-control" ID="TxbNombreAlta" name="TxbNombreAlta" runat="server"></asp:TextBox>                                            
										</div>
										<div class="form-group col-sm-6">
											<label>Apellido <asp:RequiredFieldValidator ID="RqvApellid" runat="server" ErrorMessage="Campo Requerido" ControlToValidate="TxbApellidoAlta" ForeColor="Red" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator></label>
											<asp:TextBox class="form-control" ID="TxbApellidoAlta" runat="server"></asp:TextBox>
										</div>
										
										<div class="form-group col-sm-6">
											<label>DNI <sup>*</sup><asp:RequiredFieldValidator ID="RqvDni" runat="server" ErrorMessage="Campo Requerido" ControlToValidate="TxbDniAlta" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator></label>
											<asp:TextBox class="form-control" ID="TxbDniAlta" runat="server" ></asp:TextBox>                                            
										</div>
										<div class="form-group col-sm-6">
											<label>Teléfono <sup>*</sup><asp:RequiredFieldValidator ID="RqvTel" runat="server" ErrorMessage="Campo Requerido" ControlToValidate="TxbTelefonoAlta" ForeColor="Red" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator></label>
											<asp:TextBox class="form-control" ID="TxbTelefonoAlta" runat="server" ></asp:TextBox>                                            
										</div>
										<div class="form-group col-sm-9">
											<label>Dirección de Entrega <sup>*</sup><asp:RequiredFieldValidator ID="RqvDireccion" runat="server" ErrorMessage="Campo Requerido" ControlToValidate="TxbDireccionAlta" ForeColor="Red" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator></label>
											<asp:TextBox class="form-control" ID="TxbDireccionAlta" runat="server" ></asp:TextBox>                                            
										</div>
                                        <div class="form-group col-sm-3">
											<label>Departamento </label>
											<asp:TextBox class="form-control" ID="TxbDeptoAlta" runat="server"></asp:TextBox>
										</div>
										<div class="form-group col-sm-12">
											<label>Mail <sup>*</sup> 
                                                <asp:RegularExpressionValidator ID="RvxMail" runat="server" ErrorMessage="RegularExpressionValidator" ControlToValidate="TxbMailAlta" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" SetFocusOnError="True" Display="Dynamic"></asp:RegularExpressionValidator>
                                                <asp:RequiredFieldValidator ID="RqvMail" runat="server" ErrorMessage="Campo Requerido" ControlToValidate="TxbMailAlta" ForeColor="Red" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
											</label>
											<asp:TextBox type="email" class="form-control" ID="TxbMailAlta" runat="server" data-error="El mail es inválido" ></asp:TextBox>                                                                                        
                                            <div class="help-block with-errors"></div>
										</div>
										<div class="form-group col-sm-6">
											<label>Usuario <sup>*</sup>
                                                <asp:RegularExpressionValidator Display="Dynamic" ControlToValidate="TxbUsuarioAlta" ID="RexUsuario" ValidationExpression="^[\s\S]{5,}$" ForeColor="Red"  runat="server" ErrorMessage="Debe tener más de 5 dígitos" SetFocusOnError="True"></asp:RegularExpressionValidator>
                                                <asp:RequiredFieldValidator ID="RqvUsuario" runat="server" ErrorMessage="Campo Requerido" ControlToValidate="TxbUsuarioAlta" ForeColor="Red" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
											</label>
											<asp:TextBox class="form-control" ID="TxbUsuarioAlta" runat="server" ></asp:TextBox>                                                                                        
										</div>
										<div class="form-group col-sm-6">
											<label>Clave <sup>*</sup>
                                                <asp:RegularExpressionValidator Display="Dynamic" ControlToValidate="TxbClaveAlta" ID="RexClave" ValidationExpression="^[\s\S]{5,}$" ForeColor="Red"  runat="server" ErrorMessage="Debe tener más de 5 dígitos" SetFocusOnError="True"></asp:RegularExpressionValidator>
                                                <asp:RequiredFieldValidator ID="RqvClave" runat="server" ErrorMessage="Campo Requerido" ControlToValidate="TxbClaveAlta" ForeColor="Red" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
											</label>
											<asp:TextBox class="form-control" type="password" ID="TxbClaveAlta" runat="server" ></asp:TextBox>                                                                                                                                    
										</div>
                                        <div class="form-group col-sm-8">
											<p><small>Al registrarte estás aceptando las <a target="_blank" style="color:#00a9e0" href="Politicas">Condiciones de uso y Políticas</a> de Antilope SA.</small></p>
                                            
										</div>	
                                        
                                    							
                                    </div>
									<div class="block-button-right">											
                                        <asp:Button CssClass="add-tag-btn" ID="BtnAltaUsuario" runat="server" Text="Continuar" OnClick="BtnAltaUsuario_Click"  />
									</div>	                                     
									
								</div>
							</div>
						</div>
                    <!--/ END SINGLE PANEL -->
						
					
				</div>
			</div>
		</div>
        
        
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CphBrandClient" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="CphJsInferior" runat="server">
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?key=AIzaSyCHCQomohspEbZpQ_vzraZMDn4heHmCook"></script>
    

    <script type="text/javascript">
        function DirGoogle() {
            var placesAutocomplete = places({ container: document.querySelector('#CphBody_TxbDireccionAlta'), countries: ['ar'] });    
        }
        $(document).ready(function () {
            DirGoogle();
        });
    </script>
    

</asp:Content>
