<%@ page language="C#" responseencoding="utf-8" autoeventwireup="true" inherits="ZoomLa.WebSite.Shop.PayOnline, App_Web_yz3pemee" enableviewstatemac="false" enableEventValidation="false" viewStateEncryptionMode="Never" %><!DOCTYPE HTML>
<html>
<head runat="server">
<title>在线支付</title>
<link type="text/css" href="/App_Themes/UserThem/style.css" rel="Stylesheet" />
<link href="/App_Themes/UserThem/user_user.css" rel="stylesheet" type="text/css" />
<style type="text/css">.PayPlat_s{ line-height:25px;}</style>
<script type="text/javascript" src="/JS/jquery-1.11.0.min.js"></script>
<script src="/dist/js/bootstrap.min.js"></script>
<link href="/dist/css/bootstrap.min.css" rel="stylesheet"/>
<link href="/dist/css/font-awesome.min.css" rel="stylesheet"/>
<link href="/App_Themes/ICMS/order.css" rel="stylesheet" />
<style type="text/css">
  .paytable{margin: auto; width:100%; margin-top: 10px; height: 180px;}
</style>
</head>
<body style=" background:none">
<asp:PlaceHolder ID="form1" runat="server">
<div style=" position:relative; width:950px; margin:auto;"> 
  <table class="paytable" id="display1"  runat="server">
  <tr><td><div class="top_pay"><div class="pay_logo"><a href="/"><img src="<%:Call.LogoUrl %>"></a></div></div></td></tr>
    <tr class="title">
      <td>
      <div class="pay_select">
    <div class="pay_tab" id="pay_con">
    <strong>订单提交成功，请您尽快付款！</strong><br/>
    订单号:<asp:Label ID="LblOid" runat="server"></asp:Label>&nbsp;&nbsp;
    应付金额：<span><asp:Label ID="LblPayMoney" runat="server"></asp:Label></span><br/>
    <asp:Label Text="手续费：" ID="Fee" runat="server"></asp:Label><asp:Label ID="LblRate" runat="server"></asp:Label><div id="RateTips" runat="server"></div>
     </div>
    <div class="PayPlat_s">
    <p>请选择在线支付的方式：<br/>
       <asp:Label ID="Plat" Text="支付平台：" runat="server"></asp:Label>
       <asp:Label ID="LblPayPlatform" runat="server"></asp:Label><a href="javascript:;" onclick="ShowPayDiag()" style="margin-left:10px;">重新选择</a>
    </p>
    <div id="divComm" runat="server"  ></div>
       <asp:Label ID="jhBankCode" runat="server"></asp:Label>  
       <asp:Label ID="LblHiddenValue" runat="server" CssClass="fleft" Visible="false"></asp:Label>  
    </div>   
    <span style="display:none"><asp:Label ID="Titles" runat="server"><strong>在线支付操作（确认支付款项)</strong></asp:Label></span>
    </td></tr>
    <tr>
      <td class="tdbg">
        <div class="p_center">
          <table width="500" cellspacing="1" cellpadding="2">
            <tr class="tdbg">
                <td align="right"> </td>
                <td align="left"></td>
            </tr>
            <tr class="tdbg" id="Paymoney" visible="false" runat="server" style=" color:Red; display:none">
                <td align="right" style=" font-size:20px; font-weight:bolder;">支付金额：</td>
                <td align="left"><asp:Label ID="Label1" Font-Size="20px" runat="server"></asp:Label></td>
            </tr>
            <tr class="tdbg" id="Paymoney2" runat="server" style="display:none">
                <td align="right">支付金额：</td>
                <td align="left"></td>
            </tr>
            <tr class="tdbg" id="ActualAmount1" runat="server" style="display:none">
                <td align="right">：</td>
                <td align="left"> </td>
            </tr>
            <tr class="tdbg" id="aa" runat="server" style="display:none">
                <td colspan="2" align="center" style="height: 38px;"><strong>点击“确认支付”按钮后，将进入在线支付界面。</strong></td>
            </tr>
            <tr class="tdbg" id="bb" runat="server">
                <td colspan="5" align="center" style="height: 38px; padding-left: 140px;"></td>
            </tr>
          </table>
        </div>
      </td>
    </tr>
  </table>
  <table class="paytable" id="display2" runat="server">
    <tr><td><div class="top_pay"><div class="pay_logo"><img src="<%:Call.LogoUrl %>"></div></div></td></tr>
    <tr>
        <td class="tdbg">
            <div class="p_center">
                <div class="pay_select">
                    <div class="pay_tab"><strong>恭喜您，下单成功！</strong><br /><b>确 认 款 项</b></div>
                    <div class="PayPlat_s" style="margin-top: 10px;">
                        支付方式：<asp:Label ID="zfpt" runat="server"></asp:Label><br />
                        订单号：<asp:Label ID="ddh" runat="server"></asp:Label><br />
                        支付金额：<asp:Label ID="zfje" runat="server" Text="0"></asp:Label><br />
                        <asp:Label ID="fees" runat="server" Text="手续费："></asp:Label><asp:Label ID="sxf" runat="server"></asp:Label><br />
                        <table width="500" cellspacing="1" cellpadding="2" style="display: none">
                            <tr class="tdbg" id="ActualAmount" runat="server">
                                <td align="right">实际金额： </td>
                                <td align="left">
                                    <asp:Label ID="sjhbje" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <asp:Literal runat="server" ID="remindHtml" EnableViewState="false"></asp:Literal>
                        </table>
                        <input id="bt2"  type="button" class="btn btn-primary" value="返回首页" onclick="window.location.href = '/Default.aspx'" />
                    </div>
                </div>
            </div>
        </td>
    </tr>
