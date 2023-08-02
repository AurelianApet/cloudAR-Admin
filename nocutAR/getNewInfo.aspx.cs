using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using DataAccess;
using nocutAR.Common;

namespace nocutAR
{
    public partial class getNewInfo : Common.PageBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);

            Response.Clear();
            Response.ContentType = "text/json";
            Response.ContentEncoding = System.Text.Encoding.UTF8;


            //int iReqCount = 0;
            string iReqName = "";
            string iReqProject = "";
            string iReqPath = "";
            long iReqID = 0;

            DataSet dsReq = DBConn.RunStoreProcedure(Constants.SP_GETUNREADREQUEST);

            //iReqCount = DataSetUtil.RowIntValue(dsReq, "req_count", 0);
            iReqName = DataSetUtil.RowStringValue(dsReq, "content_title", 0);
            iReqProject = DataSetUtil.RowStringValue(dsReq, "project_title", 0);
            iReqPath = DataSetUtil.RowStringValue(dsReq, "marker_url", 0);
            iReqID = DataSetUtil.RowLongValue(dsReq, "content_id", 0);

            //for (int i = 0; i < DataSetUtil.RowCount(dsReq); i++)
            //{
                Response.Write("{\"reqcontentname\":\"" + iReqName +
                         "\", \"reqprojectname\":\"" + iReqProject +
                         "\", \"contentid\":\"" + iReqID +
                         "\", \"reqmarkerpath\":\"" + iReqPath +
                         "\"}");
            //}


            Response.End();
        }
    }
}