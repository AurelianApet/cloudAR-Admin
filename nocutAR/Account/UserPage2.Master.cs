using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using nocutAR.Common;
using DataAccess;

namespace nocutAR.Account
{
    public partial class UserPage2 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataSet dsUsedStatus = null;
            DataSet dsUsedProduct = null;

            dsUsedStatus = CurrentPage.DBConn.RunSelectQuery("SELECT SUM(api_requests) AS api_requests, SUM(size) AS usedhard, COUNT(*) AS markers, (SELECT SUM(size) AS traffic FROM traffics WHERE userid={0}) AS traffic FROM contents WHERE userid = {0}",
                new string[] { "@userid" },
                new object[] { CurrentPage.AuthUser.ID });
            dsUsedProduct = CurrentPage.DBConn.RunSelectQuery("SELECT products.* FROM products INNER JOIN users ON users.use_product = products.id WHERE users.id = {0}",
                new string[] { "@id" },
                new object[] { CurrentPage.AuthUser.ID });
            if (!DataSetUtil.IsNullOrEmpty(dsUsedProduct) && !DataSetUtil.IsNullOrEmpty(dsUsedProduct))
            {
                if (DataSetUtil.RowIntValue(dsUsedProduct, "api_requests", 0) <= DataSetUtil.RowIntValue(dsUsedStatus, "api_requests", 0))
                {
                    CurrentPage.ShowMessageBox(Resources.Msg.MSG_APIREQUESTOVER, "CampainList.aspx");
                }
                if (DataSetUtil.RowIntValue(dsUsedProduct, "hardused", 0) * 1024 <= DataSetUtil.RowFloatValue(dsUsedStatus, "usedhard", 0))
                {
                    //하드용량이 초과되었다는 xml출력
                    CurrentPage.ShowMessageBox(Resources.Msg.MSG_HARDOVER, "CampainList.aspx");
                }
                if (DataSetUtil.RowIntValue(dsUsedProduct, "traffic", 0) * 1024 <= DataSetUtil.RowFloatValue(dsUsedStatus, "traffic", 0))
                {
                    //트래픽용량이 초과되었다는 xml출력
                    CurrentPage.ShowMessageBox(Resources.Msg.MSG_TRAFFICOVER, "CampainList.aspx");
                }
                if (DataSetUtil.RowIntValue(dsUsedProduct, "markers", 0) <= DataSetUtil.RowIntValue(dsUsedStatus, "markers", 0))
                {
                    //트래픽용량이 초과되었다는 xml출력
                    CurrentPage.ShowMessageBox(Resources.Msg.MSG_MARKEROVER, "CampainList.aspx");
                }
            }
        }
        public PageBase CurrentPage
        {
            get { return Page as PageBase; }
        }
    }
}