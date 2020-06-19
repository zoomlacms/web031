<%@ page language="C#" autoeventwireup="true" inherits="Manage_WorkFlow, App_Web_1unkpe1h" masterpagefile="~/Manage/I/Default.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <title>添加流程</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <div>
        <table class="table table-striped table-bordered">
            <tr>
                <td class="td_m">流程名称：</td>
                <td>
                    <asp:TextBox runat="server" CssClass="form-control" ID="proNameT" MaxLength="30" />
                    <span style="color: #f00">*</span>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="proNameT" runat="server" ErrorMessage="名称不能为空" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>流程分类：</td>
                <td>
                    <asp:DropDownList runat="server" ID="proTypeDP" CssClass="form-control"></asp:DropDownList>
                </td>
            </tr>
            <tr><td>表单类型：</td><td>
                <asp:RadioButtonList runat="server" ID="FormType_Rad" RepeatDirection="Horizontal">
                    <asp:ListItem Value="1" Selected="True">模型表单</asp:ListItem>
                    <asp:ListItem Value="2">Word表单</asp:ListItem>
                    <asp:ListItem Value="3">Excel表单</asp:ListItem>
                </asp:RadioButtonList></td></tr>
            <tr>
                <td>表单模型：</td>
                <td>
                    <asp:TextBox runat="server" ID="FormInfo_T" CssClass="form-control" /><span>请输入表单的内容模型ID,或Word文档ID</span>
                </td>
            </tr>
            <tr>
                <td>使用人员：</td>
                <td>
                    <div class="input-group" style="width: 300px;">
                        <asp:TextBox runat="server" CssClass="form-control" ID="sponsor_T" />
                        <span class="input-group-btn">
                            <input type="button" value="选择" class="btn btn-primary" onclick="ShowUserDiag('sponsor');"/>
                        </span>
                    </div>
                    <asp:HiddenField runat="server" ID="sponsor_Hid" />
                    <%-- <asp:HiddenField runat="server" ID="sponsorGroupD" />--%>
                </td>
            </tr>
            <tr>
                <td>管理人员：</td>
                <td>
                    <div class="input-group" style="width: 300px;">
                        <asp:TextBox runat="server" CssClass="form-control" ID="manager_T" />
                        <asp:HiddenField runat="server" ID="manager_Hid" />
                        <span class="input-group-btn">
                            <input type="button" value="选择" class="btn btn-primary" onclick="ShowUserDiag('manager');" />
                        </span>
                    </div>
                    <asp:HiddenField runat="server" ID="HiddenField1" />
                </td>
            </tr>
            <tr>
                <td>允许附件：</td>
                <td>
                    <asp:DropDownList ID="ddlFlowDoc" CssClass="form-control" Width="80" runat="server">
                        <asp:ListItem Value="1">是</asp:ListItem>
                        <asp:ListItem Value="0">否</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td style="line-height: 60px;">流程说明：</td>
                <td>
                    <asp:TextBox runat="server" ID="remindT" CssClass="form-control" TextMode="MultiLine" Columns="60" Width="300" Height="60px" />
                </td>
            </tr>
            <tr style="display: none;">
                <td>自动文号表达式：</td>
                <td>
                    <input name="txtAutoName" type="text" size="30" id="txtAutoName" class="BigInput" />
                    &nbsp;&nbsp;<a href="javascript:my_tip()">查看说明</a>
                </td>
            </tr>
            <tr id="tip" style="display: none">
                <td>说明：</td>
                <td>表达式中可以使用以下特殊标记：<br>
                    {Y}：表示年 4位的年份<br>
                    {yy}：表示年 不包含纪元的年份，如果不包含纪元的年份小于 10，则显示具有前导0的年份<br>
                    {M}：表示月 一位数的月份没有前导0<br>
                    {mm}：表示月 一位数的月份有一个前导0<br>
                    {D}：月中的某一天,一位数的日期没有前导0<br>
                    {dd}：月中的某一天,一位数的日期有一个前导0<br>
                    {H}：表示时<br>
                    {I}：表示分<br>
                    {S}：表示秒<br>
                    {F}：表示流程名<br>
                    {U}：表示用户姓名<br>
                    {SD}：表示短部门<br>
                    {LD}：表示长部门<br>
                    {R}：表示角色<br>
                    {N}：表示编号，通过 <u>编号计数器</u> 取值并自动增加计数值<br>
                    <br>
                    例如，表达式为：成建委发[{Y}]{N}号，编号位数为4<br>
                    自动生成文号如：成建委发[2006]0001号<br>
                    <br>
                    例如，表达式为：BH{N}，编号位数为3<br>
                    自动生成文号如：BH001<br>
                    <br>
                    例如，表达式为：{F}流程（{Y}年{M}月{D}日{H}:{I}）{U}<br>
                    自动生成文号如：请假流程（2009年1月1日10:30）张三<br>
                    <br>
                    可以不填写自动文号表达式，则系统默认按以下格式，如：<br>
                    请假流程(2009-01-01 10:30)
                </td>
            </tr>
            <tr style="display: none;">
                <td>允许手工输入文号：</td>
                <td>
                    <asp:DropDownList runat="server" ID="flowDP">
                        <asp:ListItem Value="1">允许手工修改文号</asp:ListItem>
                        <asp:ListItem Value="0">不允许手工修改文号</asp:ListItem>
                        <asp:ListItem Value="2">允许在自动文号前输入前缀</asp:ListItem>
                        <asp:ListItem Value="3">允许在自动文号后输入后缀</asp:ListItem>
                        <asp:ListItem Value="4">允许在自动文号前后输入前缀和后缀</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr align="center">
                <td colspan="2">
                    <asp:Button runat="server" ID="saveBtn" CssClass="btn btn-primary" Text="保存" OnClick="saveBtn_Click" />
                    <input type="button" value="返回" class="btn btn-primary" name="back" onclick="history.back();">
                </td>
            </tr>
        </table>
    </div>
    <script src="/JS/Controls/ZL_Dialog.js"></script>
    <script>
        var udiag = new ZL_Dialog();
        udiag.maxbtn = false;
        udiag.backdrop = false;
        function ShowUserDiag(source) {
            udiag.title = "选择用户";
            udiag.url = "/MIS/OA/Mail/SelGroup.aspx?Type=AllInfo#" + source;
            udiag.ShowModal();
        }
        //用户选择回调(后期专门整理为一个插件)
        function UserFunc(json, select) {
            var uname = "", uid = "";
            for (var i = 0; i < json.length; i++) {
                uname += json[i].UserName + ",";
                uid += json[i].UserID + ",";
            }
            if (uid) uid = uid.substring(0, uid.length - 1);
            $("#" + select + "_T").val(uname);
            $("#" + select + "_Hid").val(uid);
            udiag.CloseModal();
        }
    </script>
</asp:Content>
