<%@ page language="C#" autoeventwireup="true" inherits="V_Content_AddContent, App_Web_tgku1j5m" masterpagefile="~/Manage/I/Default.master" clientidmode="Static" validaterequest="false" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="head">
<title><asp:Literal runat="server" ID="Title_L"></asp:Literal></title>
<style>
.speDiag{width:500px;}
.specDiv{width:110px;padding-left:5px;}
.specDiv .spec{border:solid 1px #ccc;margin:5px;}
.specDiv .specname{text-align:left;padding-left:5px;display:inline-block}
.specDiv span{display:inline-block;float:right;line-height:20px;}
.Conent_fix #toTop { position:fixed; margin-left:10px; bottom:5px; font-size:12px;}
.Conent_fix #toTop i { font-size:16px; }
#OAkeyword{ max-width:460px; height:36px; border:1px solid #ccc; display:inline-block;min-width:300px;padding-top:3px;}
.tabinput{ border:none; padding-left:5px; height:30px; line-height:30px;}
.radius{margin:2px;margin-top:20px;height:24px; line-height:24px; background:#eee; border:1px solid #ddd;border-radius:3px;padding:3px;}
#Keywords{ display:none;}
.msgtips{line-height:25px; color:green;}
</style>
<script type="text/javascript" charset="utf-8" src="/Plugins/Ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="/Plugins/Ueditor/ueditor.all.js"></script>
<script type="text/javascript" src="/Plugins/Ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="/JS/OAKeyWord.js"></script>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <div class="tabbable">
        <ul class="nav nav-tabs">
            <li class="active"><a href="#ConInfo" data-toggle="tab">内容信息</a></li>
            <li><a href="#InfoAttr" data-toggle="tab">信息属性</a></li>
            <li><a href="#Process " data-toggle="tab">流程控制</a></li>
            <li><a href="#Reward " data-toggle="tab">悬赏定义</a></li>
        </ul><style>	</style>
        <div class="tab-content">
            <div class="tab-pane active" id="ConInfo">
                <table id="mainTable" class="table table-bordered table_padding0" >
                    <tr>
                        <td style="overflow-x:hidden;" class="col-sm-1 col-xs-1 text-right"><asp:Label ID="bt_txt" runat="server" Text="标题"></asp:Label>&nbsp;&nbsp;</td>
                        <td class="col-sm-11 col-xs-11">
                            <asp:TextBox ID="txtTitle" style="background:url(/Images/bg1.gif) repeat-x;width:50%;max-width:715px;" CssClass="form-control pull-left" onkeyup="isgoEmpty('txtTitle','span_txtTitle');Getpy('txtTitle','PYtitle')"  runat="server"></asp:TextBox>
                            <span class="vaild_tip">*</span>

                            <a href="javascript:;" id="Button11" class="btn btn-info btn-sm" onclick="ShowTitle()" ><i class="fa fa-info"></i> 标题属性</a>
<%--                            <input id="Button11" type="button" class="btn btn-info btn-sm" value="标题属性" onclick="ShowTitle()" />--%>
                            <button type="button" class="btn btn-info btn-sm" onclick="ShowContentList()"><i class="fa fa-chain"></i> 关联内容</button>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtTitle" ErrorMessage="标题不能为空" ForeColor="Red" Display="Dynamic" />
                            <span id="span_txtTitle" name="span_txtTitle"></span>
                            <asp:HiddenField ID="ThreadStyle" runat="server" />
                            <div id="duptitle_div" class="alert alert-warning" style="position: absolute;margin-left:315px;display:none;">
                                <ul id='duptitle_ul'></ul>
                            </div>
                        </td>
                    </tr>
                    <tbody id="Sys_Fied" runat="server">
                    <tr>
                        <td class="text-right"><asp:Label ID="py" runat="server" Text="拼音缩写"></asp:Label>&nbsp;&nbsp;</td>
                        <td>
                            <asp:TextBox ID="PYtitle" CssClass="form-control pull-left" runat="server" />
                        </td>
                    </tr>
                   <tr id="spec_tr">
                        <td class="text-right">所属专题&nbsp;&nbsp;</td>
                        <td>
                            <div class="specDiv"></div>
                            <span id="specbtn_span"><asp:Literal ID="SpecInfo_Li" runat="server"></asp:Literal></span>
                            <asp:HiddenField ID="Spec_Hid" runat="server" />
                        </td>
                    </tr>
                    <tr runat="server">
                        <td class="tdbgleft" align="right"> 
                            <asp:Label ID="gjz_txt" runat="server" Text="关键字"></asp:Label>
                            &nbsp;
                        </td>
                        <td>                             
                            <div id="OAkeyword"></div>
                            <asp:TextBox ID="Keywords" runat="server" CssClass="form-control" /><span class="rd_green">(提示：使用空格键或回车键分隔关键字，每个关键字长度不超过5个)</span>  
<%--                                <input id="FindKeyWord" type="button" value="提取关键字" class="btn btn-sm btn-primary" onclick="getstrKeys()" class="btn btn-primary"  />&nbsp;
                            <span class="hidden-xs hidden-sm">
                            <span class="content_k_lr">[</span><a href="#" onclick="SelectKey('tabinput');"><span class="remind_g_x">选择关键字</span></a><span class="content_k_lr">]</span>--%>     
                         </td>                        
                    </tr>
                    <tr runat="server">
                        <td class="text-right"><asp:Label ID="Label4" runat="server" Text="副标题"></asp:Label>&nbsp;&nbsp;</td>
                        <td>
                            <asp:TextBox ID="Subtitle" CssClass="form-control pull-left" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-right">允许评论</td>
                        <td>
                            <asp:RadioButtonList ID="IsComm_Radio" runat="server" CssClass="pull-left" RepeatColumns="2">
                                <asp:ListItem Value="1" Selected="True">是</asp:ListItem>
                                <asp:ListItem Value="0">否</asp:ListItem>
                            </asp:RadioButtonList> <span class="pull-left msgtips">(该操作只在节点管理下配置了允许发表评论时生效!)</span>
                        </td>
                    </tr>
                    </tbody>
                    <asp:Literal ID="ModelHtml" runat="server"></asp:Literal>
                    <tr>
                        <td class="text-right">内容缩略图</td>
                    </tr>
                    <tr id="attPic" runat="server">
                        <td class="text-right">
                            附属图片
                        </td>
                        <td style="height:80px;">
                            <ul id="ThumImg_ul" class="preview_img_ul">
                            </ul>
                            <div class="clearfix"></div>
                            <select name="selectpic" id="selectpic" onchange="ShowPic(this.value)" class="form-control">
                                <option value="" selected="selected">不指定附属图片</option>
                            </select>
                        </td>
                    </tr>
                    <tr id="CreateHTML" runat="server">
                        <td class="text-right">
                            <asp:Label ID="Label1" runat="server" Text="生成"></asp:Label>&nbsp;
                        </td>
                        <td>
                            <asp:CheckBox ID="quickmake" runat="server" Checked="false" Text="是否立即生成" />&nbsp;
                        </td>
                    </tr>
                </table>
                <div style="height:50px;"></div>
            </div>
            <div class="tab-pane fade" id="InfoAttr">
                <table class="table table-bordered table_padding0">
                    <tr>
                        <td class="text-right">录入者</td>
                        <td>
                            <asp:TextBox ID="txtInputer" CssClass="form-control" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-right">添加时间</td>
                        <td>
                            <asp:TextBox ID="txtAddTime" CssClass="form-control" onclick="WdatePicker({ dateFmt: 'yyyy-MM-dd HH:mm:ss' })" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-right"><asp:Label ID="gx_time" runat="server" Text="修改时间"></asp:Label></td>
                        <td>
                            <asp:TextBox ID="txtdate" CssClass="form-control" onClick="WdatePicker({ dateFmt: 'yyyy-MM-dd HH:mm:ss' })" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-right"><asp:Label ID="hits_txt" runat="server" Text="点击数"></asp:Label></td>
                        <td>
                            <asp:TextBox ID="txtNum" CssClass="form-control" runat="server">0</asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-right">指定个性模板</td>
                        <td>
                            <asp:TextBox ID="TxtTemplate" CssClass="form-control" runat="server"></asp:TextBox>
                            <input type="button" value="选择模板" onclick="WinOpenDialog('../Template/TemplateList.aspx?OpenerText='+escape('TxtTemplate')+'&FilesDir=',650,480)" class="btn btn-primary" />

                        </td>
                    </tr>
                    <tr>
                        <td class="text-right">生成PDF文件</td>
                        <td>
                            <asp:CheckBox ID="Makepdf" runat="server" Text="启用" />
                        </td>
                    </tr>
                </table>
            </div>
            <div class="tab-pane fade" id="Process">
                <table class="table table-bordered">
                    <tr>
                        <td class="text-right">
                            <asp:Label ID="tj_txt" runat="server" Text="推荐级别"></asp:Label></td>
                        <td>
                            <asp:CheckBox ID="ChkAudit" runat="server" />推荐
                        </td>
                    </tr>
                    <tr id="contentsk" runat="server">
                        <td class="text-right"><asp:Label ID="zht_txt" runat="server" Text="状态"></asp:Label></td>
                        <td>
                            <asp:RadioButtonList ID="ddlFlow" runat="server" RepeatColumns="5">
                            <%--    <asp:ListItem Value="99" Selected="True">已审</asp:ListItem>
                                <asp:ListItem Value="0">待审</asp:ListItem>
                                <asp:ListItem Value="-1">退稿</asp:ListItem>--%>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="tab-pane fade" id="Reward">
                <table class="table table-bordered table_padding0">
                    <tr>
                        <td class="text-right">发布悬赏</td>
                        <td>
                            <asp:DropDownList ID="BidType" CssClass="form-control" runat="server" onchange="changevalue(this.value);">
                                <asp:ListItem Value="0">选择方式</asp:ListItem>
                                <asp:ListItem Value="1">单人中标</asp:ListItem>
                                <asp:ListItem Value="2">记件工资</asp:ListItem>
                            </asp:DropDownList>
                            <div id="changeins" style="display: none">
                                我想要<asp:TextBox ID="pronum" Width="30px" runat="server" CssClass="l_input">0</asp:TextBox>
                                 个方案，每个
                                <asp:TextBox ID="bidmoney" Width="30px" runat="server" CssClass="l_input">0</asp:TextBox>
                                元
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-right">项目完成周期 </td>
                        <td>
                            <asp:TextBox ID="proweek" CssClass="form-control" runat="server"></asp:TextBox>天
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    <div class="Conent_fix">
        <asp:HiddenField runat="server" ID="JoinGID_Hid" />
        <asp:HiddenField ID="hidGID" runat="server" />
        <asp:HiddenField ID="nodename" runat="server" />
        <asp:Button ID="EBtnSubmit" CssClass="btn btn-primary" Text="添加项目" OnClick="EBtnSubmit_Click" runat="server" />
        <asp:Button ID="DraftBtn" CssClass="btn btn-primary" runat="server" OnClick="DraftBtn_Click" Text="存为草稿" />
        <asp:Button ID="EBtnBack" CssClass="btn btn-primary" Text="返回列表" OnClick="BtnBack_Click" runat="server" />
        <a href="javascript:;" id="toTop" onclick="pageScroll();"><i class="fa fa-angle-up"></i>top</a>
    </div>
<script>
    var zlconfig = {
        updir: "<%=ZoomLa.Components.SiteConfig.SiteOption.UploadDir.ToLower()%>",
        duptitlenum: "<%=ZoomLa.Components.SiteConfig.SiteOption.DupTitleNum%>" 
    };
</script>
<script type="text/javascript" src="/JS/ICMS/ZL_Common.js"></script>
<script type="text/javascript" src="/JS/DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="/JS/chinese.js"></script>
<script type="text/javascript" src="/JS/Common.js"></script>
<script type="text/javascript" src="/JS/Controls/ZL_Dialog.js"></script>
<script type="text/javascript" src="/JS/ICMS/tags.json"></script>
<script type="text/javascript" src="/JS/ZL_Content.js"></script>
</asp:Content>