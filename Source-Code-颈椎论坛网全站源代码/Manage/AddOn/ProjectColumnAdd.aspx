﻿<%@ page language="C#" autoeventwireup="true" validaterequest="false" inherits="manage_AddOn_ProjectColumnAdd, App_Web_1y0j1chh" enableviewstatemac="false" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<!DOCTYPE HTML>
<html>
<head runat="server">
<title>添加项目字段</title>
<link href="../../App_Themes/AdminDefaultTheme/Guide.css" type="text/css" rel="stylesheet" />
<link href="../../App_Themes/AdminDefaultTheme/index.css" type="text/css" rel="stylesheet" />
<link href="../../App_Themes/AdminDefaultTheme/main.css" type="text/css" rel="stylesheet" />
<script language="javascript" type="text/javascript">
 function CheckColumn()
 {
   if(document.form1.TxtProjectConlumn.value=="")
    {
           alert("请输入字段名称！");
           form1.TxtProjectConlumn.focus();
           return false
     }
     if(document.form1.TxtAlias.value=="")
    {
           alert("请输入字段别名！");
           form1.TxtAlias.focus();
           return false
     }
     if(document.form1.TxtColumnDefault.value=="")
    {
           alert("请输入字段值！");
           form1.TxtColumnDefault.focus();
           return false
     }
 }
 function load()
 {        
    form1.TxtProjectConlumn.focus();
 }
</script>
</head>
<body onload="load()">
<form id="form1" runat="server">
<div class="r_navigation">
	<span>后台管理</span>&gt;&gt;<span><a href="ProjectManage.aspx">项目管理</a> </span>&gt;&gt;<span>字段添加</span>	</div> 
    <div class="clearbox"></div>  <table style="width: 100%; margin: 0 auto;" cellpadding="2" cellspacing="1" class="border">
    <tr align="center">
        <td colspan="2" class="spacingtitle">
            <asp:Label ID="LblTitle" runat="server" Text="项目字段添加" Font-Bold="True"></asp:Label>
            </td>
    </tr>
    <tr class="tdbg" onmouseover="this.className='tdbgmouseover'" onmouseout="this.className='tdbg'">
        <td class="tdbgleft" align="right" style="width: 105px">
            <strong>项目名称：&nbsp;</strong></td>
        <td class="tdbg" align="left">
        <asp:Label runat="server" Text="Label" ID="TxtProjectName"></asp:Label>             
            
        </td>
    </tr>
    <tr class="tdbg" onmouseover="this.className='tdbgmouseover'" onmouseout="this.className='tdbg'">
        <td class="tdbgleft" align="right" style="width: 105px">
            <strong>字段名称：&nbsp;</strong></td>
        <td class="tdbg" align="left">
            <asp:TextBox ID="TxtProjectConlumn" runat="server" class="l_input"></asp:TextBox>            
        </td>
    </tr>
    <tr class="tdbg" onmouseover="this.className='tdbgmouseover'" onmouseout="this.className='tdbg'">
        <td class="tdbgleft" align="right" style="width: 105px">
            <strong>字段别名：&nbsp;</strong></td>
        <td class="tdbg" align="left">
            <asp:TextBox ID="TxtAlias" runat="server" class="l_input"></asp:TextBox> 
            <asp:RegularExpressionValidator ID="ValeTableName" runat="server" ControlToValidate="TxtAlias"
                ErrorMessage="只允许输入字母、数字或下划线" ValidationExpression="^[\w_]+$" SetFocusOnError="true"
                Display="Dynamic" />                         
        </td>
    </tr>
    <tr class="tdbg" onmouseover="this.className='tdbgmouseover'" onmouseout="this.className='tdbg'">
        <td class="tdbgleft" align="right" style="width: 105px">
            <strong>字段类型：&nbsp;</strong></td>
        <td class="tdbg" align="left">
            <asp:DropDownList ID="DDLFieldType" runat="server">
            <asp:ListItem Text="数字" Value="int" Selected="True"></asp:ListItem>
            <asp:ListItem Text="时间" Value="datetime"></asp:ListItem>
            <asp:ListItem Text="字符(字节存储)" Value="varchar"></asp:ListItem>
            <asp:ListItem Text="字符(字符存储)" Value="nvarchar"></asp:ListItem>
            <asp:ListItem Text="文本(字节存储)" Value="Text"></asp:ListItem>
            <asp:ListItem Text="文本(字符存储)" Value="nText"></asp:ListItem>
            </asp:DropDownList>
        </td>
    </tr>          
    <tr class="tdbg" onmouseover="this.className='tdbgmouseover'" onmouseout="this.className='tdbg'">
        <td class="tdbgleft" align="right" style="width: 105px;">
            <strong>字段值：&nbsp;</strong></td>
        <td class="tdbg" align="left">
                           <asp:TextBox ID="TxtColumnDefault" runat="server" class="l_input"></asp:TextBox> 
            <asp:CheckBox ID="CBdoc" runat="server" Text="上传文档" OnCheckedChanged="CBdoc_CheckedChanged" AutoPostBack="true"/>
            <asp:FileUpload ID="FileUpload1" runat="server" Height="21px"  Visible="false"/>
            <asp:Button ID="Button1" runat="server" Visible="false" OnClick="Button1_Click" Text="上传" Width="58px" class="C_input"/></td>
    </tr>   
    <tr class="tdbgbottom">
        <td colspan="2">
          <asp:Button ID="EBtnModify" Text="修改" OnClick="EBtnModify_Click" runat="server" Visible="false" class="C_input"/>
            <asp:Button ID="EBtnSubmit" Text="保存"  runat="server" OnClientClick="return CheckColumn();" OnClick="EBtnSubmit_Click" class="C_input"/>&nbsp;&nbsp;
            <asp:Button ID="BtCanCel" Text="取消" OnClick="CanCel_Click" runat="server" class="C_input"/>
        </td>
    </tr>        
