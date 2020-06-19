<%@ page language="C#" autoeventwireup="true" inherits="Common_Ppc, App_Web_tn0wgvve" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<!DOCTYPE html>
<html>
<head runat="server">
<title>多级选择</title>
<script type="text/javascript" src="/JS/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="http://code.zoomla.cn/Area.js"></script>
<script type="text/javascript" src="/JS/Controls/ZL_PCC.js"></script>
</head>
<body>
<form id="form1" runat="server">
<div>
	<select id="tbProvince"></select>
	<select id="tbCity"></select>
	<select ID="tbCounty"></select>
	<input id="address" runat="server" type="hidden" />
</div>
</form>
</body>
</html>
<script type="text/javascript">
    $().ready(function () {
        var pcc = new ZL_PCC("tbProvince", "tbCity", "tbCounty");
        $("#address").val('<%=Request.QueryString["FValue"] %>');
        if ($("#address").val() != "") {
            var defdata = $("#address").val().split(',');
            pcc.SetDef(defdata[0], defdata[1], defdata[2]);
        }
        pcc.ProvinceInit();
        $("select").change(function () {
            parent.SetCitys('<%=Request.QueryString["FieldName"] %>',$("#tbProvince").val() + ',' + $("#tbCity").val() + ',' + $("#tbCounty").val())
        });
    });
</script>