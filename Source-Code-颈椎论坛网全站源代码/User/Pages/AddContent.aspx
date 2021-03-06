﻿<%@ page language="C#" autoeventwireup="true" validaterequest="false" inherits="ZoomLa.WebSite.User.Content.AddContent, App_Web_v3rgrt44" enableviewstatemac="false" enableEventValidation="false" viewStateEncryptionMode="Never" %>

<!DOCTYPE HTML>
<html>
<head runat="server">
    <title>添加内容</title>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
    <link type="text/css" rel="stylesheet" href="/dist/css/bootstrap.min.css" />
    <link type="text/css" rel="stylesheet" href="/App_Themes/ICMS/User_V3.css" />
    <script type="text/javascript" src="/JS/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="/dist/js/bootstrap.min.js"></script>
    <script src="/js/Common.js" type="text/javascript"></script>
    <script type="text/javascript" charset="utf-8" src="/Plugins/Ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="/Plugins/Ueditor/ueditor.all.min.js"></script>
    <script type="text/javascript" src="/JS/DatePicker/WdatePicker.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <ol class="breadcrumb">
            <li>
                <asp:Label ID="lblNodeName" runat="server" Text="Label"></asp:Label>
            </li>
            <li>
                添加内容：<asp:Label ID="lblAddContent" runat="server" Text="Label"></asp:Label>
            </li>
        </ol>
        <div>
            <table class="table table-bordered table-hover table-striped">
                <tr>
                    <td colspan="2" class=" text-center">
                        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>所属节点：</td>
                    <td>
                        <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>内容标题：</td>
                    <td>
                        <asp:TextBox ID="txtTitle" runat="server" Text='' CssClass="form-control" MaxLength="30"></asp:TextBox>
                        <span><font color="red">*</font></span>&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1"
                            runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="txtTitle">内容标题必填</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <asp:Literal ID="ModelHtml" runat="server"></asp:Literal>
                <tr>
                    <td colspan="2" class="text-center">
                        <asp:HiddenField ID="HdnNode" runat="server" />
                        <asp:HiddenField ID="HdnModel" runat="server" />
                        <asp:TextBox ID="FilePicPath" runat="server" Text="fbangd" Style="display: none"></asp:TextBox>
                        <asp:Button ID="EBtnSubmit" Text="添加项目" CssClass="btn btn-primary" OnClick="EBtnSubmit_Click" runat="server" />
                        <asp:Button ID="BtnBack" CssClass="btn btn-primary" runat="server" Text="返　回" OnClick="BtnBack_Click" UseSubmitBehavior="False" CausesValidation="False" />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
