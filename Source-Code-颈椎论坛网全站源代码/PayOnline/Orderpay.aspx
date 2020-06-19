<%@ page language="C#" autoeventwireup="true" inherits="ZoomLa.WebSite.PayOnline.Orderpay, App_Web_4di12yi2" enableviewstatemac="false" masterpagefile="~/Cart/order.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<title>选择支付平台</title>
<link type="text/css" href="/App_Themes/UserThem/style.css" rel="Stylesheet" />
<link href="/App_Themes/UserThem/user_user.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/JS/jquery.js"></script>
<script type="text/javascript">
    function createImage(a, b,ids) {
        var array = b.split(",");
        ids = ids.split(",");
        console.log(ids);
        console.log(array);
        for (var i = 0; i < array.length ; i++) {
            var image = document.createElement("img");
            image.display = "block";
            var id = array[i];
            image.src = a + id + ".jpg";
            var obj = document.getElementById("td_" + id+"_"+ids[i]);
            $(obj).append(image);
        }
    }
    $(function () {
        $("#DDLPayPlat img").click(function () { $(this).siblings(":radio").click(); });
    })
</script>
    <style type="text/css">
        td img {width:149px;height:39px;}
        .Paylist li{float:left;}
    </style>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <div class="top_pay"><div class="pay_logo"><a href="/"><img src="<%Call.Label("{$LogoUrl/}"); %>" alt=""></a></div></div>
        <div class="pay_select">
            <div class="pay_tab">
                <strong>订单提交成功，请您尽快付款！</strong><br /> 
                订单号:<asp:Label ID="OrderCode" runat="server" Text=""></asp:Label>
                应付金额:<asp:Label ID="TxtvMoney" runat="server" Text="0"></asp:Label>
            </div>
            <table class="border" cellspacing="1" style="margin: auto; width: 100%; margin-top: 10px; height: 180px;">
                <tr class="title">
                    <td style="color: #F60; font-size: 14px;"><strong style="padding-left: 20px;">在线支付操作(选择支付平台)</strong></td>
                </tr>
                <tr class="tdbg">
                    <td style="text-align: center;">
                        <asp:HiddenField ID="nfdmy" runat="server" />
                        <div class="PayPlat_s">
                            
                           
                            <asp:RadioButtonList runat="server" ID="DDLPayPlat" Style="text-align: center; vertical-align: middle; text-align: left;" RepeatDirection="Horizontal" RepeatColumns="4"></asp:RadioButtonList>
                            <asp:Button ID="BtnSubmit" CssClass="i_bottom" runat="server" OnClick="BtnSubmit_Click" />
                            <div class="clear"></div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
  
</asp:Content>
