﻿<%@ page title="" language="C#" masterpagefile="~/User/Default.master" autoeventwireup="true" inherits="CN_nite_VideoHouseApplyManage, App_Web_30em2mko" clientidmode="Static" enableviewstatemac="false" enableEventValidation="false" viewStateEncryptionMode="Never" %>

<asp:Content ContentPlaceHolderID="Head" runat="Server">
   <title>视频房间申请列表</title>
</asp:Content>
   

<asp:Content ContentPlaceHolderID="Content" runat="Server"> 
    <ol class="breadcrumb">
        <li>您现在的位置：<a title="网站首页" href="/"><%= Call.SiteName%></a></li>
        <li><a title="会员中心" href="/User/Default.aspx">会员中心</a></li>
        <li class="active">视频房间申请管理</li><a href="VideoHouseApply.aspx">[申请房间]</a>
    </ol><asp:HiddenField ID="Hidd" runat="server" /> 

<table  class="table table-bordered table-hover table-striped">
  <tr align="center">
    <td width="10%" class="title">房间编号</td>
    <td width="15%" class="title">房间名称</td>
    <td width="20%" class="title">职位名称</td>
    <td width="20%" class="title">申请时间</td>     
    <td width="15%" class="title">操作</td>
  </tr>
    <asp:Repeater ID="gvCard" runat="server"> 
    <ItemTemplate>
  <tr class="tdbg" onmouseover="this.className='tdbgmouseover'" onmouseout="this.className='tdbg'">   
    <td height="22" align="center"><%#Eval("Rid")%></td>   
    <td height="22" align="center"><%#Eval("Rname")%></td>
    <td height="22" align="center"><%#GetJobname(Eval("RJob","{0}"))%></td>
    <td height="22" align="center"><%#Eval("Dredgetime")%></td>
    <td height="22" align="center">
        <a href="VideoHouseApply.aspx?EidteID=<%#Eval("Rid")%>">编辑</a>&nbsp;&nbsp;        
        <a href="VideoHouseApplyManage.aspx?ID=<%#Eval("Rid")%>" onclick="return confirm('确定删除该信息吗？删除后该信息不可恢复!');">删除</a>&nbsp;&nbsp;
    </td>
  </tr>
    </ItemTemplate>
    </asp:Repeater>
    <tr class="tdbg">
    <td height="22" colspan="5" align="center" class="tdbgleft">
    共
    <asp:Label ID="Allnum" runat="server" Text=""></asp:Label>
    个信息
    <asp:Label ID="Toppage" runat="server" Text="" />
    <asp:Label ID="Nextpage" runat="server" Text="" />
    <asp:Label ID="Downpage" runat="server" Text="" />
    <asp:Label ID="Endpage" runat="server" Text="" />
    页次：<asp:Label ID="Nowpage" runat="server" Text="" />/<asp:Label ID="PageSize" runat="server"
        Text="" />页
    <asp:Label ID="pagess" runat="server" Text="" />个信息/页 转到第<asp:DropDownList ID="DropDownList1"
        runat="server" AutoPostBack="True" 
            onselectedindexchanged="DropDownList1_SelectedIndexChanged">
    </asp:DropDownList>
    页
          </td>
  </tr>
</table>
</asp:Content>    
