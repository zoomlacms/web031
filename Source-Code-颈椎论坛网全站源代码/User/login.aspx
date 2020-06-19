<%@ page language="C#" autoeventwireup="true" validaterequest="false" inherits="User_login, App_Web_aie0qeud" enableviewstatemac="false" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<!DOCTYPE HTML>
<html lang="zh-CN">
<head runat="server">
<meta charset="utf-8">
<title>用户登录-<%:Call.SiteName %></title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script type="text/javascript" src="/JS/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="/JS/ZL_ValidateCode.js"></script>
<script type="text/javascript" src="/dist/js/bootstrap.min.js"></script>
<link href="/dist/css/font-awesome.min.css" rel="stylesheet"/>
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
<script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
<![endif]-->
<link type="text/css" href="/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="/Template/cvfnetwork/style/global.css" rel="stylesheet" />
<script type="text/javascript" src="../JS/ajaxrequest.js"></script>
<script src="/js/scrolltopcontrol.js" type="text/javascript"></script>
<script type="text/javascript">
if (self != top) { top.location = self.location; }
function onfocus() {
try {
document.getElementById('TxtUserName').focus();
}catch(Error){}
}
var sts = 3;//登录后跳转等待时间;单位：秒
function sucse(s, url) {
if (s == 1) {//成功
document.getElementById("main_l").style.display = "none";
document.getElementById("main_s").style.display = "";
document.getElementById("sec").innerHTML = sts;
setInterval(loacationgoto, 1000);
}
else {
document.getElementById("main_l").style.display = "";
document.getElementById("main_s").style.display = "none";
}
}
function BtnTj() {
var username = document.getElementById("TxtUserName");
var userpass = document.getElementById("TxtPassword"); 
var VCode = document.getElementById("VCode");
if (username.value == "") {
username.focus();
return false;
}
if (userpass.value == "") {
userpass.focus();
return false;
}
if (VCode && VCode.value == "") {
    VCode.focus();
return false;
}
}
</script>
<style>
</style>
</head>
<body onload="onfocus();" class="cms2login">
<%Call.Label("{ZL.Label id=\"全站头部\"/}"); %>
<form id="form" runat="server">
<div class="navbar navbar-default" style="display:none;">
<div class="navbar navbar-static-top" role="navigation" id="scolls">
<div class="navbar-header">
<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
<span class="sr-only">移动下拉</span>
<span class="icon-bar"></span>
<span class="icon-bar"></span>
<span class="icon-bar"></span>
</button>
<div class="menua"><a class="navbar-brand" href="#"  onmouseover="showMoreSoftware(this,'softList')" onmouseout="hideMoreSoftware()">登录<%:Call.SiteName %></a></div>
</div>
<div class="navbar-collapse collapse">
<ul class="nav navbar-nav">
<li><a href="/" target="_blank">网站首页</a></li>
<li><a href="/Home" target="_blank">能力中心</a></li>
<li><a href="/Index" target="_blank">社区</a></li>
<li><a href="/Ask" target="_blank">问答</a></li>
<li><a href="/Guest" target="_blank">留言</a></li>
<li><a href="/Baike" target="_blank">百科</a></li>
<li><a href="/Office" target="_blank">OA</a></li>
</ul>
</div>
</div>
</div>
<!-- 导航到此结束 -->
<div style=" min-height:47em; background:#EDF3FC; padding-top:10em;">
<div class="container">
<div class="row">
<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 col-md-offset-3">
<div class="main_ldiv">
<h1><span class="glyphicon glyphicon-user"></span>登录会员中心</h1>
<ul class="list-unstyled">
<li><asp:TextBox ID="TxtUserName" placeholder="用户名" onblur="CheckUserCode()" runat="server" CssClass="form-control"></asp:TextBox></li>
<li><asp:TextBox ID="TxtPassword" placeholder="密码" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox></li>
<li><div class="form-group" visible="false" id="trVcodeRegister" runat="server">
<asp:TextBox ID="VCode" placeholder="验证码" MaxLength="6" runat="server" CssClass="form-control codestyle" style="display:inline;"></asp:TextBox>
<img id="VCode_img" title="点击刷新验证码" class="code"  style="height:34px;margin-left:2px;width:28%;"/>
<input type="hidden" id="VCode_hid" name="VCode_hid" />
</div>
</li>
<li id="usercode_li" style="display:none;">
    <asp:TextBox ID="UserCode_T" runat="server" placeholder="动态口令" CssClass="form-control"></asp:TextBox>
