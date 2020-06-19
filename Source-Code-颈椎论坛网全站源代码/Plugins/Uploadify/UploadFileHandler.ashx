<%@ WebHandler Language="C#" Class="UploadFileHandler" %>
using System;
using System.Web;
using System.Data;
using System.IO;
using ZoomLa.BLL;
using ZoomLa.BLL.Helper;
using ZoomLa.BLL.Plat;
using ZoomLa.Model;
using ZoomLa.Model.Plat;
using ZoomLa.Common;
using ZoomLa.Components;
using Zoomla.Safe;
using System.Linq;
using System.Web.SessionState;
using System.Drawing;
using System.Drawing.Imaging;

/*
 *用于文件工厂,OA,Plat附件上传
 */

public class UploadFileHandler : IHttpHandler, IRequiresSessionState
{
    M_DocModel model = new M_DocModel();
    M_UserInfo mu = new M_UserInfo();
    B_DocModel bll = new B_DocModel();
    B_Admin badmin = new B_Admin();
    B_User buser = new B_User();
    ZipClass zipBll = new ZipClass();
    //true是允许的视频格式
    public bool IsWebVideo(string fname)
    {
        string[] extArr = new string[] { "flv", "wmv", "rmvb", "rm", "mp4", "mpeg" };
        bool flag = false;
        string extName = Path.GetExtension(fname).Replace(".", "");
        flag = extArr.Select(p => p).Equals(extName);
        return flag;
    }
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        context.Request.ContentEncoding = System.Text.Encoding.GetEncoding("UTF-8");
        context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("UTF-8");
        if (!buser.CheckLogin() && !badmin.CheckLogin()) { throw new Exception("未登录"); }
        HttpPostedFile file = context.Request.Files["Filedata"];
        if (file == null)
            file = context.Request.Files["file"];//接受Uploadify或WebUploader传参,优先Uploadify
        if (file.ContentLength < 1) { return; }
        if (SafeSC.FileNameCheck(file.FileName))
        {
            throw new Exception("不允许上传该后缀名的文件");
        }
        /*-------------------------------------------------------------------------------------------*/
        mu = buser.GetLogin();
        string uploadPath = SiteConfig.SiteOption.UploadDir, filename = "", ppath = "", result = "0";//上传根目录,文件名,上物理路径,结果
        string action = context.Request.Params["action"], value = context.Request["value"];
        try
        {
            switch (action)
            {
                case "OAattach"://OA--公文||事务--附件
                    uploadPath += "OA/" + mu.UserName + mu.UserID + "/";
                    ppath = context.Server.MapPath(uploadPath);
                    //判断是否有同名文件的存在
                    break;
                case "Blog"://能力中心--博客
                    uploadPath = B_Plat_Common.GetDirPath(B_Plat_Common.SaveType.Blog);
                    ppath = context.Server.MapPath(uploadPath);
                    break;
                case "Plat_Doc"://能力中心--我的文档
                    uploadPath = B_Plat_Common.GetDirPath(B_Plat_Common.SaveType.Person) + SafeSC.PathDeal(context.Request["Dir"]);
                    ppath = context.Server.MapPath(uploadPath);
                    break;
                case "Plat_Doc_Common"://能力中心--公司文档
                    uploadPath = B_Plat_Common.GetDirPath(B_Plat_Common.SaveType.Company) + SafeSC.PathDeal(context.Request["Dir"]);
                    ppath = context.Server.MapPath(uploadPath);
                    break;
                case "Plat_Task"://能力中心--任务中心附件
                    int tid = Convert.ToInt32(value);
                    ZoomLa.Model.Plat.M_Plat_Task taskMod = new B_Plat_Task().SelReturnModel(tid);
                    uploadPath = B_Plat_Common.GetDirPath(B_Plat_Common.SaveType.Plat_Task) + taskMod.TaskName + "/";
                    break;
                case "Plat_Project"://能力中心--项目
                    int pid = Convert.ToInt32(value);
                    ZoomLa.Model.Plat.M_Plat_Pro proMod = new B_Plat_Pro().SelReturnModel(pid);
                    uploadPath = B_Plat_Common.GetDirPath(B_Plat_Common.SaveType.Plat_Task) + proMod.Name + "/";
                    break;
                case "ModelFile"://组图,多图等
                    int nodeid = Convert.ToInt32(value);
                    M_Node nodeMod = new B_Node().GetNodeXML(nodeid);
                    string exname = Path.GetExtension(file.FileName).Replace(".", "");
                    string fpath = nodeMod.NodeDir + "/" + exname + "/" + DateTime.Now.ToString("yyyy/MM/");
                    filename = DateTime.Now.ToString("HHmmss") + function.GetRandomString(6, 2) + "." + exname;
                    uploadPath = SiteConfig.SiteOption.UploadDir + fpath;
                    break;
                case "UPVideo"://上传视频(管理员)
                    if (!badmin.CheckLogin()) { throw new Exception("UPVideo,管理员未登录"); }
                    uploadPath = SiteConfig.SiteOption.UploadDir + "/Video/" + DateTime.Now.ToString("yyyyMMdd") + "/";
                    break;
            }
            if (!Directory.Exists(uploadPath)) { Directory.CreateDirectory(uploadPath); }
            if (action.Equals("Plat_Doc") || action.Equals("Plat_Doc_Common"))
            {
                M_Plat_File fileMod = new M_Plat_File();
                B_Plat_File fileBll = new B_Plat_File();
                M_User_Plat upMod = B_User_Plat.GetLogin();
                fileMod.FileName = file.FileName;
                fileMod.SFileName = function.GetRandomString(12) + Path.GetExtension(file.FileName);
                fileMod.VPath = uploadPath;
                fileMod.UserID = upMod.UserID.ToString();
                fileMod.CompID = upMod.CompID;
                SafeSC.SaveFile(uploadPath, file, fileMod.SFileName);
                fileMod.FileSize = new FileInfo(ppath + fileMod.SFileName).Length.ToString();
                fileBll.Insert(fileMod);
            }
            else if (action.Equals("UPVideo"))//后台视频上传
            {
                result = SafeSC.SaveFile(uploadPath, file);
                string imgvpath = uploadPath + Path.GetFileNameWithoutExtension(result) + ".jpg";//预览图
                B_Content_Video videoBll = new B_Content_Video();
                VideoHelper conver = new VideoHelper(function.VToP("/Tools/ffmpeg.exe"), "/Temp/Video/");
                VideoFile model = conver.GetVideoInfo(function.VToP(result));
                conver.CutImgFromVideo(result, imgvpath);
                M_Content_Video videoMod = new M_Content_Video()
                {
                    VName = Path.GetFileName(result),
                    VTime = model.Duration.ToString(),
                    VPath = result,
                    Thumbnail = imgvpath,
                    CDate = DateTime.Now
                };
                videoBll.Insert(videoMod);
            }
            else
            {
                switch (context.Request["upmode"])//组图,多图上传
                {
                    case "1"://压缩包上传
                        string zipvpath = SafeC.SaveFile(uploadPath, file, Path.GetFileName(file.FileName));
                        string imgpdir = function.VToP(uploadPath + Path.GetFileNameWithoutExtension(file.FileName)) + @"\";
                        zipBll.UnZipFiles(function.VToP(zipvpath), imgpdir);
                        //移除目录下的非图片文件
                        DataTable dirDT = FileSystemObject.GetDirectoryInfos(imgpdir, FsoMethod.All);
                        foreach (DataRow dr in dirDT.Rows)
                        {
                            if (!SafeC.IsImage(dr["Name"].ToString()))
                            {
                                SafeC.DelFile(function.PToV(dr["FullPath"].ToString()));
                            }
                        }
                        DataTable imgdt = FileSystemObject.SearchImg(imgpdir);
                        result = "";
                        foreach (DataRow dr in imgdt.Rows)
                        {
                            result += dr["Path"] + "|";
                        }
                        result = result.TrimEnd('|');
                        break;
                    default:
                        result = SafeSC.SaveFile(uploadPath, file, filename);
                        if (context.Request["IsWater"].Equals("1"))
                            result = ImgHelper.AddWater(result);
                        break;
                }
            }
            //else if (SafeC.IsImageFile(file.FileName) && file.ContentLength > 500 * 1024)//图片文件先压缩再保存,500K以上才压
            //{
            //    string exname = Path.GetExtension(file.FileName).ToLower();
            //    result = uploadPath + file.FileName;
            //    ImgHelper imghelper = new ImgHelper();
            //    imghelper.CompressImg(file, result);
            //}
            
        }
        catch (Exception ex)
        {
            B_Site_Log.Insert("上传出错", ex.Message);
        }
        context.Response.Write(result); context.Response.End();
    }
    
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}