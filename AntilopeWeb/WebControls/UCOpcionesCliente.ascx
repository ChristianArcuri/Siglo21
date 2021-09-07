<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UCOpcionesCliente.ascx.cs" Inherits="AntilopeWeb.WebControls.UCOpcionesCliente" %>

  <div class="box box-widget widget-user-2" style="box-shadow: 4px 4px 2px rgba(0,0,0,0.1);">
            <!-- Add the bg color to the header using any of the bg-* classes -->
            <div class="widget-user-header bg-yellow">
              <div class="widget-user-image">                
                <%--<img class="img-circle" src="../img/user1-128x128.jpg" />--%>                                       
                  <asp:Literal ID="LitImagenCliente" runat="server"></asp:Literal>
              </div>
              <!-- /.widget-user-image -->
              <h3 class="widget-user-username" style="color: #fff">
                  <asp:Label ID="LblNombre" runat="server" Text=""></asp:Label>
              </h3>
              <h5 class="widget-user-desc" style="color: #fff;font-size:14px">
                  <asp:Label ID="LblDireccion"  style="font-weight: 100;" runat="server" Text=""></asp:Label>
              </h5>
            </div>
            <div class="box-footer no-padding">
              <ul class="nav nav-stacked">
                <li><a href="../MiCuenta.aspx">Mi Cuenta </a></li>                  
                <%--<li><a href="../Mispuntos.aspx">Mis Puntos <span class="pull-right badge bg-green"><asp:Label ID="LblCantPuntos" runat="server" Text="0"></asp:Label></span></a></li>--%>
                <li><a href="../MisPedidos.aspx">Mis Pedidos <span class="pull-right badge bg-green"><asp:Label ID="LblCantPedidos" runat="server" Text="0"></asp:Label></span></a></li>
                <li><a href="../Cart.aspx">Mi Carrito <span class="pull-right badge bg-green"><asp:Label ID="LblCantCarrito" runat="server" Text="0"></asp:Label></span></a></li>  
                  <li><a href="../MiPassword.aspx">Cambiar Clave </a></li>
                <li><a href="../Home.aspx?logout=true">Salir</a></li>
              </ul>
            </div>
          </div>
          <!-- /.widget-user -->

