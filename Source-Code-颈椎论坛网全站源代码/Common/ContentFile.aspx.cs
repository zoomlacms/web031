using System;
using System.Collections.ObjectModel;
using System.IO;
using System.Text;
using System.Web;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using ZoomLa.Model;
using ZoomLa.Components;
using ZoomLa.Common;
using ZoomLa.BLL;
using System.Collections.Generic;
namespace ZoomLa.WebSite.Manage.Common
{
    public partial class FileUpload : CustomerPageAction
    {
        string m_FieldName;
        string m_FileExtArr;//扩展
        int m_MaxFileSize;
        string m_FileSizeField;
        int m_ModelId;
        string m_ShowPath;

        M_ModelField m_ModelField;
        M_Node m_NodeInfo;
        B_Node bnode = new B_Node();
        B_ModelField bfield = new B_ModelField();
        B_Admin badmin = new B_Admin();
        B_User buser = new B_User();
       protected string fileName = "";
        protected void BtnUpload_Click(object sender, EventArgs e)
        {
            if (!this.FupFile.HasFile)
            {
                this.ReturnManage("请指定一个上传文件");
                return;
            }

            if (!SiteConfig.SiteOption.EnableUploadFiles)
            {
                this.ReturnManage("本站不允许上传文件！");
                return;
            }

            string str2 = Path.GetExtension(this.FupFile.FileName).ToLower();
            if (!this.CheckFilePostfix(str2.Replace(".", "")))
            {
                this.ReturnManage("上传的文件不是符合扩展名" + this.m_FileExtArr + "的文件");
                return;
            }

            this.m_FileExtArr = SiteConfig.SiteOption.UploadPicExts;
            this.m_MaxFileSize = DataConverter.CLng(SiteConfig.SiteOption.UploadPicMaxSize);
            if (string.IsNullOrEmpty(this.m_FileExtArr))
            {
                this.ReturnManage("要上传文件的字段没有指定上传文件类型");
                return;
            }
            if (!this.CheckFilePostfix(str2.Replace(".", "")))
            {
                this.ReturnManage("上传的文件不是符合扩展名" + this.m_FileExtArr + "的文件");
                return;
            }

            if (((int)this.FupFile.FileContent.Length) > (this.m_MaxFileSize * 0x400))
            {
                this.ReturnManage("上传的文件超过限制的" + this.m_MaxFileSize + "KB大小");
                return;
            }
            string str3 = DataSecurity.MakeFileRndName();//文件名
            string foldername = "";
            foldername = base.Request.PhysicalApplicationPath.TrimEnd('\\') + (VirtualPathUtility.AppendTrailingSlash(SiteConfig.SiteOption.UploadDir) + this.FileSavePath()).Replace("/", "\\");
            fileName = FileSystemObject.CreateFileFolder(foldername, HttpContext.Current);
            List<string> arr = new List<string>();
            arr.AddRange(".jpg,.gif,.png,.jpeg,.bmp".Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries));
            bool found = arr.Contains(str2);
            if (WaterModuleConfig.WaterConfig.IsUsed && found && RadioButtonList1.SelectedValue == "1")
            {
                foldername = foldername.Replace(this.HiddenField1.Value, "test");
                string Testfilename = FileSystemObject.CreateFileFolder(foldername, HttpContext.Current);
                SafeSC.SaveFile(function.PToV(Testfilename), FupFile, str3 + str2);
                WaterImages dd = new WaterImages();
                if (WaterModuleConfig.WaterConfig.WaterClass == "1")
                {
                    string imgurl =Server.MapPath(WaterModuleConfig.WaterConfig.imgLogo);
                    int post = DataConverter.CLng(WaterModuleConfig.WaterConfig.lopostion);
                    dd.DrawImage(Testfilename + str3+str2, imgurl, fileName + str3 + str2);
                }
                else
                {
                    string waterword = WaterModuleConfig.WaterConfig.WaterWord;
                    string ziti = WaterModuleConfig.WaterConfig.WaterWordType;
                    dd.DrawFont(Testfilename, fileName + str3 + str2);
                }
                fileName = Testfilename;
                int sizes = (int)this.FupFile.FileContent.Length;
                string thumbnailPath = "";
                thumbnailPath = this.m_ShowPath + str3 + str2;
                this.GetScriptByModuleName(thumbnailPath, sizes);
                this.ReturnManage("文件上传成功");
            }
            else
            {
                SafeSC.SaveFile(function.PToV(fileName), FupFile, str3 + str2);
                int sizes = (int)this.FupFile.FileContent.Length;
                string thumbnailPath = "";
                thumbnailPath = this.m_ShowPath + str3 + str2;
                this.GetScriptByModuleName(thumbnailPath, sizes);
                this.ReturnManage("文件上传成功");
            }
            string sitepath = SiteConfig.SiteMapath();
            if (fileName.Contains(sitepath))
               fileName = fileName.Substring(sitepath.Length-1);
            fileName = fileName.Replace('\\', '/');
        }

