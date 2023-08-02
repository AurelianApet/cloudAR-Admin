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
    public partial class trafficdetail : Common.PageBase
    {
        int IID = 0;

        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
        }

        protected void InitData()
        {
            hfdID.Value = "0";
            Literal[] arrLtrMarker = new Literal[] {ltrMarker1, ltrMarker2, ltrMarker3, ltrMarker4, ltrMarker5, ltrMarker6, ltrMarker7, ltrMarker8, ltrMarker9, ltrMarker10, ltrMarker11, ltrMarker12};
            ltrCompany.Text = "";
            ltrMarkers.Text = "";
            ltrScans.Text = "";
            ltrDate.Text = "";
            ltrCondition.Text = "";
            ltrStatus.Text = "";
            tdHard.Width = "0px";
            tdTraffic.Width = "0px";
            for (int i = 0; i < 12; i++)
            {
                arrLtrMarker[i].Text = "";
            }
            ltlData.Text = "<script type='text/javascript'> var graphdata=[0,0,0,0,0,0,0,0,0,0,0,0]; </script>";
        }

        protected override void InitControls()
        {
            base.InitControls();

            if (!IsPostBack)
            {
                int curYear = DateTime.Now.Year;
                ddlScans.Items.Clear();
                ddlMarkers.Items.Clear();

                for (int i = 0; i < 5; i++)
                {
                    ddlScans.Items.Add(new ListItem((curYear - i).ToString(), (curYear - i).ToString()));
                    ddlMarkers.Items.Add(new ListItem((curYear - i).ToString(), (curYear - i).ToString()));
                }

                ddlScans.SelectedIndex = 0;
                ddlMarkers.SelectedIndex = 0;
                if (!string.IsNullOrEmpty(Request.Params["id"]))
                    IID = Int32.Parse(Request.Params["id"]);
                if (IID == 0)
                {
                    InitData();
                }
                else
                {
                    DataSet dsUsers = DBConn.RunStoreProcedure(Constants.SP_GETMEMBERS,
                    new string[] {
                        "@searchtype",
                        "@keyword"
                    },
                    new object[] {
                        3,
                        IID
                    });
                    onSetData(dsUsers);
                }
            }
        }

        protected void onSetData(DataSet dsUsers)
        {
            if (DataSetUtil.IsNullOrEmpty(dsUsers))
                InitData();
            else
            {
                hfdID.Value = DataSetUtil.RowStringValue(dsUsers, "id", 0);
                // 계약기간
                DateTime dtSDate = DateTime.Parse(DataSetUtil.RowStringValue(dsUsers, "contract_start", 0));
                DateTime dtEDate = DateTime.Parse(DataSetUtil.RowStringValue(dsUsers, "contract_end", 0));
                // 설정된 마커수
                int nCntMarkers = DataSetUtil.RowIntValue(dsUsers, "markers", 0);
                // 현재 마커수
                int nCntUseMarkers = DataSetUtil.RowIntValue(dsUsers, "usemakers", 0);
                // 설정된 스캔수
                int nCntScans = DataSetUtil.RowIntValue(dsUsers, "api_requests", 0);
                // 현재 스캔수
                int nCntUseScans = DataSetUtil.RowIntValue(dsUsers, "usescans", 0);
                // 총트래픽
                int nTraffic = DataSetUtil.RowIntValue(dsUsers, "traffic", 0);
                // 사용된 트래픽
                double nUseTraffic = Math.Round(DataSetUtil.RowFloatValue(dsUsers, "usetraffic", 0)/1024,3);
                // 전체 하드사용용량
                int nHardUsed = DataSetUtil.RowIntValue(dsUsers, "hardused", 0);
                // 현재 하드 사용용량
                double nUsedHard = Math.Round(DataSetUtil.RowDoubleValue(dsUsers, "usedhard", 0)/1024,3);

                ltrCompany.Text = DataSetUtil.RowStringValue(dsUsers, "company", 0);
                ltrMarkers.Text = nCntUseMarkers.ToString();
                ltrScans.Text = nCntUseScans.ToString() + "/" + nCntScans.ToString();
                ltrDate.Text = dtSDate.ToString("yyyy/MM/dd") + "~" + dtEDate.ToString("yyyy/MM/dd");
                string strStatusFormat = "<img src='{0}' width='21' height='21' border='0'>";
                string strStatus = "이용가능";
                ltrStatus.Text = "이용가능";
                //빨간색 – 계약기간이 지난 상태, 또는 설정된 마커수 이상을 등록하여 마커수 제한상태,또는  설정된 스캔수 이상을 스캔하여 스캔수 제한 상태 인경우 표시
                //노란색 – 계약기간종료 1개월전, 또는 설정된 마커수의 70% 이상을 등록한상태,또는  설정된 스캔수의 70%이상을 스캔한상태일때 표시
                //녹색 – 위의 발간색, 노란색의 상태가 아닌경우
                if (dtEDate <= DateTime.Now || nCntUseMarkers >= nCntMarkers || nCntUseScans >= nCntScans)
                {
                    strStatus = "/img/icon_condition_red.png";
                    ltrStatus.Text = "이용불가";
                }
                else if ((DateTime.Now.Month == dtEDate.Month && DateTime.Now.Day - dtEDate.Day < 31) || (dtEDate.Month - DateTime.Now.Month == 1 && DateTime.Now.Day > dtEDate.Day) || nCntUseMarkers >= nCntMarkers * 7 / 10 || nCntUseScans >= nCntScans * 7 / 10)
                    strStatus = "/img/icon_condition_yellow.png";
                else
                    strStatus = "/img/icon_condition_green.png";
                ltrCondition.Text = string.Format(strStatusFormat, strStatus);

                if (nUsedHard > nHardUsed)
                    tdHard.Width = "474px";
                else
                    tdHard.Width = (474 * nUsedHard / nHardUsed).ToString() + "px";

                if (nUseTraffic > nTraffic)
                    tdTraffic.Width = "474px";
                else
                    tdTraffic.Width = (474 * nUseTraffic / nTraffic).ToString() + "px";

                tdHard_div.Text = nUsedHard + "G/" + nHardUsed + "G";
                tdTraffic_div.Text = nUseTraffic + "G/" + nTraffic + "G"; ;

                ddlMarkers_SelectedIndexChanged(null, null);
                ddlScans_SelectedIndexChanged(null, null);
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (txtSearchKey.Text != "")
            {
                DataSet dsUsers = DBConn.RunStoreProcedure(Constants.SP_GETMEMBERS,
                    new string[] {
                        "@searchtype",
                        "@keyword"
                    },
                    new object[] {
                        ddlSearchKey.SelectedValue,
                        txtSearchKey.Text
                    });

                onSetData(dsUsers);
            }
        }

        protected void ddlMarkers_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (hfdID.Value != "" && hfdID.Value != "0")
            {
                string strQuery = "SELECT COUNT(*) scan, month FROM (SELECT *, CAST(CONVERT(NVARCHAR(2), regdate, 110) AS int) as month FROM contents WHERE userid={0} AND CONVERT(NVARCHAR(4), regdate, 111)={1}) as s GROUP BY month ";
                DataSet dsScans = DBConn.RunSelectQuery(strQuery,
                    new string[] {
                        "@id",
                        "@year"
                    },
                    new object[] {
                        hfdID.Value,
                        ddlMarkers.SelectedValue
                    });

                Literal[] arrLtrMarker = new Literal[] { ltrMarker1, ltrMarker2, ltrMarker3, ltrMarker4, ltrMarker5, ltrMarker6, ltrMarker7, ltrMarker8, ltrMarker9, ltrMarker10, ltrMarker11, ltrMarker12 };

                for (int i = 0; i < 12; i++)
                {
                    arrLtrMarker[i].Text = "0";
                }
                if (!DataSetUtil.IsNullOrEmpty(dsScans)) {
                    for (int i = 0; i < DataSetUtil.RowCount(dsScans); i++)
                    {
                        int month = DataSetUtil.RowIntValue(dsScans, "month", i);
                        int scan = DataSetUtil.RowIntValue(dsScans, "scan", i);
                        arrLtrMarker[month-1].Text = scan.ToString();
                    }
                }
            }
        }

        protected void ddlScans_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (hfdID.Value != "" && hfdID.Value != "0")
            {
                string strQuery = "SELECT COUNT(*) scan, month FROM (SELECT *, CAST(CONVERT(NVARCHAR(2), regdate, 110) AS int) as month FROM contentsusehist WHERE userid={0} AND CONVERT(NVARCHAR(4), regdate, 111)={1}) as s GROUP BY month ";
                DataSet dsScans = DBConn.RunSelectQuery(strQuery,
                    new string[] {
                        "@id",
                        "@year"
                    },
                    new object[] {
                        hfdID.Value,
                        ddlScans.SelectedValue
                    });
                if (DataSetUtil.IsNullOrEmpty(dsScans))
                {
                    ltlData.Text = "<script type='text/javascript'> var graphdata=[0,0,0,0,0,0,0,0,0,0,0,0]; </script>";
                }
                else
                {
                    string[] arrData = new String[] { "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0"};
                    for (int i = 0; i < DataSetUtil.RowCount(dsScans); i++)
                    {
                        int month = DataSetUtil.RowIntValue(dsScans, "month", i);
                        int scan = DataSetUtil.RowIntValue(dsScans, "scan", i);
                        arrData[month - 1] = scan.ToString();
                    }
                    string data = arrData[0];
                    for(int i = 1 ; i < 12 ; i++) {
                        data += ","+arrData[i];
                    }
                    ltlData.Text = "<script type='text/javascript'> var graphdata=[" + data + "]; </script>";
                }
            }
        }
    }
}