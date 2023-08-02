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
    public partial class setMarkerUpdateData : Common.AjaxPageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            Response.Clear();
            Response.ContentType = "text/html";
            Response.ContentEncoding = System.Text.Encoding.UTF8;

            string marker_url   = Request.Params["marker_url"];
            string[] temp = marker_url.Split('/');

            string rate = Request.Params["rate"];
            string xml = "";

            DataSet dsContent = null;

            long content_id     = Int32.Parse(Request.Params["id"]);

            dsContent = DBConn.RunSelectQuery("SELECT contents.xml FROM contents WHERE contents.id={0}",
                                                new string[] { "@id" },
                                                new object[] { content_id });
            if (!DataSetUtil.IsNullOrEmpty(dsContent)){
                xml = updateXML(DataSetUtil.RowStringValue(dsContent, "xml", 0), marker_url, rate);
            }

            DBConn.RunUpdateQuery("UPDATE contents SET marker_url={0}, xml={1}, server_id={2} WHERE id={3}",
                new string[] { "@marker_url",
                               "@xml",
                               "@server_id",
                               "@id"},
                new object[] { temp[temp.Length-1].Replace(".png",".jpg"),
                                xml,
                                "COAR_" + content_id,
                                content_id});
            Response.Write("MarkerImage is registerd successfully!");
            Response.End();
        }

        protected string updateXML(string xml,string marker_url,string rate)
        {
            string updatedXML = xml;
            int pos1 = 0;
            int pos2 = 0;

            //marker_url 교체
            pos1 = updatedXML.IndexOf("<url>") + 5;
            pos2 = updatedXML.IndexOf("</url>");
            updatedXML.Remove(pos1,pos2-pos1);
            updatedXML.Insert(pos1, marker_url);

            //rate 교체
            pos1 = updatedXML.IndexOf("<rate>") + 5;
            pos2 = updatedXML.IndexOf("</rate>");
            updatedXML.Remove(pos1, pos2 - pos1);
            updatedXML.Insert(pos1, marker_url);

            return updatedXML;
        }
    }
}