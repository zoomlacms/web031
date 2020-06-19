<%@ page language="C#" autoeventwireup="true" inherits="test_design, App_Web_jm5ozgzq" validaterequest="false" clientidmode="Static" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="renderer" content="webkit" />
	<link href="/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="/dist/css/font-awesome.min.css" rel="stylesheet" />
    <link href="/App_Themes/ICMS/V3.css" rel="stylesheet" />
    <script src="/JS/jquery-1.9.1.min.js"></script>
    <script src="/dist/js/bootstrap.min.js"></script>
    <script src='/JS/jquery-ui.min.js'></script>
    <link rel="stylesheet" href="/Plugins/CodeMirror/lib/codemirror.css" />
    <script src="/Plugins/CodeMirror/lib/codemirror.js"></script>
    <style type="text/css">
	.padding0{ padding-left:0; padding-right:0;}
	.padding5{ padding-left:5px; padding-right:5px;}
	/*.opdiv{position:fixed;top:0px;width:100%; padding-left:1em; background-color:rgba(70, 66, 66, 0.8);border-color:#BCBEC3; z-index:99999;} 
	.opdiv a{ float:left; display:block; width:3em; min-height:2em; line-height:2em; color:#fff; font-size:1.4em; text-align:center;}
	.opdiv a:hover,.opdiv a:focus{ background:#ee7e13; outline:none;}
	.opdiv input:focus{ background:#B369EC; outline:none;}*/
	.edit_l{ position:fixed; top:0; left:0; bottom:0; padding-top:2px; background:rgba(1,0,2,0.6); min-width:80px; z-index:9999;}
	.edit_l li{ height:50px;padding:15px 0px 10px 10px; border-bottom:1px solid #888; overflow:hidden;cursor:pointer;}
	.edit_l li:hover,.edit_l li:focus{ background:rgba(0,0,0,0.8);}
	.edit_l li i{ float:left; display:block;height:50px;  color:#ddd; font-size:2em; text-align:center;}
	.edit_l li i:hover{ cursor:pointer;}
    .edit_l li .lispan{margin-left:5px;margin-right:10px;color:#fff;line-height:25px;font-size:1.2em;}
	.edit_r{ position:fixed;top:0; bottom:0; right:0px; padding-left:5px; padding-right:5px; width:25%; background-color:rgba(70, 66, 66, 0.07);border-color:#BCBEC3;}
	#html_text{ padding:5px; width:100%; height:400px; border:1px solid #999; border-radius:4px;}
	#more_func{ position:relative;}
	#more_func .funcs{ display:none; position:absolute; top:2.8em; left:15em; width:200px; background:#000;}
	#more_func .funcs a{ width:100%;}
	.edit_body{ padding-left:110px;}
    /*标签*/
    #label_div{width: 410px;position:fixed;left:110px;background-color:rgba(1,0,2,0.6);padding:5px;display:none;}
    .CodeMirror {height:100px;width:100%;border-radius:5px;}
    </style> 
    <title>可视化设计</title>
</head>
<body onbeforeunload="return '确定关闭页面吗?';">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="hidden">
            <asp:Button runat="server" ID="Save_Btn" OnClick="Save_Btn_Click" Style="display: none;" />
            <asp:HiddenField runat="server" ID="Html_Hid" />
            <input type="hidden" id="vpath_hid" />
        </div>
        <div class="edit">
            <div class="edit_l">
                <ul class="list-unstyled">
                    <li onclick="SaveHtml();"><i class="fa fa-save"></i><span class="lispan">保存</span></li>
                    <li onclick="obj.InitDrag();"><i class="fa fa-arrows"></i><span class="lispan">拖动</span></li>
                    <li onclick="obj.StopDrag();"><i class="fa fa-stop"></i><span class="lispan">锁定</span></li>
                    <li onclick="$('#label_div').toggle('fast');"><i class="fa fa-external-link" title="标签"></i><span class="lispan">标签</span></li>
            <%--        <li><i class="fa fa-tachometer"></i><span class="lispan">风格</span></li>--%>
                    <li onclick="ShowDiag('模板库','TemplateList.aspx?OpenerText=vpath_hid');"><i class="fa fa-cloud"></i><span class="lispan">模板库</span></li>
                    <li><a href="TlpShow.aspx?PreView=1&VPath=<%:VPath %>" target="_blank"><i class="fa fa-search-plus"></i><span class="lispan">预览</span></a></li>
                </ul>
            </div>
            <div class="col-lg-9 col-md-9 col-sm-9 col-xs-12 padding0 edit_body">
                <iframe id="tlp_ifr" src="TlpShow.aspx?VPath=<%:VPath %>" style="border: none; width: 100%; height: 900px;"></iframe>
            </div>
            <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12 padding0 edit_r">
                <div class="rightdiv">
                    <ul class="nav nav-tabs">
                        <li class="active" tab="#div0" onclick="ShowTabs(this)"><a href="javascript:;" data-toggle="tab" >代码块</a></li>
                        <li tab="#div1" onclick="ShowTabs(this);"><a href="javascript:;" data-toggle="tab">所有动态标签</a></li>
                        <li tab="#div2" onclick="ShowTabs(this);"><a href="javascript:;" data-toggle="tab">信息概述</a></li>
                    </ul>
                    <div id="div0">
                        <textarea id="html_text" runat="server"></textarea>
                        <input type="button" class="btn btn-xs btn-primary" value="更新Html块" onclick="SaveEdit();" />
                        <div class="panel panel-primary margin_t10">
                            <div class="panel-heading"><i class="fa fa-bookmark-o"></i><span class="margin_l5">标签列表(只显示动态标签)</span></div>
                            <div class="panel-body">
                                <asp:UpdatePanel ID="LabelList_UP" runat="server">
                                    <ContentTemplate>
                                        <asp:Button runat="server" ID="GetLabel_Btn" OnClick="GetLabel_Btn_Click" Style="display: none;" />
                                        <table class="table table-bordered table-striped">
                                            <asp:Repeater runat="server" ID="CurDivLabe_RPT">
                                                <ItemTemplate>
                                                    <tr>
                                                        <td title="点击修改"><a href="javascript:;" onclick="ShowDiag('修改标签','LabelSql.aspx?LabelName=<%#Eval("Name") %>');"><%#Eval("Name") %></a></td>
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                    <div id="div1" style="display:none;">
                        <table class="table table-bordered table-striped">
                            <asp:Repeater runat="server" ID="CurHtml_RPT">
                                <ItemTemplate>
                                    <tr><td title="点击修改"><a href="javascript:;" onclick="ShowDiag('修改标签','LabelSql.aspx?LabelName=<%#Eval("Name") %>');"><%#Eval("Name") %></a></td></tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </table>
                    </div>
                    <div id="div2" style="display:none;">
                        <table class="table table-bordered table-striped">
                            <tr><td class="td_m">模板目录:</td><td><asp:Label runat="server" ID="TempDir_L"></asp:Label></td></tr>
                            <tr><td>文件名:</td><td><asp:Label runat="server" ID="FName_L"></asp:Label></td></tr>
                            <tr><td>文件大小:</td><td><asp:Label runat="server" ID="FSize_L"></asp:Label></td></tr>
                            <tr><td>修改时间:</td><td><asp:Label runat="server" ID="EditDate_L"></asp:Label></td></tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div id="label_div">
            <asp:UpdatePanel ID="LabelPanel" runat="server">
                <ContentTemplate>
                    <ul class="nav nav-tabs" id="myTab">
                        <li class="active" onclick="ShowTabs(this);" tab="#Tabs0"><a href="javascript:;">自定标签</a></li>
                        <li onclick="ShowTabs(this);" tab="#Tabs1" style="cursor: pointer;"><a href="javascript:;">字段标签</a></li>
                        <li onclick="ShowTabs(this);" tab="#Tabs2" style="cursor: pointer;"><a href="javascript:;">系统标签</a></li>
                        <li onclick="ShowTabs(this);" tab="#Tabs3" style="cursor: pointer;"><a href="javascript:;">扩展函数</a></li>
                        <li style="width:40px;"><span class="glyphicon glyphicon-remove" style="font-size:1em;cursor:pointer;color:#fff;float:right;margin-top:5px;margin-right:5px;" title="关闭" onclick="$('#label_div').hide('fast');"></span></li>
                    </ul>
                    <div class="tab-content" style="background-color:#fff;">
                        <div class="tab-pane active" id="Tabs0" runat="server">
                            <table class="table table-striped table-bordered">
                                <tbody>
                                    <tr class="text-center">
                                        <td style="vertical-align: top;">
                                            <asp:DropDownList ID="DDLCate" runat="server" OnSelectedIndexChanged="ChangeCate" AutoPostBack="true"></asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr class="text-center">
                                        <td style="vertical-align: top;">
                                            <div style="overflow: auto; height: 410px">
                                                <asp:Label ID="LblLabel" runat="server"></asp:Label>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <table class="table table-striped" style="background-color:#fff;">
                        <tbody id="Tabs4" class="tab-pane" runat="server"></tbody>
                        <tbody id="Tabs1" class="tab-pane" runat="server" style="display: none">
                            <tr class="text-center">
                                <td>
                                    <asp:DropDownList ID="DDLField" runat="server" OnSelectedIndexChanged="ChangeSourceField"
                                        AutoPostBack="true">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr class="text-center">
                                <td>
                                    <div style="overflow: auto; height: 410px">
                                        <asp:Label ID="LblSourceField" runat="server"></asp:Label>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                        <tbody id="Tabs2" class="tab-pane" style="display: none">
                            <tr class="text-center">
                                <td>
                                    <div style="overflow: auto; height: 410px">
                                        <asp:Label ID="lblSys" runat="server"></asp:Label>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                        <tbody id="Tabs3" class="tab-pane" style="display: none">
                            <tr class="text-center">
                                <td>
                                    <div style="overflow: auto; height: 410px">
                                        <asp:Label ID="lblFun" runat="server"></asp:Label>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="panel panel-primary margin_t10">
                <div class="panel-heading"><i class="fa fa-bookmark-o"></i><span class="margin_l5">标签文本</span></div>
                <div class="panel-body">
                    <textarea id="textContent"></textarea>
                </div>
            </div>
        </div> 
        <script src="/JS/Controls/ZL_Dialog.js"></script>
        <script src="/Plugins/CodeMirror/LabelCall.js"></script>
        <script type="text/javascript">
            var obj = $("#tlp_ifr")[0].contentWindow;
            var $curEle = null;
            function EditA(element) {
                $curEle = $(element);
                $("#html_text").val($curEle.html());
                $("#GetLabel_Btn").click();
            }
            function SaveEdit() {
                $curEle.html( $("#html_text").val());
            } 
            function SaveHtml() {
                if (confirm("确定要保存已编辑的Html吗")) {
                    obj.BeginSave();
                    $("#Html_Hid").val("<html>" + $("#tlp_ifr").contents().find("html").html() + "</html>");
                    $("#Save_Btn").click();
                }
            }
        </script>
        <script type="text/javascript">
		$().ready(function(e) {
			$(".edit_l li i").mouseover(function(e) {
				$(this).parent().find("a").css({
						display:'block',
						})
                $(this).parent().find("a").fadeIn();
            }).mouseout(function(e) {
                $(this).parent().find("a").hide();
            });;
			var clinum=1;
            $(".edit_l li i").click(function(e) 
			{
				if(clinum==1){ 
					$(this).parent().parent().find("a").css({
						display:'block',
						});
					$(this).parent().parent().find("a").fadeIn(); 
				}else{
					$(this).parent().parent().find("a").hide();	
				}
				clinum*=-1;
            });
			$("#more_func").mouseenter(function(e) {
                $(this).find("#more_btn").css("background",'#000');
                $(this).find(".funcs").slideDown();
            }).mouseleave(function(e) {
				$(this).find("#more_btn").css("background",'none');
                $(this).find(".funcs").slideUp();
            });

		});
		var diag = new ZL_Dialog();
         //标签
		function ShowDiag(title, url)
		{
		    diag.maxbtn = false;
		    diag.backdrop = true;
		    diag.title = title;
		    diag.url = url;
		    diag.ShowModal();
		}
		function CloseDialog() {
		    var url = $("#vpath_hid").val();
		    $("#vpath_hid").val("");
		    if (url != "") {
		        location = "Design.aspx?VPath=<%=ZoomLa.Components.SiteConfig.SiteOption.TemplateDir%>/" + url;
		    }
        }
		function ShowTabs(obj) {
		    $(obj).siblings("li[tab]").each(function () { $(this).removeClass("active"); id = $(this).attr("tab"); $(id).hide(); });
		    var sid = $(obj).attr("tab");
		    $(obj).addClass("active");
		    $(sid).show();
		}
		function closeCuModal() {
		    diagLabel.CloseModal();
		}
        </script>
    </form>
</body>
</html>
