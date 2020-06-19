<%@ page title="" language="C#" masterpagefile="~/User/Default.master" autoeventwireup="true" inherits="User_UserShop_Pay_List, App_Web_byfldukf" clientidmode="Static" validaterequest="false" enableviewstatemac="false" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content ContentPlaceHolderID="head" runat="Server">
    <title>支付信息</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <ol class="breadcrumb">
        <li>您现在的位置：<a title="网站首页" href="/"><%= Call.SiteName%></a></li>
        <li><a title="会员中心" href="/User/Default.aspx">会员中心</a></li>
        <li class="active">支付记录浏览<a href="Pay_Add.aspx">[添加支付平台]</a></li>
    </ol>
    <ZL:ExGridView runat="server" ID="EGV" DataKeyNames="PaymentID" AutoGenerateColumns="false" AllowPaging="true" PageSize="10"  EnableTheming="False"  
                CssClass="table table-striped table-bordered table-hover" EmptyDataText="当前没有信息!!" 
                OnPageIndexChanging="EGV_PageIndexChanging" OnRowCommand="EGV_RowCommand" OnRowDataBound="Egv_RowDataBound" >
        <Columns>
            <asp:BoundField DataField="PaymentID" HeaderText="接口">
                <HeaderStyle Width="6%" />
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="用户">
                <HeaderStyle Width="6%" />
                <ItemTemplate>
                    <%#(Eval("UserID"))%>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:BoundField DataField="PaymentNum" HeaderText="支付序号">
                <HeaderStyle Width="10%" />
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="MoneyPay" HeaderText="金额">
                <HeaderStyle Width="6%" />
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="MoneyTrue" HeaderText="实际金额">
                <HeaderStyle Width="6%" />
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="交易状态">
                <HeaderStyle Width="6%" />
                <ItemTemplate>
                    <%# GetStatus(Eval("Status","{0}"))%>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="处理结果">
                <HeaderStyle Width="6%" />
                <ItemTemplate>
                    <%# GetCStatus(Eval("CStatus","{0}"))%>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="完成时间">
                <HeaderStyle Width="14%" />
                <ItemTemplate>
                    <%# Eval("SuccessTime")%>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
        </Columns>
     <PagerStyle HorizontalAlign="Center" />
    <RowStyle Height="24px" HorizontalAlign="Center"  />
</ZL:ExGridView>
</asp:Content>
