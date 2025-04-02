<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MdTStudios.eEzyTest.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Log in to eEzyTest | eFutureSoft</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <meta content="" name="description" />
    <meta content="" name="author" />
    <!-- BEGIN GLOBAL MANDATORY STYLES -->
    <link href="assets/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="assets/plugins/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />
    <link href="assets/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="assets/css/style-metro.css" rel="stylesheet" type="text/css" />
    <link href="assets/css/style.css" rel="stylesheet" type="text/css" />
    <link href="assets/css/style-responsive.css" rel="stylesheet" type="text/css" />
    <link href="assets/css/themes/default.css" rel="stylesheet" type="text/css" id="style_color" />
    <link rel="stylesheet" type="text/css" href="assets/plugins/select2/select2_metro.css" />
    <!-- END GLOBAL MANDATORY STYLES -->
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link href="assets/css/pages/login-soft.css" rel="stylesheet" type="text/css" />
    <!-- END PAGE LEVEL STYLES -->
    <link rel="shortcut icon" href="favicon.ico" />
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body class="login">
    <!-- BEGIN LOGO -->
    <div class="logo">
        <!-- PUT YOUR LOGO HERE -->
    </div>
    <!-- END LOGO -->
    <!-- BEGIN LOGIN -->
    <div class="content">
        <!-- BEGIN LOGIN FORM -->
        <form runat="server" class="form-vertical login-form" method="post">
            <input type="hidden" runat="server" id="LoginPurpose" value="Login" />
            <h3>
                <img src="assets/Logo/128 x 128.png" style="margin-left: 75px;" /></h3>
            <h3 class="form-title" id="Logaccount">Log in to your account</h3>
            <div runat="server" class="alert alert-error" id="errordiv" style="display: none">
                <button class="close" data-dismiss="alert"></button>
                <div runat="server" id="errorlabel"></div>
            </div>
            <div class="control-group">
                <!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
                <label class="control-label visible-ie8 visible-ie9">Email address</label>
                <div class="controls">
                    <div class="input-icon left">
                        <i class="icon-user"></i>
                        <asp:TextBox runat="server" class="m-wrap placeholder-no-fix" onkeypress="hideerror()" ID="txtUsername" autocomplete="off" placeholder="Email address" name="username" />
                    </div>
                </div>
            </div>
            <div class="control-group" id="Passwordarea">
                <label class="control-label visible-ie8 visible-ie9">Password</label>
                <div class="controls">
                    <div class="input-icon left">
                        <i class="icon-lock"></i>
                        <asp:TextBox runat="server" TextMode="Password" class="m-wrap placeholder-no-fix" ID="txtPassword" onkeypress="hideerror()" type="password" autocomplete="off" placeholder="Password" name="password" />
                    </div>
                </div>
            </div>
            <div class="form-actions">
                <label class="checkbox" id="remember">
                    <input style="margin-left: 0px;" type="checkbox" name="remember" value="1" />&nbsp;&nbsp; Remember me
                </label>
                <asp:Button runat="server" Text="&#xf090;&nbsp;&nbsp;Log in" OnClientClick="return validate()" ID="btnlogin" OnClick="Login_Click" class="btn blue pull-right" />
            </div>
            <div class="forget-password">
                <h4 id="forgotyourpassword">Forgot your password?</h4>
                <p id="backtologin">
                    No worries, click <a onclick="forgotpassword()" id="forget-password">here</a> to reset your password.
                </p>
            </div>
            <div class="forget-password" id="CreateAccount">
                <h4 id="RegisterAcount">Not having an account?</h4>
                <p id="createaccount">
                    Click <a id="create-password">here</a> to create one, it's so easy.
                </p>
            </div>
        </form>
    </div>
    <!-- END LOGIN -->
    <!-- BEGIN COPYRIGHT -->

    <!-- END COPYRIGHT -->
    <!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
    <!-- BEGIN CORE PLUGINS -->
    <script src="assets/plugins/jquery-1.10.1.min.js" type="text/javascript"></script>
    <script src="assets/plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
    <!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
    <script src="assets/plugins/jquery-ui/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>
    <script src="assets/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <!--[if lt IE 9]>
	<script src="assets/plugins/excanvas.min.js"></script>
	<script src="assets/plugins/respond.min.js"></script>  
	<![endif]-->
    <script src="assets/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
    <script src="assets/plugins/jquery.blockui.min.js" type="text/javascript"></script>
    <script src="assets/plugins/jquery.cookie.min.js" type="text/javascript"></script>
    <!-- END CORE PLUGINS -->
    <!-- BEGIN PAGE LEVEL PLUGINS -->
    <!-- 	<script src="assets/plugins/jquery-validation/dist/jquery.validate.min.js" type="text/javascript"></script>
 -->
    <script src="assets/plugins/backstretch/jquery.backstretch.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="assets/plugins/select2/select2.min.js"></script>
    <!-- END PAGE LEVEL PLUGINS -->
    <!-- BEGIN PAGE LEVEL SCRIPTS -->
    <script src="assets/scripts/app.js" type="text/javascript"></script>
    <script src="assets/scripts/login-soft.js" type="text/javascript"></script>
    <!-- END PAGE LEVEL SCRIPTS -->
    <script>
        jQuery(document).ready(function () {
            var isPostBackObject = document.getElementById('isPostBack');
            if (isPostBackObject != null) {
                if (isPostBackObject.value == "Forgot") forgotpassword();
            }
            App.init();
            Login.init();
        });

        function validate() {
            var username = document.forms["ctl01"]["txtUsername"].value;
            var password = document.forms["ctl01"]["txtPassword"].value;
            if (username == null || username == "") {
                document.getElementById("errorlabel").style.display = "block";
                document.getElementById("errordiv").style.display = "block";
                document.getElementById("errorlabel").innerHTML = "We need your email address!";
                document.getElementById("txtUsername").focus();
                return false;
            }
            else if (password == null || password == "") {
                document.getElementById("errorlabel").style.display = "block";
                document.getElementById("errordiv").style.display = "block";
                document.getElementById("errorlabel").innerHTML = "We need your password too!";
                document.getElementById("txtPassword").focus();
                return false;
            }
        }
        function hideerror() {
            document.getElementById("errorlabel").style.display = "none";
            document.getElementById("errordiv").style.display = "none";
        }
        function forgotpassword() {
            document.getElementById("Passwordarea").style.display = "none";
            document.getElementById("remember").style.display = "none";
            document.getElementById("CreateAccount").style.display = "none";
            document.getElementById("btnlogin").value = "Email password";
            document.getElementById("LoginPurpose").value = "Forgot";
            document.getElementById("txtPassword").value = "Forgot";
            document.getElementById("Logaccount").innerHTML = 'Resetting the password';
            document.getElementById("forgotyourpassword").innerHTML = 'Got your password?';
            document.getElementById("backtologin").innerHTML = 'Great, click <a href="Default.aspx" id="forget-password">here</a> to log in to your account.';

        }
    </script>
    <!-- END JAVASCRIPTS -->
</body>
<!-- END BODY -->
</html>
