<%@ page language="C#" title="角色管理" autoeventwireup="true" inherits="User.RoleManage, App_Web_3ilsllhd" enableeventvalidation="false" enableviewstatemac="false" masterpagefile="~/Manage/I/Default.master" viewStateEncryptionMode="Never" %>

<asp:Content runat="server" ContentPlaceHolderID="head">
    <title>角色管理</title>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="Content">
     <ZL:ExGridView runat="server" ID="EGV" AutoGenerateColumns="false" AllowPaging="true" PageSize="10"  EnableTheming="False"  
                CssClass="table table-striped table-bordered table-hover" DataKeyNames="RoleID" 
                OnPageIndexChanging="EGV_PageIndexChanging" OnRowCommand="EGV_RowCommand" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="RoleID" HeaderText="ID">
                <HeaderStyle Width="10%" />
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="RoleName" HeaderText="角色名">
                <HeaderStyle Width="10%" />
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="Description" HeaderText="描述">
                <HeaderStyle Width="50%" />
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="操作">
                <ItemTemplate>
                    <asp:LinkButton ID="Userlist" CommandName="ListRolelist" CommandArgument='<%# Eval("RoleID")%>' runat="server">成员管理</asp:LinkButton>
                    <asp:LinkButton ID="LinkEdit" CommandName="ModifyRole" CommandArgument='<%# Eval("RoleID")%>' runat="server">修改</asp:LinkButton>
                    <asp:LinkButton ID="LnkDel" CommandName="Del" Enabled='<%# Returnuser(Eval("RoleID").ToString()) %>' CommandArgument='<%# Eval("RoleID")%>' OnClientClick="return confirm('您确认删除该记录吗?')" runat="server">删除</asp:LinkButton>
                    <asp:LinkButton ID="LinkButton1" Enabled='<%# Returnuser(Eval("RoleID").ToString()) %>' CommandName="ModifyPower" CommandArgument='<%# Eval("RoleID")%>' runat="server">权限设置</asp:LinkButton>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
        </Columns>
        <PagerStyle HorizontalAlign="Center" />
        <RowStyle Height="24px" HorizontalAlign="Center"  />
</ZL:ExGridView>
    <div class="clearbox"></div>
    <table class="table table-striped table-bordered table-hover">
        <tr class="tdbg">
            <td class="tdbgleft">
                <img src="/Images/notice.gif" align="absmiddle" />&nbsp;<b>说明：超级管理员拥有最高的权限，不能修改其权限，删除该组！</b></td>
        </tr>
    </table>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <script type="text/javascript" src="/JS/ICMS/ZL_Common.js"></script>
</asp:Content>