</table>
 <div class="clearbox"></div>  
<asp:GridView ID="Egv" runat="server" AllowPaging="True" AutoGenerateColumns="False" CssClass="border"
       DataKeyNames="ID" PageSize="8" OnPageIndexChanging="Egv_PageIndexChanging" Width="100%" OnRowCommand="GridView1_RowCommand" EmptyDataText="无任何相关数据">
        <Columns>
            <asp:TemplateField HeaderText="选择" ItemStyle-HorizontalAlign="Center">
                  <ItemTemplate>
                      <asp:CheckBox ID="chkSel" runat="server" />
                  </ItemTemplate>
                  <HeaderStyle Width="4%" />
                  <ItemStyle CssClass="tdbg" HorizontalAlign="Center" />
            </asp:TemplateField> 
               <asp:TemplateField HeaderText="字段名称" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>  
                    <%#DataBinder.Eval(Container.DataItem, "FieldName").ToString()%>      
                </ItemTemplate>
                <HeaderStyle Width="35%" />
                <ItemStyle CssClass="tdbg" HorizontalAlign="Center" />
            </asp:TemplateField>     
             <asp:BoundField DataField="Alias" HeaderText="字段别名" ItemStyle-HorizontalAlign="Center">
                <HeaderStyle Width="25%" />
                <ItemStyle CssClass="tdbg" HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="Type" HeaderText="字段类别" ItemStyle-HorizontalAlign="Center">
                <HeaderStyle Width="25%" />
                <ItemStyle CssClass="tdbg" HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="操作" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>     
                <asp:LinkButton ID="LinkButton1"  runat="server" CommandName="ModifyField" CommandArgument='<%# Eval("ID")%>'>修改</asp:LinkButton>                   
                    <asp:LinkButton ID="LnkDelete"  runat="server" CommandName="DelField" OnClientClick="return confirm('确实要删除吗？');"
                        CommandArgument='<%# Eval("ID")%>'>删除</asp:LinkButton>                         
                    </ItemTemplate>
                  <ItemStyle CssClass="tdbg" HorizontalAlign="Center" />
            </asp:TemplateField>
        　</Columns>
         <RowStyle ForeColor="Black" BackColor="#DEDFDE" Height="25px" />
        <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
        <PagerStyle CssClass="tdbg" ForeColor="Black" HorizontalAlign="Center" />
        <HeaderStyle CssClass="tdbg" Font-Bold="True" ForeColor="#E7E7FF" BorderStyle="None" Height="30px" Font-Overline="False" />
        <PagerSettings FirstPageText="第一页" LastPageText="最后页" Mode="NextPreviousFirstLast" NextPageText="下一页" PreviousPageText="上一页" />
    </asp:GridView>
            <div class="clearbox"></div>                    
    <asp:CheckBox ID="cbAll" runat="server" AutoPostBack="True" Font-Size="9pt" OnCheckedChanged="cbAll_CheckedChanged"
        Text="全选" />      
    
    <asp:Button ID="btnDel" runat="server" Text="批量删除" OnClick="btnDel_Click" OnClientClick="if(!IsSelectedId()){alert('请选择删除项');return false;}else{return confirm('你确定要将所有选择项删除吗？')}" class="C_input"/>
</form>
</body>
</html>