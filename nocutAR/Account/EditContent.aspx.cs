using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using DataAccess;

using System.Xml;

namespace nocutAR.Account
{
    public partial class EditContent : Common.PageBase
    {

        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            if (string.IsNullOrEmpty(Request.Params["id"]))
            {
                ShowMessageBox("비정상적인 접근입니다.","ProjectList.aspx");
                return;
            }
            long content_id = Int32.Parse(Request.Params["id"]);
            DataSet dsContent = DBConn.RunSelectQuery("SELECT contents.server_id FROM contents WHERE id={0} AND userid={1}",
                new string[] {
                    "@id",
                    "@userid"
                },
                new object[] {
                    content_id,
                    AuthUser.ID
                });
            if (DataSetUtil.IsNullOrEmpty(dsContent))
            {
                ShowMessageBox("비정상적인 접근입니다.", "ProjectList.aspx");
                return;
            }
            outputRes2JS(
                new string[] {
                    "USER_ID",
                    "CONTENT_ID",
                    "SERVER_ID"

                },
                new string[] {
                    AuthUser.ID.ToString(),
                    content_id.ToString(),
                    DataSetUtil.RowStringValue(dsContent,"server_id",0)
                });

            //DataSet dsContent = null;
            //string strXML;
            //DBConn.RunSelectQuery("SELECT xml FROM contents WHERE id={0}",
            //    new string[] { "@id" },
            //    new object[] { content_id });
            //if (!DataSetUtil.IsNullOrEmpty(dsContent))
            //    strXML = DataSetUtil.RowStringValue(dsContent, "xml", 0);
            //StringReader strReader = new StringReader(strXML);
            //XmlReader reader=XmlTextReader.Create(strReader);
            //while (reader.Read())
            //{
            //    switch (reader.NodeType)
            //    {
            //    }
            //}

            //String strMarkerPath=null;
            //DataSet dsContent = DBConn.RunSelectQuery("SELECT * FROM contents WHERE id={0}",
            //     new string[] { "@id" }, new object[] { content_id });
            //if (!DataSetUtil.IsNullOrEmpty(dsContent) && DataSetUtil.RowStringValue(dsContent, 3, 0) != null)
            //{
            //    strMarkerPath = "/markers/" + DataSetUtil.RowStringValue(dsContent, 3, 0);
            //    imgMarker.ImageUrl = strMarkerPath;
            //    imgMarker.Visible = true;
            //}
            //else
            //    imgMarker.Visible = false;
        }

        public void outputRes2JS(string[] strNames, string[] strValues)
        {
            if (strNames.Length != strValues.Length)
                return;

            string strRet = "<script language=\"javascript\" type=\"text/javascript\">\n";
            for (int i = 0; i < strNames.Length; i++)
            {
                strRet += "var " + strNames[i] + " = \"" + strValues[i] + "\";\n";
            }
            strRet += "</script>";

            ltlScript.Text += strRet;
        }
    }
}