using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace nocutAR.Account
{
    public partial class VUpload : Common.PageBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            string serverPath = Server.MapPath("/bin/VuforiaUpload.exe");
            long width = 0;
            string strImgPath = "";
            string arguments ="";
            long content_id = Int32.Parse(Request.Params["content_id"]);
            string strType = Request.Params["type"];
            if ("remove".Equals(strType))
            {
                arguments = "COAR " + strType + " COAR_" + content_id;
            }
            else
            {
                width = Int32.Parse(Request.Params["width"]);
                strImgPath = Request.Params["imgPath"];
                ChangeColor24Depth(strImgPath, "/markers");
                strImgPath = Server.MapPath(strImgPath.Replace(".png",".jpg"));
                arguments = "COAR " + strType + " COAR_" + content_id + " " + width + " " + strImgPath;
            }
            RunVUpload(arguments);
            if ("remove".Equals(strType))
            {
                Response.Write("Removed successfully!");
            }
            else
            {
                Response.Write("Added successfully!");
            }
        }
    }
}