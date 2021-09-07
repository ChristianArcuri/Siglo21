<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGralNew.Master" enableEventValidation="false" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="AntilopeWeb.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CphJsSuperior" runat="server">
    <style type="text/css">
        .add-tag-btn {
            background-color: #383838;        
            color: #fff;
            display: inline-block;
            font-size: 12px;
            font-weight: 700;        
            text-transform: uppercase;
            line-height: 23px;
            padding: 8px 25px 7px;
            border-radius: 10px;
            width: 70%;
        }
        input.add-tag-btn {
            border-radius: 10px;
            width: 70%;
        }
        .add-tag-btn:hover{
	        color:#fff;
        }
        .form-top {
            border: 3px solid #454545;    
        }
        .contact-form {
            text-align:center;
        }
        a.add-tag-btn {
            border-radius: 10px;        
            width: 70%;
        }
       #panelLogin{
           background-color: #454545e0;
       }
       #SubpanelLogin{
           background-color: white;             
           box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
       }
       #SubpanelImage{
           color: white;             
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
        <div class="contact-us-form">								
			<div class="contact-form">
				<form action="#">
					<div id="panelLogin" class="form-top col-sm-10 col-md-10 col-lg-10">
                        <div id="SubpanelLogin" class="contact-form col-sm-12 col-md-6 col-lg-6">
                            <div class="form-group col-sm-12 col-md-12 col-lg-12">
							    <h2 style="padding-top: 10px;">Ingresá a Antilope SA</h2>
						    </div>                                            
                            
                            <img src="img/LineaSeparadora.png" />
						    <div class="form-group col-sm-12 col-md-12 col-lg-12">
							    <label>Ingresá con tu E-mail</label>												
						    </div>
						    <div class="form-group col-sm-12 col-md-12 col-lg-12">																			
                                <asp:TextBox placeholder="E-Mail" class="form-control" ID="TxbUsuario" runat="server"></asp:TextBox>
						    </div>
                            <div class="form-group col-sm-12 col-md-12 col-lg-12">								
                                <asp:TextBox class="form-control" type="password" placeholder="Contraseña" ID="TxbClave" runat="server"></asp:TextBox>
						    </div>
						    <div class="form-group col-sm-12 col-md-12 col-lg-12">
							    <label>¿Te olvidaste la contraseña?</label><a onclick="$('#ModalRecuperarClave').modal('show');" style="cursor:pointer;color: #00a9e0;"> Recuperala</a>
						    </div>
                            <div class="form-group col-sm-12 col-md-12 col-lg-12">																			
                                <asp:Button CssClass="add-tag-btn" ID="BtnIniciarSesion" runat="server" Text="Ingresar" OnClick="BtnIniciarSesion_Click" />
						    </div>
                            <div class="form-group col-sm-12 col-md-12 col-lg-12">
							    <label>¿Aún no tenés cuenta? </label><a onclick="window.location.href='Registrarse' " style="cursor:pointer;color: #00a9e0;"> Registrate</a>
						    </div>											
                            <div class="form-group col-sm-12 col-md-12 col-lg-12">
                                <asp:Literal ID="LiErrorLogin" runat="server"></asp:Literal>
                            </div>
                        </div>
                        <div id="SubpanelImage" class="contact-form col-sm-12 col-md-6 col-lg-6">
                            <div class="single-img-add single-sidebar">
                                    <img src="img/Desc4.png" />
                                <br /><br />
                                <div class="form-group col-sm-12 col-md-12 col-lg-12">
							        <h2 style="color:white;border-bottom: none;">Los articulos para tu hogar en una sola web.</h2>
                                    <p>Registrate y recibí descuentos y promociones de cientos de productos</p>
                                    
						        </div>		
                                <img src="img/Desc6.png" />

							</div>
                        </div>
					</div>		                    
				</form>
			</div>
            
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
                  <asp:Button CssClass="btn btn-primary" ID="BtnRecuperarClave" UseSubmitBehavior="false" data-dismiss="modal" runat="server" Text="Recuperar Clave" OnClick="BtnRecuperarClave_Click" />                    
              </div>
            </div>
          </div>
        </div>
        </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CphBrandClient" runat="server">
    
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="CphJsInferior" runat="server">
    
</asp:Content>
