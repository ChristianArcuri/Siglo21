<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="AntilopeWeb.AdminSuc.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <meta charset="utf-8" />
      <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
      <title>Antilope SA | Admin</title>      
      <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport"/>      
      <link rel="shortcut icon" type="image/x-icon" href="../img/faviconmy.ico" />    
      <link href="../css/bootstrap.min.css" rel="stylesheet" />
      <link href="../css/font-awesome.min.css" rel="stylesheet" />
      <link href="../css/ionicons.min.css" rel="stylesheet" />
      <link href="../css/AdminLTE.min.css" rel="stylesheet" />
      <link href="../css/components/blue.css" rel="stylesheet" />      

      <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
      <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
      <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
      <![endif]-->

      <!-- Google Font -->
      <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic" />
</head>
<body class="hold-transition login-page">
    <form id="form1" runat="server">
        <div class="login-box">
          <div class="login-logo">
            <a href="Login.aspx"><b>Antilope SA</b><p>Admin</p></a>
          </div>
          <!-- /.login-logo -->
          <div class="login-box-body">
            <p class="login-box-msg">Ingrese usuario y clave para iniciar sesión</p>            
              <div class="form-group has-feedback">                
                <asp:TextBox ID="TxbUsuario" class="form-control" placeholder="Usuario" runat="server" Text=""></asp:TextBox>
                <span class="glyphicon glyphicon-user form-control-feedback"></span>
              </div>
              <div class="form-group has-feedback">                
                <asp:TextBox ID="TxbClave" class="form-control" placeholder="Clave" runat="server" TextMode="Password" Text="demo123"></asp:TextBox>
                <span class="glyphicon glyphicon-lock form-control-feedback"></span>
              </div>
              <div class="row">
                <div class="col-xs-8">
                    <asp:CheckBox ID="CheckBox1" class="checkbox icheck" runat="server" Text="&nbsp;&nbsp; Recordarme" />                  
                </div>
                <!-- /.col -->
                <div class="col-xs-4">                  
                    <asp:Button ID="BtnIngresar" class="btn btn-primary btn-block btn-flat" runat="server" Text="Ingresar" OnClick="BtnIngresar_Click" />
                </div>
                <!-- /.col -->
              </div>
               <div class="row">
                <div class="col-xs-12">
                    <asp:Label ID="LblError" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                </div>                
              </div>
            
            <hr />
            
          </div>
          <!-- /.login-box-body -->
        </div>
        <!-- /.login-box -->
    </form>

    <script src="../js/jquery.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/icheck.min.js"></script>
    <script>
      $(function () {
        $('input').iCheck({
          checkboxClass: 'icheckbox_square-blue',
          radioClass: 'iradio_square-blue',
          increaseArea: '20%' // optional
        });
      });
    </script>
</body>
</html>
