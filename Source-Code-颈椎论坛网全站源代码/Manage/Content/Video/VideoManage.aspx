<%@ page language="C#" autoeventwireup="true" inherits="Manage_Content_Video_VideoManage, App_Web_ycnmxeqx" masterpagefile="~/Manage/I/Default.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head"><title>视频处理</title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
         <div class="panel panel-primary">
             <div class="panel-heading"><span class="margin_l5">视频处理</span></div>
              <div class="panel-body">
                  <table class="table table-bordered">
                       <tbody>
                       <tr>
                      <td class="td_m">来源视频:</td><td>
                          <asp:TextBox runat="server" ID="Source_T" CssClass="form-control" />
                          <input type="button" class="btn btn-default" onclick="SelVideos('Source_T')" value="选择视频" />
                          <input type="button" class="btn btn-default" value="预览视频" onclick="ViewVideo($('#Source_T').val());"/></td></tr>
                          <tr><td>目标格式:</td>
                              <td>
                                  <asp:DropDownList runat="server" ID="Format_DP" CssClass="form-control td_m">
                                      <asp:ListItem Value="flv" Selected="True">FLV</asp:ListItem>
                                    <%--  <asp:ListItem Value="wmv">WMV</asp:ListItem>
                                      <asp:ListItem Value="rmvb">RMVB</asp:ListItem>
                                      <asp:ListItem Value="rm">RM</asp:ListItem>
                                      <asp:ListItem Value="mpeg">MPEG</asp:ListItem>--%>
                                  </asp:DropDownList></td>
                          </tr>
                          <tr><td>操作:</td><td><asp:Button runat="server"  Text="开始转换" ID="Conver_Btn" OnClick="Conver_Btn_Click" class="btn btn-primary" /></td></tr>
                       </tbody>
                       <tbody>
                          <tr><td colspan="2" class="titletd"><i class="fa fa-tag"></i>视频合并(用于加入广告等)</td></tr>
                          <tr><td>选项:</td><td>
                              <label><input type="radio" name="merge_rad" value="front" checked="checked" />前面</label>
                              <label><input type="radio" name="merge_rad" value="behind" />后面</label><span class="rd_green">(将来源视频,插入至需合并视频)</span></td></tr>
                           <tr><td>需合并视频:</td><td>
                              <asp:TextBox runat="server" ID="Merge_T" CssClass="form-control" />
                              <input type="button" class="btn btn-default" onclick="SelVideos('Merge_T')" value="选择视频" />
                              <input type="button" class="btn btn-default" value="预览视频" onclick="ViewVideo($('#Merge_T').val());"/></td></tr>
                          <tr><td>操作:</td><td><asp:Button runat="server" ID="Merge_Btn" Text="开始合并" OnClick="Merge_Btn_Click" class="btn btn-primary" /></td></tr>
                      </tbody>
                      <tbody>
                          <tr><td colspan="2" class="titletd"><i class="fa fa-tag"></i>视频水印</td></tr>
                          <tr><td>水印图片:</td><td>
                              <asp:DropDownList runat="server" ID="WaterPos_DP" CssClass="form-control text_s">
                                  <asp:ListItem Value="1">左上</asp:ListItem>
                                  <asp:ListItem Value="2">右上</asp:ListItem>
                                  <asp:ListItem Value="3">左下</asp:ListItem>
                                  <asp:ListItem Value="4">右下</asp:ListItem>
                              </asp:DropDownList>
                               <asp:TextBox runat="server" ID="ImgWater_T" CssClass="form-control" Text="sign.png" />
                               <input type="button" value="选择图片" class="btn btn-default" /></td></tr>
                          <tr><td>操作:</td><td><asp:Button runat="server" ID="Water_Btn" Text="添加水印" OnClick="Water_Btn_Click" class="btn btn-primary"/></td></tr>
                      </tbody>
                      <tbody>
                            <tr><td colspan="2" class="titletd"><i class="fa fa-tag"></i>视频截图</td></tr>
                           <tr><td>截图时间</td><td>
                               <span>第</span><asp:TextBox runat="server" ID="CutImgSec_T" Text="60" CssClass="form-control text_xs" /><span>秒的截图</span>
                               <asp:Image runat="server" ID="PreView_Img" Visible="false" Width="110" Height="110" /></td></tr>
                           <tr><td>操作:</td><td><asp:Button runat="server" Text="获取截图" ID="CutImg_Btn" OnClick="CutImg_Btn_Click"  class="btn btn-primary"/></td></tr>
                      </tbody>
                      <tbody>
                          <tr><td colspan="2" class="titletd"><i class="fa fa-tag"></i>移除视频</td></tr>
                          <tr><td>选项:</td><td>
                              <label><input type="radio" name="remove_rad" value="front" checked="checked" />前面</label>
                              <label><input type="radio" name="remove_rad" value="behind" />后面</label>
                              <asp:TextBox runat="server" ID="RemoveSecond_T" CssClass="form-control text_xs" Text="60" /><span>秒</span>
                                          </td></tr>
                          <tr><td>操作:</td><td><asp:Button runat="server" ID="Remove_Btn" Text="开始移除" OnClick="Remove_Btn_Click" class="btn btn-primary" /></td></tr>
                      </tbody>
                  </table>
                  </div></div>
      <%--  <asp:FileUpload runat="server" ID="File_UP" />
        <asp:Button runat="server" ID="Button1" Text="开始转换" OnClick="Conver_Btn_Click" />
        <asp:Button runat="server" ID="Conver_Btn2" Text="开始转换2" OnClick="Conver_Btn2_Click" />
        <asp:Button runat="server" ID="Cut_Btn" Text="获取指定时间内的视频" OnClick="Cut_Btn_Click" />
        <asp:Button runat="server" ID="CutBegin_Btn" Text="移除前60秒的视频" OnClick="CutBegin_Btn_Click"/>
        <asp:Button runat="server" ID="CutEnd_Btn" Text="移除最后60秒的视频" OnClick="CutEnd_Btn_Click" />
        <asp:Button runat="server" ID="CutImg_Btn" Text="获取截图" OnClick="CutImg_Btn_Click" />
        <asp:Button runat="server" ID="GetVideo_Btn" Text="获取前60秒的视频" OnClick="GetVideo_Btn_Click"/>
        <asp:Button runat="server" ID="WaterMask_Btn" Text="添加水印" OnClick="WaterMask_Btn_Click" />
        <asp:Button runat="server" ID="Combine_Btn" Text="合并视频" OnClick="Combine_Btn_Click" />--%>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <style type="text/css">
        .titletd{background-color:#428bca;color:#fff;font-size:1.2em;}
    </style>
    <script src="/JS/Controls/ZL_Dialog.js"></script>
    <script>
        var diag = new ZL_Dialog();
        function ViewVideo(vpath) {
            if (vpath == "") { alert("请先选择需要预览的视频"); return false; }
            diag.title = "视频预览";
            diag.maxbtn = false;
            diag.url = "/PreView.aspx?vpath=" + vpath;
            diag.backdrop = false;
            diag.ShowModal();
        }
        function SelVideos(name) {
            diag.title = "选择视频";
            diag.url = "/Common/SelFiles.aspx?action=dbvideo&pval={\"name\":\"" + name + "\"}";
            diag.maxbtn = false;
            diag.ShowModal();
        }
        function PageCallBack(action, url, pval) {
            $("#" + pval.name).val(url.split('|')[0]);
            closeDiag();
        }
        function closeDiag() {
            diag.CloseModal();
        }
    </script>
</asp:Content>
