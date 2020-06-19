<%@ page language="C#" autoeventwireup="true" inherits="Manage_User_DepositManage, App_Web_twg4402e" masterpagefile="~/Manage/I/Default.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <title>提现管理</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <table class="table table-striped table-bordered table-hover">
        <tr>
            <td></td>
            <td>ID</td>
            <td>用户名</td>
            <td>提现金额</td>
            <td>提现状态</td>
            <td>备注</td>
            <td>管理员备注</td>
            <td>操作</td>
        </tr>
        <ZL:ExRepeater ID="Deposit_RPT" runat="server" OnItemCommand="Deposit_RPT_ItemCommand" PageSize="10" PagePre="<tr id='page_tr'><td><input type='checkbox' id='chkAll'/></td><td colspan='10' id='page_td'>" PageEnd="</td></tr>">
            <ItemTemplate>
                <tr>
                    <td><input type="checkbox" name="idchk" value="<%#Eval("ID") %>" /></td>
                    <td><%#Eval("ID") %></td>
                    <td><a href="javascript:;" onclick="ShowUserDiag(<%#Eval("UserID") %>)"><%#GetUserName() %></a><input type="hidden" name="uname_hid" value="<%#GetUserName() %>" /></td>
                    <td><%#Eval("Str1") %><input type="hidden" name="price_hid" value="<%#Eval("Str1") %>" /></td>
                    <td><%#GetStatus() %></td>
                    <td><%#Eval("Describe") %></td>
                    <td><%#Eval("Str4") %></td>
                    <td>
                        <asp:Button runat="server" CommandName="Check" Text="确认" style="display:none;" CommandArgument='<%#Eval("ID") %>'></asp:Button>
                        <%#GetOP() %>
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate></FooterTemplate>
        </ZL:ExRepeater>
    </table>
    <div id="backdepos_div" style="display:none;">
        <table class="table table-striped table-bordered table-hover">
            <tr>
                <td style="width:15%" class="text-right">用户名：</td>
                <td><span id="uname_span"></span></td>
            </tr>
            <tr>
                <td class="text-right">将返回金额：</td>
                <td><span id="price_span"></span> (拒绝后此金额将退回给用户)</td>
            </tr>
            <tr>
                <td class="text-right">拒绝理由：</td>
                <td><asp:TextBox ID="BackDecs_T" runat="server" TextMode="MultiLine" Rows="5" CssClass="form-control"></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="2" class="text-center">
                    <asp:HiddenField ID="backID_Hid" runat="server" />
                    <asp:Button ID="BackDe_Btn" CssClass="btn btn-primary" OnClick="BackDe_B_Click" runat="server" Text="确定" />
                    <button type="button" onclick="CloseBack()" class="btn btn-primary">取消</button>
                </td>
            </tr>
        </table>
    </div>
    <asp:Button ID="CheckDepos_B" CssClass="btn btn-primary" runat="server" OnClick="CheckDepos_B_Click" Text="批量确认" />
    <script type="text/javascript" src="/JS/SelectCheckBox.js"></script>
    <script type="text/javascript" src="/JS/ICMS/ZL_Common.js"></script>
    <script type="text/javascript" src="/JS/Controls/ZL_Dialog.js"></script>
    <script>
        $().ready(function () {
            $("#chkAll").click(function () {//EGV 全选
                selectAllByName(this, "idchk");
            });
        });
        var userDiag = new ZL_Dialog();
        function ShowUserDiag(uid) {
            userDiag.title = "用户信息";
            userDiag.url = "Userinfo.aspx?id=" + uid;
            userDiag.ShowModal();
        }
        var backDiag = new ZL_Dialog();
        function ShowBack(id,obj) {
            backDiag.title = "拒绝理由";
            backDiag.content = "backdepos_div";
            backDiag.ShowModal();
            $("#backID_Hid").val(id);
            $("#BackDecs_T").val("");
            var curdata = $(obj).parent().parent();
            $("#uname_span").text($(curdata).find("[name=uname_hid]").val());
            var price = parseInt($(curdata).find("[name=price_hid]").val());
            $("#price_span").text(price+"+"+(price*0.1)+"="+(price+(price*0.1)));
        }
        function CloseBack() {
            backDiag.CloseModal();
        }
        function checkFunc(obj) {
            $(obj).prev().click();
        }
    </script>
</asp:Content>
