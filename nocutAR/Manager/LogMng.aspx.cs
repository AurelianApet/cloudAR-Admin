using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using nocutAR.Common;
using DataAccess;

namespace nocutAR.Manager
{
    public partial class LogMng : Common.PageBase
    {
        string m_strKeyword = null;
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);

        }
        protected override GridView getGridControl()
        {
            return gvContent;
        }
        protected override void BindData()
        {
            base.BindData();
        }
        protected override void LoadData()
        {
            base.LoadData();
            DataSet dsContents = null;

            m_strKeyword = txtSearchKey.Text;
            if (m_strKeyword == "")
            {
                dsContents = DBConn.RunStoreProcedure(Constants.SP_GETEVENTLOG);
            }
            else
            {
                if ("master".Contains(m_strKeyword))
                {
                    dsContents = DBConn.RunStoreProcedure(Constants.SP_GETEVENTLOG,
                    new string[] {
                        "@searchtype",
                        "@keyword"
                    },
                    new object[] {
                        3,
                        m_strKeyword
                    });
                }
                else
                {
                    dsContents = DBConn.RunStoreProcedure(Constants.SP_GETEVENTLOG,
                        new string[] {
                        "@searchtype",
                        "@keyword"
                    },
                        new object[] {
                        ddlSearchKey.SelectedValue,
                        m_strKeyword
                    });
                }
            }

            PageDataSource = dsContents;
            BindData();
        }

        protected void gvContent_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // when mouse is over the row, save original color to new attribute, and change it to highlight yellow color

                e.Row.Attributes.Add("onmouseover",
                "this.originalstyle=this.style.backgroundColor;this.style.backgroundColor='#d6d6d6'");

                e.Row.Attributes.Add("onmouseout",
                "this.style.backgroundColor=this.originalstyle;");

            }

        }

        protected override void gvContent_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //string abc = ((GridView)sender).DataKeys[e.Row.RowIndex].Value.ToString();
                //e.Row.Attributes["onDblClick"] = "OnDblCLick(" + DataBinder.Eval(e.Row.DataItem, "id") + ")";

                e.Row.Attributes.Add("style", "cursor:pointer;");

            }

        }
    }
}