<%@ page language="C#" autoeventwireup="true" inherits="test, App_Web_laumfnsr" masterpagefile="~/Manage/I/Default.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <style type="text/css">
      .table>tbody>tr>td{padding:0px;}
      .item{cursor:pointer;height:120px;}
      .hid{display:none;}
      .content{height:85px; width: 100%;resize:none;text-align:center;border:none;}
      .itemhead{height: 30px;line-height: 30px; width: 100%; background-color: rgba(0, 0, 0, 0.50); text-align: right; padding-right: 5px; color:white;}
        /*班级*/
        #classul li{float:left;margin-left:5px;}
    </style>
    <title>自动排课</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <div class="panel panel-primary">
        <div class="panel-heading"><span class="glyphicon glyphicon-user"></span><span class="margin_l5">班级选择</span></div>
        <div class="panel-body">
            <ul id="classul">
                <asp:Repeater runat="server" ID="ClassRPT">
                    <ItemTemplate>
                        <li>
                            <label>
                                <input type="radio" value="<%#Eval("GroupID") %>" name="class_rad" />
                                <%#Eval("Regulationame")%></label></li>
                    </ItemTemplate>
                </asp:Repeater>
            </ul>
        </div>
    </div>
    <div id="Set_Div" runat="server">
        时期:
        <asp:TextBox ID="SDate_T" CssClass="form-control td_l" onclick="WdatePicker({ dateFmt: 'yyyy/MM/dd' });" runat="server"></asp:TextBox> - <asp:TextBox ID="EDate_T" runat="server" CssClass="form-control td_l" onclick="WdatePicker({ dateFmt: 'yyyy/MM/dd' });"></asp:TextBox>
        
        <button type="button" class="btn btn-primary" onclick="ShowInfo()">查询班级课表</button>
    </div>
    <div id="Sel_Div" runat="server" visible="false">
        <asp:RadioButtonList id="DateList_R" AutoPostBack="true" OnSelectedIndexChanged="SeachDate_B_Click" runat="server" RepeatDirection="Horizontal">
        </asp:RadioButtonList>
    </div>
    <table class="table table-bordered table-striped margin_t10">
        <tr><td>ID</td><td>教师名</td><td>学科</td><td>职位</td><td>排课</td></tr>
        <ZL:ExRepeater runat="server" ID="Teacher_RPT" PageSize="10" PagePre="<tr><td colspan='5'>" PageEnd="</tr></td>">
            <ItemTemplate>
                <tr>
                    <td class="td_s">
                        <label><input type="checkbox" name="idchk" value="<%#Eval("ID") %>" /><%#Eval("ID") %></label>
                    </td>
                    <td><span id="tname_<%#Eval("ID") %>"><%#Eval("TName")%></span></td>
                    <td><%#Eval("Post") %></td>
                    <td><%#Eval("Teach")%></td>
                    <td>
                        <select id="pktype_<%#Eval("ID") %>"><option value="everyday">每天必排</option><option value="everyweek">每周必排</option></select>
                        <input id="pknum_<%#Eval("id") %>" type="text" value="2" class="text_xs margin_l5" /><span>节课</span>
                    </td>
                </tr>
            </ItemTemplate>
        </ZL:ExRepeater>
        <tr>
            <td colspan="5" style="padding:5px;">
                <input type="button" class="btn btn-primary" value="开始排课" onclick="BeginPK();" />
                <asp:Button runat="server" ID="Save_Btn" CssClass="btn btn-primary" Text="保存" OnClick="Save_Btn_Click" OnClientClick="BeginSave();" /></td>
        </tr>
    </table>
    <table id="maintable" class="table table-bordered">
        <thead style="text-align:center;"><tr><td class="td_s"></td><td>星期一</td><td>星期二</td><td>星期三</td><td>星期四</td><td>星期五</td><td>星期六</td><td>星期日</td></tr></thead>
        <tbody id="courseTable"></tbody>
    </table>
    <asp:HiddenField runat="server" ID="Json_Hid" />
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <script src="/JS/DatePicker/WdatePicker.js"></script>
    <script src="/JS/ICMS/ZL_EDU.js"></script>
    <script src="/JS/Controls/ZL_Dialog.js"></script>
    <script>
        var table = $("#courseTable");
        var config = JSON.parse($("#Json_Hid").val());
        var items = JSON.parse(config.items);//单元格Json
        //var jsontd = { time: "", day: "", num: "", disabled: "", text: "" };
        $(function () {
            InitTable();
        })
        function BeginPK() {
            //检测配置项是否齐全
            $idchk = $("input[name=idchk]:checked");
            if ($idchk.length < 1) {
                alert("请先选定需要排课的教师"); return false;
            }
            //开始读取配置
            var techArr = [];
            for (var i = 0; i < $idchk.length; i++) {
                var tech = { id: "", tname: "", pktype: "", pknum: "" };//ID,排课选项,课数
                tech.id = $idchk[i].value;
                tech.tname = $("#tname_" + tech.id).text();
                tech.pktype = $("#pktype_" + tech.id).val();
                tech.pknum = $("#pknum_" + tech.id).val();
                techArr.push(tech);
            }
            //根据基本配置和教师配置,开始生成排课
            //先暂只实现每天必排,其优先以高,再实现每周必排,如此循环
            if ($("input[name=class_rad]:checked").length < 1) { alert("请先选定班级"); return false; }
            else
            {
                config.class = $("input[name=class_rad]:checked").val();
            }
            items = JSON.parse(config.items);//初始化
            for (var i = 0; i <= config.weekday ; i++) {
                itemday = items.GetDayItem(i); //从第一天开始排
                FinishDayPK(itemday, techArr);//完成排课
            }
            FinishWeekPK(items, techArr);
            InitTable();
        }
        //完成一天的排课,用于每天必排
        function FinishDayPK(itemday, techArr) {
            for (var i = 0; i < techArr.length; i++) {
                PushDayPK(itemday, techArr[i]);
            }
        }
        function PushDayPK(itemday, tech) {
            if (tech.pktype == "everyday") {
                var index = 0;
                for (var i = 0; i < itemday.length && index < tech.pknum ; i++) {
                    if (itemday[i].text != "") continue;//被禁用或已安排,则不处理,跳到下一次
                    else { itemday[i].text = tech.tname; index++; }
                }
            }
        }
        //用于每周必排
        function FinishWeekPK(items, techArr) {
            for (var i = 0; i < techArr.length; i++) {
                PushWeekPK(items, techArr[i]);
            }
        }
        function PushWeekPK(items, tech) {
            if (tech.pktype == "everyweek") {
                var index = 0;
                for (var i = 0; i < items.length && index < tech.pknum ; i++) {
                    if (items[i].text != "") continue;//被禁用或已安排,则不处理,跳到下一次
                    else { items[i].text = tech.tname; index++; }
                }
            }
        }
        function BeginSave()
        {
            config.items = JSON.stringify(items);
            $("#Json_Hid").val(JSON.stringify(config));
            return true;
        }
        //-----------------------
        function SelRad(val) {
            $("input[name=class_rad][value=" + val + "]")[0].checked = true;
        }
        function SelChk(vals) {
            var arr = vals.split(',');
            for (var i = 0; i < arr.length; i++) {
                $("input[name=idchk][value=" + arr[i] + "]")[0].checked = true;
            }
        }
        var infodiag = new ZL_Dialog();
        function ShowInfo() {
            if ($("input[name=class_rad]:checked").length < 1) { alert("请先选定班级"); return; }
            infodiag.title = "班级时期表";
            infodiag.url = "ClassInfo.aspx?id=" + $("input[name=class_rad]:checked").val();
            infodiag.reload = true;
            infodiag.ShowModal();
        }
        function CloseInfo() {
            infodiag.CloseModal();
        }

    </script>
</asp:Content>