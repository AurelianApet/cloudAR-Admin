using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using DataAccess;
using System.Data;
using nocutAR.Common;

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
        protected override void BindData()
        {
            base.BindData();
        }
        protected override void LoadData()
        {
            base.LoadData();

            DataSet dsContents = null;
            dsContents = DBConn.RunSelectQuery("SELECT * FROM notices WHERE {0} like '%" + txtSearchKey.Text.Trim() + "%' ORDER BY regdate DESC",
                new string[] { "@key" },
                new object[] { ddlSearchKey.SelectedValue }
            );

            PageDataSource = dsContents;
            BindData();
            if (!IsPostBack)
            {
            }
        }

        protected void btnAddNoticeOK_Click(object sender, EventArgs e)
        {
            long lNoticeID = 0;
            if (!string.IsNullOrEmpty(Request.Params["hdNoticeID"]))
                lNoticeID = long.Parse(Request.Params["hdNoticeID"]);
            if (lNoticeID == 0)
            {
                lNoticeID = DataSetUtil.GetID(DBConn.RunStoreProcedure(Constants.SP_CREATENOTICE,
                new string[] {
                    "@title",
                    "@notice"
                },
                new object[] {
                    txtTitile.Text,
                    txtContent.Text
                }));
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
                    lNoticeID,
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

        protected void btnRemoveOk_Click(object sender, EventArgs e)
        {
            long lNoticeID = 0;
            if (!string.IsNullOrEmpty(Request.Params["hdRemoveID"]))
            {
                lNoticeID = long.Parse(Request.Params["hdRemoveID"]);

                DBConn.RunDeleteQuery("DELETE FROM Notices WHERE id={0}",
                    new string[] {
                        "@id"

                    },
                    new object[] {
                        Convert.ToInt64(lNoticeID)

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
    }
}