using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using DataAccess;
using System.Data;
using nocutAR.Common;
namespace nocutAR.Account
{
    public partial class Notice : Common.PageBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
        }
        protected override GridView getGridControl()
        {
            return gvContent;
        }
        protected override void LoadData()
        {
            base.LoadData();
            PageDataSource = DBConn.RunStoreProcedure(Constants.SP_GETNOTICELIST);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            DataSet dsContents = null;
            dsContents = DBConn.RunSelectQuery("SELECT * FROM notices WHERE CHARINDEX({0}, title) > 0 OR CHARINDEX({0}, notice) > 0 ORDER BY regdate DESC",
                new string[] { "@key" },
                new object[] { txtSearchKey.Text.Trim() }
            );

            PageDataSource = dsContents;
            BindData();
        }
    }
}