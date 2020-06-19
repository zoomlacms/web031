<%@ WebHandler Language="C#" Class="OALogin" %>
using System;
using System.Web;
using System.Data;
using ZoomLa.BLL;
using ZoomLa.BLL.User;
using ZoomLa.Model;
using ZoomLa.Common;
using ZoomLa.Components;
public class OALogin : IHttpHandler, System.Web.SessionState.IReadOnlySessionState
{
    public int LoginCount
    {
        get
        {
            if (HttpContext.Current.Session["ValidateCount"] == null)
            {
                HttpContext.Current.Session["ValidateCount"] = 0;
            }
            return Convert.ToInt32(HttpContext.Current.Session["ValidateCount"]);
        }
        set
        {
            HttpContext.Current.Session["ValidateCount"] = value;
        }
    }
    public void ProcessRequest(HttpContext context)
    {
        string action = context.Request.Params["action"];
        B_User buser = new B_User();
        B_User_Friend friendBll = new B_User_Friend();
        B_Group gpBll=new B_Group();
        M_UserInfo mu = new M_UserInfo();
        switch (action)
        {
            case "HasLogged":
                mu = buser.GetLogin();
                if (mu != null && !mu.IsNull)
                {
                    M_Uinfo basemod = buser.GetUserBaseByuserid(mu.UserID);
                    string result = "{\"UserID\":\"" + mu.UserID + "\",\"UserName\":\"" + mu.UserName + "\",\"UserFace\":\"" + basemod.UserFace + "\",\"TrueName\":\"" + basemod.TrueName + "\"}";
                    context.Response.Write(result);
                }
                else context.Response.Write("-1");
                break;
            case "GetBarUInfo":
                {
                    int uid = Convert.ToInt32(context.Request["uid"]);
                    mu = buser.GetUserByUserID(uid);
                    M_Uinfo ubMod = buser.GetUserBaseByuserid(uid);
                    string result = "{\"UserFace\":\"" + ubMod.UserFace + "\",\"UserExp\":\"" + mu.UserExp + "\",\"UserSex\":\"" + (ubMod.UserSex ? "男" : "女") + "\",\"GroupName\":\"" + gpBll.GetByID(DataConverter.CLng(mu.GroupID)).GroupName + "\",\"UserBirth\":\"" + ubMod.BirthDay + "\",\"RegTime\":\"" + mu.RegTime + "\",\"UserID\":\"" + mu.UserID + "\",\"UserName\":\"" + mu.UserName + "\"}";
                    context.Response.Write(result);
                }
                break; 
            case "CheckKey":
                 string chkUname= context.Request.Form["uname"];
                 M_UserInfo usermod = buser.GetUserByName(chkUname);
                 if (usermod != null && !string.IsNullOrEmpty(usermod.ZnPassword))
                     context.Response.Write("1");
                 else
                     context.Response.Write("-1");
                break;
            case "AddFriend":
                mu = buser.GetLogin();
                if (mu!=null&&!mu.IsNull)
                {
                    int fid = Convert.ToInt32(context.Request.Form["value"]);
                    DataTable dt=friendBll.AddFriend(mu.UserID,fid);
                    if (dt != null)
                        context.Response.Write(JsonHelper.JsonSerialDataTable(dt));
                    else
                        context.Response.Write("-1");
                }
                else
                    context.Response.Write("-1");
                break;
            default://Login
                #region -1登录失败,-2验证码失败,-10启用验证码
                string value = context.Request["value"];
                string uname = value.Split(':')[0], upwd = value.Split(':')[1], key = "", code = "";
                if (LoginCount >= 3)//验证码
                {
                    key = value.Split(':')[2]; code = value.Split(':')[3];
                    //context.Response.Write(value + ":" + key + ":" + code);
                    if (!ZoomlaSecurityCenter.VCodeCheck(key, code))
                    {
                        context.Response.Write("-2");
                        return;
                    }
                }
                mu = buser.AuthenticateUser(uname, upwd);
                if (mu.IsNull)
                {
                    LoginCount++;
                    if (LoginCount >= 3)
                    {
                        context.Response.Write("-10");
                    }
                    else
                    {
                        context.Response.Write("-1");
                    }
                }
                else
                {
                    LoginCount = 0;
                    buser.SetLoginState(mu, "Day");
                    M_Uinfo basemod = buser.GetUserBaseByuserid(mu.UserID);
                    string result = "{\"UserID\":\"" + mu.UserID + "\",\"UserName\":\"" + mu.UserName + "\",\"UserFace\":\"" + basemod.UserFace + "\",\"TrueName\":\"" + basemod.TrueName + "\"}";
                    context.Response.Write(result);
                }
                #endregion
                break;
        }
        context.Response.Flush();
        context.Response.End();
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}