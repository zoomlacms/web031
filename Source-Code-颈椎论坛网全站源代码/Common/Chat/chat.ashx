﻿<%@ WebHandler Language="C#" Class="chat" %>

using System;
using System.Web;
using System.Collections.Generic;
using ZoomLa.Model;
using ZoomLa.Common;
using ZoomLa.BLL;
using ZoomLa.BLL.Helper;

/*
 * 超时清除(30分钟),群组聊天
 */
public class chat : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    //支持Html等多种格式,后期可以增加一种纯文本格式,自动过滤掉Html标记
    B_ChatMsg msgBll = new B_ChatMsg();
    B_ChatMsg chatBll = new B_ChatMsg();
    string boundary = "------asjdfohponzvnzcvapowtunzafadsfwt";//Html分隔符
    public void ProcessRequest (HttpContext context) {
        HttpRequest request = context.Request;
        HttpResponse response = context.Response;
        string action = request["action"];
        string result = "";
        //传两个吧uid,rece目标uid
        switch (action)
        {
            case "sendmsg":
                {
                    string uid = request.Form["uid"];
                    M_OnlineUser mu = chatBll.GetModelByUid(uid);
                    M_ChatMsg model = new M_ChatMsg();
                    model.UserID = mu.UserID;
                    model.UserName = mu.UserName;
                    model.UserFace = mu.UserFace;
                    model.Content = request.Form["content"];
                    model.ReceUser = StrHelper.IdsFormat(request.Form["rece"]);
                    chatBll.Insert(model);
                    B_ChatMsg.MsgList.Add(model);
                    result = "99";
                    //更新在线用户信息(一个计数,每过十秒更新一次状态)
                    response.Write(result);
                }
                break;
            case "getmsg"://同时更新在线状态
                {
                    string uid = request.Form["uid"];//我要接收谁的信息
                    string rece = request.Form["rece"];
                    //在线用户在进页面的时候加入这里只更新,用户自已提交ID上来
                    M_OnlineUser mu = chatBll.GetModelByUid(uid);
                    List<M_ChatMsg> msglist = msgBll.GetMsgByUid(mu.UserID.ToString(), rece);
                    string contents = "";
                    chatBll.UpdateTime(mu.UserID.ToString());
                    string onlinelist = chatBll.GetOnlineStr();//在线列表IDS格式
                    string unread = chatBll.GetMsgCount(mu.UserID);
                    foreach (M_ChatMsg model in msglist)
                    {
                        model.ReceUser = model.ReceUser.Replace("," + mu.UserID + ",", ",");//移除用户指示
                        result += "{\"UserName\":\"" + model.UserName + "\",\"UserFace\":\"" + model.UserFace + "\",\"CDate\":\"" + model.CDate.ToString("HH:mm:ss") + "\"},";
                        contents += boundary + model.Content;
                    }
                    result = result.TrimEnd(',');
                    result = "[" + result + "]";
                    result += boundary + onlinelist;
                    result += boundary + unread;
                    result += contents;
                    response.Write(result);
                }
                break;
            case "getonline"://初次登录时检测一次
                {
                    string uid = context.Request.Form["uid"];
                    chatBll.UpdateTime(uid);
                    result = chatBll.GetOnlineStr();//在线列表IDS格式
                    response.Write(result); 
                }
                break;
            case "userlogin"://用户与游客登录
                {
                    string uname = request.Form["name"];
                    M_OnlineUser model = chatBll.GetUser(uname);
                    result = "{\"UserID\":\"" + model.UserID + "\",\"UserName\":\"" + model.UserName + "\",\"UserFace\":\"" + model.UserFace + "\"}";
                    response.Write(result);
                }
                break;
            case "getonlinelist":
                result = chatBll.GetOnlineJson(true);//在线列表Json格式
                response.Write(result);
                break;
        }
        response.Flush(); response.End();
       
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}