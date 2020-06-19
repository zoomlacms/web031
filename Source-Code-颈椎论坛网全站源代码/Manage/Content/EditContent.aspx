﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditContent.aspx.cs" Inherits="V_Content_EditContent" MasterPageFile="~/Manage/I/Default.master" ClientIDMode="Static" ValidateRequest="false"  Debug="true" %>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="head">
<title>修改内容</title>
<script type="text/javascript" charset="utf-8" src="/Plugins/Ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="/Plugins/Ueditor/ueditor.all.js"></script>
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
</style>
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="Content">
  <asp:HiddenField ID="nodename" runat="server" />
  <div class="tabbable">
    <ul class="nav nav-tabs">
      <li class="active"><a href="#ConInfo" data-toggle="tab">内容信息</a></li>
      <li><a href="#InfoAttr" data-toggle="tab">信息属性</a></li>
      <li><a href="#Process " data-toggle="tab">流程控制</a></li>
      <li><a href="#Reward " data-toggle="tab">悬赏定义</a></li>
      <li class="content_tem_li" runat="server" id="Remind_Li" visible="false"> <a href="#InfoAttr" data-toggle="tab" title="提示：该内容启用了个性模板"></a> </li>
    </ul>
    <div class="tab-content">
      <div class="tab-pane active" id="ConInfo" >
        <table class="table table-bordered table_padding0">
          <tr>
            <td style="overflow-x:hidden;" class="col-sm-1 col-xs-1 text-right"><asp:Label ID="bt_txt" runat="server" Text="标题"></asp:Label></td>
            <td class="col-sm-11 col-xs-11"><asp:TextBox ID="txtTitle" style="background:url(/Images/bg1.gif) repeat-x;" CssClass="form-control m715-50" onblur="getstrKeys()" onkeyup="isgoEmpty('txtTitle','span_txtTitle');Getpy('txtTitle','PYtitle')" runat="server" Text=''></asp:TextBox>
              <span id="span_txtTitle" name="span_txtTitle"></span><span><span class="vaild_tip">*</span></span>
               <a href="javascript:;" id="Button3" onclick="ShowTitle()" class="btn btn-info btn-sm" ><i class="fa fa-info"></i> 标题属性</a>
               <button type="button" class="btn btn-info btn-sm" onclick="ShowContentList()"><i class="fa fa-chain"></i> 关联内容</button>
              <asp:HiddenField ID="ThreadStyle" runat="server" />
                <div id="duptitle_div" class="alert alert-warning" style="position: absolute; margin-left: 315px; display: none;">
                    <ul id='duptitle_ul'></ul>
                </div>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="txtTitle">内容标题必填</asp:RequiredFieldValidator></td>
          </tr>
          <tbody id="Sys_Fied" runat="server">
            <tr>
              <td  class="text-right"><asp:Label ID="Label7" runat="server" Text="拼音缩写"></asp:Label></td>
              <td><asp:TextBox ID="PYtitle" runat="server" Text='' CssClass="form-control m715-50"></asp:TextBox></td>
            </tr>
              <tr id="spec_tr">
                  <td class="text-right">所属专题&nbsp;&nbsp;</td>
                        <td>
                            <div class="specDiv"></div>
                            <span id="specbtn_span"><asp:Literal ID="SpecInfo_Li" runat="server"></asp:Literal></span>
                            <asp:HiddenField ID="Spec_Hid" runat="server" />
                        </td>
                    </tr>
            <tr>
              <td class="tdbgleft text-right"><asp:Label ID="gjz_txt" runat="server" Text="关键字"></asp:Label>
                </td>
              <td class="bqright">              
                 <div id="OAkeyword" style="display:inline-block;min-width:300px;"></div>
                 <asp:TextBox ID="Keywords" runat="server" CssClass="form-control" /><span class="rd_green">(使用空格键或回车键分隔关键字，每个关键字长度不超过5个)</span>  
              </td>
            </tr>
            <tr>
              <td class="text-right"><asp:Label ID="Label21" runat="server" Text="副标题"></asp:Label></td>
              <td><asp:TextBox ID="Subtitle" runat="server" Text='' Width="41%" CssClass="form-control pill-left" TextMode="SingleLine"></asp:TextBox></td>
            </tr>
             <tr>
            
         </tr>
          </tbody>
          <asp:Literal ID="ModelHtml" runat="server"></asp:Literal>
          <tr>
            <td class="text-right" style="height:100px;">
              <asp:Label ID="Label6" runat="server" Text="附属图片"></asp:Label></td>
            <td >                             
                <select name="selectpic" id="selectpic" class="form-control text_300">
                <option value="" selected="selected">不指定编辑器扩展图</option></select>
                <div class="clearfix"></div>
                <ul id="ThumImg_ul" class="preview_img_ul">
                    <div class="clearfix"></div>
                </ul>
            </td>
          </tr>
          <tr id="CreateHTML" runat="server">
            <td  align="right"><asp:Label ID="Label4" runat="server" Text="生成"></asp:Label></td>
            <td><asp:CheckBox ID="quickmake" runat="server" Checked="true" Text="是否立即生成" /></td>
          </tr>
        </table>
      </div>
      <div class="tab-pane fade" id="InfoAttr">
        <table class="table table-bordered table_padding0">
          <tr>
            <td align="right"><span>录入者</span></td>
            <td><asp:TextBox ID="txtInputer" CssClass="form-control text_md" runat="server"></asp:TextBox></td>
          </tr>
          <tr>
            <td align="right"><span>添加时间</span></td>
            <td><asp:TextBox ID="txtAddTime" CssClass="form-control text_md" runat="server" onclick="WdatePicker({ dateFmt: 'yyyy-MM-dd HH:mm:ss' });"></asp:TextBox></td>
          </tr>
          <tr>
            <td align="right"><span>更新时间</span></td>
            <td><asp:TextBox ID="txtdate" CssClass="form-control text_md" runat="server" onclick="WdatePicker({ dateFmt: 'yyyy-MM-dd HH:mm:ss' });"></asp:TextBox></td>
          </tr>
          <tr>
            <td align="right"><asp:Label ID="hits_txt" runat="server" Text="点击数"></asp:Label></td>
            <td><asp:TextBox ID="txtNum" CssClass="form-control text_md" runat="server"></asp:TextBox></td>
          </tr>
            <td class="text-right">允许评论</td>
            <td>
                <asp:RadioButtonList ID="IsComm_Radio" runat="server" CssClass="pull-left" RepeatColumns="2">
                    <asp:ListItem Value="1" Selected="True">是</asp:ListItem>
                    <asp:ListItem Value="0">否</asp:ListItem> 
                </asp:RadioButtonList> <span class="pull-left rd_green">(该操作只在节点管理下配置了允许发表评论时生效!)</span>
            </td>
          <tr>
            <td align="right"><span>个性模板</span></td>
            <td><asp:TextBox ID="TxtTemplate" CssClass="form-control text_md" runat="server" Columns="50"></asp:TextBox>
              <input type="button" value="选择模板" onclick="ShowDiag('../Template/TemplateList.aspx?OpenerText=' + escape('TxtTemplate') + '&FilesDir=','选择模板')" class="btn btn-primary" /></td>
          </tr>
          <tr id="outpdf">
            <td align="right"><asp:Button runat="server" ID="makePDFBtn" Text="生成PDF" CssClass="btn btn-primary btn-xs" OnClick="makePDFBtn_Click" /></td>
            <td><asp:LinkButton runat="server" ID="downPdfHref" ToolTip="点击下载" OnClick="downPdfBtn_Click" Visible="false"> <img src="/Plugins/ckfinder/skins/kama/images/icons/16/pdf.gif" class="content_d_img"/> </asp:LinkButton>
              <asp:LinkButton runat="server" ID="delPdfHref" ToolTip="删除" OnClick="delPdfBtn_Click" OnClientClick="return confirm('确定要删除吗!')" Visible="false"> <img src="/App_Themes/AdminDefaultTheme/images/del.png" class="content_d_img"/> </asp:LinkButton></td>
          </tr>
          <tr id="outword">
            <td align="right"><asp:Button runat="server" ID="makeWordBtn" Text="生成Word" CssClass="btn btn-primary btn-primary btn-xs" OnClick="makeWordBtn_Click" /></td>
            <td><asp:LinkButton runat="server" ID="downWordHref" ToolTip="点击下载" OnClick="downWordBtn_Click" Visible="false"> <img src="/Plugins/Ueditor/themes/default/images/word.gif" class="content_d_img"/></asp:LinkButton>
              <asp:LinkButton runat="server" ID="delWordHref" ToolTip="删除" OnClick="delWordBtn_Click" OnClientClick="return confirm('确定要删除吗!')" Visible="false"> <img src="/App_Themes/AdminDefaultTheme/images/del.png" class="content_d_img"/></asp:LinkButton></td>
          </tr>
        </table>
      </div>
      <div class="tab-pane fade" id="Process">
        <table class="table table-bordered">
          <tr>
            <td align="right"><asp:Label ID="tj_txt" runat="server" Text="推荐级别"></asp:Label></td>
            <td><asp:CheckBox ID="ChkAudit" Text="推荐" runat="server" /></td>
          </tr>
          <tr>
            <td align="right"><asp:Label ID="zht_txt" runat="server" Text="状态"></asp:Label></td>
            <td><asp:RadioButtonList ID="ddlFlow" runat="server" RepeatDirection="Horizontal" RepeatColumns="5">
              </asp:RadioButtonList></td>
          </tr>
          
        </table>
      </div>
      <div class="tab-pane fade" id="Reward">
        <table class="table table-bordered table_padding0">
          <tr>
            <td align="right"><asp:Label ID="Label3" runat="server" Text="发布悬赏"></asp:Label></td>
            <td><asp:DropDownList ID="BidType" CssClass="form-control text_md" runat="server" onchange="changevalue(this.value);">
                <asp:ListItem Value="0">选择方式</asp:ListItem>
                <asp:ListItem Value="1">单人中标</asp:ListItem>
                <asp:ListItem Value="2">记件工资</asp:ListItem>
              </asp:DropDownList>
              <div id="changeins" style="display: none"> 我想要
                <asp:TextBox ID="pronum" Width="30px" runat="server" CssClass="form-control text_xs">0</asp:TextBox>
                个方案，每个
                <asp:TextBox ID="bidmoney" Width="30px" runat="server" CssClass="form-control text_xs">0</asp:TextBox>
                元 </div></td>
          </tr>
          <tr id="bidmoneytable">
            <td align="right"><asp:Label ID="Label5" runat="server" Text="项目完成周期"></asp:Label></td>
            <td><asp:TextBox ID="proweek" runat="server" Width="60" CssClass="form-control text_xs">0</asp:TextBox>
              天 </td>
          </tr>
        </table>
      </div>
    </div>
  </div>
  <div class="Conent_fix">
       <asp:HiddenField ID="JoinGID_Hid" runat="server" Value="" />
      <asp:Button ID="EBtnSubmit" CssClass="btn btn-primary" Text="保存项目" runat="server" OnClick="EBtnSubmit_Click" />
      <asp:Button ID="Button1" CssClass="btn btn-primary" Text="添加为新项目" runat="server" OnClick="Button1_Click" />
      <a href="javascript:history.go(-1);" class="btn btn-primary">返回列表</a>
      <a href="javascript:;" id="toTop" onclick="pageScroll();"><i class="fa fa-angle-up"></i>top</a>
      <asp:Button ID="BtnDoc" CssClass="btn btn-primary" runat="server" OnClientClick="return generate('docTitle','docParamValue');" Text="重新生成文档" Visible="false" />
  </div>    
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
<script type="text/javascript">
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
<script type="text/javascript" src="/JS/ZL_Content.js"></script>
<script type="text/javascript" src="/JS/OAKeyWord.js"></script>
<script>
    function SelPic(value) {
        $("#selectpic").bind("changedata",function(){
            $("#selectpic").val(value); 
        });
    }
</script>
</asp:Content>