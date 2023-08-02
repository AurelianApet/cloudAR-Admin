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
    public partial class get3DTemplateInfo : Common.AjaxPageBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            Response.Clear();
            Response.ContentType = "text/html";
            Response.ContentEncoding = System.Text.Encoding.UTF8;
            DataSet dsContent = null;
            string strData = null;

            int uid = Int32.Parse(Request.Params["id"]);
            dsContent = DBConn.RunSelectQuery("SELECT products.three_template FROM products INNER JOIN users ON users.use_product LIKE products.id WHERE users.id={0}",
                new string[] { "@id" },
                new object[] { uid });
            if (!DataSetUtil.IsNullOrEmpty(dsContent))
            {
                string strItemFormat = "{{\"flag\":\"{0}\"}}";
                strData = string.Format(strItemFormat, DataSetUtil.RowIntValue(dsContent, "three_template", 0));
            }
            Response.Write(strData);
            Response.End();
        }
    }
}