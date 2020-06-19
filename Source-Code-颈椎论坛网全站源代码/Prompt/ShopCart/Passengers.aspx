<%@ page language="C#" autoeventwireup="true" inherits="Prompt_ShopCart_Passengers, App_Web_oolontvc" masterpagefile="~/Cart/order.master" enableviewstatemac="false" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <script src="/JS/ZL_Regex.js"></script>
    <title>信息补充</title>
    </asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <div class="head_div">
         <a href="/"><img src="<%=Call.LogoUrl %>" class="margin_l5" /></a>
        <div class="input-group pull-right skey_div">
            <input type="text" id="skey_t" placeholder="商品搜索" class="form-control skey_t" />
            <span class="input-group-btn">
                <input type="button" value="搜索" class="btn btn-default" onclick="skey();" />
            </span>
        </div>
    </div>
    <div class="container">
        <div class="panel panel-primary">
          <div class="panel-heading"><span class="glyphicon glyphicon-plane"></span><span class="margin_l5">旅游路线</span></div>
          <div class="panel-body">
              <table class="table table-bordered">
        <tr><td>旅游线路</td><td>出发时间</td><td>备注</td><td>单价</td><td>人数</td><td>合计</td></tr>
        <asp:Repeater runat="server" ID="ProList_RPT">
            <ItemTemplate>
                <tr><td><%#Eval("ProName") %></td>
                <td><%#Eval("GoDate","{0:yyyy年MM月dd日 HH:mm}") %></td>
                <td><%#Eval("Remind") %></td>
                <td><%#Eval("Price","{0:f2}") %></td>
                <td><%#Eval("ProNum") %></td>
                <td><%#Eval("AllMoney","{0:f2}") %></td></tr>
            </ItemTemplate>
        </asp:Repeater>
        <tr><td colspan="6"><span>总计:</span><span runat="server" id="AllMoney_sp" class="r_red_mid"></span></td></tr>
    </table>
          </div></div>
  <%--  <div><strong>保险数量:</strong><asp:TextBox runat="server" ID="Safenum_T" CssClass="form-control" /></div>--%>
    <div class="panel panel-primary">
        <div class="panel-heading"><span class="glyphicon glyphicon-user"></span><span class="margin_l5">旅客信息</span></div>
        <div class="panel-body">
            <ul id="user_ul">
        <li>
            <table class='table table-bordered'>
                <tr><td rowspan='2' class='r_green_mid min'>旅客<span class='num'>1</span></td><td><input type='text' class='form-control required' name='name_t_1' placeholder='姓名' />
                    <span class='btn btn-default glyphicon glyphicon-plus' onclick='AddGuest();'></span></td></tr>
                <tr><td><select name='certtype_sel_1' class='form-control min selnum'>
                    <option value='1' selected='selected'>身份证</option>
                    <option value='2'>护照</option>
                    <option value='3'>学生证</option>
                    <option value="4">其它证件</option>
                        </select><input type='text' class='form-control margin_l5 required digits IDCards' name='certcode_t_1' placeholder='证件号' /></td></tr>
            </table>
        </li>
    </ul></div></div>
     <div class="panel panel-primary">
          <div class="panel-heading"><span class="glyphicon glyphicon-user"></span><span class="margin_l5">联系人信息</span></div>
          <div class="panel-body">
              <table class="table table-bordered">
         <tr><td class="tdleft">姓名:</td><td><input type="text" class="form-control required" name="c_name_t" /></td></tr>
         <tr><td>手机:</td><td><input type="text" class="form-control required phones" name="c_mobile_t" /></td></tr>
         <tr><td>地址:</td><td><input type="text" class="form-control required" name="c_address_t" /></td></tr>
         <tr><td></td><td><asp:Button runat="server" ID="Save_Btn" OnClick="Save_Btn_Click" Text="预订" CssClass="btn btn-primary" OnClientClick="return CheckSubmit();" /></td></tr>
    </table>
              </div></div>
    </div>
     
    <input type="hidden" id="Pros_Hid" name="Pros_Hid" />
    <input type="hidden" id="Guest_Hid" name="Guest_Hid"/>
    <input type="hidden" id="Contract_Hid" name="Contract_Hid"/>
    <!--修改时调用-->
    <input type="hidden" id="Guest_Hid2" runat="server" />
    <input type="hidden" id="Contract_Hid2" runat="server" />
    <input type="hidden" id="IDS_Hid" runat="server" />
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <style type="text/css">
       .tdleft{width:120px;}
       .panel-primary{margin-top:10px;}
    </style>
    <script type="text/javascript" src="/JS/jquery.validate.min.js"></script>
    <script>
        $(function () {
            $("#Pros_Hid").val('<%=Pros%>');
            $(".selnum").change(function () {
                if ($(this).val() != '1')
                    $(this).next().removeClass("IDCards");
                else
                    $(this).next().addClass("IDCards");
            });

            jQuery.validator.addMethod("IDCards", function (value) {
                return ZL_Regex.isIDCard(value);
            }, "请输入正确的证件号码！");
            jQuery.validator.addMethod("phones", function (value) {
                return ZL_Regex.isMobilePhone(value);
            }, "请输入正确的手机号码！");
            FillGuest();
            FillContract();
            $("form").validate({});
        });
        var addTlp = "<li><table class='table table-bordered'>"
        + "<tr><td rowspan='2' class='r_green_mid min'>旅客<span class='num'>@num</span></td><td><input type='text' class='form-control required' name='name_t_@num' placeholder='姓名' /><span class='btn btn-default glyphicon glyphicon-minus margin_l5' onclick='RemoveUser(this);'></span></td></tr>"
        + "<tr><td><select name='certtype_sel_@num' class='form-control min selnum'>"
        + "<option value='1' selected='selected'>身份证</option><option value='2'>护照</option><option value='3'>学生证</option><option value='4'>其它证件</option></select>"
        + "<input type='text' class='form-control margin_l5 required digits IDCards' name='certcode_t_@num' placeholder='证件号' /></td></tr></table></li>";
        //添加一个新旅客
        function AddGuest() {
            var num = parseInt($("#user_ul li:last .num").text()) + 1;
            var obj = $(addTlp.replace(new RegExp(/@num/g), num));
            $(obj).find(".selnum").change(function () {
                if ($(this).val() != '1')
                    $(this).next().removeClass("IDCards");
                else
                    $(this).next().addClass("IDCards");
            });
            $("#user_ul").append(obj);
            return false;
        }
        function RemoveUser(obj) {
            if (confirm("确定要移除吗")) {
                $(obj).closest("li").remove();
            }
        }
        function AddGuests(num) {
            for (var i = 1; i < num; i++) {
                AddGuest();
            }
        }
        function CheckSubmit() {
            var guestArr = [];//旅客
            var contractArr = [];//联系人
            $liarr = $("#user_ul li");
            for (var i = 0; i < $liarr.length; i++) {
                $li = $($liarr[i]);
                var model = { Name: $li.find("input[name=name_t_" + (i + 1) + "]").val(), CertType: $li.find("[name=certtype_sel_" + (i + 1) + "]").val(), CertCode: $li.find("input[name=certcode_t_" + (i + 1) + "]").val() };
                guestArr.push(model);
            }
            var model = { Name: $("input[name=c_name_t]").val(), Mobile: $("input[name=c_mobile_t]").val(), Address: $("input[name=c_address_t]").val() };
            contractArr.push(model);
            $("#Guest_Hid").val(JSON.stringify(guestArr));
            $("#Contract_Hid").val(JSON.stringify(contractArr));
            //-------------
            if (!IsDump(guestArr)) { alert("证件号码不能为空或重复!"); return false; }
            var vaild = $("form").validate({ meta: "validate" });
            return vaild.form();
        }
        function IsDump(gusetArr) {
            var n = {}, r = []; //n为hash表，r为临时数组
            for (var i = 0; i < gusetArr.length; i++) //遍历当前数组      
            {
                if (n[gusetArr[i].CertCode]) { return false; } //如果hash表中没有当前项            {
                n[gusetArr[i].CertCode] = true; //存入hash表
                r.push(gusetArr[i].CertCode); //把当前数组的当前项push到临时数组里面            }
            }
            return true;
        }
        function skey() {
            var key = $("#skey_t").val();
            window.open("/Search/SearchList.aspx?node=0&keyword=" + key);
        }
        function FillGuest(id) {
            var json = $("#Guest_Hid2").val();
            if (json) {
                var list = JSON.parse(json);
                for (var i = 0; i < list.length; i++) {
                    var model = list[i];
                    var index = i + 1;
                    $("[name=name_t_" + index + "]").val(model.Name);
                    $("[name=certcode_t_" + index + "]").val(model.CertCode);
                    $("[name=certtype_sel_" + index + "]").val(model.CertType);
                }
            }
        }
        function FillContract()
        {
            var json = $("#Contract_Hid2").val();
            if (json) {
                var list = JSON.parse(json);
                for (var i = 0; i < list.length; i++) {
                    var model = list[i];
                    $("[name=c_name_t]").val(model.Name);
                    $("[name=c_mobile_t]").val(model.Mobile);
                    $("[name=c_address_t]").val(model.Address);
                }
            }
        }
    </script>
</asp:Content>