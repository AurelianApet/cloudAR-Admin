using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
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

        protected override void gvContent_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //string abc = ((GridView)sender).DataKeys[e.Row.RowIndex].Value.ToString();

                //e.Row.Attributes["onDblClick"] = "OnDblCLick('1','2','3')";
                e.Row.Attributes["onDblClick"] = "OnDblCLick(" + DataBinder.Eval(e.Row.DataItem, "id").ToString() + ")";

                //e.Row.Attributes["onClick"] = "location.href='Default.aspx?id=" + DataBinder.Eval(e.Row.DataItem, "CategoryID") + "'";

                e.Row.Attributes.Add("style", "cursor:pointer;");

            }
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
    }
}