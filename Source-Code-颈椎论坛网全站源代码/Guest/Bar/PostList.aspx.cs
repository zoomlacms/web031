﻿using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ZoomLa.BLL;
using ZoomLa.BLL.Helper;
using ZoomLa.BLL.Message;
using ZoomLa.Common;
using ZoomLa.Model;
using ZoomLa.Model.Message;
using ZoomLa.SQLDAL;

public partial class Guest_Bar_PostList : System.Web.UI.Page
{
    M_GuestBookCate cateMod = new M_GuestBookCate();
    M_Guest_Bar barMod = new M_Guest_Bar();
    B_Guest_Bar barBll = new B_Guest_Bar();
    B_GuestBook guestBll = new B_GuestBook();
    B_Guest_BarAuth authBll = new B_Guest_BarAuth();
    B_User buser = new B_User();
    public int pageSize = 20;
    public bool IsBarOwner = false, IsSearch = false;
    public int CPage
    {
        get
        {
            return PageCommon.GetCPage();
        }
    }
    public int CateID { get { return DataConvert.CLng(Request.QueryString["id"]); } }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            MyBind();
        }
    }
    public void MyBind()
    {
        int pageCount = 0;
        DataTable dt = new DataTable();
        M_UserInfo mu = barBll.GetUser();
        if (!string.IsNullOrEmpty(Request.QueryString["searchstr"]) || !string.IsNullOrEmpty(Request.QueryString["uid"]) || !string.IsNullOrEmpty(Request.QueryString["islike"]))
        {
            string skey = Request.QueryString["searchstr"];
            int uid = DataConvert.CLng(Request.QueryString["uid"]);
            bool sellike = DataConvert.CLng(Request.QueryString["islike"]) > 0 ? true : false;
            string skeyTlp = "\"<span style='color:#ff6a00;'>{0}</span>\"";

            if (!string.IsNullOrEmpty(skey))
            {
                BarName_L.Text = "相关" + string.Format(skeyTlp, skey) + "的贴子";
                Title_L.Text = skey + "\"的贴子";
                dt = barBll.SelByCateID(skey, 3);
            }
            else if (sellike)
            {
                BarName_L.Text = string.Format(skeyTlp, "我的收藏");
                Title_L.Text = "我的收藏";
                dt = barBll.SelByCateID(mu.UserID.ToString(), 4);
            }
            else
            {
                M_UserInfo smu = new M_UserInfo();
                if (uid < 1)//匿名用户不允许搜索
                {
                    smu.UserName = "匿名用户";
                }
                else
                {
                    smu = buser.GetUserByUserID(uid);
                    dt = barBll.SelByCateID(uid.ToString(), 2);
                }
                BarName_L.Text = string.Format(skeyTlp, smu.UserName) + "的贴子";
                Title_L.Text = smu.UserName + "的贴子";
            }
            totalspan.InnerText = "共搜索到" + dt.Rows.Count + "个贴子";
            function.Script(this, "SetImg('/App_Themes/Guest/images/timg.jpg');");
            IsSearch = true;
            MsgTitle_T.Enabled = false;
            MsgContent_T.Enabled = false;
            SendDiv.Visible = false;
        }
        else
        {
            dt = barBll.SelByCateID(CateID.ToString(), 1, true);
            cateMod = B_GuestBook.GetCate(CateID);

            #region 权限校验
            if (cateMod.IsBarOwner(mu.UserID))
            {
                barowner_div.Visible = true;
                IsBarOwner = true;
                DPBind();
            }
            else//非吧主权限验证
            {
                switch (cateMod.PermiBit)
                {
                    case "1"://版面类别
                        emptydiv.Style.Add("display", "none");
                        send_div.Visible = false;
                        RPT.Visible = false;
                        break;
                    default:
                        if (!authBll.AuthCheck(cateMod, mu, "needlog"))//访问权限
                        {
                            if (cateMod.NeedLog == 2)
                                function.WriteErrMsg("你没有访问权限");
                        }
                        if (!authBll.AuthCheck(cateMod, mu, "send"))//发贴权限
                        {
                            send_div.Visible = false;
                            noauth_div.Visible = true;
                        }
                        break;
                }

            }
            #endregion
            BarInfo_L.Text = cateMod.Desc;
            function.Script(this, "SetImg('" + cateMod.BarImage + "');");
            if (cateMod.IsNull) function.WriteErrMsg("该贴吧不存在!!");
            Title_L.Text = cateMod.CateName;
            BarName_L.Text = cateMod.CateName;
            DataTable chdt = B_GuestBook.GetCateList(CateID);
            if (chdt.Rows.Count > 0)
            {
                ChildRPT.DataSource = chdt;
                ChildRPT.DataBind();
            }
            else
            {
                childBar.Visible = false;
            }
        }
        RPT.DataSource = PageCommon.GetPageDT(pageSize, CPage, dt, out pageCount);
        RPT.DataBind();
        int tiecount = 0;
        int recout = 0;
        barBll.GetCount(CateID, out tiecount, out recout);
        replycount.InnerText = recout.ToString();
        dnum_span.InnerText = dt.Rows.Count.ToString();
        dnum_span2.InnerText = tiecount.ToString();
        pagenum_span1.InnerText = pageCount.ToString();
        MsgPage_L.Text = PageCommon.CreatePageHtml(pageCount, CPage);
        if (dt.Rows.Count > 0)
        {
            contentdiv.Visible = true;
        }
        else
        {
            emptydiv.Visible = true;
        }
        Anony_Span.Visible = !buser.CheckLogin();
    }
    //版面下拉列胶
    public void DPBind()
    {
        DataTable dt = B_GuestBook.Cate_SelByType(M_GuestBookCate.TypeEnum.PostBar);
        BindItem(dt);
        selected_Hid.Value = Request.QueryString["PID"];
    }
    public void BindItem(DataTable dt, int pid = 0, int layer = 0)
    {
        DataRow[] drs = dt.Select("ParentID=" + pid);
        string pre = layer > 0 ? "{0}<img src='/Images/TreeLineImages/t.gif' />" : "";
        string nbsp = "";
        for (int i = 0; i < layer; i++)
        {
            nbsp += "&nbsp;&nbsp;&nbsp;";
        }
        pre = string.Format(pre, nbsp);
        foreach (DataRow dr in drs)
        {
            PCate_ul.InnerHtml += string.Format("<li class='barli' data-barid='{1}'><a role='menuitem' tabindex='1' href='javascript:;'>{0}</a></li>", pre + dr["CateName"].ToString(), dr["CateID"].ToString());
            BindItem(dt, Convert.ToInt32(dr["CateID"]), (layer + 1));
        }
    }
    public string ConverDate(object o, string format)
    {
        if (o != null && o != DBNull.Value)
        {
            return DataConvert.CDate(o).ToString(format);
        }
        else
        {
            return DateTime.Now.ToString(format);
        }
    }
    public string GetTieStaues()
    {
        string[] statues = Eval("PostFlag").ToString().Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
        string tieimgs = "";
        if (statues.Length > 0)
        {
            for (int i = 0; i < statues.Length; i++)
            {
                switch (statues[i])
                {
                    case "Recommend":
                        tieimgs += "<img src='/App_Themes/Guest/images/Bar/jing.gif'/>  ";
                        break;
                }
            }
        }
        if (Convert.ToInt32(Eval("OrderFlag")) == 1)
        {
            tieimgs += "<img src='/App_Themes/Guest/images/Bar/zding.gif'/>  ";
        }
        return tieimgs;
    }
    protected void PostMsg_Btn_Click(object sender, EventArgs e)
    {
        M_UserInfo mu = barBll.GetUser();
        M_Guest_Bar lastMod = barBll.SelLastModByUid(mu);
        M_GuestBookCate catemod = B_GuestBook.GetCate(CateID);
        if (!ZoomlaSecurityCenter.VCodeCheck(Request.Form["VCode_hid"], VCode.Text.Trim()))
        {
            function.WriteErrMsg("验证码不正确", "/" + B_Guest_Bar.CreateUrl(1, CateID, CPage));
        }
        else if (catemod.IsBarOwner(mu.UserID))
        {

        }
        else if (mu.UserID != 0 && (DateTime.Now - mu.RegTime).TotalMinutes < 120)//匿名用户不受此限
        {
            int minute = 120 - (int)(DateTime.Now - mu.RegTime).TotalMinutes;
            function.WriteErrMsg("新注册用户120分钟内不能发贴,你还需要" + minute + "分钟", "javascript:history.go(-1);");
        }
        else if (lastMod != null && (DateTime.Now - lastMod.CDate).TotalMinutes < 5)
        {
            int minute = 5 - (int)(DateTime.Now - lastMod.CDate).TotalMinutes;
            function.WriteErrMsg("你发贴太快了," + minute + "分钟后才能再次发贴", "javascript:history.go(-1);");
        }
        string msg = MsgContent_T.Text;
        GetSubTitle(ref msg);
        catemod = guestBll.SelReturnModel(CateID);
        barMod = FillMsg(MsgTitle_T.Text, msg, catemod);
        int id = barBll.Insert(barMod);
        if (catemod.Status == 1 && mu.UserID != 0)
        {
            buser.AddExp(mu.UserID, catemod.SendScore);
            M_UserExpHis hismod = new M_UserExpHis();
            hismod.detail = string.Format("{0} {1}在版面:{2}发表主题:{3},赠送{4}分", DateTime.Now, mu.UserName, catemod.CateName, MsgTitle_T.Text.Trim(), catemod.SendScore);
            hismod.score = catemod.SendScore;
            hismod.HisTime = DateTime.Now;
            hismod.UserID = mu.UserID;
            B_History.AddExpHis(hismod);
            Response.Redirect("/" + B_Guest_Bar.CreateUrl(2, id));
        }
        else
            Response.Redirect("/" + B_Guest_Bar.CreateUrl(1, CateID));
    }
    public M_Guest_Bar FillMsg(string title, string msg, M_GuestBookCate cmode)
    {
        if (msg.Length > 29500) function.WriteErrMsg("发贴失败,原因:内容过长,请减少内容文字或Html");
        M_UserInfo mu = barBll.GetUser();
        M_Guest_Bar model = new M_Guest_Bar();
        model.MsgType = 1;
        model.Status = cmode.Status > 1 ? 0 : 1;//判断贴吧是否开启审核，如果是就默认设置为未审核
        model.CUser = mu.UserID;
        model.CUName = mu.UserName;
        model.Title = title.Trim();
        model.SubTitle = GetSubTitle(ref msg);
        model.MsgContent = msg;
        model.CateID = cmode.CateID;
        model.IP = EnviorHelper.GetUserIP();
        model.IDCode = mu.UserID == 0 ? mu.WorkNum : mu.UserID.ToString();
        string ipadd = IPScaner.IPLocation(model.IP);
        ipadd = ipadd.IndexOf("本地") > 0 ? "未知地址" : ipadd;
        model.IP = model.IP + "|" + ipadd;
        model.Pid = 0;
        model.ReplyID = 0;
        model.ColledIDS = "";
        return model;
    }
    public string GetSubTitle(ref string msg)
    {
        string text = StringHelper.StripHtml(msg, 500).Replace(" ", "").Replace("&nbsp;", "");
        string result = (text.Length > 50 ? text.Substring(0, 50) + "..." : text) + "<br/><ul class='thumbul'>";
        RegexHelper regHelper = new RegexHelper();
        int need = 3;
        int curCount = 0;
        if (msg.Contains("edui-faked-video"))//在线视频,如不以swf结尾,则直接显示链接
        {
            string qvtlp = "<li class='thumbli'><img src='/App_Themes/Guest/images/Bar/videologo.png' data-type='quotevideo' data-content='{0}'/></li>";
            //只取其引用,不存实体
            MatchCollection mcs = regHelper.GetValuesBySE(msg, "<embed", "/>");
            for (int i = 0; i < need && i < mcs.Count; i++)
            {
                string src = regHelper.GetHtmlAttr(mcs[i].Value, "src");//引用区分大小写
                if (Path.GetExtension(src).Equals(".swf"))
                {
                    result += string.Format(qvtlp, src);
                    curCount++;
                }
                else
                {
                    msg = msg.Replace(mcs[i].Value, string.Format("<a href='{0}'>{0}</a>", src));
                }
            }
        }
        if (msg.Contains("<video ") && curCount < need)//上传的视频文件
        {
            string videotlp = "<li class='thumbli'><img src='/App_Themes/Guest/images/Bar/videologo.png' data-type='video' data-content='{0}'/></li>";
            msg = msg.Replace("<video", " <video");
            MatchCollection mcs = regHelper.GetValuesBySE(msg, "<video", ">");
            for (int i = 0; i < need && i < mcs.Count && curCount < need; i++)
            {
                string src = regHelper.GetHtmlAttr(mcs[i].Value, "src");
                result += string.Format(videotlp, src);
                curCount++;
            }
        }
        if (msg.Contains("<img ") && curCount < need)//图片
        {
            MatchCollection mcs = regHelper.GetValuesBySE(msg, "<img", "/>");//匹配图片文件
            for (int i = 0; i < need && i < mcs.Count && curCount < need; i++)
            {
                if (mcs[i].Value.Contains("/Ueditor")) { continue; }//不存表情
                result += "<li class='thumbli'>" + mcs[i].Value + "</li>";
                curCount++;
            }
        }
        return result += "</ul>";

    }
    public string GetTitle()
    {
        //"<a style="<%#Eval("Style") %>" href="<%#CreateUrl(2,Eval("ID")) %>">"
        string title = Eval("Title").ToString().Trim();
        title = title.Length > 45 ? title.Substring(0, 44) : title.ToString();
        string result = "";
        if (IsSearch)
        {
            result = "[<a href='" + CreateUrl(1, Eval("CateID")) + "'>" + Eval("CateName") + "</a>]";
        }
        result += "<a style='" + Eval("Style") + "' href='" + CreateUrl(2, Eval("ID")) + "'>" + title + "</a>";
        if (Convert.ToInt32(Eval("C_Status")) == 3 && Convert.ToInt32(Eval("Status")) < 1)
        {
            result = "<span class='uncheck_title'>" + result + "[未审核]</span>";
        }
        return result;
    }
    public string GetSubTitle()
    {
        if (Convert.ToInt32(Eval("C_Status")) == 3 && Convert.ToInt32(Eval("Status")) < 1)
            return "";
        return Eval("SubTitle").ToString();
    }
    //删除,置顶,精华,沉底
    protected void Bar_Btn_Click(object sender, EventArgs e)
    {
        cateMod = B_GuestBook.GetCate(CateID);
        int uid = buser.GetLogin().UserID;
        string ids = Request.Form["idchk"];
        if (cateMod.IsBarOwner(uid) && !string.IsNullOrWhiteSpace(ids))
        {

            switch ((sender as LinkButton).CommandArgument)
            {
                case "Del":
                    barBll.UpdateStatus(CateID, ids, -1);
                    break;
                case "AddTop":
                    barBll.UpdateTop(ids, true);
                    break;
                case "RemoveTop":
                    barBll.UpdateTop(ids, false);
                    break;
                case "AddRecom":
                    barBll.UpdateRecommend(ids, true);
                    break;
                case "RemoveRecom":
                    barBll.UpdateRecommend(ids, false);
                    break;
                case "AddBottom":
                    barBll.UpdateDown(ids, true);
                    break;
                case "RemoveBottom":
                    barBll.UpdateDown(ids, false);
                    break;
                case "Checked":
                    DataTable dt = barBll.SelByIDS(ids);
                    foreach (DataRow item in dt.Rows)
                    {
                        if (DataConverter.CLng(item["Status"]) != 1 && DataConverter.CLng(item["CUser"]) > 0)
                        {
                            buser.AddExp(DataConverter.CLng(item["CUser"]), DataConverter.CLng(item["SendScore"]));
                            M_UserExpHis hismod = new M_UserExpHis();
                            hismod.detail = string.Format("{0} {1}在版面:{2}发表主题:{3},赠送{4}分", DateTime.Now, item["CUName"], item["Catename"], item["Title"], DataConverter.CLng(item["SendScore"])
                                , DataConverter.CLng(item["ReplyScore"]));
                            hismod.score = DataConverter.CLng(item["SendScore"]);
                            hismod.HisTime = DateTime.Now;
                            hismod.UserID = DataConverter.CLng(item["CUser"]);
                            B_History.AddExpHis(hismod);
                        }
                    }
                    barBll.CheckByIDS(ids);
                    break;
                case "UnCheck":
                    barBll.UnCheckByIDS(ids);
                    break;
            }
        }
        Refresh();
    }
    public string DisCheckBox()
    {
        if (IsBarOwner)
            return "<input type='checkbox' name='idchk' value='" + Eval("ID") + "'/>";
        else return "";
    }
    //Uid为提供
    public string GetRUser()
    {
        string tlp = "<span class='uname' title='回复时间:{0}'><span class='glyphicon glyphicon-comment'></span><a href='{1}'>{2}</a>"
                     + "<span class='pull-right remind_g_x'>{3}</span></span>";
        bool isnull = Eval("R_CUser") == DBNull.Value;
        int rcuser = isnull ? DataConvert.CLng(Eval("CUser").ToString()) : DataConvert.CLng(Eval("R_CUser").ToString());
        string rcuname = isnull ? function.GetStr(Eval("CUName"), 6) : function.GetStr(Eval("R_CUName"), 6);
        string url = rcuser == 0 ? "javascript:;" : CreateUrl(1, "") + "?uid=" + rcuser;
        DateTime cdate = isnull ? Convert.ToDateTime(Eval("CDate")) : Convert.ToDateTime(Eval("R_CDate"));
        string rdate = cdate.ToString("yyyy-MM-dd HH:mm");
        string rdate2 = isnull ? function.GetBarDate(Eval("CDate")) : function.GetBarDate(Eval("R_CDate"));
        return string.Format(tlp, rdate, url, rcuname, rdate2);
    }
    public void Refresh()
    {
        Response.Redirect(B_Guest_Bar.CreateUrl(1, CateID, CPage));
    }
    public string CreateUrl(int type, object id, int page = 1)
    {
        if (id != DBNull.Value)
        {
            return B_Guest_Bar.CreateUrl(type, DataConvert.CLng(id), page);
        }
        return "";
    }
    protected void SureMove_Btn_Click(object sender, EventArgs e)
    {
        string ids = Request.Form["idchk"];
        int cid = DataConvert.CLng(selected_Hid.Value);
        if (!string.IsNullOrEmpty(ids) && cid > 0)
        {
            barBll.ShiftPost(ids, cid);
            Response.Redirect(Request.RawUrl);
        }
        else { function.WriteErrMsg("提交的参数不正确"); }
    }
}