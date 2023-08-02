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
    public partial class Manager : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (CurrentPage.AuthUser==null || !CurrentPage.AuthUser.IsAdmin)
            {
                CurrentPage.UserLogout();
                CurrentPage.Alert(Resources.Err.ERR_REQUIRED_ADMINAUTH, Defines.URL_LOGIN);
                return;
            }

        }
        public PageBase CurrentPage
        {
            get { return Page as PageBase; }
        }

        protected void btn_RegMarker_Click(object sender, EventArgs e)
        {
            CurrentPage.DBConn.RunUpdateQuery("UPDATE contents SET server_id={0} WHERE id={1}",
                new string[] {
                                "@server_id",
                                "@id"

                            },
                new object[] {
                                txtMarkName.Text,
                                Request.Params["content_id"]
                            });
            Response.Redirect("MemberMng.aspx");
        }
        protected void btnChangPwdOK_Click(object sender, EventArgs e)
        {
            if (txtCurrentPwd.Text != CryptSHA256.Decrypt(CurrentPage.AuthUser.LoginPwd))
            {
                CurrentPage.ShowMessageBox("현재 패스워드가 정확치 않습니다.");
                return;
            }
            CurrentPage.DBConn.RunUpdateQuery("UPDATE users SET loginpwd={0} WHERE id={1}",
                new string[] {
                                "@loginpwd",
                                "@loginid"

                            },
                new object[] {
                                CryptSHA256.Encrypt(txtNewPwd.Text),
                                CurrentPage.AuthUser.ID
                            });
            CurrentPage.DBConn.RunStoreProcedure(Constants.SP_ADDEVENTLOG,
                    new string[] {
                        "@event",
                        "@userid",
                        "@user_ip"
                    },
                    new object[] {
                        Constants.EVENT_CHANGEPWD,
                        CurrentPage.AuthUser.ID,
                        Request.ServerVariables["REMOTE_ADDR"]
                    });
        }
    }
}