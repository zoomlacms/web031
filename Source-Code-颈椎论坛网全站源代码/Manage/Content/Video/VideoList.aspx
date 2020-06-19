<%@ page language="C#" autoeventwireup="true" inherits="Manage_Content_Video_VideoList, App_Web_ycnmxeqx" masterpagefile="~/Manage/I/Default.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>视频列表</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" Runat="Server">
    <ZL:ExGridView ID="Egv" runat="server" AutoGenerateColumns="False" PageSize="10" 
        OnPageIndexChanging="Egv_PageIndexChanging" IsHoldState="false" AllowPaging="True" AllowSorting="True" 
        CssClass="table table-striped table-bordered table-hover" EnableTheming="False" EnableModelValidation="True" EmptyDataText="没有内容">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <input type="checkbox" name="idchk" value="<%#Eval("ID") %>" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="视频名称">
                <ItemTemplate>
                    <a href="VideoInfo.aspx?id=<%#Eval("ID") %>"><%#Eval("VName") %></a>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="VPath" HeaderText="视频地址" />
            <asp:BoundField DataField="VTime" HeaderText="视频长度" />
            <asp:BoundField DataField="CDate" HeaderText="创建时间" />
            <asp:BoundField DataField="Desc" HeaderText="备注" />
            <asp:TemplateField HeaderText="操作">
                <ItemTemplate>
                    <a href="VideoInfo.aspx?id=<%#Eval("ID") %>">修改</a>
                    <a href="VideoManage.aspx?id=<%#Eval("ID") %>">管理</a>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </ZL:ExGridView>

    <script type="text/javascript" src="/JS/Controls/ZL_Dialog.js"></script>
    <script>
        var diag = new ZL_Dialog();
        function ShowUpFile() {
            diag.title = "添加视频";
            diag.url = "/Plugins/WebUploader/webup.aspx?json={ashx:\"action=UPVideo\"}";
            diag.maxbtn = false;
            diag.reload = true;
            diag.ShowModal();
        }
        function AddAttach(file, ret, json) {
            window.location = location;
        }
        var videodiag = new ZL_Dialog();
        function VideoSet() {
            videodiag.title = "视频设置";
            videodiag.url = "VideoConfig.aspx";
            videodiag.maxbtn = false;
            videodiag.reload = true;
            videodiag.ShowModal();
        }
        function CloseVideo() {
            videodiag.CloseModal();
        }
    </script>
</asp:Content>
