<%@ page language="C#" autoeventwireup="true" inherits="API_Login, App_Web_jrksopsy" masterpagefile="~/User/Empty.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <link href="/App_Themes/ICMS/order.css" rel="stylesheet" />
    <style type="text/css">.code{display:none;}</style>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <div class="login_body">
            <ul class="list-unstyled">
                <li><span class="pull-left"><%:Call.SiteName%>会员</span>
                    <span class="pull-right"><i class="fa fa-chevron-circle-right"></i>
                        <a href="/User/Register.aspx" target="_blank">立即注册</a></span></li>
                <li class="clearfix"></li>
                <li class="input-group">
                    <span class="input-group-addon"><i class="fa fa-user"></i></span>
                    <input type="text" id="uname_t" class="form-control text_max" placeholder="用户名/用户ID" data-enter="0"/>
                </li>
                <li class="input-group">
                    <span class="input-group-addon"><i class="fa fa-key"></i></span>
                    <input type="password" id="passwd_t" class="form-control text_max" placeholder="密码" data-enter="1"/>
                </li>
                <li id="code_li" style="height:32px;">
                    <input type="text" id="VCode" placeholder="验证码" maxlength="6" class="form-control text_x code" data-enter="2" />
                    <img id="VCode_img" title="点击刷新验证码" class="code"  style="height:34px;"/>
                    <input type="hidden" id="VCode_hid" name="VCode_hid" />
                </li>
                <li><input type="button" id="login_btn" onclick="Login();" value="登录" class="btn btn-primary center-block" data-enter="3"/></li>
            </ul>
        </div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Script">
    <script src="/JS/ZL_ValidateCode.js"></script>
    <script src="/JS/Controls/B_User.js"></script>
    <script src="/JS/Controls/Control.js"></script>
    <script>
        var buser = new B_User();
        $(function () {
            Control.EnableEnter();
        })
        function Login() {
            var model = { name: $("#uname_t").val(), pwd: $("#passwd_t").val(), key: $("#VCode_hid").val(), code: $("#VCode").val() };
            console.log(model);
            buser.Login(model, function (data) {
                if (data == -1) { alert("用户名或密码错误"); }
                else if (data == -10) {
                    alert("用户名或密码错误");
                    EnableCode();
                }
                else if (data == -2) { alert("验证码错误"); }
                else {
                    parent.LoginSuccess();
                }
            });
        }
        function EnableCode() {
            if ($(".code").is(":hidden")) {
                $(".code").show();
                $("#VCode_img").click();
                $("#VCode").ValidateCode();
            }
        }
    </script>
</asp:Content>