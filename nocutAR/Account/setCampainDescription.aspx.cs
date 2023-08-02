using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using DataAccess;

namespace nocutAR.Account
{
    public partial class setCampainDescription : Common.AjaxPageBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            Response.Clear();
            Response.ContentType = "text/html";
            Response.ContentEncoding = System.Text.Encoding.UTF8;

            string description = Request.Params["description"];
            long content_id = Int32.Parse(Request.Params["id"]);

            DBConn.RunUpdateQuery("UPDATE contents SET description={0} WHERE id={1}",
                new string[] { "@description",
                               "@id"},
                new object[] { description,
                               content_id });
            Response.Write("캠페인설명이 정확히 등록되었습니다.");
            Response.End();
        }
    }
}