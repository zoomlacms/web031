﻿<%@ page language="C#" autoeventwireup="true" inherits="MIS_Target_mailQuote, App_Web_q3wzvw5f" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<!DOCTYPE html>
<html>
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>邮件引用</title>
<link href="/App_Themes/UserThem/Mis.css" type="text/css" rel="stylesheet" />
<script>
    function ProTypes(obj) {
        document.getElementById("ProID").value = obj.value;
    }
    function Cquote() {
        parent.document.getElementById("QuoteContent").style.display = "none";
    }
</script>
</head>
<body>
<form id="mform1" runat="server"> 
<div class="Qutote_Tit">
<span class="rights"><a href="javascript:void(0)" onclick="Cquote()">关闭</a></span>
<asp:Label ID="QTitle" runat="server" Text=""></asp:Label>共<asp:Label ID="tbxMailboxInfo" runat="server"></asp:Label>封
</div>
<div class="Qutote_li">
<%--<div class="search" style="border-bottom:1px dashed #ccc; padding-bottom:10px;"> 
<asp:TextBox ID="TxtKey" CssClass="b_input" runat="server" Text="请输入关键字" Width="260" onclick="setEmpty(this)" onblur="settxt(this)"></asp:TextBox>
<asp:Button ID="Button1" runat="server" Text="" CssClass="bottom_bg" OnClick="Button1_Click" />
</div>--%>
<asp:HiddenField ID="tbxUserMail" runat="server" ></asp:HiddenField> 
<asp:HiddenField ID="txbPassword" runat="server"></asp:HiddenField> 
<asp:HiddenField ID="tbxSmtpServer" runat="server"></asp:HiddenField> 
<asp:HiddenField ID="tbxPOP3Server" runat="server"></asp:HiddenField> 
<ul> 
<asp:Repeater ID="Repeater1" runat="server">
<ItemTemplate>
<li><input type="radio" name="types" onclick="ProTypes(this)"   value="<%#Eval("ID") %>" id='<%#Eval("ID") %>'/>
<a href="ProjectView.aspx?ID=<%#Eval("ID") %>"><%#Eval("MailTitle") %></a> </li>
</ItemTemplate>
</asp:Repeater> 
</ul> 
    <table>
<tr class="tdbg">
    <td class="tdbgleft">共
        <asp:Label ID="Allnum" runat="server" Text=""></asp:Label>
        条信息
        <asp:Label ID="Toppage" runat="server" Text="" />
        <asp:Label ID="Nextpage" runat="server" Text="" />
        <asp:Label ID="Downpage" runat="server" Text="" />
        <asp:Label ID="Endpage" runat="server" Text="" />
        页次：
        <asp:Label ID="Nowpage" runat="server" Text="" />
        /
        <asp:Label ID="PageSize" runat="server" Text="" />
        页
        <asp:Label ID="pagess" runat="server" Text="" />
        条信息/页 转到第
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True"> </asp:DropDownList>
        页 </td>
    </tr>
</table>
<div class="bot_bor"><asp:Button Text="引用"  runat="server" ID="BtnCommit" CssClass="i_bottom"  OnClick="Button1_Click" /></div>
</div>
<asp:HiddenField ID="ProID" runat="server" />
<asp:HiddenField ID="HiddenField1" runat="server" />
</form>
<div id="WirteJs"></div>  
</body>
</html>
