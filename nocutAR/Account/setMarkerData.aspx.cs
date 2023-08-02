using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using DataAccess;

namespace nocutAR.Account
{
    public partial class setMarkerData : Common.AjaxPageBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            Response.Clear();
            Response.ContentType = "text/html";
            Response.ContentEncoding = System.Text.Encoding.UTF8;

            string marker_url=Request.Params["marker_url"];
            long content_id = Int32.Parse(Request.Params["id"]);

            string[] temp = marker_url.Split('/');
            DBConn.RunUpdateQuery("UPDATE contents SET marker_url={0}, server_id={1} WHERE id={2}",
                new string[] { "@marker_url",
                               "@server_id",
                               "@id"},
                new object[] { temp[temp.Length-1].Replace(".png",".jpg"),
                                "COAR_" + content_id,
                                content_id});
            Response.Write("MarkerImage is registerd successfully!");
            Response.End();
        }
    }
}