        private bool CheckFilePostfix(string fileExtension)
        {
            return StringHelper.FoundCharInArr(this.m_FileExtArr.ToLower(), fileExtension.ToLower(), "|");
        }

        private string FileSavePath()
        {
            string str = "";
            if (SiteConfig.SiteOption.EnableUploadFiles)
            {
                this.m_NodeInfo = bnode.GetNodeXML(DataConverter.CLng(this.ViewState["NodeId"].ToString()));

                str = this.m_NodeInfo.NodeDir + "/{$FileType}/{$Year}/{$Month}/";
                this.HiddenField1.Value = this.m_NodeInfo.NodeDir;
                str = str.Replace("{$FileType}", Path.GetExtension(this.FupFile.FileName).ToLower().Replace(".", "")).Replace("{$Year}", DateTime.Now.Year.ToString()).Replace("{$Month}", DateTime.Now.Month.ToString()).Replace("\\", "/");
                //  this.m_ShowPath = VirtualPathUtility.AppendTrailingSlash(SiteConfig.SiteOption.UploadDir) + str;
                this.m_ShowPath = str;
            }
            return str;
        }

        private void GetScriptByModuleName(string thumbnailPath, int size)
        {
            string id = this.ViewState["FieldName"].ToString();
            StringBuilder builder = new StringBuilder();
            builder.Append("<script language=\"javascript\" type=\"text/javascript\">");
            string upload = SiteConfig.SiteOption.UploadDir;
            if (this.ViewState["UploadType"] != null)
            {
                if (this.ViewState["UploadType"].ToString() == "FileType")
                {
                    string sizeid = this.ViewState["SizeField"].ToString();
                    builder.Append("  parent.DealwithUpload(\"" + thumbnailPath + "\",\"" + size + "\",\"sel_" + id + "\",\"txt_" + id + "\",\"txt_" + sizeid + "\");");
                }

                if (this.ViewState["UploadType"].ToString() == "PicType")
                {
                    builder.Append("  parent.DealwithUploadPic(\"" + thumbnailPath + "\",\"txt_" + id + "\");parent.DealwithUploadImg(\"" + upload +"/"+ thumbnailPath + "\",\"Img_" + id + "\");");
                }

                if (this.ViewState["UploadType"].ToString() == "SmallFileType")
                {
                    builder.Append("  parent.DealwithUploadPic(\"" + thumbnailPath + "\",\"txt_" + id + "\");parent.DealwithUploadImg(\"" + upload + "/" + thumbnailPath + "\",\"Img_" + id + "\");");
                }
            }
            else
            {
                builder.Append("  parent.DealwithUploadPic(\"" + thumbnailPath + "\",\"txt_" + id + "\");parent.DealwithUploadImg(\"" + upload + "/" + thumbnailPath + "\",\"Img_" + id + "\");");
            }

            builder.Append("</script>");
            this.Page.ClientScript.RegisterStartupScript(base.GetType(), "UpdateParent", builder.ToString());
        }

