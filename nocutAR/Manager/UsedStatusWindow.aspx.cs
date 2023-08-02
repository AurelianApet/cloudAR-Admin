using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using DataAccess;
using nocutAR.Common;

namespace nocutAR.Manager
{
    public partial class UsedStatusWindow : Common.PageBase
    {
        int IID = 0;
        protected override void Page_Load(object sender, EventArgs e)
        {
            IID = Int32.Parse(Request.Params["id"]);
            outputRes2JS(
                new string[] {
                    "USER_ID"
                },
                new string[] {
                    IID.ToString()
                });
            base.Page_Load(sender, e);

        }
        protected override GridView getGridControl()
        {
            return gvContent;
        }
        protected override void InitControls()
        {
            if (getGridControl() != null)
                getGridControl().PageSize = 10;
        }
        protected override void BindData()
        {
            base.BindData();
        }
        protected override void LoadData()
        {
            base.LoadData();
            DataSet dsContent = null;
            dsContent = DBConn.RunStoreProcedure(Constants.SP_GETCAMPAIGNPOPLIST,
                new string[] {
                    "@userid",
                    "@searchdate"
                },
                new object[] {
                    IID ,
                    ddlSearchDate.SelectedValue
                });

            PageDataSource = dsContent;
            BindData();

        }

        protected void gvContent_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                // when mouse is over the row, save original color to new attribute, and change it to highlight yellow color
                e.Row.Attributes.Add("onmouseover",
                "this.originalstyle=this.style.backgroundColor;this.style.backgroundColor='#d6d6d6'");
                // when mouse leaves the row, change the bg color to its original value
                e.Row.Attributes.Add("onmouseout",
                "this.style.backgroundColor=this.originalstyle;");
            }

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