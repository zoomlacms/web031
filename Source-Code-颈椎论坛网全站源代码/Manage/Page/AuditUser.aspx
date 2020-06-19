<%@ page language="C#" autoeventwireup="true" validaterequest="false" enableeventvalidation="false" inherits="manage_Page_AuditUser, App_Web_wkvmzi0r" enableviewstatemac="false" masterpagefile="~/Manage/I/Default.master" viewStateEncryptionMode="Never" %>


<asp:Content runat="server" ContentPlaceHolderID="head">
    <title>查看企业黄页</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <table class="table table-striped table-bordered table-hover">
        <tbody id="Tbody1">
            <tr class="tdbg">
                <td align="center" colspan="2" class="title" style="width:10%">
                    <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
                </td>
            </tr>
                    <tr class="tdbg">
                        <td align="right" class="tdbgleft">用 户 名：</td>
                        <td align="left" class="tdbgright"><asp:TextBox runat="server" ID="UName_T"></asp:TextBox></td>
                    </tr>
                    <tr>
                         <td align="right" class="tdbgleft">首页模板：</td>
                         <td align="left" class="tdbgright"><asp:TextBox runat="server" ID="Template_T" CssClass="form-control" style="display:inline;" />
                              <button type="button" onclick="ShowTList('../Template/TemplateList.aspx?OpenerText=' + escape('Template_T') + '&FilesDir=')" class="btn btn-primary">选择模板</button></td>
                    </tr>
                    <tr id="Tr2" class="tdbg" runat="server">
                        <td align="right" class="tdbgleft" style="width:120px;">企业名称：</td>
                        <td align="left" class="tdbgright"><asp:TextBox runat="server" ID="CompName_T" class="form-control" /></td>
                    </tr>
                    <tr id="Tr4" class="tdbg" runat="server">
                        <td align="right" class="tdbgleft">企业LOGO：</td>
                        <td align="left" class="tdbgright">
                             <asp:TextBox runat="server" ID="Logo_T" class="form-control" />
                        </td>
                    </tr>
                    <tr id="Tr5" class="tdbg" runat="server">
                        <td align="right" class="tdbgleft">
                            企业说明：
                        </td>
                        <td align="left" class="tdbgright">
                             <asp:TextBox runat="server" ID="PageInfo_T" class="form-control" TextMode="MultiLine" style="width:300px;height:200px;" />
                        </td>
                    </tr>
            <tr><td colspan="2"><asp:Literal ID="ModelHtml" runat="server"></asp:Literal></td></tr>
            <asp:Label ID="RegFileds" runat="server" Text=""></asp:Label><tr class="tdbg">
                <td align="center" colspan="2" class="tdbgright" style="height: 24px; width: 100%">
                    <asp:HiddenField ID="HdnID" runat="server" />
                    <asp:HiddenField ID="HdnModel" runat="server" />
                    <asp:Button ID="Button5" CssClass="btn btn-primary" runat="server" Text="修改" OnClick="Button5_Click" />
                    <asp:Button ID="Button4" CssClass="btn btn-primary" runat="server" OnClick="Button4_Click" Text="返回" />
                </td>
            </tr>
        </tbody>
    </table>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <script type="text/javascript" src="/JS/Common.js"></script>
    <script type="text/javascript" src="/JS/DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="/JS/Controls/ZL_Dialog.js"></script>
    <script>
        var diag = new ZL_Dialog();
        function ShowTList(url) {
            diag.title = "选择模板";
            diag.url = url;
            diag.maxbtn = false;
            diag.ShowModal();
        }
        function CloseDialog() {
            diag.CloseModal();
        }
    </script>
</asp:Content>