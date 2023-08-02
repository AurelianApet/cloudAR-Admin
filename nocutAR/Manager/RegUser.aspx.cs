using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataAccess;
using nocutAR.Common;

namespace nocutAR.Manager
{
    public partial class RegUser : Common.PageBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            // 아이디중복검사
            if (!DataSetUtil.IsNullOrEmpty(DBConn.RunStoreProcedure(
                Constants.SP_GETUSER,
                new string[] {
                "@loginid"
            },
                new object[] {
                txtLoginID.Text
            })))
            {
                ShowMessageBox(Resources.Err.ERR_LOGINID_INUSED);
                return;
            }

            //// 닉네임중복검사
            //if (!DataSetUtil.IsNullOrEmpty(DBConn.RunStoreProcedure(
            //    Constants.SP_GETUSER,
            //    new string[] {
            //    "@nick"
            //},
            //    new object[] {
            //    txtNickName.Text
            //})))
            //{
            //    ShowMessageBox(Resources.Err.ERR_NICKNAME_INUSED);
            //    return;
            //}
            long lUserID = DataSetUtil.GetID(
                DBConn.RunStoreProcedure(Constants.SP_CREATEUSER,
                new string[] {
                    "@loginid",
                    "@loginpwd",
                    "@company",
                    "@auth_no",
                    "@address",
                    "@owner",
                    "@handphone",
                    "@telephone",
                    "@ulevel",
                    "@use_area",
                    "@test_req",
                    "@comment",
                    "@reg_ip"
                },
                new object[] {
                    txtLoginID.Text,
                    CryptSHA256.Encrypt(txtLoginPwd.Text),
                    txtCompany.Text,
                    txtAuthNo.Text,
                    txtAddress.Text,
                    txtOwner.Text,
                    txtMobile.Text,
                    txtTel.Text,
                    SiteConfig.JoinLevel,
                    ddlUseArea.SelectedValue,
                    chkboxTestReq.Checked,
                    txtComment.Text,
                    Request.ServerVariables["REMOTE_ADDR"]
                })
            );
            ShowMessageBox(Resources.Msg.MSG_MEMBERJOIN, Defines.URL_LOGIN);
        }
    }
}