<%@ page title="" language="C#" masterpagefile="~/User/Default.master" autoeventwireup="true" inherits="User_Default, App_Web_okhj5ffc" clientidmode="Static" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>会员中心</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <div class="row user_div padding5" style="margin-top:0;">
        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 padding10">
            <div style="background:#27a9e3" class="user_base">
                <a href="/User/Order/PreViewOrder1.aspx?menu=Orderinfo">购买的医生</a>
            </div>
        </div>
        <div class="col-lg-4 col-md-3 col-sm-12 col-xs-12">
            <div style="background:#27a9e3" class="user_base">
                <a href="/User/Order/PreViewOrder.aspx?menu=Orderinfo">订单管理</a>
            </div>
        </div>        
        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 padding10">
            <div style="background:#a43ae3" class="user_base">
                <a href="Info/Listprofit.aspx">财务管理</a>
            </div>
        </div>
        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 padding10">
            <div style="background:#c47f3e" class="user_base">
                <a href="Info/UserInfo.aspx">我的信息</a>
            </div>
        </div>
        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 padding10">
            <div style="background:#669933" class="user_base">
                <a href="Content/MyContent.aspx">内容管理</a>
            </div>
        </div>
        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 padding10">
            <div style="background:#990066 " class="user_base">
                <a href="/User/UserShop/Default.aspx">商城管理</a>
            </div>
        </div>
        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 padding10">
            <div style="background:#9900FF" class="user_base">
                <a href="iServer/FiServer.aspx">有问必答</a>
            </div>
        </div>
    </div>
</asp:Content>