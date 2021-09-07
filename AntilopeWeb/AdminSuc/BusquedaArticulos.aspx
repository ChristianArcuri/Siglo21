<%@ Page Title="" Language="C#" MasterPageFile="~/MasterAdminSuc.Master" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="BusquedaArticulos.aspx.cs" Inherits="AntilopeWeb.AdminSuc.BusquedaArticulos" %>


<asp:Content ID="Content4" ContentPlaceHolderID="CphJsSup" runat="server">
    <script type="text/javascript">
        function VerDetalle(PLU) {
            window.location.href = "DetalleArticulos.aspx?SKU=" + PLU;
        }
        function CallGetEditPreCarga() {
            var PLU = $("#CphBody_TxbCodPLU").val();
            GetEditId(PLU);
            //$("#CphBody_ChkPreCarga").prop('checked', true);
        }

        function GetEditId(id) {
            $("[id$=HdnIdArticulo]").val(id);
            $.ajax({
                type: "POST",
                url: "BusquedaArticulos.aspx/IniModalEdit",
                data: "{Id:'" + id + "'}",
                traditional: true,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var ListaMC = (typeof response.d) == 'string' ? eval('(' + response.d + ')') : response.d;
                    if (ListaMC[0] == null) {
                        //alert('No exiten datos');                        
                        $("[id$=HdnEsNuevoArt]").val(1);
                        $("[id$=LblPLU]").text(id);
                        $("#TxbDescripcion").val('');
                        $("[id$=DlMedida]").val('GR');
                        $("#TxbUnidad").val(0);
                        $("[id$=DlSubCategoria]").val(1);
                        $("#CphBody_ChkCompleto").prop('checked', false);

                        $("#myModalABM").modal('show');
                        $("#CphBody_DlSubCategoria").select2();
                    }
                    else {
                        var chkCompleto = (ListaMC[0].Habilitado == 1) ? true : false;
                        $("[id$=LblPLU]").text(ListaMC[0].SKU);
                        $("#TxbDescripcion").val(ListaMC[0].Descripcion);                        
                        $("[id$=DlMedida]").val(ListaMC[0].Medida);
                        $("#TxbUnidad").val(ListaMC[0].Unidad);
                        $("[id$=DlSubCategoria]").val(ListaMC[0].Id_SubCategoria);
                        $("#TxbImagen").val(ListaMC[0].StrImagen);
                        $('#myUploadedImg').attr('src', ListaMC[0].StrImagen);
                        $("#CphBody_ChkCompleto").prop('checked', chkCompleto);
                        $("#TxbPrecioVenta").val(ListaMC[0].Precio_Venta);
                        $("#TxbPrecioOferta").val(ListaMC[0].Precio_Oferta);
                        $("#TxbStock").val(ListaMC[0].Stock);
                        
                        $("#myModalABM").modal('show');
                        $("#CphBody_DlSubCategoria").select2();
                    }
                },
                error: function (result) {
                    alert('ERROR ' + result.status + ' ' + result.statusText);
                }
            });
        }
        function GrabarArticulo() {
            var vImagenBig = null;
            var vPlu = $("[id$=HdnIdArticulo]").val();
            var vDescrip = $("#TxbDescripcion").val();
            var vMedida = $("[id$=DlMedida]").val();
            var vUnidad = $("#TxbUnidad").val();            
            var vSubCateg = $("[id$=DlSubCategoria]").val();
            var vImagen = "img/articulos/ImagenNoDisponible.png";
            var vImagen = $("#myUploadedImg").attr("src");            
            if (vImagen != null) {
                vImagenBig = vImagen.replace("articulos", "articulos_big");
            }
            var chkCompleto = $("[id$=ChkCompleto]").prop('checked');
            var EsNuevo = $("[id$=HdnEsNuevoArt]").val();
            var vPrecio = $("#TxbPrecioVenta").val();
            var vPrecioOferta = $("#TxbPrecioOferta").val();
            var vStock = $("#TxbStock").val();
            
            var Articulo = { SKU: vPlu, Descripcion: vDescrip, Medida: vMedida,Stock: vStock,Precio_Venta: vPrecio,Precio_Oferta: vPrecioOferta, Unidad: vUnidad, Id_SubCategoria: vSubCateg, StrImagen: vImagen, StrImagenBig: vImagenBig, Habilitado: chkCompleto };
                        
            $.ajax({
                type: "POST",
                url: "BusquedaArticulos.aspx/GrabarArticulo",                
                data: JSON.stringify({ 'art': Articulo, 'EsNuevo': EsNuevo }),
                traditional: true,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var resp = (typeof response.d) == 'string' ? eval('(' + response.d + ')') : response.d;
                    if (resp==1)
                    {
                        $('#myModalABM').modal('hide'); $('body').removeClass('modal-open'); $('.modal-backdrop').remove();
                        //RefrescarUpdatePanel();
                        window.location.href = "BusquedaArticulos.aspx";
                    }
                    else {
                        AlertError();
                    }
                },
                error: function (result) {
                    alert('ERROR ' + result.status + ' ' + result.statusText);
                }
            });
        }

        function GetCategorias() {
            var Depto = $("[id$=DlDepartamento]").val();;
            $.ajax({
                type: "POST",
                url: "BusquedaArticulos.aspx/GetCategoriasByDepto",
                contentType: "application/json; charset=utf-8",
                data: '{"depto":"' + Depto + '"}',
                dataType: "json",
                success: function (result, status, xhr) {
                    $("[id$=DlCategoria]").html(result.d);
                },
                error: function (xhr, status, error) {
                    alert("Result: " + status + " " + error + " " + xhr.status + " " + xhr.statusText)
                }
            });
        }

        function GetSubCategorias() {
            var categoriaId = $("[id$=DlCategoria]").val();
            $.ajax({
                type: "POST",
                url: "BusquedaArticulos.aspx/GetSubCategoriasByCateg",
                contentType: "application/json; charset=utf-8",
                data: '{"categ":"' + categoriaId + '"}',
                dataType: "json",
                success: function (result, status, xhr) {
                    $("[id$=DlSubCategoria]").html(result.d);
                },
                error: function (xhr, status, error) {
                    alert("Result: " + status + " " + error + " " + xhr.status + " " + xhr.statusText)
                }
            });
        }
        
        function sendFile(file) {            
            var idSubCateg = $("#CphBody_DlSubCategoria").val();
            var Sku = $("[id$=LblPLU]").text();
            var formData = new FormData();
            formData.append('file', $('#f_UploadImage')[0].files[0]);
            formData.append('idSubCategoria', idSubCateg);
            formData.append('SKU', Sku);
            $.ajax({
                type: 'post',
                url: 'fileUploader.ashx',
                data: formData,
                success: function (status) {
                    if (status != 'error') {
                        var my_path = "../img/articulos/" + status;                        
                        $("#myUploadedImg").attr("src", my_path);
                    }
                },
                processData: false,
                contentType: false,
                error: function () {
                    alert("Whoops something went wrong!");
                }
            });
        }
        function showpreview(input) {

            if (input.files && input.files[0]) {

                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#imgpreview').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }

        }
        
    </script>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentBeginAndEndHandler" runat="server">
    <script type="text/javascript" language="javascript">
        function BeginRequestHandler() {
            //Antes de ejecutar la peticion de AJAX ASP.Net                      
        }
        Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
        function EndRequestHandler(sender, args) {
            if (args.get_error() == undefined) {                
                if ($("[id$=HdnIdArticulo]").val() == "0") {                    
                    $("#myModalABM").modal('hide');
                }
                $('#example1').DataTable();                
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CphBody" runat="server">
    <section class="content-header">
      <h1>
        Articulos
        <small>Listado de Articulos</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Inicio</a></li>
        <li><a href="#">Articulos</a></li>
        <li class="active">Listado de Articulos</li>
      </ol>
    </section>
    <asp:HiddenField ID="HdnIdArticulo" runat="server" Value="0" />
    <asp:HiddenField ID="HdnEsNuevoArt" runat="server" Value="0" />
    

    <!-- Main content -->
    <section class="content">        
      <!-- /.row -->
        <div class="row">
            <div class="col-md-3">
                <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">Busqueda de Articulos</h3>
                </div>
                <!-- /.box-header -->
                <!-- form start -->
                <div role="form">
                    <div class="box-body">                    
                    <div class="form-group">
                        <label for="TxbNombrePLU">Por Nombre</label>
                        <asp:TextBox ID="TxbNombrePLU" class="form-control" runat="server" placeholder="Nombre"></asp:TextBox>
                    </div>                
                    </div>
                    <div class="box-footer">                
                    <asp:Button class="btn btn-primary" ID="BtnBuscarPLU" runat="server" Text="Buscar" OnClick="BtnBuscarPLU_Click" />
                    </div>
                </div>
                </div>
                <hr />
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title">Por SKU</h3>
                    </div>
                <!-- /.box-header -->
                <!-- form start -->
                    <div role="form">
                        <asp:Panel ID="panelCarga" runat="server" DefaultButton="BtnBuscarPorPLU">
                            <div class="box-body">
                        <div class="form-group">
                            <label for="TxbCodPLU">SKU</label>                  
                            <asp:TextBox ID="TxbCodPLU" class="form-control" runat="server" placeholder="SKU" Height="22px"></asp:TextBox>
                        </div>
                        </div>
                            <div class="box-footer">                
                                <asp:Button class="btn btn-primary" ID="BtnBuscarPorPLU" runat="server" Text="Buscar SKU" OnClientClick="CallGetEditPreCarga();return false" />
                            </div>
                        </asp:Panel>
                    </div>
                </div>
            </div>
            <!-- /.col -->
            <div class="col-md-9">
             <div class="box">
            <div class="box-header">
              <h3 class="box-title">Listado de Articulos</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
                    <th>SKU</th>
                    <th>Descripcion</th>
                    <th>Medidad</th>
                    <th>Unidad</th>                    
                    <th>Subcategoria</th>                                        
                    <th>Ver Detalle</th>
                </tr>
                </thead>
                <tbody>
                    <asp:Literal ID="LitGrillaDetPedido" runat="server"></asp:Literal>                            
                </tbody>
                <tfoot>                
                </tfoot>
              </table>
            </div>
            <!-- /.box-body -->
          </div>
                <!-- /.box -->
        </div>
       </div>

        
    </section>
    
    <div class="modal fade" id="myModalABM"  data-backdrop="static"  data-keyboard="false" aria-hidden="true" role="dialog">    
        <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title"><i class="fa fa-pencil"></i> Edición del SKU: <asp:Label ID="LblPLU" runat="server" Text="0"></asp:Label></h4>
            </div>
            <div class="modal-body">
                <div class="form-horizontal form-label-left">                    
                    <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Descripción</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">                                                
                            <asp:TextBox class="form-control" ClientIDMode="Static" onKeyDown="TocarKey(event)" placeholder="Descripción del SKU" ID="TxbDescripcion" runat="server" MaxLength="50"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Sub Categoria</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">                                                
                            <asp:DropDownList class="form-control select2" style="width: 100%;" ID="DlSubCategoria" runat="server"></asp:DropDownList>
                        </div>
                    </div>
                    <div class="form-group">
                        
                        <label class="control-label col-md-3 col-sm-3 col-xs-6">Medida</label>
                        <div class="col-md-3 col-sm-3 col-xs-6">                                                
                            <asp:DropDownList class="form-control" ID="DlMedida" runat="server">
                                <asp:ListItem>GR</asp:ListItem>
                                <asp:ListItem>UN</asp:ListItem>
                                <asp:ListItem>LT</asp:ListItem>
                                <asp:ListItem>CC</asp:ListItem>
                                <asp:ListItem>KG</asp:ListItem>
                                <asp:ListItem>ML</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <label class="control-label col-md-2 col-sm-2 col-xs-6">Unidad</label>
                        <div class="col-md-4 col-sm-4 col-xs-6">                                                
                            <asp:TextBox class="form-control" ClientIDMode="Static" placeholder="Unidad de Medida" ID="TxbUnidad" runat="server"></asp:TextBox>
                        </div>

                    </div>                                   
                    
                    <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-6">Precio Venta ($)</label>
                        <div class="col-md-3 col-sm-3 col-xs-6">                                 
                            <asp:TextBox class="form-control" ClientIDMode="Static" placeholder="Precio del Local" ID="TxbPrecioVenta" runat="server" MaxLength="80"></asp:TextBox>
                        </div>
                        <label class="control-label col-md-2 col-sm-2 col-xs-6">Oferta ($)</label>
                        <div class="col-md-4 col-sm-4 col-xs-6">                                                
                            <asp:TextBox class="form-control" ClientIDMode="Static" placeholder="Precio de Oferta" ID="TxbPrecioOferta" runat="server" MaxLength="80"></asp:TextBox>
                        </div>
                    </div> 
                    <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Stock</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">                                                
                            <asp:TextBox class="form-control" ClientIDMode="Static" placeholder="Stock" ID="TxbStock" runat="server" MaxLength="50" TextMode="Number"></asp:TextBox>
                        </div>
                    </div> 
                    <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Imagen</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">                                                
                            <asp:TextBox class="form-control" ClientIDMode="Static" placeholder="Ruta Imagen" ID="TxbImagen" runat="server"></asp:TextBox>
                            <img id="myUploadedImg" alt="Photo" style="width:180px;" />
                            <br />
                            <input type="file" class="upload"  id="f_UploadImage">                            
                        </div>
                        
                    </div>  
                     
                    <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Completo</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">                                                
                            <asp:CheckBox ID="ChkCompleto" runat="server" />
                        </div>
                    </div>               
                </div>
            </div>
            <div class="modal-footer">                
                <button type="button" ID="BtnCancelar" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                <asp:Button ID="BtnAceptar" class="btn btn-primary" runat="server" Text="Aceptar" OnClientClick="GrabarArticulo(); return false"  />                
            </div>
        </div>
        <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="CphJsInf" runat="server">
    <script>
      $(function () {
        $('#example1').DataTable()
        $('.select2').select2();
      })

      var _URL = window.URL || window.webkitURL;
      $("#f_UploadImage").on('change', function () {          
          var file, img;
          if ((file = this.files[0])) {
              img = new Image();
              img.onload = function () {
                  sendFile(file);
              };
              img.onerror = function () {
                  alert("Not a valid file:" + file.type);
              };
              img.src = _URL.createObjectURL(file);
          }
      });
      $("#TxbPrecioVenta").on("keyup", function () {
          var valid = /^\d{0,7}(\.\d{0,2})?$/.test(this.value),
              val = this.value;

          if (!valid) {
              //console.log("Invalid input!");
              this.value = val.substring(0, val.length - 1);
          }
      });
      $("#TxbPrecioOferta").on("keyup", function () {
          var valid = /^\d{0,7}(\.\d{0,2})?$/.test(this.value),
              val = this.value;

          if (!valid) {
              //console.log("Invalid input!");
              this.value = val.substring(0, val.length - 1);
          }
      });
      
      $('#myModalABM').on('shown.bs.modal', function () {
          $('#TxbDescripcion').focus();
      })
      
      function TocarKey(event) {
          if (event.which == 120) {
              GrabarArticulo();
          }
      }
      
    </script>
</asp:Content>