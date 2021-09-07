<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGralNew.Master" AutoEventWireup="true" CodeBehind="MiPassword.aspx.cs" Inherits="AntilopeWeb.MiPassword" %>

<%@ Register Src="~/WebControls/UCOpcionesCliente.ascx" TagPrefix="uc1" TagName="UCOpcionesCliente" %>


<asp:Content ID="Content1" ContentPlaceHolderID="CphJsSuperior" runat="server">
      <link href="../css/ionicons.min.css" rel="stylesheet" />
    <link href="../css/AdminLTE.min.css" rel="stylesheet" />
    
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
        <div class="col-md-4">
          <uc1:UCOpcionesCliente runat="server" id="UCOpcionesCliente" />
        </div>
        <div class="col-md-8">
            <div class="box box-info">
            <div class="box-header with-border">
              <h3 class="box-title">Cambio de Clave</h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <div class="form-horizontal">
                <div class="box-body">
                    <div class="form-group">                                
                                <label class="col-sm-4 control-label" for="TxbClaveActual"><i class="fa fa-check"></i> Ingrese Clave Actual</label>
                                <div class="col-sm-8">                        
                                    <asp:TextBox TextMode="Password" class="form-control" ID="TxbClaveActual" runat="server" ></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Campo Requerido" ControlToValidate="TxbClaveActual" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>                    
                            </div>
                    <div class="form-group">
                        <label for="TxbClaveNueva" class="col-sm-4 control-label">Ingrese Clave Nueva</label>
                        <div class="col-sm-8">                        
                            <asp:TextBox class="form-control" ID="TxbClaveNueva" runat="server" TextMode="Password" ></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Campo Requerido" ControlToValidate="TxbClaveNueva" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator Display="Dynamic" ControlToValidate="TxbClaveNueva" ID="RexClave" ValidationExpression="^[\s\S]{5,}$" ForeColor="Red"  runat="server" ErrorMessage="Debe tener más de 5 dígitos" SetFocusOnError="True"></asp:RegularExpressionValidator>                                                
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="TxbRepClaveNueva" class="col-sm-4 control-label">Repita la Clave Nueva</label>
                        <div class="col-sm-8">                            
                            <asp:TextBox class="form-control" TextMode="Password" ID="TxbRepClaveNueva" runat="server" ></asp:TextBox>                                    
                            <asp:CompareValidator ID="CompareValidator2" runat="server" ErrorMessage="Las claves ingresadas no coinciden" ControlToCompare="TxbClaveNueva" ControlToValidate="TxbRepClaveNueva" ForeColor="Red"></asp:CompareValidator>
                        </div>
                    </div>             
              </div>
              <!-- /.box-body -->
              <div class="box-footer">                  
                  <asp:Button CssClass="btn btn-danger" ID="BtnCancelar" runat="server" Text="Cancelar" OnClick="BtnCancelar_Click"   />&nbsp;

                  <asp:Button CssClass="btn btn-info pull-right" ID="BtnAceptar" runat="server" Text="Guardar" OnClick="BtnAceptar_Click"/>                
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
    
</asp:Content>
