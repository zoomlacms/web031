<%@ page language="C#" autoeventwireup="true" inherits="manage_User_ServiceSeat, App_Web_twg4402e" enableviewstatemac="false" masterpagefile="~/Manage/I/Default.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>

<asp:Content runat="server" ContentPlaceHolderID="head">
    <title>客服信息</title>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="Content">
    <div>
         <ZL:ExGridView runat="server" ID="EGV" AutoGenerateColumns="false" AllowPaging="true" PageSize="10"  EnableTheming="False" 
                CssClass="table table-striped table-bordered table-hover" EmptyDataText="当前没有信息!!" DataKeyNames="S_ID" >      
            <Columns>
                <asp:BoundField DataField="S_ID" HeaderText="编号" ItemStyle-HorizontalAlign="Center" />
                <asp:TemplateField HeaderText="席位名称" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate><%#DataBinder.Eval(Container.DataItem, "S_Name")%> </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="管理员" ItemStyle-HorizontalAlign="Center" ItemStyle-Height="26px" HeaderStyle-Height="26px">
                    <ItemTemplate><%#GetAdminName(DataBinder.Eval(Container.DataItem, "S_AdminID").ToString())%> </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="显示位置" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate><%#DataBinder.Eval(Container.DataItem, "S_Index")%> </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="默认客服" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate><%#(DataBinder.Eval(Container.DataItem, "S_Default","{0}") == "1") ? "是" : "否"%> </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="操作" HeaderStyle-Width="200px" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbtEdit" runat="server" OnClick="lbtEdit_Click">修改</asp:LinkButton>
                        |
                        <asp:LinkButton ID="lbtDel" runat="server" OnClick="lbtDel_Click" OnClientClick="javascript:return confirm('你确定要删除这个客服席位吗？')">删除</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </ZL:ExGridView>
    </div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <script type="text/javascript" src="/js/Common.js"></script>
</asp:Content>
