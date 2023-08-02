using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

using nocutAR.Common;
using DataAccess;
using System.Data;

namespace nocutAR.Account
{
    public partial class campainhist : Common.PageBase
    {
        int IID = 0;

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
            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents WHERE userid={0} ORDER BY id",
                new string[] { "@userid" },
                new object[] { AuthUser.ID }
            );
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

                ddlMarkers_SelectedIndexChanged(null, null);
                ddlScans_SelectedIndexChanged(null, null);
            }
        }

        protected override void gvContent_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            base.gvContent_RowDataBound(sender, e);
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView dr = (DataRowView)e.Row.DataItem;
                Literal ltrStatus = (Literal)e.Row.FindControl("ltrObjCount");
                // XML
                string strXML = dr["xml"].ToString();
                if (!string.IsNullOrEmpty(strXML))
                {
                    XmlDocument xmlDoc = new XmlDocument();
                    xmlDoc.LoadXml(strXML);
                    XmlNodeList nodelist = null;
                    //nodelist = xmlDoc.SelectNodes("contents");
                    XmlElement elm = xmlDoc.DocumentElement;
                    nodelist = elm.ChildNodes;
                    int nCount = nodelist.Count;

                    ltrStatus.Text = nCount > 2 ? (nCount - 2).ToString() : "0";
                }
                else
                {
                    ltrStatus.Text = "0";
                }
            }
        }
        protected void ddlScans_SelectedIndexChanged(object sender, EventArgs e)
        {
            string strQuery = "SELECT COUNT(*) scan, month FROM (SELECT *, CAST(CONVERT(NVARCHAR(2), regdate, 110) AS int) as month FROM contentsusehist WHERE userid={0} AND CONVERT(NVARCHAR(4), regdate, 111)={1}) as s GROUP BY month ";
            DataSet dsScans = DBConn.RunSelectQuery(strQuery,
                new string[] {
                    "@id",
                    "@year"
                },
                new object[] {
                    AuthUser.ID,
                    ddlScans.SelectedValue
                });
            if (DataSetUtil.IsNullOrEmpty(dsScans))
            {
                ltlData.Text = "<script type='text/javascript'> var graphdata=[0,0,0,0,0,0,0,0,0,0,0,0]; </script>";
            }
            else
            {
                string[] arrData = new String[] { "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0" };
                for (int i = 0; i < DataSetUtil.RowCount(dsScans); i++)
                {
                    int month = DataSetUtil.RowIntValue(dsScans, "month", i);
                    int scan = DataSetUtil.RowIntValue(dsScans, "scan", i);
                    arrData[month - 1] = scan.ToString();
                }
                string data = arrData[0];
                for (int i = 1; i < 12; i++)
                {
                    data += "," + arrData[i];
                }
                ltlData.Text = "<script type='text/javascript'> var graphdata=[" + data + "]; </script>";
            }
        }

        protected void ddlMarkers_SelectedIndexChanged(object sender, EventArgs e)
        {
            string strQuery = "SELECT COUNT(*) scan, month FROM (SELECT *, CAST(CONVERT(NVARCHAR(2), regdate, 110) AS int) as month FROM contents WHERE userid={0} AND CONVERT(NVARCHAR(4), regdate, 111)={1}) as s GROUP BY month ";
            DataSet dsScans = DBConn.RunSelectQuery(strQuery,
                new string[] {
                    "@id",
                    "@year"
                },
                new object[] {
                    AuthUser.ID,
                    ddlMarkers.SelectedValue
                });

            Literal[] arrLtrMarker = new Literal[] { ltrMarker1, ltrMarker2, ltrMarker3, ltrMarker4, ltrMarker5, ltrMarker6, ltrMarker7, ltrMarker8, ltrMarker9, ltrMarker10, ltrMarker11, ltrMarker12 };

            for (int i = 0; i < 12; i++)
            {
                arrLtrMarker[i].Text = "0";
            }
            if (!DataSetUtil.IsNullOrEmpty(dsScans))
            {
                for (int i = 0; i < DataSetUtil.RowCount(dsScans); i++)
                {
                    int month = DataSetUtil.RowIntValue(dsScans, "month", i);
                    int scan = DataSetUtil.RowIntValue(dsScans, "scan", i);
                    arrLtrMarker[month - 1].Text = scan.ToString();
                }
            }
        }
    }
}