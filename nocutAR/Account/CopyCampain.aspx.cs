using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

using DataAccess;

namespace nocutAR.Account
{
    public partial class CopyCampain : Common.AjaxPageBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            Response.Clear();
            Response.ContentType = "text/html";
            Response.ContentEncoding = System.Text.Encoding.UTF8;
            DataSet dsContent = null;
            string strData = "{{\"result\":\"failed\"}}";

            long id=0;
            if (!string.IsNullOrEmpty(Request.Params["id"]))
                id = long.Parse(Request.Params["id"]);
            
            dsContent = DBConn.RunSelectQuery("SELECT * FROM contents WHERE userid = {0} AND id={1}",
                new string[] { "@userid", "@id" },
                new object[] { AuthUser.ID, id });

            if (!DataSetUtil.IsNullOrEmpty(dsContent))
            {
                id = DBConn.RunInsertQuery("INSERT INTO contents (project_id, userid, title, marker_url, xml, server_id, api_requests, size, regdate, changedate, description, is_board) "
                    + " SELECT project_id, userid, title+'_A', '', xml, '', 0, size, getDate(), getDate(), description, is_board FROM contents WHERE id={0}",
                    new string[] { "@id" },
                    new object[] { id }, true);

                strData = "{{\"result\":\"success\"}}";
            }
            Response.Write(strData);
            Response.End();
        }
    }
}