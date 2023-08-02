using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

using DataAccess;

namespace nocutAR.Manager
{
    public partial class getUsedStatus : Common.AjaxPageBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            Response.Clear();
            Response.ContentType = "text/html";
            Response.ContentEncoding = System.Text.Encoding.UTF8;
            DataSet dsContent = null;
            DataSet dsTraffic = null;
            string strData = null;


            int IID = 0;
            if(!string.IsNullOrEmpty(Request.Params["id"]))
                IID=Int32.Parse(Request.Params["id"]);
            dsContent = DBConn.RunSelectQuery("SELECT (SELECT company FROM users WHERE (id = {0})) AS company,SUM(api_requests) AS api_requests, SUM(size) AS usedhard, COUNT(*) AS markers FROM contents WHERE userid = {0}",
                new string[] { "@id" },
                new object[] { IID });
            dsTraffic = DBConn.RunSelectQuery("SELECT SUM(size) AS traffic FROM traffics WHERE userid={0}",
                new string[] { "@id" },
                new object[] { IID });

            if (!DataSetUtil.IsNullOrEmpty(dsContent) && !DataSetUtil.IsNullOrEmpty(dsTraffic))
            {

                string strItemFormat = "{{\"company\":\"{0}\", " +
                                   "\"markers\":\"{1}\", " +
                                   "\"usedhard\":\"{2}\", " +
                                   "\"traffic\":\"{3}\", " +
                                   "\"api_requests\":\"{4}\" " +
                                   "}}";
                float usehard = DataSetUtil.RowFloatValue(dsContent, "usedhard", 0);
                float traffic = DataSetUtil.RowFloatValue(dsTraffic, "traffic", 0);
                if (usehard == -1)
                    usehard = 0;
                if (traffic == -1)
                    traffic = 0;
                strData = string.Format(strItemFormat, DataSetUtil.RowStringValue(dsContent, "company", 0),
                    DataSetUtil.RowIntValue(dsContent, "markers", 0),
                    usehard/1024.0,
                    traffic / 1024.0,
                    DataSetUtil.RowLongValue(dsContent, "api_requests", 0));
            }
            Response.Write(strData);
            Response.End();


        }

    }
}