</table>
  <div style=" position:absolute; top:310px; left:0px;">
      <form id="Form2" runat="server">
          <asp:Button runat="server" ID="Sure_Btn" Visible="false" Text="确定支付" OnClick="Confirm_Click" />
          <div id="SecPwd" runat="server" style="position: absolute; top: -115px; left: 78px; width: 300px;" visible="false">请输入二级密码:<asp:TextBox ID="Second" runat="server" TextMode="Password" /></div>
          <asp:Button Text="确认支付" ID="Confirm" runat="server" OnClick="Confirm_Click" />
          <span style="display: none">
              <input type="button" id="Cancel" value="取消支付" class="i_bottom" runat="server" onclick="javascript: history.back()" /></span>
          <table class="border" visible="false" style="margin: auto; text-align: center;" cellspacing="1" id="Table1" runat="server">
              <tr class="title">
                  <td><strong>选择支付方式！</strong></td>
              </tr>
              <tr>
                  <td>
                      <asp:RadioButtonList ID="Payment" runat="server" RepeatDirection="Horizontal">
                          <asp:ListItem Value="Purse" Selected="True"> 金币</asp:ListItem>
                          <asp:ListItem Value="SilverCoin"> 银币</asp:ListItem>
                      </asp:RadioButtonList>
                  </td>
              </tr>
          </table>
      </form>
  </div>
</div> 
</asp:PlaceHolder>
    <div id="paytype_div" style="display:none;">
        <p><i class="fa fa-credit-card strong"> 支付方式</i></p>
            <div class="indent">
                <ul class="methodul">
                    <li runat="server" id="onlinepayli" class="active" title="支付宝,银联等在线支付"><i class="fa fa-rmb">在线支付</i><input type="radio" class="hidden" name="method_rad" value="1" /></li>
                    <li runat="server" id="purseli" title="用户余额支付"><i class="fa fa-credit-card">余额支付</i><input type="radio" class="hidden" name="method_rad" value="2" /></li>
                    <li runat="server" id="silverli" title="用户银币支付"><i class="fa fa-rouble">银币支付</i><input type="radio" class="hidden" name="method_rad" value="3" /></li>
                    <li runat="server" id="scoreli" title="用户积分支付" visible="false"><i class="fa fa-money">积分支付</i><input type="radio" class="hidden" name="method_rad" value="4" /></li>
                </ul>
                <div class="clearfix"></div>
            </div>
        <div class="margin_t5 text-center">
        <button type="button" class="btn btn-default" onclick="returnPayUrl()">确定</button>
        <button type="button" class="btn btn-default" onclick="ClosePayDiag();">取消</button>
    </div>
    </div>
    <script type="text/javascript" src="/JS/Controls/ZL_Dialog.js"></script>
    <script>
        var payDiag = new ZL_Dialog();
        function ShowPayDiag() {
            payDiag.title = "选择支付方式";
            payDiag.content = "paytype_div";
            payDiag.ShowModal();
            $(".methodul li").click(function () {
                $(this).siblings().removeClass("active");
                $(this).addClass("active");
                $(this).find(":radio")[0].checked = true;
            })
            $(".methodul li:first").click();
        }
        function ClosePayDiag() {
            payDiag.CloseModal();
        }
        function jumpurl(url) {
            location.href = url;
        }
        
        function returnPayUrl() {
            var paytype = $("input[type='radio']:checked").val();
            var method = "";
            switch (paytype) {
                case '1':
                    method = "";
                    break;
                case '2':
                    method = "Purse";
                    break;
                case '3':
                    method = "SilverCoin";
                    break;
            }
            if (method == "")
                jumpurl("/PayOnline/Orderpay.aspx?OrderCode=<%=OrderCode %>");
            else
                jumpurl("/PayOnline/PayOnline.aspx?Method=" + method + "&OrderCode=<%=OrderCode %>");
        }
    </script>
</body>
</html>