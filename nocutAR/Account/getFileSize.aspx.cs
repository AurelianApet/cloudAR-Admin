using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace nocutAR.Account
{
    public partial class getFileSize : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string strImgUrl = Request.Params["imgurl"];
            if (strImgUrl.Contains("http://"))
            {
                string strHost = "http://" + Request.Url.Host;
                if (Request.Url.Port != 80)
                    strHost += ":" + Request.Url.Port;

                strImgUrl = strImgUrl.Replace(strHost, "");
            }

            string strPath = Server.MapPath(strImgUrl);
            FileInfo info = new FileInfo(strPath);

            Response.Clear();
            Response.Write((double)info.Length / 1024.0f / 1024.0f);
            Response.End();
        }
    }
}