        private void InitFileExtArr()
        {
            this.m_ModelId = DataConverter.CLng(this.ViewState["ModelId"].ToString());
            this.m_FieldName = this.ViewState["FieldName"].ToString();

            this.m_ModelField = bfield.GetModelByFieldName(this.m_ModelId, this.m_FieldName);
            if (this.m_ModelField.FieldID > 0)
            {
                string[] Setting = this.m_ModelField.Content.Split(new char[] { ',' });
                if (this.m_ModelField.FieldType == "PicType")
                {
                    int Warter = DataConverter.CLng(Setting[0].Split(new char[] { '=' })[1]);
                    if (!IsPostBack)
                    {
                        if (Warter == 1)
                        {
                            RadioButtonList1.SelectedValue = "1";
                        }
                        else
                        {
                            RadioButtonList1.SelectedValue = "0";
                        }
                    }
                    this.m_MaxFileSize = DataConverter.CLng(Setting[1].Split(new char[] { '=' })[1]);
                    this.ViewState["MaxFileSize"] = Setting[1].Split(new char[] { '=' })[1];
                    this.m_FileExtArr = Setting[2].Split(new char[] { '=' })[1];
                    this.ViewState["FileExtArr"] = Setting[2].Split(new char[] { '=' })[1];
                    this.ViewState["UploadType"] = "PicType";
                }


                if (this.m_ModelField.FieldType == "FileType")
                {
                    string chkSize = Setting[0].Split(new char[] { '=' })[1];
                    string SizeField = Setting[1].Split(new char[] { '=' })[1];
                    this.ViewState["SizeField"] = SizeField;
                    this.m_MaxFileSize = DataConverter.CLng(Setting[2].Split(new char[] { '=' })[1]);
                    this.ViewState["MaxFileSize"] = Setting[2].Split(new char[] { '=' })[1];
                    this.m_FileExtArr = Setting[3].Split(new char[] { '=' })[1];
                    this.ViewState["FileExtArr"] = Setting[3].Split(new char[] { '=' })[1];
                    this.ViewState["UploadType"] = "FileType";
                }

                if (this.m_ModelField.FieldType == "SmallFileType")
                {
                    this.m_MaxFileSize = DataConverter.CLng(Setting[0].Split(new char[] { '=' })[1]);
                    this.ViewState["MaxFileSize"] = Setting[0].Split(new char[] { '=' })[1];
                    this.m_FileExtArr = Setting[1].Split(new char[] { '=' })[1];
                    this.ViewState["FileExtArr"] = Setting[1].Split(new char[] { '=' })[1];
                    this.ViewState["UploadType"] = "SmallFileType";
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (badmin.CheckLogin() || buser.CheckLogin())
            {
            }
            else { function.WriteErrMsg("该页面必须登录后才能访问"); }
            this.ViewState["NodeId"] = base.Request.QueryString["NodeId"];
            this.ViewState["ModelId"] = base.Request.QueryString["ModelID"];
            this.ViewState["FieldName"] = base.Request.QueryString["FieldName"];

            this.InitFileExtArr();

            if (!IsPostBack)
            {

                if (Request.QueryString["Showtype"] != null)
                {
                    int Showtype = DataConverter.CLng(Request.QueryString["Showtype"]);
                    if (Showtype == 0)
                    {
                        this.show1.Visible = false;
                        this.show2.Visible = false;
                    }
                    else
                    {
                        this.show1.Visible = true;
                        this.show2.Visible = true;
                    }
                }
                else
                {
                    this.show1.Visible = true;
                    this.show2.Visible = true;
                }
            }
        }

        private void ReturnManage(string manage)
        {
            if (!string.IsNullOrEmpty(manage))
            {
                StringBuilder builder = new StringBuilder();
                builder.Append("<script language=\"javascript\" type=\"text/javascript\">");
                builder.Append("   parent.DealwithUploadErrMessage(\"" + manage + "\");");
                builder.Append("</script>");
                this.Page.ClientScript.RegisterStartupScript(base.GetType(), "UpdateParent", builder.ToString());
            }
        }
      
}
}