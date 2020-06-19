<%@ page title="" language="C#" masterpagefile="~/User/Default.master" autoeventwireup="true" inherits="User_Cloud_CloudManage, App_Web_okhj5ffc" clientidmode="Static" enableEventValidation="false" viewStateEncryptionMode="Never" %>

<asp:Content ContentPlaceHolderID="head" runat="Server">
    <title>网络云盘</title>
    <link type="text/css" rel="stylesheet" href="/App_Themes/ICMS/Sass.css" />
    <style>
        *{font-family:"Microsoft YaHei";}
        .table thead tr td{font-size:15px;font-weight:bold;}
        .hoverDiv span{margin-left:10px;margin-right:10px;}
        .form-control{display:inline-block;}
        .dirdiag{width:300px;}
        .table tr{border-bottom:1px solid #ddd;}
        .url_title{margin:5px;font-size:15px;}
    </style>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <ol class="breadcrumb">
        <li>您现在的位置：<a title="网站首页" href="/"><%= Call.SiteName%></a></li>
        <li><a title="会员中心" href="/User/Default.aspx">会员中心</a></li>
        <li class="active">网络云盘</li>
    </ol>
    <span runat="server" id="OpenCloud" visible="false">您还没有云盘，请先
        <asp:LinkButton ID="Open" runat="server" OnClick="OpenCloud_Click" ForeColor="Red">开通云盘</asp:LinkButton>
    </span>

    <div id="Cloud" runat="server" visible="false">
        <div class="url_title">
            <span id="navv" runat="server" style="margin-left: 10px;"></span>
            <asp:HiddenField ID="HdnPath" runat="server" />
        </div>
        <div class="clearfix"></div>
        <div class="us_seta" id="us_seta" style="text-align: left;margin-top:5px;" runat="server">
            <input id="back" type="button" runat="server" class="btn btn-primary" value="返 回" onclick="javascript:history.back();" />
            <input type="button" class="btn btn-primary" name="demoCode04-3" value="上传"
                onclick="ShowFileDiag()" />
            <input id="newFile" type="button" class="btn btn-primary" value="新建文件夹"
                onclick="ShowDirDiag()" />
        </div>
        <table class="table">
                <thead>
                    <tr>
                 <td style="width:60%;">名称</td>
	            <td style="width:20%;">大小</td>
	            <td style="width:20%;">创建时间</td></tr>
                </thead>
        <asp:Repeater ID="RptFiles" runat="server" OnItemCommand="RptFiles_ItemCommand">
            <ItemTemplate>
                <tr style="height: 24px" class="tdbg" onmouseover="$(this).find('.hoverDiv').show();" onmouseout="$(this).find('.hoverDiv').hide();">
                    <td align="left">
                        <div style="position:relative;bottom:-10px;display:inline-block;"><%# System.Convert.ToInt32(Eval("type")) == 1 ? GroupPic.GetExtNameMini("filefolder") : GroupPic.GetExtNameMini(Eval("content_type").ToString())%></div>
                        <%#GetLink(Eval("type").ToString(),Eval("content_type").ToString(),Eval("Name").ToString()) %>
                        <span class="hoverDiv" style="display:none;">
		  <%#GetOP() %>
                            <%if (GetDelAuth())
                          { %>
			 <asp:LinkButton ID="LbtnDelList" CommandName='<%# System.Convert.ToInt32(Eval("type")) == 1 ? "DelDir":"DelFiles" %>' CommandArgument='<%# Eval("Name")%>'
                 OnClientClick="if(!this.disabled) return confirm('确定要删除吗？');" runat="server"><span class='glyphicon glyphicon-trash' title='删除'></span></asp:LinkButton></td>
                    <%} %>
                    </td>
                    <td><%# GetSize(Eval("size").ToString())%></td>
                    <td><%# Eval("createTime")%></td>
                   <%-- <td align="center"><%--[<a href='javascript:' onclick='javascript:parent.NewFormd(\"文件分享\" ,\"/Common/File.aspx?T=f&FD=" + FileJiaM(CurrentDir+"/"+Eval("Name").ToString()) + "\")'>分享</a>]
                        <%#GetDownUrl() %>
                        <%if (GetDelAuth())
                          { %>
			 [<asp:LinkButton ID="LbtnDelList" CommandName='<%# System.Convert.ToInt32(Eval("type")) == 1 ? "DelDir":"DelFiles" %>' CommandArgument='<%# Eval("Name")%>'
                 OnClientClick="if(!this.disabled) return confirm('确定要删除吗？');" runat="server">删除</asp:LinkButton>]</td>
                    <%} %>--%>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
        </table>
  <asp:Literal runat="server" ID="MsgPage_L" EnableViewState="false"></asp:Literal>
    </div>
    <div style="display:none;" id="NewDir_div">
        <asp:TextBox ID="DirName_T" CssClass="form-control" runat="server"></asp:TextBox>
        <asp:Button ID="CreateDiv" runat="server" CssClass="btn btn-primary" OnClick="CreateDiv_Click" Text="确定" />
    </div>
    <div style="display:none;" id="File_div">
        <input type="file" id="files" />
    </div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
<link href="/Plugins/Uploadify/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/Plugins/Uploadify/jquery.uploadify.js"></script>
<script src="/JS/Controls/ZL_Dialog.js"></script>
    <script type="text/javascript">

        (function () {
            var _skin, _jQuery;
            var _search = window.location.search;
            if (_search) {
                _skin = _search.split('demoSkin=')[1];
                _jQuery = _search.indexOf('jQuery=true') !== -1;
                if (_jQuery) document.write('<scr' + 'ipt src="jquery-1.6.2.min.js"></sc' + 'ript>');
            };
            document.write('<scr' + 'ipt src="artDialog.source.js?&skin=' + (_skin || 'aero') + '"></sc' + 'ript>');
        })();
        var DirDiag=new ZL_Dialog();
        function ShowDirDiag(){
            DirDiag.content="NewDir_div";
            DirDiag.title="新建目录";
            DirDiag.width="dirdiag";
            DirDiag.ShowModal();
        }
        var FileDiag=new ZL_Dialog();
        function ShowFileDiag(){
            FileDiag.title="文件上传";
            FileDiag.content="File_div";
            FileDiag.width="dirdiag";
            FileDiag.ShowModal();
            $("#files").uploadify({
                //按钮宽高
                width: 120,
                height: 35,
                auto: true,
                swf: '/Plugins/Uploadify/uploadify.swf',
                uploader: '/Plugins/Uploadify/UploadFileHandler.ashx',
                buttonText: "上传附件",
                buttonCursor: 'hand',
                fileTypeExts: "*.*",
                fileTypeDesc: "请选择文件",
                fileSizeLimit: "50000KB",
                formData: { "action": "Cloud_Doc", "value": "<%:CurrentDir%>","Type":"<%=Request["Type"] %>" },
                queueSizeLimit: 3,
                removeTimeout: 2,
                multi: true,
                onUploadStart: function (file) { },
                onUploadSuccess: function (file, data, response) {//json,result,tru||false
                },
                onQueueComplete: function (queueData) { location = location; },
                onUploadError: function (file) { }
            });
        }
        $().ready(function(){
            
        });
        function NewFormd(title, content) {
            if ($("iframe").eq(2).html() == null) {
                $(".aui_title").html(title);
                art.dialog.data('homeDemoPath', './_doc/');
                if (title == "新建文件夹") {
                    art.dialog.open(content, { title: title, width: "360" }, true);
                    $("iframe").eq(2).css({ "width": "360px", "height": "300px" });
                } else if (title == "文件上传") { 
                    art.dialog.open(content, { title: title, width: "440" }, true);
                    $("iframe").eq(2).css({  "width": "430px","height": "500px" });
                } else if (title == "音乐播放") {
                    art.dialog.open(content, { title: title, width: "300" }, true);
                    $("iframe").eq(2).css({ "width": "430px", "height": "500px" });
                    $('#back').remove();
                } else {
                    art.dialog.open(content, { title: title, width: "400" }, true);
                    $("iframe").eq(2).css({ "width": "430px", "height": "500px" });
                }
            } else {
                $("iframe").eq(2).attr("src", $("iframe").eq(2).attr("src"));
            }
        }
    </script>
    <script type="text/javascript">
        function myfunction() {
            $.get("CloudManage.aspx?DownUrl=" + escape(Url) + "&time=" + Date(), function (da) {
                alert(da);
            })
        }
        function UXml(mp, Url) {
            $.get("CloudManage.aspx?mpname=" +escape(mp) + "&time=" + Date()+"&Url="+escape(Url), function (data) {
            })
        }

        function open(path) {
            var titles = path.split('/');
            var title;
            for (var i = 0; i < titles.length; i++) {
                if (titles[i].indexOf('.') > 0)
                    title = titles[i];
            } 
            switch ('<%=Request["Type"] %>') {              
                case "file":
                    popAlert(path);
                    break;
                case "photo":
                    popAlert(path);
                    break;
                case "video":
                    NewFormd(title, "Cloud/Jwplayer/PlayM.aspx?MeUrl=" + path);
                    break;
                case "music":
                    NewFormd("音乐播放", "Cloud/Jwplayer/PlayM.aspx?MeUrl=" + path);
                    break;
                case "PF":
                    //根据后缀名来判断
                    result=checkFileType(path.split(".")[(path.split(".").length-1)]);
                    switch(result)
                    {
                        case 1:
                            parent.popAlert(path+"&Type=PF");
                            break;
                        case 2:
                            parent.NewFormd("音乐播放", "Cloud/Jwplayer/PlayM.aspx?MeUrl=" + path+"&Type=PF");
                            break;
                    }
                    break;
            }
        }
        function checkFileType(ex)//后缀名
        {
            var imgArr=["jpg","gif","png","bmp","txt"];
            var video=["mp3","wma","wmv","avi","mp4","f4v","m4v","rmvb","rm","flv","wm","ram","asf","wmv"];
            for (var i = 0; i < imgArr.length; i++) {
                if(imgArr[i]==ex)
                    return 1;
            }
            for (var i = 0; i < video.length; i++) {
                if(video[i]==ex)
                    return 2;
            }
        }
    </script>
    <script type="text/javascript">

        function popAlert(str) {
            //width="' + $(window).width() + '"
            $('<div id="popalert">' + '<iframe id="picture" name="picture" marginwidth="0" marginheight="0" frameborder="0" scrolling="no"  src="/user/Cloud/ShowPhoto.aspx?Dir=' + str + '\" width="100%" height="100%"></iframe>' + '</div>').appendTo('body');
            var _popalert = $('#popalert');
            _popalert.css({
                position: 'absolute',
                height: ($(window).height() + $('body').scrollTop()) + 'px',
                width: ($(window).width()) + 'px',
                left: '0px',
                top: '0px'
            });
        }
        //窗口自适应
        window.onresize = function () {
            $('#popalert').css({
                position: 'absolute',
                height: ($(window).height()) + 'px',
                width: ($(window).width()) + 'px',
                left: '0px',
                top: '0px'
            });
        }
        //关闭浏览图片
        function close() {
            $('#popalert').remove();
        }
        //关闭弹出层
        function closeNewFile() {
            //alert(8);
            $('.aui_focus').remove();
            $('#back').remove();

        }
        //弹出层
        function NewFormd(title, content) {
            //alert(title);
            if ($("iframe").eq(2).html() == null) {
                $(".aui_title").html(title);
                art.dialog.data('homeDemoPath', './_doc/');
                if (title == "新建文件夹") {
                    art.dialog.open(content, { title: title, width: "360" }, true);
                    $("iframe").eq(2).css({ "width": "360px", "height": "200px" });
                } else if (title == "文件上传") {
                    art.dialog.open(content, { title: title, width: "360" }, true);
                    $("iframe").eq(2).css({ "height": "180px", "width": "360px" });
                } else if (title == "音乐播放") {
                    art.dialog.open(content, { title: title, width: "300" }, true);
                    $("iframe").eq(2).css({ "width": "300px", "height": "405px" });
                    $('#back').remove();
                } else {
                    art.dialog.open(content, { title: title, width: "400" }, true);
                    $("iframe").eq(2).css({ "width": "400px", "height": "300px" });
                }
            } else {
                $("iframe").eq(2).attr("src", $("iframe").eq(2).attr("src"));
            }
        }
    </script>

</asp:Content>