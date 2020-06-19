<%@ page language="C#" autoeventwireup="true" inherits="Manage_User_UApiConfig, App_Web_twg4402e" masterpagefile="~/Manage/I/Default.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <link rel="stylesheet" href="/dist/css/bootstrap-switch.min.css" />
    <link href="/Plugins/Third/ystep/css/ystep.css" rel="stylesheet" />
    <title>站群用户整合配置</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<div class="ystep1"></div>
<div class="ystep-step" id="step1">
    <div class="alert alert-info">第一步：设置远程主站数据库IP或域名
        <div class="input-group" style="width: 360px;">
           <%-- <span class="input-group-addon">http://</span>--%>
            <asp:TextBox runat="server" ID="sip_t" CssClass="form-control" data-enter="1" placeholder="demo.zoomla.cn" />
            <span class="input-group-btn">
                <input type="button" class="btn btn-primary" value="下一步" onclick="GetNext2();" data-enter="3" />
            </span>
        </div></div>
</div>
<div class="ystep-step" id="step2">
    <div class="alert alert-info">第二步：站点拓扑图
        <input type="button" class="btn btn-primary" value="上一步" onclick="ShowStep(1);" />
        <input type="button" class="btn btn-primary" value="下一步" onclick="GetNext3();" />
    </div>
<iframe id="network_ifr" style='width:100%;border:none;height:450px;' src=""></iframe>
</div>
<div class="ystep-step" id="step3">
     <div class="alert alert-info">第三步：站群整合详情配置 <input type="button" id="copyhref" class="btn btn-primary" value="复制SQL语句"></div>
     <table class="table table-bordered">
                <tr><td class="td_l">服务器IP：</td><td><asp:TextBox runat="server" ID="ServerIP_T" CssClass="form-control required ip" data-enter="5"/></td></tr>
                <tr><td>数据库名：</td><td><asp:TextBox runat="server" ID="DBName_T" CssClass="form-control required" data-enter="6"/></td></tr>
                <tr><td>用户名：</td><td><asp:TextBox runat="server" ID="UName_T" CssClass="form-control required" data-enter="7"/></td></tr>
                <tr><td>密码：</td><td><asp:TextBox runat="server" ID="Pwd_T" data-enter="8" CssClass="form-control required"/></td></tr>
                <tr><td>操作：</td><td>
                    <asp:Button runat="server" ID="Begin_Btn" CssClass="btn btn-primary" Text="生成整合SQL" OnClientClick="CheckData();" OnClick="Begin_Btn_Click" data-enter="9"  />
                    <asp:Button runat="server" ID="Cancel_Btn" CssClass="btn btn-primary" Text="生成取消SQL" OnClick="Cancel_Btn_Click" />
                    <a href="http://code.zoomla.cn/Files/跨站整合示例.docx" target="_blank" class="btn btn-primary">下载示例文档</a>
                    <input type="button" class="btn btn-primary" value="上一步" onclick="ShowStep(2);" />
                    <asp:Button runat="server" ID="Save_Btn" CssClass="btn btn-primary" Text="完成配置" OnClick="Save_Btn_Click" />
                </td></tr></table>
    <div style="height: 38px;"></div>
    <div runat="server" id="Sql_Div" class="alert alert-info">尚未生成SQL语句</div>
</div>
<div class="ystep-step" id="step4">
    <h4 class="alert alert-info">配置已经完成,下次进入将不再显示</h4>
