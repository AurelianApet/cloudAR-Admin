using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using nocutAR.Common;
using DataAccess;

namespace nocutAR
{
    public partial class getCheckDup : Common.AjaxPageBase
    {
        protected override void Page_Init(object sender, EventArgs e)
        {
        }
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);

            Response.Clear();
            Response.ContentType = "text/html";
            Response.ContentEncoding = System.Text.Encoding.UTF8;

            string strRet = "false";
            try
            {
                string strType = Request.Params["type"];
                string strVal = Request.Params["val"];

                if (!string.IsNullOrEmpty(strVal))
                {
                    DataSet dsTemp = null;
                    if (strType == "id")
                    {
                        dsTemp = DBConn.RunStoreProcedure(Constants.SP_GETUSER,
                            new string[] { "@loginid" }, new object[] { strVal });
                    }
                    else if (strType == "nick")
                    {
                        dsTemp = DBConn.RunStoreProcedure(Constants.SP_GETUSER,
                            new string[] { "@nick" }, new object[] { strVal });
                    }
                    if (!DataSetUtil.IsNullOrEmpty(dsTemp)) strRet = "true";
                }
            }
            catch { }

            Response.Write(strRet);
            Response.End();
        }
    }
}