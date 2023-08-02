using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using nocutAR.Common;
using DataAccess;
using System.Data;

namespace nocutAR.Account
{
    public partial class accountinfo : Common.PageBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            //ShowMessageBox(CryptSHA256.Decrypt("/wUVK3kHw38="));
            base.Page_Load(sender, e);
        }

        protected override void InitControls()
        {
            base.InitControls();
            DataSet dsInfo = DBConn.RunSelectQuery("SELECT *,product_name AS use_productname FROM (SELECT * FROM users WHERE id={0}) as u LEFT OUTER JOIN products as p ON u.use_product=p.id"
                , new string[] { "@id" }
                , new object[] { AuthUser.ID }
                );
            if (!DataSetUtil.IsNullOrEmpty(dsInfo))
            {
                ltrCompany.Text = DataSetUtil.RowStringValue(dsInfo, "company", 0);
                ltrLoginID.Text = AuthUser.LoginID;
                ltrProduct.Text = DataSetUtil.RowStringValue(dsInfo, "use_productname", 0);
                ltrUseDate.Text = DataSetUtil.RowStringValue(dsInfo, "contract_start", 0).Substring(0, 10) + "~" + DataSetUtil.RowStringValue(dsInfo, "contract_end", 0).Substring(0, 10);
            }
        }

        protected void btnChangePwd_Click(object sender, EventArgs e)
        {
            string curPwd = tbxCurPwd.Text;
            string newPwd = tbxNewPwd.Text;
            string confirmPwd = tbxConfirmPwd.Text;
            if (CryptSHA256.Encrypt(curPwd) != AuthUser.LoginPwd)
            {
                ShowMessageBox("현재 비번이 일치하지 않습니다.");
                return;
            }
            if (newPwd != confirmPwd)
            {
                ShowMessageBox("신규 비번이 일치하지 않습니다.");
                return;
            }
            try
            {
                DBConn.RunUpdateQuery("Update users SET loginpwd={0} WHERE id={1}",
                        new string[] {
                        "@loginpwd",
                        "@id"
                    },
                        new object[] {
                        CryptSHA256.Encrypt(newPwd),
                        AuthUser.ID
                });
                AuthUser.LoginPwd = CryptSHA256.Encrypt(newPwd);
                ShowMessageBox("비번이 변경되었습니다.");
            }
            catch
            {
                ShowMessageBox("비번 변경과정에 오류가 발생하였습니다.");
                return;
            }
        }
    }
}