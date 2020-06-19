﻿<%@ page language="C#" autoeventwireup="true" masterpagefile="~/User/Default.master" inherits="User_UserShop_SelProType, App_Web_0ihne1vk" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<%@ Register Src="WebUserControlTop.ascx" TagName="WebUserControlTop" TagPrefix="uc2" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <title>选择商品类型</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <ol class="breadcrumb" style="margin-bottom:0px;">
        <li>您现在的位置：<a title="网站首页" href="/"><%= Call.SiteName%></a></li>
        <li><a title="会员中心" href="/User/Default.aspx">会员中心</a></li>
        <li class="active">选择商品类别</li>
    </ol>
    <uc2:WebUserControlTop ID="ShopNav" runat="server" />
    <table class="table">
                <tr>
                    <td>
                        <asp:ListBox ID="class0" DataTextField="NodeName" DataValueField="NodeID" CssClass="form-control" runat="server" Height="280px" Width="180px" AutoPostBack="True" OnSelectedIndexChanged="class0_SelectedIndexChanged"></asp:ListBox>
                    </td>
                    <td>
                        <asp:ListBox ID="class1" DataTextField="NodeName" DataValueField="NodeID" CssClass="form-control" runat="server" Height="280px" Width="180px" AutoPostBack="True" OnSelectedIndexChanged="class1_SelectedIndexChanged"></asp:ListBox>
                    </td>
                    <td>
                        <asp:ListBox ID="class2" DataTextField="NodeName" DataValueField="NodeID" CssClass="form-control" runat="server" Height="280px" Width="180px" AutoPostBack="True" OnSelectedIndexChanged="class2_SelectedIndexChanged"></asp:ListBox>
                    </td>
                    <td>
                        <asp:ListBox ID="class3" DataTextField="NodeName" DataValueField="NodeID" CssClass="form-control" runat="server" Height="280px" Width="180px" AutoPostBack="True"></asp:ListBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="4" class="text-center">
                        <a href="" runat="server" id="Add_Href" class="btn btn-primary" >添加商品</a>
                    </td>
                </tr>
            </table>
</asp:Content>


