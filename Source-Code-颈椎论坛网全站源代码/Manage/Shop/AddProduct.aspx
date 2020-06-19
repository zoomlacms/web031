<%@ page language="C#" autoeventwireup="true" validaterequest="false" enableeventvalidation="false" inherits="Zoomla.Website.manage.Shop.AddProduct, App_Web_5ikqejeg" enableviewstatemac="false" masterpagefile="~/Manage/I/Default.master" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <script type="text/javascript" src="/JS/DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" charset="utf-8" src="/Plugins/Ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="/Plugins/Ueditor/ueditor.all.min.js"></script>
    <link type="text/css" href="/dist/css/bootstrap-switch.min.css" rel="stylesheet" />
    <style type="text/css">
    .classdiv{display:none;}
    </style>
    <script type="text/javascript" src="/dist/js/bootstrap-switch.js"></script>
    <title>编辑商品</title>
    <style>
        .btn-group{display:inline-table;}.nav-tabs{margin-top:10px;}
    </style>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:HiddenField ID="HiddenUser" runat="server" />
    <ul class="nav nav-tabs">
        <li class="active"><a href="#tab0" data-toggle="tab" onclick="ShowTabss(0)">基本信息</a></li>
        <li><a href="#tab1" data-toggle="tab" onclick="ShowTabss(1)">商品说明</a></li>
        <li><a href="#tab2" data-toggle="tab" onclick="ShowTabss(2)">库存厂税</a></li>
        <li><a href="#tab3" data-toggle="tab" onclick="ShowTabss(3)">价格运费</a></li>
        <li><a href="#tab4" data-toggle="tab" onclick="ShowTabss(4)">促销推广</a></li>
        <li><a href="#tab4" data-toggle="tab" onclick="ShowTabss(5)">详细属性</a></li>
    </ul>
    <table style="width: 100%;">
        <tr>
            <td>
                <table class="table table-striped table-bordered">
                    <tbody id="Tabs0" style="border-top:none;">
                        <tr>
                            <td class="td_m">
                                <strong>所属节点：</strong>
                            </td>
                            <td>
                                <asp:Label ID="nodename" runat="server"></asp:Label>
                                <asp:HiddenField ID="ClickType" runat="server" />
                                <asp:HiddenField ID="ID" runat="server" Value="0" />
                                <asp:HiddenField ID="I_tem" runat="server" />
                                <asp:HiddenField ID="ComModelID" runat="server" />
                                <asp:HiddenField ID="Hiddenbind" runat="server" />
                                <asp:HiddenField ID="hidNum" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>所属专题：</strong>
                            </td>
                            <td>
                                <asp:Label ID="Categoryname" runat="server"></asp:Label>
                                <div id="lblSpec" runat="server"></div>
                                <input type="button" id="Button1" value="添加到专题" class="btn btn-primary" onclick="AddToSpecial()" />
                                <asp:HiddenField ID="Categoryid" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>商品编号：</strong>
                            </td>
                            <td style="width: 592px;">
                                <asp:TextBox ID="ProCode" runat="server" disabled="disabled" Width="200" class="form-control" />
                                <asp:CheckBox ID="CheckBox1" Text="自动编号" onclick="SetDisabled(this.checked)" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>捆绑销售：</strong>
                            </td>
                            <td style="height: 26px;">
                                <asp:Button ID="Button3" class="btn btn-primary" runat="server" Text="添加捆绑商品" OnClientClick="OpenSelect();return false;" />
                                <asp:Button ID="Button4" class="btn btn-primary" runat="server" Text="清空捆绑列表" OnClientClick="ClearSelect();return false;" /><br />
                                <span runat="server" id="Span1"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>自选数量：</strong>
                            </td>
                            <td>
                                <asp:TextBox ID="Propeid" runat="server" Text="0" Width="51px" class="form-control" />
                                <span class="rd_green">(0为不允许自选购买;如果捆绑商品为空,则此数值为无效)</span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>条形码：</strong>
                            </td>
                            <td>
                                <asp:TextBox ID="BarCode" runat="server" Width="155px" class="form-control" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>商品名称：</strong>
                            </td>
                            <td>
                                <asp:TextBox ID="Proname" runat="server" Width="442px" class="form-control" />
                                <span class="STYLE1">*<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                    ControlToValidate="Proname" Display="Dynamic" ErrorMessage="商品名称不能为空!" SetFocusOnError="True"></asp:RequiredFieldValidator></span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>关键字：</strong>
                            </td>
                            <td>
                                <asp:TextBox ID="Kayword" runat="server" Width="155px" class="form-control" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>商品单位：</strong>
                            </td>
                            <td>
                                <asp:TextBox ID="ProUnit" runat="server" Width="155px" class="form-control" Text="件" />
                                <span class="STYLE1"><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ProUnit" Display="Dynamic" ErrorMessage="商品单位不能为空!" SetFocusOnError="True"></asp:RequiredFieldValidator></span>
                                <div id="Unitd" class="btn btn-group">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>商品重量：</strong>
                            </td>
                            <td>
                                <asp:TextBox ID="Weight" runat="server" class="form-control text_xs" />
                                <span>千克（Kg）</span><asp:RegularExpressionValidator ID="RegularExpressionValidator12" runat="server"
                                    ControlToValidate="Weight" ErrorMessage="商品重量必须是数字!" ValidationExpression="^(-?\d+)(\.\d+)?$" SetFocusOnError="True" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>商品类型：</strong>
                            </td>
                            <td>
                                <input type="radio" id="normal" checked="checked" value="1" name="ProClass" /><label for="normal">正常销售</label> 
                                <input type="radio" id="TeJia" value="2" name="ProClass" /><label for="TeJia">特价处理</label> 
                                <input type="radio" id="JiFen" value="3" name="ProClass" /><label for="JiFen">积分商品</label> 
                                <input type="radio" id="Tuan" value="4" name="ProClass" /><label for="Tuan">团购</label> 
                                <input type="radio" id="DaiMai" value="5" name="ProClass" /><label for="YG">云购</label>
                                <input type="radio" id="IDC" value="6" name="ProClass" /><label for="IDC">IDC商品</label> 
                                <input type="radio" id="LvYou" value="7" name="ProClass" /><label for="LvYou">旅游</label> 
                                <input type="radio" id="Hotel" value="8" name="ProClass" /><label for="Hotel">酒店</label> 
                                <asp:HiddenField ID="ProClass" runat="server" />
                                <div id="TG" >
                                    <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
                                        <asp:View ID="View1" runat="server">
                                            <table id="tgTable" class="classdiv">
                                                <tr>
                                                    <td>团购订金：</td>
                                                    <td>
                                                        <asp:TextBox ID="txtColoneDeposit" runat="server" class="form-control"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator6"
                                                    runat="server" ControlToValidate="txtColoneDeposit" ErrorMessage="团购订金格式不对!" ValidationExpression="\d+[.]?\d*"
                                                    Display="Dynamic" SetFocusOnError="True"></asp:RegularExpressionValidator></td>
                                                </tr>
                                                <tr>
                                                    <td>最低团购人数：</td>
                                                    <td>
                                                        <asp:TextBox ID="NumberText" runat="server" class="form-control text_s" /><span>人</span>
                                                    </td>
                                                    <td>团购价格:</td>
                                                    <td>
                                                        <asp:TextBox ID="TGPrice" runat="server" class="form-control text_s" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>开始时间</td>
                                                    <td>
                                                        <asp:TextBox ID="ColonelStartTimetxt" runat="server" onclick="WdatePicker({ dateFmt: 'yyyy/MM/dd HH:mm:ss' });" class="form-control"></asp:TextBox>
                                                    </td>
                                                    <td>结束时间:</td>
                                                    <td>
                                                        <asp:TextBox ID="ColonelendTimetxt" runat="server" onclick="WdatePicker({ dateFmt: 'yyyy/MM/dd HH:mm:ss' });" class="form-control"></asp:TextBox>
                                                        <asp:HiddenField ID="hfEndTime" runat="server" />
                                                        <asp:HiddenField ID="hfBeginTime" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" align="center">
                                                        <asp:Button ID="Button14" class="btn btn-primary" Style="width: 100px" runat="server" Text="添加" CausesValidation="false" OnClick="Button14_Click" />
                                                        <asp:Button ID="Button15" class="btn btn-primary" Style="width: 100px" runat="server" Text="浏览价格"
                                                            CausesValidation="false" OnClientClick="OpenSelect2();return false;" />
                                                        <asp:Button ID="TGButtion" class="btn btn-primary" Style="width: 100px" runat="server" Text="取消"
                                                            CausesValidation="false" OnClick="TGButtion_Click" />
                                                    </td>
                                                </tr>
                                            </table>
                                            </asp:View>
                                            </asp:MultiView>
                                </div>
                                <table id="idcTable" class="classdiv">
                                    <tr>
                                        <td>
                                            <strong>服务期限：</strong>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="ServerPeriod" runat="server" class="form-control text_xs" />
                                            <asp:DropDownList ID="ServerType" CssClass="form-control text_x" runat="server">
                                                <asp:ListItem Selected="True" Value="3">年</asp:ListItem>
                                                <asp:ListItem Value="2">月</asp:ListItem>
                                                <asp:ListItem Value="1">日</asp:ListItem>
                                            </asp:DropDownList><span class="rd_green">每次购买,充值多长时间</span>
                                            <asp:RegularExpressionValidator ID="reg11" runat="server"
                                                ControlToValidate="ServerPeriod" ErrorMessage="服务期限必须是数字!" ValidationExpression="^\d+$"
                                                SetFocusOnError="True" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><strong>到期提醒：</strong></td>
                                        <td>
                                            <asp:DropDownList runat="server" ID="expRemindDP" CssClass="form-control text_x">
                                                <asp:ListItem Value="1">1天</asp:ListItem>
                                                <asp:ListItem Value="3">3天</asp:ListItem>
                                                <asp:ListItem Value="5">5天</asp:ListItem>
                                                <asp:ListItem Value="10">10天</asp:ListItem>
                                                <asp:ListItem Value="15">15天</asp:ListItem>
                                                <asp:ListItem Value="30">1月</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>销售状态：</strong>
                            </td>
                            <td>
                                <asp:CheckBox ID="Sales" Text="打勾表示销售中，否则为停售状态" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>属性设置：</strong>
                            </td>
                            <td>
                                <asp:CheckBox ID="istrue_Chk" runat="server" Text="审核通过" Checked="true" />
                                <asp:CheckBox ID="isnew" runat="server" Text="新品" />
                                <asp:CheckBox ID="ishot" runat="server" Text="热销" />
                                <asp:CheckBox ID="isbest" runat="server" Text="精品" />
                            </td>
                        </tr>
                    </tbody>
                    <tbody id="Tabs1" style="border-top:none;display: none;">
                        <tr>
                            <td class="td_m">
                                <strong>商品简介：</strong>
                            </td>
                            <td>用于首页及栏目页显示，最多255个字符<br />
                                <asp:TextBox ID="Proinfo" runat="server" Height="87px" TextMode="MultiLine" Width="500px"
                                    class="form-control" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>详细介绍：</strong>
                            </td>
                            <td>
                                <textarea id="Procontent" style="width: 715px; height: 300px;" runat="server"></textarea>
                                <%=Call.GetUEditor("Procontent",2) %>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>商品清晰图：</strong>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_Clearimg" runat="server" Width="300px" class="form-control" />
                                <iframe id="bigimgs" style="top: 2px;width:100%;height:25px;" src="/Common/fileupload.aspx?FieldName=Clearimg&ModelID=<%:ModelID %>&NodeID=<%:NodeID %>" frameborder="0" marginheight="0" marginwidth="0" scrolling="no"></iframe>
                            </td>
                        </tr>
                        <tr id="addsmallimg">
                            <td>
                                <strong>商品缩略图：</strong>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_Thumbnails" runat="server" Width="300px" class="form-control" />
                                <iframe id="smallimgs" style="top: 2px;width:100%;height:25px;" src="/Common/fileupload.aspx?FieldName=Thumbnails&ModelID=<%:ModelID %>&NodeID=<%:NodeID %>" frameborder="0" marginheight="0" marginwidth="0" scrolling="no"></iframe>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>个性模板：</strong>
                            </td>
                            <td>
                                <asp:TextBox ID="ModeTemplate" runat="server" class="form-control" />
                                <input type="button" class="btn btn-primary" style="width: 100px" value="选择模板" onclick="WinOpenDialog('../Template/TemplateList.aspx?OpenerText=' + escape('ModeTemplate') + '&FilesDir=', 650, 480)" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>点击数：</strong>
                            </td>
                            <td>
                                <asp:TextBox ID="txtCountHits" runat="server" class="form-control text_md" Text="0" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>更新时间：</strong>
                            </td>
                            <td style=" width: 592px;">
                                <asp:TextBox ID="UpdateTime" runat="server" onclick="WdatePicker({ dateFmt: 'yyyy/MM/dd HH:mm' });" class="form-control text_md" />
                            </td>
                        </tr>
                    </tbody>
                    <tbody id="Tabs2" style="border-top:none;display: none">
                        <tr>
                            <td width="20%">
                                <strong>生 产 商：</strong>
                            </td>
                            <td>
                                <asp:TextBox ID="Producer" runat="server" Width="214px" class="form-control"></asp:TextBox><a
                                    href="###" onclick="SelectProducer();">[请选择]</a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>品牌/商标：</strong>
                            </td>
                            <td>
                                <asp:TextBox ID="Brand" runat="server" Width="214px" class="form-control"></asp:TextBox><a
                                    href="###" onclick="SelectBrand();">[请选择]</a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>缺货时允许购买:</strong>
                            </td>
                            <td>
                                <asp:CheckBox ID="Allowed" runat="server" Text="打勾表示缺货时允许购买， 否则缺货时不允许购买" Checked="true" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>限购数量:</strong>
                            </td>
                            <td>
                                <asp:TextBox ID="Quota" runat="server" Width="100px" class="form-control">-1</asp:TextBox>
                               <span class="rd_green">-1为不限制数量 0为不允许购买</span>
                            <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="Quota"
                                ErrorMessage="限购数量必须是数字!" Type="Integer" SetFocusOnError="True"></asp:RangeValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>最低购买数量:</strong>
                            </td>
                            <td>
                                <asp:TextBox ID="DownQuota" runat="server" Width="100px" class="form-control">-1</asp:TextBox>
                                <span class="rd_green">  -1为不限制数量 0为不允许购买</span>
                            <asp:RangeValidator ID="RangeValidator2" runat="server" ControlToValidate="DownQuota"
                                ErrorMessage="最低购买数量必须是数字!" Type="Integer" SetFocusOnError="True"></asp:RangeValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>秒杀时间段:(限制购买时间)</strong>
                            </td>
                            <td>从<asp:TextBox ID="TextBox13" onclick="WdatePicker({ dateFmt: 'yyyy/MM/dd HH:mm:ss' });" runat="server" class="form-control"></asp:TextBox>
                                &nbsp;到
                            <asp:TextBox ID="TextBox14" onclick="WdatePicker({ dateFmt: 'yyyy/MM/dd HH:mm:ss' });" runat="server" class="form-control"></asp:TextBox>
                                &nbsp;为止
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>库存数量:</strong>
                            </td>
                            <td>
                                <asp:TextBox ID="Stock" runat="server" Width="100px" class="form-control" ClientIDMode="Static">10</asp:TextBox>
                                <asp:RangeValidator ID="RangeValidator3" runat="server" ControlToValidate="Stock"
                                    ErrorMessage="库存数量必须是数字!" Type="Integer" SetFocusOnError="True"></asp:RangeValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>库存报警下限:</strong>
                            </td>
                            <td style=" width: 592px;">
                                <asp:TextBox ID="StockDown" runat="server" Width="100px" class="form-control">1</asp:TextBox>
                                <asp:RangeValidator ID="RangeValidator4" runat="server" ControlToValidate="StockDown"
                                    ErrorMessage="库存报警下限必须是数字!" Type="Integer" SetFocusOnError="True"></asp:RangeValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>前台库存计算方式:</strong>
                            </td>
                            <td>
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td width="25%">
                                            <asp:RadioButtonList ID="JisuanFs" runat="server" RepeatDirection="Horizontal">
                                                <asp:ListItem Selected="True" Value="0">实际库存</asp:ListItem>
                                                <asp:ListItem Value="1">虚拟库存</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                        <td width="89%">（实际库存－已订购数）
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>税率设置:</strong>
                            </td>
                            <td>
                                <asp:RadioButtonList ID="Rateset" runat="server">
                                    <asp:ListItem Selected="True" Value="1">含税，不开发票时有税率优惠 </asp:ListItem>
                                    <asp:ListItem Value="2">含税，不开发票时没有税率优惠</asp:ListItem>
                                    <asp:ListItem Value="3">不含税，开发票时需要加收税费</asp:ListItem>
                                    <asp:ListItem Value="4">不含税，开发票时不需要加收税费</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>商品税率:</strong>
                            </td>
                            <td>
                                <asp:TextBox ID="Rate" runat="server" Text="0" class="form-control" />
                                %
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator10" runat="server"
                                ControlToValidate="Rate" ErrorMessage="商品税率必须是数字!" ValidationExpression="^(-?\d+)(\.\d+)?$"
                                SetFocusOnError="True" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>商品推荐等级:</strong>
                            </td>
                            <td>
                                <asp:DropDownList ID="Dengji" runat="server">
                                    <asp:ListItem Value="5">★★★★★</asp:ListItem>
                                    <asp:ListItem Value="4">★★★★</asp:ListItem>
                                    <asp:ListItem Selected="True" Value="3">★★★</asp:ListItem>
                                    <asp:ListItem Value="2">★★</asp:ListItem>
                                    <asp:ListItem Value="1">★</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </tbody>
                    <tbody id="Tabs3" style="border-top:none;display: none">
                        <tr>
                            <td class="td_l">
                                <strong>市场价：<span class="rd_red">*</span></strong>
                            </td>
                            <td>
                                 <asp:TextBox ID="ShiPrice" onblur="DisPrice(this)" runat="server" class="form-control text_xs" Text="0" /><span>元</span>
                                 <asp:RegularExpressionValidator ID="RegularExpressionValidator13" runat="server" ControlToValidate="ShiPrice" ErrorMessage="价格格式不对!" ValidationExpression="\d+[.]?\d*" Display="Dynamic" SetFocusOnError="True" />
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ShiPrice" ErrorMessage="价格不能为空!" SetFocusOnError="True" />
                            </td>
                        </tr>
                        <tr>
                            <td> <strong>当前售价：<span class="rd_red">*</span></strong></td>
                            <td>
                                <asp:HiddenField ID="hfprice" runat="server" />
                                <asp:HiddenField ID="hfFesPrice" runat="server" />
                                <asp:HiddenField ID="hfBookprice" runat="server" />
                                <asp:TextBox ID="LinPrice" runat="server" class="form-control text_xs" /><span>元</span>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator14" runat="server" ControlToValidate="LinPrice" ErrorMessage="零售价格式不对!" ValidationExpression="\d+[.]?\d*" Display="Dynamic" SetFocusOnError="True" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="LinPrice" ErrorMessage="零售价不能为空!" SetFocusOnError="True" />
                            </td>
                        </tr>
                        <tr>
                            <td><strong>附加售价：</strong></td>
                            <td>
                                <div id="linprice_td">
                                    <asp:TextBox ID="LinPrice_Purse_T" runat="server" class="form-control text_xs curprice" Text="0" /><asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="LinPrice_Purse_T" ErrorMessage="积分格式不对!" ValidationExpression="\d+[.]?\d*" Display="Dynamic" SetFocusOnError="True" />
                                    <span>余额</span>
                                <asp:TextBox ID="LinPrice_Sicon_T" runat="server" class="form-control text_xs curprice" Text="0" />
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator8" runat="server" ControlToValidate="LinPrice_Sicon_T" ErrorMessage="余额格式不对!" ValidationExpression="\d+[.]?\d*" Display="Dynamic" SetFocusOnError="True" />
                                    <span>银币</span>
                                <asp:TextBox ID="LinPrice_Point_T" runat="server" class="form-control text_xs curprice" Text="0" /><asp:RegularExpressionValidator ID="RegularExpressionValidator11" runat="server" ControlToValidate="LinPrice_Point_T" ErrorMessage="银币格式不对!" ValidationExpression="\d+[.]?\d*" Display="Dynamic" SetFocusOnError="True" /><span>积分</span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>会员价:</strong>
                            </td>
                            <td>
                                <label><input type="radio" runat="server" value="0" groupname="UserPrice" name="UserPrice_Rad" id="UserPrice0_Rad" onclick="$('#userP').show();$('#divGroup').hide();" checked="true"/>会员价</label>
                                <label><input type="radio" runat="server" value="1" groupname="UserPrice" name="UserPrice_Rad" id="UserPrice1_Rad" onclick="$('#userP').hide();$('#divGroup').show();"  />会员组</label>
                                <div id="userP" runat="server" style="display:none;">
                                    会员价：<asp:TextBox ID="userPrice" runat='server' class="form-control text_xs"></asp:TextBox>元
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator9" runat="server" ControlToValidate="userPrice"
                                                ErrorMessage="会员价格格式不正确!" ValidationExpression="\d+[.]?\d*" Display="Dynamic" ForeColor="Red" SetFocusOnError="True" />
                                </div>
                                <div id="divGroup" runat="server" style="display: none;">
                                    <asp:Repeater ID="repGroup" runat="server">
                                        <ItemTemplate>
                                            <asp:HiddenField ID="groupID" runat="server" Value='<%#Eval("GroupID") %>' />
                                            <%#Eval("GroupName")%>：<asp:TextBox ID="GroupPrice" runat='server' class="form-control text_xs"></asp:TextBox>元
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>运费设置：<a href="DeliverType.aspx">(前往配置)</a></strong>
                            </td>
                            <td>
                                <asp:RadioButtonList runat="server" ID="FareTlp_Rad" DataTextField="TlpName" DataValueField="ID" RepeatDirection="Horizontal" RepeatColumns="5"></asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>节日价格:</strong>
                            </td>
                            <td>
                                <asp:TextBox ID="txtDayPrice" runat="server" class="form-control" />
                                <asp:RegularExpressionValidator ID="rv3" runat="server" ControlToValidate="txtDayPrice" ErrorMessage="节日价格格式不正确!" ValidationExpression="\d+[.]?\d*" Display="Dynamic" SetFocusOnError="True"></asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>节日时间:</strong>
                            </td>
                            <td>
                                <div id='hotelDiv'>
                                    <asp:TextBox ID='CheckInDate' runat="server" class="form-control text_md" onclick="WdatePicker({ dateFmt: 'yyyy/MM/dd HH:mm' });"></asp:TextBox>至
                                    <asp:TextBox ID='CheckOutDate' runat="server" class="form-control text_md" onclick="WdatePicker({ dateFmt: 'yyyy/MM/dd HH:mm' });"></asp:TextBox>
                                </div>
                                <input id='IntervallCheckInAndChekOut' value='1' type='hidden' />
                                <input id='CheckOut' type='hidden' runat="server" />
                                <asp:HiddenField ID="serverdate" runat="server" Value='2010-8-31' />
                                <div id='m_contentend'>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>预订价格:</strong>
                            </td>
                            <td>
                                <asp:TextBox ID="txtBookPrice" runat="server" class="form-control"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtBookPrice"
                                    ErrorMessage="预订价格格式不正确!" ValidationExpression="\d+[.]?\d*" Display="Dynamic"
                                    SetFocusOnError="True"></asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>预订时间:</strong>
                            </td>
                            <td>
                                <asp:TextBox ID="txtBookDay" runat="server" class="form-control"></asp:TextBox>
                                <span class="rd_green">节日时间提前N天为预订价</span>
                               <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" ControlToValidate="txtBookDay"
                                    ErrorMessage="预订价格格式不正确!" ValidationExpression="\d+[.]?\d*" Display="Dynamic"
                                    SetFocusOnError="True"></asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>打折优惠率:</strong>
                            </td>
                            <td>
                                <asp:TextBox ID="txtRecommend" runat="server" Text="0"  class="form-control text_s" /><span>%</span>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtRecommend"
                                ErrorMessage="优惠率必须是数字!" ValidationExpression="^(-?\d+)(\.\d+)?$" SetFocusOnError="True" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>PV:</strong>
                            </td>
                            <td>
                                <asp:TextBox ID="txtPoint" runat="server" Text="0" class="form-control text_s" />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtPoint"
                                    ErrorMessage="PV值必须是数字!" ValidationExpression="^(-?\d+)(\.\d+)?$" SetFocusOnError="True" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>允许批发：</strong>
                            </td>
                            <td>
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td>
                                            <input type="checkbox" runat="server" id="Wholesales" class="switchChk"   onchange="show(this)" />
                                        </td>
                                    </tr>
                                    <tr id="pifaji" style="display: none" onmouseover="this.className='tdbgmouseover'"
                                        onmouseout="this.className='tdbg'">
                                        <td>
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td>① 一次性购买此商品数量满
                                                    <asp:TextBox ID="s1" runat="server" Text='10' Width="49px" class="form-control" />
                                                        时，批发价为
                                                    <asp:TextBox ID="j1" runat="server" Width="68px" class="form-control">0</asp:TextBox>
                                                        元
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td height="24">② 一次性购买此商品数量满
                                                    <asp:TextBox ID="s2" runat="server" Text='50' Width="49px" class="form-control" />
                                                        时，批发价为
                                                    <asp:TextBox ID="j2" runat="server" Width="68px" class="form-control">0</asp:TextBox>
                                                        元
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td height="24">③ 一次性购买此商品数量满
                                                    <asp:TextBox ID="s3" runat="server" Text='100' Width="49px" class="form-control" />
                                                        时，批发价为
                                                    <asp:TextBox ID="j3" runat="server" Width="68px" class="form-control">0</asp:TextBox>
                                                        元
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>允许单独销售：</strong>
                            </td>
                            <td>
                                  <input type="checkbox" runat="server" id="Wholesaleone" class="switchChk"  checked="checked" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>设置为礼品：</strong>
                            </td>
                            <td>
                                <input type="checkbox" runat="server" id="Largess" class="switchChk" checked="checked" />
                                <span class="rd_green">(自选数量大于0时设为礼品无效)</span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>礼品价格：</strong>
                            </td>
                            <td>
                                <asp:TextBox ID="Largesspirx" runat="server" Width="91px" class="form-control">0</asp:TextBox>
                                元 <span class="rd_green">设置为礼品且允许单独销售时的价格</span>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="Largesspirx"
                                    ErrorMessage="礼品价格必须是数字!" ValidationExpression="^(-?\d+)(\.\d+)?$" SetFocusOnError="True" />
                            </td>
                        </tr>
                    </tbody>
                    <tbody id="Tabs4" style="border-top:none;display: none">
                        <tr>
                            <td width="20%">
                                <strong>促销方案：</strong>
                            </td>
                            <td>
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td rowspan="7" width="39px">
                                            <asp:RadioButtonList ID="ProjectType" runat="server" Width="39px" CellSpacing="0"
                                                CellPadding="0">
                                                <asp:ListItem Value="1" Selected="True" style="line-height: 26px"></asp:ListItem>
                                                <asp:ListItem Value="2" style="line-height: 25px"></asp:ListItem>
                                                <asp:ListItem Value="3" style="line-height: 25px"></asp:ListItem>
                                                <asp:ListItem Value="4" style="line-height: 26px"></asp:ListItem>
                                                <asp:ListItem Value="5" style="line-height: 26px"></asp:ListItem>
                                                <asp:ListItem Value="6" style="line-height: 26px">6</asp:ListItem>
                                                <asp:ListItem Value="7" style="line-height: 27px">7</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                        <td width="96%" height="22">&nbsp;不促销
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="22">&nbsp;买&nbsp;<asp:TextBox class="form-control text_xs" ID="ProjectPronum2" Text="1" runat="server"></asp:TextBox>件此商品 可以送一件同样商品
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 22px">&nbsp;买&nbsp;<asp:TextBox Text="1" ID="ProjectPronum3" class="form-control text_xs" runat="server"></asp:TextBox>
                                            件此商品 可以送一件其他商品 赠品名称：<asp:TextBox ID="Productsname3" class="form-control"
                                                runat="server" ReadOnly="true" onclick="ProductsSelect('Productsname1');"></asp:TextBox><asp:Button
                                                    ID="Button6" class="btn btn-primary" runat="server" Text="浏览..." OnClientClick="ProductsSelect('3');return false;" />
                                            <asp:HiddenField ID="HiddenField3" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="22">&nbsp;送&nbsp;<asp:TextBox ID="ProjectPronum4" class="form-control text_xs" runat="server" Text="1"></asp:TextBox>件同样商品
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 22px">&nbsp;送&nbsp;<asp:TextBox ID="ProjectPronum5" runat="server" class="form-control text_xs" Text="1"></asp:TextBox>
                                            件其他商品 送一件赠品名称：<asp:TextBox ID="Productsname5" class="form-control"
                                                runat="server" ReadOnly="true" onclick="ProductsSelect('Productsname2');"></asp:TextBox>
                                            <asp:Button ID="Button7" runat="server" class="btn btn-primary" Text="浏览..." OnClientClick="ProductsSelect('5');return false;" />
                                            <asp:HiddenField ID="HiddenField5" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="22">&nbsp;加&nbsp;<asp:TextBox ID="ProjectMoney6" class="form-control text_xs" runat="server" Text="1"></asp:TextBox>元钱送商品 送一件赠品名称：<asp:TextBox ID="Productsname6" runat="server"
                                                class="form-control" ReadOnly="true" onclick="ProductsSelect('Productsname3');"></asp:TextBox><asp:Button
                                                    ID="Button8" runat="server" class="btn btn-primary" Text="浏览..." OnClientClick="ProductsSelect('6');return false;" />
                                            <asp:HiddenField ID="HiddenField6" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="22">&nbsp;满&nbsp;<asp:TextBox ID="ProjectMoney7" runat="server" Text="1" class="form-control text_xs"></asp:TextBox>元钱送商品 送一件赠品名称：<asp:TextBox ID="Productsname7" class="form-control"
                                                runat="server" ReadOnly="true" onclick="ProductsSelect('Productsname4');"></asp:TextBox><asp:Button
                                                    ID="Button5" class="btn btn-primary" runat="server" Text="浏览..." OnClientClick="ProductsSelect('7');return false;" />
                                            <asp:HiddenField ID="HiddenField7" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="20%" style="height: 19px">
                                <strong>其他促销方案：</strong>
                            </td>
                            <td style="height: 19px">
                                <asp:Button ID="Button9" class="btn btn-primary" runat="server" Text="绑定其他促销方案" Width="261px"
                                    OnClientClick="OpenprojectSelect();return false;" /><br />
                                <asp:ListBox ID="OtherProject" runat="server" Height="127px" Width="261px" SelectionMode="Multiple"></asp:ListBox>
                                <br />
                                <asp:Button ID="Button10" class="btn btn-primary" runat="server" Text="删除选中方案" Width="260px"
                                    OnClientClick="Clearoption();return false;" />
                                <br />
                                <font color="red"><b>选中状态</b></font><font color="green">的方案将被更新</font>支持<b>Ctrl</b>或<b>Shift</b>键多选
                            </td>
                        </tr>
                        <tr>
                            <td width="20%">
                                <strong>购物积分：</strong>
                            </td>
                            <td>购买&nbsp;<asp:TextBox ID="IntegralNum" runat="server" Text="1" class="form-control text_xs"></asp:TextBox>&nbsp;件此商品可以得到
                            <asp:TextBox ID="Integral" runat="server" Width="53px" class="form-control"
                                MaxLength="3" />
                                积分
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator16" runat="server"
                                ControlToValidate="Integral" ErrorMessage="积分只能是数字或小数！"
                                ValidationExpression="^\d+\.?\d+$|^\d+$"></asp:RegularExpressionValidator>
                            </td>
                        </tr>
                    </tbody>
                    <tbody id="Tabs5" style="border-top:none;display: none">
                        <tr id="addChild_TR" runat="server" visible="false">
                            <td style="width:20%;" class="text-right">子商品：</td>
                            <td><button type="button" onclick="ShowShopList('<%=ProID %>',<%=NodeID %>)" class="btn btn-primary">查看子商品</button> <a href="AddProduct.aspx?pid=<%=ProID %>&ModelID=<%=ModelID %>&NodeID=<%=NodeID %>" class="btn btn-primary">添加子商品</a></td>
                        </tr>
                        <asp:Literal ID="ModelHtml" runat="server"></asp:Literal>
                    </tbody>
                    
                </table>
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True" ShowSummary="False" />
            </td>
        </tr>
    </table>
    <div class="text-center">
        <asp:Button ID="EBtnSubmit" class="btn btn-primary" Text="保存商品信息" runat="server" OnClick="EBtnSubmit_Click1" /><!--OnClientClick="numChange('0');"-->
        <asp:Button ID="btnAdd" class="btn btn-primary" Text="添加为新商品" runat="server" OnClick="btnAdd_Click" />
        <a href="ProductManage.aspx?<%:"NodeID="+NodeID+"&StoreID="+StoreID%>" class="btn btn-primary" id="Button2">返回列表<i class="fa fa-arrow-circle-up"></i></a>
    </div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <script type="text/javascript" src="/JS/Common.js"></script>
    <script type="text/javascript" src="/JS/Controls/ZL_Dialog.js"></script>
    <script type="text/JavaScript">
        $().ready(function(){
            show(document.getElementById("Wholesales"));
            SelUnit();
            if($("#ProClass").val()=="")SelShopType($("#normal").val());
            $("input[name=ProClass]").each(function(i,v){
                if ($(v).val()==$("#ProClass").val()) {
                    v.checked=true;
                    SelShopType($(v).val());
                    return false;
                }
            });
            $("input[name=ProClass]").click(function(){
                SelShopType($(this).val());
            });
            if (parent.isParentProduct) {
                $("#addChild_TR").hide();
            }
            DisPrice($("#ShiPrice")[0]);
        });
        var shopDiag=new ZL_Dialog();
        function ShowShopList(pid,nid){
            shopDiag.title="子商品列表";
            shopDiag.reload=true;
            shopDiag.url="ProductManage.aspx?NodeID="+nid+"&pid="+pid;
            shopDiag.ShowModal();
        }
        function SelShopType(value) {
            $(".classdiv").hide();
            switch (value) {
                case '4':
                    $("#tgTable").show();
                    break;
                case '6':
                    $("#idcTable").show();
                    break;
                default:
                    break;
            }
        }
        function DisPrice(obj) {
            if (parseInt($(obj).val()) > 0) {
                $("#linprice_td *").removeAttr("disabled");
            } else {
                $("#linprice_td *").attr("disabled", "disabled").val('0');
            }
        }
        function CheckShiJia() {

        }
        function SelUnit(){
            var units= "件,个,只,组,套,把,双,台,年,月,日,季";
            var array=units.split(",");
            for (var i = 0; i < array.length; i++) {
                var str="<button type='button' class='btn btn-default'>"+array[i]+"</button>"
                $("#Unitd").append(str);
            }
            $("#Unitd").find("button").click(function(){
                $("#ProUnit").val($(this).text());
            });
            
        }
        var aid = 0;
        var showID = 0;
        var tID = 0;
        var arrTabTitle = new Array("TabTitle0", "TabTitle1", "TabTitle2", "TabTitle3", "TabTitle4", "TabTitle5", "TabTitle6", "TabTitle7");
        var arrTabs = new Array("Tabs0", "Tabs1", "Tabs2", "Tabs3", "Tabs4", "Tabs5", "Tabs6", "Tabs7");
        function ShowTabss(SID) {
            if (SID != tID) {
                if (document.getElementById(arrTabTitle[tID].toString()) != null)
                    document.getElementById(arrTabTitle[tID].toString()).className = "tabtitle";
                if (document.getElementById(arrTabTitle[SID].toString()) != null)
                    document.getElementById(arrTabTitle[SID].toString()).className = "titlemouseover";
                if (document.getElementById(arrTabs[tID].toString()) != null)
                    document.getElementById(arrTabs[tID].toString()).style.display = "none";
                if (document.getElementById(arrTabs[SID].toString()) != null)
                    document.getElementById(arrTabs[SID].toString()).style.display = "";
                tID = SID;
                aid = SID;
            }
        }

        function ShowTable() {
            if (aid < 7) {
                aid = aid + 1;
            }
            if (aid < 7) {
                ShowTabss(aid);
            }
        }

        function showup() {
            if (aid > 0) {
                aid = aid - 1;
            }
            if (aid >= 0 && aid < 8) {
                ShowTabss(aid);
            }
        }

        function deleteRow(tableID, rowIndex, rowsid) {
            var ccd = confirm('你确定将此绑定的商品删除吗？');
            if (ccd) {
                var table = document.all[tableID]
                var bindstr = "," + document.getElementById("Hiddenbind").value + ",";
                rowsid = "," + rowsid + ",";
                var reg = new RegExp(rowsid, "g")
                bindstr = bindstr.replace(reg, ",");
                reg = new RegExp(",,", "g")
                bindstr = bindstr.replace(reg, ",");
                document.getElementById("Hiddenbind").value = bindstr;
                table.deleteRow(rowIndex);
                document.getElementById("Hiddenbind").value = document.getElementById("Hiddenbind").value.replace(reg, ",");
                if (document.getElementById("Hiddenbind").value == "" || document.getElementById("Hiddenbind").value == ",") {
                    document.getElementById("Span1").innerHTML = "";
                    document.getElementById("Hiddenbind").value = "";
                }
            }
        }

        function CheckAll(spanChk)//CheckBox全选
        {
            var oItem = spanChk.children;
            var theBox = (spanChk.type == "checkbox") ? spanChk : spanChk.children.item[0];
            xState = theBox.checked;
            elm = theBox.form.elements;
            for (i = 0; i < elm.length; i++)
                if (elm[i].type == "checkbox" && elm[i].id != theBox.id && elm[i].id.indexOf("Item", false) > -1) {
                    if (elm[i].checked != xState)
                        elm[i].click();
                }
        }

        function SelectProducer() {
            window.open('Producerlist.aspx', '', 'width=600,height=450,resizable=0,scrollbars=yes');
        }
        //团购信息
        function OpenSelect2() {

            window.open('TGALL.aspx?shopid=<%=Request.QueryString["ID"] %>', '', 'width=600,height=450,resizable=0,scrollbars=yes');
            return false;
        }

        function OpenSelect() {

            window.open('AddbindPro.aspx?id=<%=Request.QueryString["ID"] %>', '', 'width=600,height=450,resizable=0,scrollbars=yes');
            return false;
        }

        function ProductsSelect(act) {
            window.open('ProductsSelect.aspx?act=' + act, '', 'width=600,height=450,resizable=0,scrollbars=yes');
        }

        function OpenprojectSelect() {

            window.open('projectSelect.aspx', '', 'width=600,height=450,resizable=0,scrollbars=yes');
            return false;
        }

        function ClearSelect() {
            document.getElementById("Span1").innerHTML = "";
            document.getElementById("Hiddenbind").value = "";
        }

        function SelectBrand() {
            window.open('Brandlist.aspx?producer=' + document.getElementById('Producer').value + '', '', 'width=600,height=450,resizable=0,scrollbars=yes');

        }

        function SetDisabled(checked) {
            document.getElementById('ProCode').disabled = checked;
        }

        function show(checked) {
            if (checked.checked) {
                document.getElementById("pifaji").style.display = "";
            }
            else {
                document.getElementById("pifaji").style.display = "none";
            }
        }
        function Clearoption() {
            var hiddenidvalue = document.getElementById("OtherProject"); //获取已经存在的ID值

            for (var i = hiddenidvalue.options.length - 1; i >= 0; i--) {
                if (hiddenidvalue[i].selected == true) {
                    hiddenidvalue[i] = null;
                }
            }

        }

        function ShowGuess(obj) {
            switch (obj) {
                case 1:
                    document.getElementById("Guess1").style.display = "none";
                    document.getElementById("Guess2").style.display = "none";
                    break;
                case 2:
                    document.getElementById("Guess1").style.display = "";
                    document.getElementById("Guess2").style.display = "none";
                    break;
                case 3:
                    document.getElementById("Guess1").style.display = "none";
                    document.getElementById("Guess2").style.display = "";
                    break;
            }

             
        }

        function ShowInterference(i) {
            switch (i) {
                case 1:
                    document.getElementById("tableInterference").style.display = "none";
                    break;
                case 2:
                    document.getElementById("tableInterference").style.display = "";
                    document.getElementById("Panel1").style.display = "";
                    document.getElementById("Panel2").style.display = "none";
                    document.getElementById("Panel3").style.display = "none";
                    break;
                case 3:
                    document.getElementById("tableInterference").style.display = "";
                    document.getElementById("Panel1").style.display = "none";
                    document.getElementById("Panel2").style.display = "";
                    document.getElementById("Panel3").style.display = "none";
                    break;
                case 4:
                    document.getElementById("tableInterference").style.display = "";
                    document.getElementById("Panel1").style.display = "none";
                    document.getElementById("Panel2").style.display = "none";
                    document.getElementById("Panel3").style.display = "";
                    break;
            }
        }
        var isParentProduct=true//子商品判断
        function buttonclick(username, userid) {
            var objlist = document.getElementById("ListBox1");
            node = document.createElement("<option   value='" + userid + "'>");
            text = document.createTextNode(username);
            node.appendChild(text);
            objlist.appendChild(node);

            for (var i = 0; i < objlist.length; i++) {
                objlist.options[i].selected = true;
            }
        }
        function deldata(userid) {
            var objlist = document.getElementById("ListBox1");
            for (i = objlist.length - 1; i >= 0; i--) {
                if (objlist.options[i].value == userid) {
                    objlist.remove(i);
                }
            }
        }

        function change(obj) {
            if (obj == "3") {
                document.getElementById("tpoint").style.display = "";
            } else {
                document.getElementById("tpoint").style.display = "none";
            }
        }
        function GetPicurl(imgurl) {
            var optlen = 1;
            var isin = 0;
            for (var i = 0; i < optlen; i++) {
                var doctxt = imgurl;
                if (imgurl.toLowerCase().indexOf("http://") > -1) {
                    isin = 1;
                }
            }

            if (isin == 0) {
                var option = document.createElement("option");
                option.text = imgurl;
                option.value = imgurl;
            }
        }
    </script>
</asp:Content>
