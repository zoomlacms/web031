<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/User/Empty.master" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <style type="text/css">
       .main {height: 400px;overflow: hidden;padding: 10px;margin-bottom: 10px;border: 1px solid #e3e3e3;}
    </style>
    <title>力导向网络拓扑图</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
     <div id="main" class="main"></div>
        <div>
            <button type="button" class="btn btn-sm btn-success" onclick="refresh(true)">刷 新</button></div>
     <textarea id="code" style="display:none;"></textarea>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Script">
    <script>
        $(function () {
           $("#code").val($(parent.document).find("#code").val());
        })
    </script>
    <script src="/Plugins/ECharts/build/source/echarts.js"></script>
    <script src="/Plugins/ECharts/ZL_Echarts.js"></script>
</asp:Content>