</div>
<asp:HiddenField runat="server" ID="CurStep_Hid" Value="1" />
    <textarea id="code" style="display:none;">
         option = {
    title : {
        text: '站点关系：用户整合',
        subtext: '数据来自主站',
        x:'right',
        y:'bottom'
    },
    tooltip : {
        trigger: 'item',
        formatter: '{a} : {b}'
    },
    toolbox: {
        show : true,
        feature : {
            restore : {show: true},
            magicType: {show: true, type: ['force', 'chord']},
            saveAsImage : {show: true}
        }
    },
    legend: {
        x: 'left',
        data:['子站','二级子站']
    },
    series : [
        {
            type:'force',
            name : "站点关系",
            ribbonType: false,
            categories : [
                {
                    name: '主站'
                },
                {
                    name: '子站',
                    symbol: 'rectangle'
                },
                {
                    name:'二级子站',
                    symbol: 'rectangle'
                }
            ],
            itemStyle: {
                normal: {
                    label: {
                        show: true,
                        textStyle: {
                            color: '#333'
                        }
                    },
                    nodeStyle : {
                        brushType : 'both',
                        borderColor : 'rgba(255,215,0,0.4)',
                        borderWidth : 1
                    }
                },
                emphasis: {
                    label: {
                        show: false
                        // textStyle: null      // 默认使用全局文本样式，详见TEXTSTYLE
                    },
                    nodeStyle : {
                        //r: 30
                    },
                    linkStyle : {}
                }
            },
            minRadius : 15,
            maxRadius : 25,
            gravity: 1.1,
            scaling: 1.2,
            draggable: false,
            linkSymbol: 'arrow',
            steps: 10,
            coolDown: 0.9,
            //preventOverlap: true,
            nodes:[
                {
                    category:0, name: '主站', value : 10,
                    symbol: 'rectangle',
                    symbolSize: [60, 35],
                    initial : [500, 40],
                    fixX : true,
                    fixY : true,
                    draggable: true,
                    itemStyle: {
                        normal: {
                            label: {
                                textStyle: {
                                    color: 'black'
                                }
                            }
                        }
                    }
                },
                {category:1, name: '<%=Call.SiteName %>',value : 2,initial : [300, 150],fixX : true,fixY : true,symbolSize: [40, 20]},
                {category:1, name: '站点名2',value : 3,initial : [400, 150],fixX : true,fixY : true,symbolSize: [40, 20]},
                {category:1, name: '站点名3',value : 3,initial : [500, 150],fixX : true,fixY : true,symbolSize: [40, 20]},
                {category:1, name: '站点名4',value : 7,initial : [600, 150],fixX : true,fixY : true,symbolSize: [40, 20]},
                {category:2, name: '二级子站1',value : 5,initial : [300, 300],fixX : true,fixY : true,symbolSize: [40, 20]},
            ],
            links : [
                {source : '<%=Call.SiteName %>', target : '主站', weight : 1, name: '子站', itemStyle: {
                    normal: {
                    }
                }},
                {source : '站点名2', target : '主站', weight : 2, name: '子站'},
                {source : '站点名3', target : '主站', weight : 1, name: '子站'},
                {source : '站点名4', target : '主站', weight : 2, name: '子站'},
                {source : '二级子站1', target : '站点名2', weight : 1, name: '二级子站'},
            ]
        }
    ]
};         
    </textarea>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <style type="text/css">
        .ystep-step{display:none;}
    </style>
    <script src="/JS/jquery.zclip.min.js"></script>
    <script src="/dist/js/bootstrap-switch.js"></script>
    <script src="/Plugins/Third/ystep/js/ystep.js"></script>
    <script src="/JS/ZL_Regex.js"></script>
    <script src="/JS/Controls/Control.js"></script>
    <script src="/JS/jquery.validate.min.js"></script>
    <script>
        //增加sync,checkfunc,提示文字方向
        $(function () {
            Control.EnableEnter();
            jQuery.validator.addMethod("ip", function (value) {
                return ZL_Regex.isIP(value);
            }, "请输入正确的IP地址!");
            $(".ystep1").loadStep({
                size: "large",
                color: "green",
                steps: [{
                    title: "参数",
                    content: "设置基本参数"
                }, {
                    title: "拓扑",
                    content: "查看网络拓扑结构图"
                }, {
                    title: "整合",
                    content: "站群整合配置"
                }, {
                    title: "完成",
                    content: "配置完成,下次进入则进入维护界面"
                }]
            });
            setTimeout(function () { ShowStep($("#CurStep_Hid").val()); }, 500);
        })
        function CheckData() {
            var vaild = $("form").validate({ meta: "validate" });
            return vaild.form();
        }
        function GetNext2() {
            var str = $("#sip_t").val();
            if (ZL_Regex.isEmpty(str)) { alert("服务器地址不能为空"); }
            else
            {
                //var url = "http://" + str + ":86/Plugins/ECharts/NetWork.aspx";
                var url = "/Plugins/ECharts/NetWork.aspx";
                ShowStep(2);
                $("#code").val($("#code").val().replace(/主站/g, str));
                $("#ServerIP_T").val(str);
                setTimeout(function () { $("#network_ifr").attr("src", url); }, 500);
            }
        }
        function GetNext3() {//执行一次复制,否则无效
            ShowStep(3);
            BindClip();
        }
        function GetNext4() {
            ShowStep(4);
            parent.CloseDiag();
        }
        function ShowStep(num) {
            $(".ystep-step").hide();
            $("#step" + num).show();
            $("#CurStep_Hid").val(num);
            $(".ystep1").setStep(num);
        }
        function BindClip()
        {
            $('#copyhref').zclip({
                path: '/JS/ZeroClipboard.swf',
                copy: function () {
                    var str = $('#Sql_Div').html();
                    str = str.replace(/<br>/g, "\n");
                    return str;
                },
                afterCopy: function () { alert("复制完成"); }
            });
        }
    </script>
</asp:Content>