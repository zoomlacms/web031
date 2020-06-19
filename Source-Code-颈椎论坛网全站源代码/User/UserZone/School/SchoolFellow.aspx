<%@ page language="C#" autoeventwireup="true" masterpagefile="~/User/Default.master" inherits="User_UserZone_School_SchoolFellow, App_Web_xahs10jg" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<%@ Register Src="../WebUserControlTop.ascx" TagName="WebUserControlTop" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<title>班级列表</title>
<link href="../../../App_Themes/UserThem/user_user.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<div class="us_topinfo">
您现在的位置：<a title="网站首页" href="/" target="_blank"><asp:Label ID="LblSiteName" runat="server" Text="Label"></asp:Label></a>&gt;&gt;<a title="会员中心" href='<%=ResolveUrl("~/User/Default.aspx") %>' target="_parent">会员中心</a>&gt;&gt;<a href="mySchoolList.aspx">我的班级</a>&gt;&gt;班级信息
</div>
<uc1:WebUserControlTop ID="WebUserControlTop1" runat="server"></uc1:WebUserControlTop>
&nbsp;
<br />
<div class="us_topinfo">
	<div>
		<a href="mySchoolList.aspx">我的班级 </a>&gt;&gt; 查找我的同学<hr />
	</div>
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td>
				输入姓名：<asp:TextBox ID="txtName" CssClass="form-control" runat="server"></asp:TextBox><asp:Button ID="Button1"
					runat="server" Text="查  找" CssClass="btn btn-primary" OnClick="MyBind" />
				<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName"
					ErrorMessage="请输入要查找的同学姓名"></asp:RequiredFieldValidator>
			</td>
		</tr>
		<tr>
			<td id="tdSelect" runat="server">
                 <ZL:ExGridView runat="server" ID="EGV" AutoGenerateColumns="false" AllowPaging="true" PageSize="10"  EnableTheming="False"  
                CssClass="table table-striped table-bordered table-hover" EmptyDataText="没有相关信息!!" 
                OnPageIndexChanging="EGV_PageIndexChanging" >			 
					<Columns>
						<asp:BoundField DataField="UserName" HeaderText="用户名" HeaderStyle-Width="20%" />
						<asp:TemplateField HeaderText="真实姓名" HeaderStyle-Width="20%">
							<ItemTemplate>
								<%#GetUserName(DataBinder.Eval(Container.DataItem, "UserID").ToString ())%>
							</ItemTemplate>
						</asp:TemplateField>
						<asp:TemplateField HeaderText="学校" HeaderStyle-Width="30%">
							<ItemTemplate>
								<%#GetSchool(DataBinder.Eval(Container.DataItem, "SchoolID").ToString ())%>
							</ItemTemplate>
						</asp:TemplateField>
						<asp:TemplateField HeaderText="班级" HeaderStyle-Width="20%">
							<ItemTemplate>
								<%#GetRoom(DataBinder.Eval(Container.DataItem, "RoomID").ToString())%>
							</ItemTemplate>
						</asp:TemplateField>
					</Columns>
				  <PagerStyle HorizontalAlign="Center" />
                <RowStyle Height="24px" HorizontalAlign="Center"  />
        </ZL:ExGridView>
			</td>
		</tr>
		 
	</table>
</div>
</asp:Content>