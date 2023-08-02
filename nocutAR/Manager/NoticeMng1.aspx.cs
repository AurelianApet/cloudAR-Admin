using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using nocutAR.Common;
using DataAccess;

namespace nocutAR.Manager
{
    public partial class NoticeMng : Common.PageBase
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

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (int.Parse(Request.Params["isReg"]) == 1)
            {
                long lUserID = DataSetUtil.GetID(
                    DBConn.RunStoreProcedure(Constants.SP_CREATENOTICE,
                    new string[] {
                        "@title",
                        "@notice"
                    },
                    new object[] {
                        txtTitile.Text,
                        txtContent.Text
                    })
                );
                DBConn.RunStoreProcedure(Constants.SP_ADDEVENTLOG,
                    new string[] {
                        "@event",
                        "@userid",
                        "@user_ip"
                    },
                    new object[] {
                        Constants.EVENT_ADDNOTICE,
                        AuthUser.ID,
                        Request.ServerVariables["REMOTE_ADDR"]
                    });
                ShowMessageBox(Resources.Msg.MSG_NOTICEREGISTERED, "NoticeMng.aspx?page=" + PageNumber);
            }
            else
            {
                DBConn.RunStoreProcedure(Constants.SP_MODIFYNOTICE,
                    new string[] {
                        "@id",
                        "@title",
                        "@notice"
                    },
                    new object[] {
                        long.Parse(Request.Params["iid"]),
                        txtTitile.Text,
                        txtContent.Text
                    });
                DBConn.RunStoreProcedure(Constants.SP_ADDEVENTLOG,
                    new string[] {
                        "@event",
                        "@userid",
                        "@user_ip"
                    },
                    new object[] {
                        Constants.EVENT_MODNOTICE,
                        AuthUser.ID,
                        Request.ServerVariables["REMOTE_ADDR"]
                    });
                ShowMessageBox(Resources.Msg.MSG_NOTICEMODIFIED, "NoticeMng.aspx?page=" + PageNumber);
            }
        }

        protected void btnModify_Click(object sender, EventArgs e)
        {

        }

        protected void btnDelSelected_Click(object sender, EventArgs e)
        {
            string strSelIDs = Request.Form["chkDel"];
            if (string.IsNullOrEmpty(strSelIDs))
            {
                ShowMessageBox(Resources.Msg.MSG_NOSELECTITEM);
                return;
            }

            string[] arrSelID = strSelIDs.Split(',');

            try
            {
                for (int i = 0; i < arrSelID.Length; i++)
                {
                    DBConn.RunDeleteQuery("DELETE FROM notices WHERE id={0}",
                        new string[] {
                        "@id"

                    },
                        new object[] {
                        Convert.ToInt64(arrSelID[i])

                    });
                    DBConn.RunStoreProcedure(Constants.SP_ADDEVENTLOG,
                    new string[] {
                        "@event",
                        "@userid",
                        "@user_ip"
                    },
                    new object[] {
                        Constants.EVENT_DELNOTICE,
                        AuthUser.ID,
                        Request.ServerVariables["REMOTE_ADDR"]
                    });
                }
            }
            catch
            {
                ShowMessageBox(Resources.Err.ERR_DBERROR);
                return;
            }

            PageDataSource = null;
            BindData();
        }
    }
}