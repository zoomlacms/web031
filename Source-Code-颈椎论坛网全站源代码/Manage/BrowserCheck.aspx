<%@ page language="C#" autoeventwireup="true" inherits="manage_SystemCheck_, App_Web_aq2idg0w" enableviewstatemac="false" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<!DOCTYPE HTML>
<html>
<head runat="server">
<title>浏览器检测</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<!--[if lt IE 9]>
	<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
	<script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
<![endif]-->
<link type="text/css" rel="stylesheet" href="/dist/css/bootstrap.min.css" />
<script type="text/javascript" src="/JS/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="/dist/js/bootstrap.min.js"></script>
    <style type="text/css">
        .info_url a {color:#1370b5;text-decoration:none;}
        .info_url a:hover {color:#ff6600;}
        #mainTB tr td {height:26px;line-height:26px;padding:1px;padding-left:8px;font-size:12px;font-family:'Microsoft YaHei';}
    </style>
</head>
<body>
<form id="form1" runat="server">
<div>
<table id="mainTB" class="table table-striped table-bordered table-hover"> 
    <tr><td style="width:100px">浏览器</td><td><%=browser%></td></tr>
    <tr><td>当前IP</td><td><%=currentIP %></td></tr>
    <tr><td>当前屏幕</td><td><%=currentWindow%>  屏大小：(<script>document.write(window.screen.width+"px,");document.write(window.screen.height+"px");</script>)</td></tr>
    <tr><td>Cookies</td><td><%=cookiesSurrport%></td></tr>
    <tr><td>服务器Mac</td><td id="tdMac" runat="server"></td></tr>
    <tr><td>当前Url</td><td> <asp:Label ID="lbServerName" runat="server" /></td></tr>
    <tr><td>服务器IIS版本</td><td> <asp:Label ID="IISVersion_L"  runat="server" /></td></tr>
    <tr><td>.NET 版本</td><td> <asp:Label ID="NFVersion_L" runat="server" /></td></tr> 
</table>
</div>
 <iframe width="0" height="0" id="nwin1" name="nwin1" src="about:blank" style="display:none;"></iframe>
</form>
</body>
</html>