<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UCCampanaPedidos.ascx.cs" Inherits="AntilopeWeb.WebControls.UCCampanaPedidos" %>

<script type="text/javascript">
    <%-- setInterval(function () { RefrescarUpdCampana() }, 3000);

    function RefrescarUpdCampana() {
            var UpdatePanel1 = '<%=UpdCampana.ClientID%>';
            __doPostBack(UpdatePanel1, '');
    }--%>
    setInterval(function () { GetDataCampana() }, 30000);

    function GetDataCampana() {
        var Sucursal = '<%= Session["Sucursal"].ToString() %>';

        $.ajax({
            type: "POST",
            url: "../AdminSuc/DefaultSuc.aspx/GetDataCampana",
            data: "{}",
            data: "{Sucursal: " + Sucursal + "}",
            traditional: true,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                var Resp = response.d;
                if (Resp != 0) {
                    $('#ComboCampana').html(Resp);
                }
                else {
                    $('#ComboCampana').html('Error!!!!');
                }                
            },
            error: function (result) {
                alert('ERROR ' + result.status + ' ' + result.statusText);
            }
        });
    }

    function GetDataSucursal() {
        var Sucursal = '<%= Session["Sucursal"].ToString() %>';

        $.ajax({
            type: "POST",
            url: "../AdminSuc/DefaultSuc.aspx/GetDataSucursal",
            data: "{}",
            data: "{Sucursal: " + Sucursal + "}",
            traditional: true,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                var Resp = response.d;
                if (Resp != 0) {
                    $('#DatosUsuario').html(Resp);
                }
                else {
                    $('#DatosUsuario').html('Error!!!!');
                }                
            },
            error: function (result) {
                alert('ERROR ' + result.status + ' ' + result.statusText);
            }
        });
    }
        
</script>
<asp:UpdatePanel ID="UpdCampana" runat="server" UpdateMode="Conditional">
    <ContentTemplate>        
        <asp:Panel ID="panelCampana" runat="server">                                    
            <div class="navbar-custom-menu">                   
                <ul class="nav navbar-nav">                         
                        <li id="ComboCampana" class="dropdown tasks-menu"></li>
                        <li id="ComboIdiomas" class="dropdown messages-menu"></li>                               
                        <li class="dropdown user user-menu">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">                      
                              <span class="hidden-xs">Bienvenido!</span>
                            </a>
                            <ul class="dropdown-menu">
                              <!-- User image -->
                              <li class="user-header">                        
                                <p id="DatosUsuario"></p>
                              </li>                      
                              <!-- Menu Footer-->
                              <li class="user-footer">
                                
                                <div class="pull-right">
                                  <a href="Login.aspx?logout=true" class="btn btn-default btn-flat">Cerrar Sesión</a>
                                </div>
                              </li>
                            </ul>
                         </li>                  
                        </ul>
            </div>
        </asp:Panel>
    </ContentTemplate>
</asp:UpdatePanel>	