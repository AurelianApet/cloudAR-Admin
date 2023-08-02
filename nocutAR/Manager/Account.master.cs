using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using nocutAR.Common;
using DataAccess;
using System.Data;

namespace nocutAR.Manager
{
    public partial class Account : System.Web.UI.MasterPage
    {
        public PageBase CurrentPage
        {
            get { return Page as PageBase; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            DataSet dsProductNames = null;
            if (!IsPostBack)
            {
                dsProductNames = CurrentPage.DBConn.RunSelectQuery("SELECT product_name, id FROM products");
                ddlUseProduct.Items.Clear();
                for (int i = 0; i < DataSetUtil.RowCount(dsProductNames); i++)
                {
                    ddlUseProduct.Items.Add(new ListItem(DataSetUtil.RowStringValue(dsProductNames, "product_name", i), DataSetUtil.RowLongValue(dsProductNames, "id", i).ToString()));
                }
            }
        }

        protected void btnAddUserOK_Click(object sender, EventArgs e)
        {
            int modifyUserid = 0;
            if (!string.IsNullOrEmpty(Request.Params["modifyUserid"]))
                modifyUserid = int.Parse(Request.Params["modifyUserid"]);
            if (modifyUserid == 0)
            {
                //아이디 중복검사
                DataSet dsUser = CurrentPage.DBConn.RunStoreProcedure(Constants.SP_GETUSER,
                    new string[] {
                        "@loginid"
                },
                    new object[] {
                        txtLoginID.Text
                });
 
                if (!DataSetUtil.IsNullOrEmpty(dsUser))
                {
                    CurrentPage.ShowMessageBox(Resources.Err.ERR_LOGINID_INUSED);
                    return;
                }

                string pwd = txtLoginPwd.Text;
                if (pwd != DataSetUtil.RowStringValue(dsUser, "loginpwd", 0))
                    pwd = CryptSHA256.Encrypt(txtLoginPwd.Text);
                long lUserID = DataSetUtil.GetID(CurrentPage.DBConn.RunStoreProcedure(Constants.SP_CREATEUSER,
                new string[] {
                "@loginid",
                "@loginpwd",
                "@company",
                "@owner",
                "@telephone",
                "@email",
                "@ulevel",
                "@use_product",
                "@contract_start",
                "@contract_end",
                "@reg_ip"
                },
                new object[] {
                txtLoginID.Text,
                pwd,
                txtCompany.Text,
                txtOwner.Text,
                txtTelNo.Text,
                txtEmail.Text,
                CurrentPage.SiteConfig.JoinLevel,
                ddlUseProduct.SelectedValue,
                tbxStartDate.Text,
                tbxEndDate.Text,
                Request.ServerVariables["REMOTE_ADDR"]
                }));
                CurrentPage.DBConn.RunStoreProcedure(Constants.SP_ADDEVENTLOG,
                        new string[] {
                        "@event",
                        "@userid",
                        "@user_ip"
                    },
                        new object[] {
                        Constants.EVENT_ADDUSER,
                        CurrentPage.AuthUser.ID,
                        Request.ServerVariables["REMOTE_ADDR"]
                    });
                CurrentPage.ShowMessageBox(Resources.Msg.MSG_MEMBERJOIN, Request.ServerVariables["HTTP_REFERER"]);
            }
            else
            {
                // 아이디중복검사
                DataSet dsUser = CurrentPage.DBConn.RunSelectQuery("SELECT * FROM users WHERE loginid={0} AND id<>{1}",
                    new string[] {
                        "@loginid",
                        "@id"
                },
                    new object[] {
                        txtLoginID.Text,
                        modifyUserid
                });

                if (!DataSetUtil.IsNullOrEmpty(dsUser))
                {
                    CurrentPage.ShowMessageBox(Resources.Err.ERR_LOGINID_INUSED);
                    return;
                }

                string strPwd = txtLoginPwd.Text;
                if (DataSetUtil.RowStringValue(dsUser, "loginpwd", 0) != txtLoginPwd.Text)
                {
                    strPwd = CryptSHA256.Encrypt(txtLoginPwd.Text);
                }

                CurrentPage.DBConn.RunStoreProcedure(Constants.SP_MODIFYUSER,
                    new string[] {
                        "@id",
                        "@loginid",
                        "@loginpwd",
                        "@company",
                        "@owner",
                        "@telephone",
                        "@email",
                        "@use_product",
                        "@contract_start",
                        "@contract_end"
                    },
                    new object[] {
                        modifyUserid,
                        txtLoginID.Text,
                        strPwd,
                        txtCompany.Text,
                        txtOwner.Text,
                        txtTelNo.Text,
                        txtEmail.Text,
                        ddlUseProduct.SelectedValue,
                        tbxStartDate.Text,
                        tbxEndDate.Text
                });
                CurrentPage.DBConn.RunStoreProcedure(Constants.SP_ADDEVENTLOG,
                        new string[] {
                        "@event",
                        "@userid",
                        "@user_ip"
                    },
                        new object[] {
                        Constants.EVENT_MODUSER,
                        CurrentPage.AuthUser.ID,
                        Request.ServerVariables["REMOTE_ADDR"]
                    });
                CurrentPage.ShowMessageBox(Resources.Msg.MSG_MEMBERMODIFIED, Request.ServerVariables["HTTP_REFERER"]);
            }
        }
    }
}