</li>
<li style="margin-top:10px;margin-bottom:10px;"><input type="checkbox" name="checkbox" checked="checked" id="checkbox" />记住登录<a href="/User/GetPassword.aspx" style="margin-left:5px;margin-right:5px; color:#000000;">忘记密码？</a></li>
<li>
<div class="row">
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12"><asp:Button ID="btnLogin" CssClass="btn btn-primary" OnClientClick="return BtnTj();" Width="100%" runat="server" Text="登录" onclick="btnLogin_Click" /></div>
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12"><a class="btn btn-primary" href="/Class_7/NodePage.aspx" style="width:100%;">点此注册</a></div>
</div>
<div class="clearfix"></div>
</li>
</ul>
<div id="main_s" style="display:none">
<ul>
<li style="color:green; font-size:14px; font-weight:bold">欢迎您！登录成功</li>
<li style="margin-top:25px;">系统将在 <span id="sec">3</span> 秒后自动跳转到<a href="MemoView.aspx">会员首页</a></li>
</ul>
</div>
<div  id="alipayDIV">
<div class="text-left"><label id="AppTitle" runat="server" style="font-size:11px; font-weight:normal;">第三方平台登录：</label></div>
<div  class="applgntype">
<asp:LinkButton ID="appSina" ToolTip="新浪" runat="server" Style="background-image: url('/images/sina.gif');background-repeat: no-repeat; " OnClick="appSina_Click"></asp:LinkButton>
<span id="qqLoginBtn" title="QQ" runat="server" style="padding:0;" ><img src="/images/qq.gif" /></span>
<asp:LinkButton ID="appBaidu" ToolTip="百度" runat="server" style="background-image:url('/images/bdidu.gif');background-repeat:no-repeat;"  OnClick="appBaidu_Click"></asp:LinkButton>
<asp:LinkButton ID="appKaiXin" ToolTip="开心网" runat="server"  style="background-image:url('/images/kaixin.gif');background-repeat:no-repeat;" onclick="appKaiXin_Click1" ></asp:LinkButton>
<asp:LinkButton ID="appRenRen" ToolTip="人人网" runat="server" style="background-image:url('/images/renren.gif');background-repeat:no-repeat;" onclick="appRenRen_Click1" ></asp:LinkButton>
<asp:LinkButton ID="appNetease" ToolTip="网易" runat="server" style="background-image:url('/images/wangyi.gif');background-repeat:no-repeat;" OnClick="appNetease_Click1" ></asp:LinkButton>
<div class="clearfix"></div>
</div>
</div>
<div style="display:none;"><asp:LinkButton ID="appQQ" runat="server" Style="background-image: url('/App_Themes/AdminDefaultTheme/images/QQ.png'); background-repeat: no-repeat;" OnClick="appQQ_Click"> QQ</asp:LinkButton></div>
</div>
</div>
<div class="col-lg-5 col-md-5 col-sm-5 col-xs-12">
<h4>登录会员中心您将获得：</h4>
<ul class="list-unstyled">
<li>自由发布信息</li>
<li>查看积分与管理空间</li>
<li>设定您的个性化空间</li>
<li>丰富的应用市场和软件</li>
<li>购物支付多彩商务体验</li>
<li>专业的用户中心引领E时代！</li>
<li><asp:HyperLink ID="hlReg" runat="server" NavigateUrl="~/User/login.aspx?RegID=1" title="E-mail登录"><span class="glyphicon glyphicon-envelope"></span></asp:HyperLink> &nbsp; <asp:HyperLink ID="uidReg" runat="server"  NavigateUrl="~/User/login.aspx?RegID=2" title="用户ID登录"><span class="glyphicon glyphicon-align-justify"></span></asp:HyperLink>
</li>
</ul>
</div>
</div>
</div>
</div>
</form>
<style type="text/css">
.codeok{background:url(/Install/images/right.gif) no-repeat #fff;background-position:98% 8px;}
.codeno{background:url(/App_Themes/AdminDefaultTheme/images/error.gif) no-repeat #fff;background-position:98% 8px ;}
</style>
<div id="home_bottom">
 <%Call.Label("{ZL.Label id=\"全站底部\"/}"); %>
</div>
</body>
</html>
<script type="text/javascript">
    $().ready(function () {
        setTimeout("CheckUserCode()", 500);
        $("#VCode").ValidateCode();
    });
QC.Login({
btnId: "qqLoginBtn",
scope: "all",
size: "C_S"
}, function (reqData, opts) {//登录成功
QC.Login.getMe(function (openId, accessToken) {
$.post("/user/AppBack.aspx", { nickName: reqData.nickname, openId: openId,Type:""}, function (data) {
if (data.result == 1)
{
location.href = "/user/default.aspx";   
}
else
{
// alert(data.result);
location.href = "/user/AppBack.aspx?type=QQ&openId=" + openId + "&nickname=" + reqData.nickname;
}
}, "json");
});//获取在线用户的信息           
}, function (opts) {//注销成功
alert('QQ登录 注销成功');
}
);
if (QC.Login.check()) {//如果已登录
//这里可以调用自己的保存接口
//用JS SDK调用OpenAPI获取用户信息
var paras = {};
QC.api("get_user_info", paras)
//指定接口访问成功的接收函数，s为成功返回Response对象
.success(function (s) {
//成功回调，通过s.data获取OpenAPI的返回数据
//alert("获取用户信息成功！当前用户昵称为：" + s.data.nickname);         
})
//指定接口访问失败的接收函数，f为失败返回Response对象
.error(function (f) {
//失败回调      
})
//指定接口完成请求后的接收函数，c为完成请求返回Response对象
.complete(function (c) {
//完成请求回调	    
});
//调用自己的接口，保存信息
//......
}
var a = function (id, str) {
var s = str;
$("#" + id).val(s).css('color', '#999')
.focus(function () { if (this.value == s) { this.value = ''; this.style.color = 'black'; } })
.blur(function () { if (this.value == '') { this.value = s; this.style.color = '#999'; } });
}
$().ready(function ()
{
a('TxtUserName', '用户名');
})
function CheckUserCode() {
    var bl = true;
        $.ajax({
            url: '/API/UserCheck.ashx',
            data: { action: 'CheckKey', uname: $("#TxtUserName").val() },
            type: 'POST',
            success: function (data) {
                if (data=='1') {
                    $("#usercode_li").show();
                    bl = false;
                } else {
                    $("#usercode_li").hide();
                }
            }
        });
    return bl;
}
//检测固顶事件
var IO=document.getElementById('scolls'),Y=IO,H=0,IE6;
IE6=window.ActiveXObject&&!window.XMLHttpRequest;
while(Y){H+=Y.offsetTop;Y=Y.offsetParent};
if(IE6)
    IO.style.cssText="position:absolute;top:expression(this.fix?(document"+
        ".documentElement.scrollTop-(this.javascript||"+H+")):0)";
window.onscroll=function (){
    var d=document,s=Math.max(d.documentElement.scrollTop,document.body.scrollTop);
     if(s>H&&IO.fix||s<=H&&!IO.fix)return;
    if(!IE6)IO.style.position=IO.fix?"":"fixed";        
    IO.fix=!IO.fix;
};
try{document.execCommand("BackgroundImageCache",false,true)}catch(e){};
 //]]>
		

$().ready(function(e) {
    $(".item-list1").addClass("active");
});
</script>