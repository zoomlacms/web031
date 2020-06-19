<%@ page language="C#" autoeventwireup="true" validaterequest="false" inherits="BBS_GuestShow, App_Web_aiy0erar" enableviewstatemac="false" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>阅读留言-<%Call.Label("{$SiteName/}"); %>留言</title>
    <script type="text/javascript" src="/JS/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="/dist/js/bootstrap.min.js"></script>
<link type="text/css" href="/dist/css/bootstrap.min.css" rel="stylesheet" />
<link type="text/css" href="/dist/css/font-awesome.min.css" rel="stylesheet"/>
<link href="../../App_Themes/UserThem/style.css"rel="stylesheet" type="text/css" />
<link href="../../App_Themes/UserThem/user_user.css" rel="stylesheet" type="text/css" />
<link href="../../App_Themes/AdminDefaultTheme/main.css" type="text/css" rel="stylesheet" /> 
<link href="../../App_Themes/Guest/ask.css" rel="stylesheet" type="text/css" />
    <link href="/App_Themes/Guest/bar.css" rel="stylesheet" type="text/css" />
<script src="/Plugins/Ckeditor/ckeditor.js" type="text/javascript"></script>
<script src="/JS/jquery.js" type="text/javascript"></script>
<script src="/JS/ZL_ValidateCode.js"></script>
<script type="text/javascript" charset="utf-8" src="/Plugins/Ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="/Plugins/Ueditor/ueditor.all.min.js"></script> 
<script>
    $(function(){
        $("#VCode").ValidateCode();
    })
function CheckDirty() {
	var value = Date.now;
	var TxtValidateCode = document.getElementById("VCode").value;

	if (value == "" || TxtValidateCode == "") {
		if (value == "") {
			var obj2 = document.getElementById("sp2");
			obj2.innerHTML = "<font color='red'>回复内容不能为空！</font>";
		}
		else {
			var obj2 = document.getElementById("sp2");
			obj2.innerHTML = "";
		}
		if (TxtValidateCode == "") {
			var obj3 = document.getElementById("sp1");
			obj3.innerHTML = "<font color='red'>验证码不能为空！</font>";
		} else {
			var obj3 = document.getElementById("sp1");
			obj3.innerHTML = "";
		}
		return false;
	}
	else {
		var obj = document.getElementById("sp2");
		obj.innerHTML = "";
		var obj3 = document.getElementById("sp1");
		obj3.innerHTML = "";
		return true;
	}
}
</script>
<style>
#Tab li { float:left; margin-left:10px; margin-right:10px;}
#Tab li a { color:#fff; }
#divshap{ position:absolute; width:100%; height:100%; background:#ccc;  filter:alpha(opacity=50); -moz-opacity:0.5; -khtml-opacity: 0.5; opacity:0.5;margin:0 auto;text-align:center; line-height:200px;z-index:999px;}
#divshap strong{ z-index:2; font-size:14px; color:#f00;}
.tdbg{ padding-left:5px;}
.h_mid_m { margin-top:30px;}
</style>
</head>
<body>

<form id="form1" runat="server">
<div id="ask_top">
  <div class="container">
    <div class="row">
      <div class="col-lg-7 col-md-7 col-sm-12 col-xs-12">
        <div class="ask_top_l">
          <ul class="list-inline">
            <li><a onclick="this.style.behavior='url(#default#homepage)';this.setHomePage('{$SiteURL/}');" href="javascript:;">设为首页</a></li>
            <li><a href="javascript:;" hrehtype="button" id="dropdownMenu1" data-toggle="dropdown">官网频道<span class="caret"></span></a>
              <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
                <%Call.Label("{ZL.Label id=\"输出根节点下一级栏目列表\" ShowNum=\"8\" /}");%>
              </ul>
            </li>
          </ul>
        </div>
      </div>
      <div class="col-lg-5 col-md-5 col-sm-12 col-xs-12">
        <div class="ask_top_r">
          <ul class="list-inline">
            <li><i class="fa fa-graduation-cap"></i><a href="/Baike" >百科</a></li>
            <li><i class="fa fa-envelope"></i><a href="/Guest">留言</a></li>
            <li><i class="fa fa-question-circle"></i><a href="/Ask">问答</a></li>
            <li><i class="fa fa-paw"></i><a href="/Index" >贴吧</a></li>
            <li>
              <div class="dropdown"> <a id="dLabel" data-target="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <asp:Label runat="server" ID="Label1"></asp:Label>
                </a><span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
                  <li role="presentation"><a role="menuitem" tabindex="-1" href="/User/" target="_blank">我的空间</a></li>
                  <li role="presentation"><a role="menuitem" tabindex="-1" href="/User/" target="_blank">我的帖子</a></li>
                  <li role="presentation"><a role="menuitem" tabindex="-1" href="/User/Content/MyFavori.aspx" target="_blank">我的喜欢</a></li>
                  <li role="presentation"><a role="menuitem" tabindex="-1" href="/User/" target="_blank">我的关注</a></li>
                  <li role="presentation"><a role="menuitem" tabindex="-1" href="/User/" target="_blank">我的投票</a></li>
                  <li role="presentation"><a role="menuitem" tabindex="-1" href="/User/Info/UserBase.aspx" target="_blank">个人设置</a></li>
                  <li role="presentation"><a role="menuitem" tabindex="-1" href="/user/Logout.aspx">安全退出</a></li>
                </ul>
              </div>
            </li>
            <li style="<%=getstyles()%>"><a href="/User/Login.aspx?ReturnUrl=/guest/" target="_blank">登录</a>|<a href="/User/Register.aspx?ReturnUrl=/Guest/" target="_blank">注册</a></li>
          </ul>
        </div>
      </div>
      <div class="clearfix"></div>
    </div>
  </div>
