<%@ page title="" language="C#" masterpagefile="~/User/Default.master" autoeventwireup="true" inherits="User_UserShop_ProductList, App_Web_0ihne1vk" clientidmode="Static" validaterequest="false" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<%@ Register Src="WebUserControlTop.ascx" TagName="WebUserControlTop" TagPrefix="uc2" %>
<asp:Content ContentPlaceHolderID="head" runat="Server">
    <title>商品列表</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <ol class="breadcrumb">
        <li>您现在的位置：<a title="网站首页" href="/"><%= Call.SiteName%></a></li>
        <li><a title="会员中心" href="/User/Default.aspx">会员中心</a></li>
        <li><a href="ProductList.aspx">店铺商品管理</a></li>
    </ol>
    <uc2:WebUserControlTop ID="WebUserControlTop1" runat="server" />
    <asp:Label ID="lblAddContent" runat="server" Text=""></asp:Label>
    <div class="us_topinfo" style="margin-top: 10px;">
        <table class="table table-bordered">
            <tbody id="Tabs">
                <tr class="tdbg">
                    <td width="34%" align="center">快速查找：
                        <asp:DropDownList ID="quicksouch" CssClass="form-control" runat="server" AutoPostBack="True">
                            <asp:ListItem Value="1">所有商品</asp:ListItem>
                            <asp:ListItem Value="2">正在销售的商品</asp:ListItem>
                            <asp:ListItem Value="3">未销售的商品</asp:ListItem>
                            <asp:ListItem Value="4">正常销售的商品</asp:ListItem>
                            <asp:ListItem Value="5">特价处理的商品</asp:ListItem>
                            <asp:ListItem Value="6">所有热销的商品</asp:ListItem>
                            <asp:ListItem Value="7">所有新品</asp:ListItem>
                            <asp:ListItem Value="8">所有精品商品</asp:ListItem>
                            <asp:ListItem Value="9">有促销活动的商品</asp:ListItem>
                            <asp:ListItem Value="10">实际库存报警的商品</asp:ListItem>
                            <asp:ListItem Value="11">预定库存报警的商品</asp:ListItem>
                            <asp:ListItem Value="12">已售完的商品</asp:ListItem>
                            <asp:ListItem Value="13">所有批发商品</asp:ListItem>
                            <asp:ListItem Value="14">团购商品</asp:ListItem>
                            <asp:ListItem Value="15">竞拍商品</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td width="66%" align="center">高级查询：
                        <asp:DropDownList ID="souchtable" CssClass="form-control" Width="150" runat="server">
                            <asp:ListItem Value="0" Selected="True">请选择</asp:ListItem>
                            <asp:ListItem Value="1">商品名称</asp:ListItem>
                            <asp:ListItem Value="2">商品简介</asp:ListItem>
                            <asp:ListItem Value="3">商品介绍</asp:ListItem>
                            <asp:ListItem Value="4">厂商</asp:ListItem>
                            <asp:ListItem Value="5">品牌/商标</asp:ListItem>
                            <asp:ListItem Value="6">条形码</asp:ListItem>
                        </asp:DropDownList>
                        <asp:TextBox ID="souchkey" CssClass="form-control" runat="server" />
                        <asp:Button ID="souchok" CssClass="btn btn-primary" runat="server" Text=" 搜索 " OnClick="souchok_Click" />
                    </td>
                </tr>
            </tbody>
        </table>
        <div>
            <!-- Nav tabs -->
            <ul class="nav nav-tabs">
                <li class="active"><a href="#Tabs4" onclick="ShowTabs(0)" data-toggle="tab">正常销售</a></li>
                <li><a href="#Tabs14" onclick="ShowTabs(1)" data-toggle="tab">团购</a></li>
                <li><a href="#Tabs15" onclick="ShowTabs(2)" data-toggle="tab">竞拍</a></li>
            </ul>
             <ZL:ExGridView ID="EGV" runat="server" AutoGenerateColumns="False" DataKeyNames="id" PageSize="10" OnRowDataBound="Egv_RowDataBound" OnPageIndexChanging="Egv_PageIndexChanging" IsHoldState="false" OnRowCommand="Egv_RowCommand" AllowPaging="True" AllowSorting="True" CssClass="table table-striped table-bordered table-hover" EnableTheming="False" EnableModelValidation="True" EmptyDataText="无相关数据！！">
            <Columns>
                <asp:TemplateField HeaderStyle-Width="3%" HeaderText="ID">
                    <ItemTemplate>
                        <input type="checkbox" name="idchk" value='<%#Eval("id") %>' />
                        <%#Eval("ID") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="商品图片">
                    <HeaderStyle CssClass="td_m" />
                    <ItemTemplate>
                        <a href="ShowProduct.aspx?menu=edit&ModelID=<%#Eval("ModelID") %>&NodeID=<%#Eval("Nodeid") %>&id=<%#Eval("id")%>">
                            <img src="<%#getproimg() %>" style="width:50px;height:50px;" />
                        </a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="商品名称">
                    <HeaderStyle Width="17%" />
                    <ItemTemplate>
                        <a href="/Store/Shopinfo.aspx?ID=<%#Eval("ID") %>" title="预览" target="_blank"><%#Eval("proname")%></a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderText="单位" DataField="ProUnit" HeaderStyle-Width="5%" />
                <asp:TemplateField HeaderText="库存">
                    <HeaderStyle Width="5%" />
                    <ItemTemplate>
                        <%#Stockshow(DataBinder.Eval(Container,"DataItem.id","{0}"))%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="价格">
                    <HeaderStyle Width="6%" />
                    <ItemTemplate>
                        <%#GetPrice()%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="类型">
                    <HeaderStyle Width="6%" />
                    <ItemTemplate>
                        <%#formatnewstype(DataBinder.Eval(Container,"DataItem.ProClass","{0}"),Eval("id","{0}"))%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderText="推荐" DataField="Dengji" HeaderStyle-Width="5%" />
                <asp:TemplateField HeaderText="商品属性">
                    <HeaderStyle Width="6%" />
                    <ItemTemplate>
                        <%#forisbest(DataBinder.Eval(Container,"DataItem.isbest","{0}"))%>
                        <%#forishot(DataBinder.Eval(Container,"DataItem.ishot","{0}"))%>
                        <%#forisnew(DataBinder.Eval(Container,"DataItem.isnew","{0}"))%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="销售中">
                    <HeaderStyle Width="6%" />
                    <ItemTemplate>
                        <%#formattype(DataBinder.Eval(Container,"DataItem.Sales","{0}"))%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="排序">
                    <HeaderStyle Width="7%" />
                    <ItemTemplate>
                        <asp:LinkButton ID="UpMove" CommandName="UpMove" CommandArgument='<%# Eval("ID") %>' runat="server" >上移</asp:LinkButton>
                        <asp:LinkButton ID="DownMove" CommandName="DownMove" CommandArgument='<%# Eval("ID") %>' runat="server" >下移</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="操作">
                    <HeaderStyle Width="12%" />
                    <ItemTemplate>
                        <a href="/Store/Shopinfo.aspx?ID=<%#Eval("ID") %>"  title="预览" target="_blank">预览</a>
                        <a href="AddProduct.aspx?menu=edit&ModelID=<%#Eval("ModelID") %>&NodeID=<%#Eval("Nodeid") %>&id=<%#Eval("id")%>">修改</a>
                        <asp:LinkButton ID="Del1" runat="server" CommandName="Del1" CommandArgument='<%# Eval("id") %>' OnClientClick="return confirm('确定要将商品移入回收站吗');" >删除</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </ZL:ExGridView>
            <table class="table table-striped table-bordered table-hover">
                <tr>
                    <td class="text-center">
                        <asp:Button ID="Button1" CssClass="btn btn-primary" runat="server" Text="开始销售" OnClick="Button1_Click" />
                        <asp:Button ID="Button2" CssClass="btn btn-primary" runat="server" Text="设为热卖" OnClick="Button2_Click" />
                        <asp:Button ID="Button6" CssClass="btn btn-primary" runat="server" Text="设为精品" OnClick="Button6_Click" />
                        <asp:Button ID="Button5" CssClass="btn btn-primary" runat="server" Text="设为新品" OnClick="Button5_Click" />
                        <asp:Button ID="Button3" CssClass="btn btn-primary" runat="server" Text="批量删除" OnClick="Button3_Click" OnClientClick="return confirm('不可恢复性删除数据,你确定将该数据删除吗？');" />
                        <asp:Button ID="Button4" CssClass="btn btn-primary" runat="server" Text="停止销售" OnClick="Button4_Click" />
                        <asp:Button ID="Button7" CssClass="btn btn-primary" runat="server" Text="取消热卖" OnClick="Button7_Click" />
                        <asp:Button ID="Button8" CssClass="btn btn-primary" runat="server" Text="取消精品" OnClick="Button8_Click" />
                        <asp:Button ID="Button9" CssClass="btn btn-primary" runat="server" Text="取消新品" OnClick="Button9_Click" /></td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <script type="text/javascript" src="/JS/ICMS/ZL_Common.js"></script>
    <script language="javascript">
        var tID = 0;
        var arrTabTitle = new Array("TabTitle0", "TabTitle1", "TabTitle2");
        var arrTabs = new Array("1", "14", "15");
        function ShowTabs(ID) {
            var ddlgradelevel = document.getElementById("quicksouch");
            var cc = 0;
            for (var i = 0; i < ddlgradelevel.options.length; i++) {
                if (ddlgradelevel.options[i].value == arrTabs[ID]) {
                    ddlgradelevel.options[i].selected = true;
                    if (ID == 0) {
                        cc = 4;
                    }
                    else {
                        cc = ddlgradelevel.options[i].value;
                    }
                    location.href = 'ProductList.aspx?type=<%=HttpUtility.HtmlEncode(Request.QueryString["type"]) %>&id=' + ID + '&quicksouch=' + cc;
                }
            }
        }
        function pload() {
            var ID = '<%=HttpUtility.HtmlEncode(Request.QueryString["id"])%>';
            if (ID != tID) {
                $(arrTabTitle[tID].toString()).addClass("tabtitle");
                $(arrTabTitle[ID].toString()).addClass("titlemouseover");
                tID = ID;
            }
        }
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
        $().ready(function () {
            pload();
            if (getParam("quicksouch")) {
                $("li a[href='#Tabs" + getParam("quicksouch") + "']").parent().addClass("active").siblings("li").removeClass("active");;
            }
        })
    </script>
</asp:Content>
