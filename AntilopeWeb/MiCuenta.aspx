<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGralNew.Master" AutoEventWireup="true" CodeBehind="MiCuenta.aspx.cs" Inherits="AntilopeWeb.MiCuenta" %>

<%@ Register Src="~/WebControls/UCOpcionesCliente.ascx" TagPrefix="uc1" TagName="UCOpcionesCliente" %>


<asp:Content ID="Content1" ContentPlaceHolderID="CphJsSuperior" runat="server">
      <link href="../css/ionicons.min.css" rel="stylesheet" />
    <link href="../css/AdminLTE.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
    <script src="https://cdn.jsdelivr.net/npm/places.js@1.4.14"></script>      

    <script type="text/javascript">
        function ImprimirRecibo(idPedido) {                
                window.open('ImprimirRecibo.aspx?Ped=' + idPedido +'','_blank');
        }
        function ShowModalClave() {
            $("#CambioClaveModal").modal('show')
        }
    </script>
    <style type="text/css">
        .blog-flickr ul li {
            float: left;
            width: 20%;
        }
        .blog-flickr {
            margin-left: 50px;
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
                    DirGoogle();
                    HideLoading();
                }
            }
        </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CphBody" runat="server">    
    <div class="row">
        <div class="col-md-4">
          <uc1:UCOpcionesCliente runat="server" id="UCOpcionesCliente" />
        </div>
        <div class="col-md-8">
            <div class="box box-info">
            <div class="box-header with-border">
              <h3 class="box-title">Datos Personales</h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <div class="form-horizontal">
                <div class="box-body">
                    <div class="form-group">
                        <label for="TxbNombreAlta" class="col-sm-2 control-label">Nombre</label>
                        <div class="col-sm-10">                        
                            <asp:TextBox class="form-control" ID="TxbNombre" runat="server" Enabled="False" ></asp:TextBox>
                        </div>                    
                    </div>
                    <div class="form-group">
                        <label for="TxbApellido" class="col-sm-2 control-label">Apellido</label>
                        <div class="col-sm-10">                        
                            <asp:TextBox class="form-control" ID="TxbApellido" Enabled="False" runat="server" ></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="TxbDni" class="col-sm-2 control-label">DNI</label>
                        <div class="col-sm-10">                            
                            <asp:TextBox class="form-control" ID="TxbDni" Enabled="False" runat="server" ></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RqvDni" runat="server" ErrorMessage="Campo Requerido" ControlToValidate="TxbDni" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="TxbTelefono" class="col-sm-2 control-label">Teléfono</label>
                        <div class="col-sm-10">                            
                            <asp:TextBox class="form-control" ID="TxbTelefono" Enabled="False" runat="server" ></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RqvTel" runat="server" ErrorMessage="Campo Requerido" ControlToValidate="TxbTelefono" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="TxbDireccion" class="col-sm-2 control-label">Dirección</label>
                        <div class="col-sm-10">                            
                            <asp:TextBox class="form-control" ID="TxbDireccion" Enabled="False" runat="server" ></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RqvDireccion" runat="server" ErrorMessage="Campo Requerido" ControlToValidate="TxbDireccion" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="TxbDepto" class="col-sm-2 control-label">Departamento</label>
                        <div class="col-sm-10">                            
                            <asp:TextBox class="form-control" ID="TxbDepto" Enabled="False" runat="server" ></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="TxbMail" class="col-sm-2 control-label">Mail</label>
                        <div class="col-sm-10">
                            <asp:TextBox type="email" class="form-control" ID="TxbMail" Enabled="False" runat="server" data-error="El mail es inválido" ></asp:TextBox>                                                                                        
                                <div class="help-block with-errors"></div>
                                 <asp:RegularExpressionValidator ID="RvxMail" runat="server" ErrorMessage="RegularExpressionValidator" ControlToValidate="TxbMail" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" SetFocusOnError="True"></asp:RegularExpressionValidator>
                                 <asp:RequiredFieldValidator ID="RqvMail" runat="server" ErrorMessage="Campo Requerido" ControlToValidate="TxbMail" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="TxbUsuario" class="col-sm-2 control-label">Usuario</label>
                        <div class="col-sm-10">
                        <asp:TextBox class="form-control" ID="TxbUsuario" Enabled="False" runat="server" ></asp:TextBox>
                            <asp:RegularExpressionValidator Display="Dynamic" ControlToValidate="TxbUsuario" ID="RexUsuario" ValidationExpression="^[\s\S]{5,}$" ForeColor="Red"  runat="server" ErrorMessage="Debe tener más de 5 dígitos" SetFocusOnError="True"></asp:RegularExpressionValidator>
                                    <asp:RequiredFieldValidator ID="RqvUsuario" runat="server" ErrorMessage="Campo Requerido" ControlToValidate="TxbUsuario" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    </div>

                </div>      
                    
                    <div class="form-group">                        
                        <label for="Imagen" class="col-sm-2 control-label">Imagen</label>
                        <div class="col-sm-10">                            
                            <asp:TextBox class="form-control" ID="TxbImagen" Enabled="False" runat="server" ></asp:TextBox>
                        </div>
                        <div class="blog-flickr">
                            <p class="blog-sidebar-title">Elija otra imagen</p>								
								<ul>
									<li><a style="cursor:pointer; width:50%" onclick="mark(this,'chica.png')"><img src="img/usuarios/chica.png" alt="" /></a></li>
									<li><a style="cursor:pointer; width:50%" onclick="mark(this,'mujer.png')"><img src="img/usuarios/mujer.png" alt="" /></a></li>
									<li><a style="cursor:pointer; width:50%" onclick="mark(this,'hombre-de-negocios.png')"><img src="img/usuarios/hombre-de-negocios.png" alt="" /></a></li>
									<li><a style="cursor:pointer; width:50%" onclick="mark(this,'hombre.png')"><img src="img/usuarios/hombre.png" alt="" /></a></li>
                                    
								</ul>								
							</div>
                    </div>          
              </div>
              <!-- /.box-body -->
              <div class="box-footer">
                  <asp:Button CssClass="btn btn-warning" ID="BtnEditar" runat="server" Text="Editar" OnClick="BtnEditar_Click"   />&nbsp;
                  <asp:Button CssClass="btn btn-danger" ID="BtnCancelar" runat="server" Text="Cancelar" OnClick="BtnCancelar_Click"   />&nbsp;

                  <asp:Button CssClass="btn btn-info pull-right" ID="BtnAceptar" runat="server" Text="Guardar" OnClick="BtnAltaUsuario_Click"/>                
              </div>
              <!-- /.box-footer -->
            </div>
          </div>            
        </div>
    </div>    
    <!-- /.box -->

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CphBrandClient" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="CphJsInferior" runat="server">
    <script src="../js/adminlte.min.js"></script>
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?key=AIzaSyCHCQomohspEbZpQ_vzraZMDn4heHmCook"></script>
    
    
    <script type="text/javascript">
        function DirGoogle() {
            var placesAutocomplete = places({ container: document.querySelector('#CphBody_TxbDireccion'), countries: ['ar'] });    
        }
        $(document).ready(function () {
            DirGoogle();
        });
        function mark(el, StrImagen) {            
            el.style.border = "1px solid blue";
            $("#CphBody_TxbImagen").val(StrImagen);
        }

    </script>
</asp:Content>
