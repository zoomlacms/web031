<%@ page language="C#" masterpagefile="~/User/Default.master" autoeventwireup="true" inherits="User_UserZone_StyleSet, App_Web_sxb24a2x" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<%@ Register Src="WebUserControlTop.ascx" TagName="WebUserControlTop" TagPrefix="uc1" %>
<asp:Content ContentPlaceHolderID="head" runat="Server">
    <title>我的空间</title>
    <style> 
	.padding5{ padding-left:5px; padding-right:5px;} 
	.us_topinfo li{ float:left; width:10%;}
	.us_topinfo div li{ width:100%;}
	.user_temp{ padding:4px; border:1px solid #ddd; border-radius:4px; background:#f5f5f5;}
	.user_temp img{ width:100%; height:200px;}
	.user_temp span{ display:block; text-align:center; padding-top:0.5em; }
 	.user_temp span a{ font-size:1em; text-decoration:underline;} 
	@media srceen and(max width:768px){
	.us_topinfo li{ width:33%;}
		
	}
	</style>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <ol class="breadcrumb">
        <li>您现在的位置：<a title="网站首页" href="/"><%= Call.SiteName%></a></li>
        <li><a title="会员中心" href="/User/Default.aspx">会员中心</a></li>
        <li class="active">设定空间模板</li>
    </ol>    
    <uc1:WebUserControlTop ID="WebUserControlTop1" runat="server"></uc1:WebUserControlTop>
    <div class="clearfix"></div>
    <div class="us_topinfo btn-group" style="margin-top: 10px;">
         <a href="/user/userzone/StyleSet.aspx">设定空间模板</a> | (当前模板:<asp:Label ID="StyleNameLB" runat="server" Text="Label"></asp:Label>)
    </div> 
    <div class="us_topinfo" style="margin-top: 10px;">
        <ul class="list-ustyled">
        <ZL:ExRepeater runat="server" ID="RPT" PageSize="12" PagePre="<li class='text-center'>" PageEnd="</li>" OnItemCommand="RPT_ItemCommand"> 
            <ItemTemplate>
              <li class=" padding5">
                    <div class="user_temp text-center">             
                            <asp:Image ID="Image1" runat="server" CssClass="center-block" onerror="this.src='/Images/nopic.gif';" ImageUrl='<%#GetImg(DataBinder.Eval(Container.DataItem, "ID").ToString())%>' />    
                            <span><%#Eval("StyleName", "{0}")%></span>
                            <asp:LinkButton runat="server" CommandArgument='<%#Eval("ID")%>' CssClass="btn btn-sm btn-primary" CommandName="set">设为模板</asp:LinkButton> 
                     <div class="clearfix"></div>              
                    </div>
                </li>             
            </ItemTemplate>
        <FooterTemplate><div class="clearfix"></div></FooterTemplate> 
    </ZL:ExRepeater>
    </ul>        
    </div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <script language="javascript">
        function CheckAll(spanChk)//CheckBox全选
        {
            var oItem = spanChk.children;
            var theBox = (spanChk.type == "checkbox") ? spanChk : spanChk.children.item[0];
            xState = theBox.checked;
            elm = theBox.form.elements;
            for (i = 0; i < elm.length; i++)
                if (elm[i].type == "checkbox" && elm[i].id != theBox.id) {
                    if (elm[i].checked != xState)
                        elm[i].click();
                }
        }
    </script>
</asp:Content>