</div>         
    <div class="header">
        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 h_top">
            <div class="logo" >
                <a href="/guest/Message/" title="留言系统" target="_top"><img src="<%Call.Label("{$LogoUrl/}"); %>" alt="<%Call.Label("{$SiteName/}"); %>留言系统" /> </a>
            </div>
            <div class="clr"></div>
        </div>
        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 h_mid">
            <div class="h_mid_l"> </div> 
<div id="tdh" class="h_mid_m">
<ul class="list-inline"> 
<li class="on"><a href="Default.aspx" title="留言首页">留言首页</a></li>
<asp:Repeater ID="Repeater2" runat="server"><ItemTemplate> <li  > <%#GetDataItem()%>  </li> </ItemTemplate></asp:Repeater> 
</ul> 
</div>
<div class="h_mid_r"></div>
</div>
</div>
<div class="clearfix"></div>
<div class="container content">
<div class="dh">您的位置：<a href="/">网站首页</a>>><a href="/guest/">留言中心</a>>>查看留言</span></div></div>
<div id="main">
 
  <div class="s_body">
    <div id="g_show">
      <asp:Repeater ID="Repeater1" runat="server">
        <ItemTemplate>
          <h1><span>[发布者：<%# GetUserName(Eval("UserID","{0}")) %>]</span>留言标题：<%# Eval("Title")%></h1>
          <div class="g_show_txt"><%# Eval("TContent")%><span>发表日期：<%# Eval("GDate")%></span></div>
        </ItemTemplate>
      </asp:Repeater>
    </div>
    <div id="Pager1" runat="server"></div>
    <!--留言分页 -->
      <div id="g_send" class="rg_inout">
          <span id="banAnony" style="color: red; margin-left: 10px;" runat="server" visible="false">你好请先登录，再发布留言!<a href="/user/Login.aspx?ReturnUrl=/guest/" style="color: #133db6;">[点击登录]</a></span>
          <div id="replyDiv" runat="server">
              <h2>发表回复:</h2>
              <div id="g_send_edit">
                  <table width="98%" align="center">
                      <tr><td colspan="2"><textarea cols="80" id="TxtContents" width="580px" height="200px" name="TxtTContent" rows="10" runat="server"></textarea>
                              <span id="sp2"></span>
                              <%=Call.GetUEditor("TxtTContent") %>
                              <input type="hidden" id="txt_Config\" value="" />
                              <asp:TextBox ID="FilePicPath" runat="server" Text="fbangd" Style="display: none"></asp:TextBox>
                              <asp:HiddenField ID="HdnCateID" runat="server" />
                              <asp:HiddenField ID="HdnGID" runat="server" />
                          </td>
                      </tr>
                      <tr>
                          <td width="10%" align="right">验证码：</td>
                          <td align="left">
                              <asp:TextBox ID="VCode" MaxLength="6" runat="server" Style="width: 70px; border: #CCC solid 1px; height: 20px; line-height: 23px;" autocomplete="off" />
                              <img id="VCode_img" title="点击刷新验证码" class="code"  style="height:34px;"/>
                              <input type="hidden" id="VCode_hid" name="VCode_hid" />
                          </td>
                      </tr>
                      <tr>
                          <td colspan="2" align="center">
                              <asp:Button ID="Button1" CssClass="i_bottom" runat="server" Text="发表回复" OnClick="Button1_Click" OnClientClick="return CheckDirty()" Style="margin-top: 10px;" /></td>
                      </tr>
                  </table>

              </div>
</div><!--replyDiv end-->
</div>

</div>
<div id="bottom">
<p>Copyright &copy; 
<script language="javascript" type="text/javascript"> 
<!-- 
var year="";
mydate=new Date();
myyear=mydate.getYear();
year=(myyear > 200) ? myyear : 1900 + myyear;
document.write(year); 
--> 
</script> <%Call.Label("{$SiteName/}"); %> All rights reserved.</p>
</div>
</form>
</body>
</html>