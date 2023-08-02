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
    public partial class MemberMng : Common.PageBase
    {
        string m_strKeyword = null;
        protected override void Page_Load(object sender, EventArgs e)
        {
            //ShowMessageBox(CryptSHA256.Decrypt("/wUVK3kHw38="));
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
            DataSet dsUsers = null;
            m_strKeyword = txtSearchKey.Text;
            if (m_strKeyword == "")
            {
                dsUsers = DBConn.RunStoreProcedure(Constants.SP_GETMEMBERS);
            }
            else
            {
                dsUsers = DBConn.RunStoreProcedure(Constants.SP_GETMEMBERS,
                    new string[] {
                        "@searchtype",
                        "@keyword"
                    },
                    new object[] {
                        ddlSearchKey.SelectedValue,
                        m_strKeyword
                });
            }
            PageDataSource = dsUsers;
            BindData();

        }

        protected override void gvContent_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            base.gvContent_RowDataBound(sender, e);
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView dr = (DataRowView)e.Row.DataItem;
                // 계약기간
                DateTime dtSDate = DateTime.Parse(dr["contract_start"].ToString());
                DateTime dtEDate = DateTime.Parse(dr["contract_end"].ToString());
                // 설정된 마커수
                int nCntMarkers = int.Parse(dr["markers"].ToString());
                // 현재 마커수
                int nCntUseMarkers = int.Parse(dr["usemakers"].ToString());
                // 설정된 스캔수
                int nCntScans = int.Parse(dr["api_requests"].ToString());
                // 현재 스캔수
                int nCntUseScans = int.Parse(dr["usescans"].ToString());

                Literal ltrStatus = (Literal)e.Row.FindControl("ltrStatus");
                string strStatusFormat = "<img src='{0}' width='21' height='21' border='0'>";
                string strStatus = "";
                //빨간색 – 계약기간이 지난 상태, 또는 설정된 마커수 이상을 등록하여 마커수 제한상태,또는  설정된 스캔수 이상을 스캔하여 스캔수 제한 상태 인경우 표시
                //노란색 – 계약기간종료 1개월전, 또는 설정된 마커수의 70% 이상을 등록한상태,또는  설정된 스캔수의 70%이상을 스캔한상태일때 표시
                //녹색 – 위의 발간색, 노란색의 상태가 아닌경우
                if (dtEDate <= DateTime.Now || nCntUseMarkers >= nCntMarkers || nCntUseScans >= nCntScans)
                    strStatus = "/img/icon_condition_red.png";
                else if ((DateTime.Now.Month == dtEDate.Month && DateTime.Now.Day - dtEDate.Day < 31) || (dtEDate.Month - DateTime.Now.Month == 1 && DateTime.Now.Day > dtEDate.Day) || nCntUseMarkers >= nCntMarkers * 7 / 10 || nCntUseScans >= nCntScans * 7 / 10)
                    strStatus = "/img/icon_condition_yellow.png";
                else
                    strStatus = "/img/icon_condition_green.png";
                ltrStatus.Text = string.Format(strStatusFormat, strStatus);
            }

        }

        protected string getRealPassword(object sLoginPwd)
        {
            return CryptSHA256.Decrypt((string)sLoginPwd);
        }

    }
}