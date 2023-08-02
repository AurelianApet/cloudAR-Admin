using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using nocutAR.Common;
using DataAccess;
using System.Net;

namespace nocutAR.Account
{
    public partial class CampainList : Common.PageBase
    {
        private string sns = "0";

        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
        }

        protected override void BindData()
        {
            base.BindData();

            string strLtrData = "";
            string strItem = " <td width='310' height='420' ><div style='position:relative;text-align:center;'> "
	            + "  <table cellpadding='0' cellspacing='0' align='center' style='border-collapse:collapse;' bgcolor='white' width='292'>"
		        + "     <tr>"
		        + "         <td width='290' height='310' style='border-width:1px; border-top-color:rgb(195,197,201); border-right-color:rgb(195,197,201); border-bottom-color:black; border-left-color:rgb(195,197,201); border-top-style:solid; border-right-style:solid; border-bottom-style:none; border-left-style:solid;'>"
			    + "         <table cellpadding='0' cellspacing='0' align='center' width='280'>"
			    + "             <tr>"
			    + "             <td width='280' height='298' bgcolor='#CCCCCC'>"
                + "                 <div style='width:280px; height:298px; overflow:hidden; margin:10px; position:relative' >"
                + "                     <img class='marker_img' {6} id='{5}' style='position:absolute;left: -100%;right: -100%;top: -100%;bottom: -100%;margin: auto; min-height: 100%; min-width: 100%;'src='{0}' border='0' onClick='onShowDetail(\"{0}\",\"{1}\",\"{2}\",\"{3}\",\"{4}\",\"{7}\",\"{8}\",\"{9}\");'/>"
                + "                     <a id='aDel_{5}' class='marker_edt' style='position:absolute;right:15px;bottom:15px;display:none' href='javascript:onDelCampaign({5})' ><img src='img/cam_icon_trash.png' class='image-btn' width='20' height='24' border='0' name='image1'></a>"
                + "                 </div>"
			    + "             </td>"
			    + "             </tr>"
			    + "         </table>"
		        + "         </td>"
		        + "     </tr>"
	            + "  <tr>"
		        + "      <td align='left' width='290' height='90' style='border-width:1px; border-top-color:black; border-right-color:rgb(195,197,201); border-bottom-color:rgb(195,197,201); border-left-color:rgb(195,197,201); border-top-style:none; border-right-style:solid; border-bottom-style:solid; border-left-style:solid;'>"
		        + "      <table cellpadding='0' cellspacing='0' align='center' width='276'>"
			    + "          <tr>"
			    + "          <td width='276' height='29'>"
			    + "              <table cellpadding='0' cellspacing='0' bordercolordark='black' bordercolorlight='black' width='260'>"
			    + "              <tr>"
			    + "                  <td width='177' height='24'>"
			    + "                <b><span style='font-size:12pt;'><font face='돋움' color='#666666'>{1}</font></span></b>"
			    + "                  </td>"
		        + "                  <td width='83' height='24'>&nbsp;</td>"
		        + "              </tr>"
	            + "              </table>"
		        + "          </td>"
		        + "          </tr>"
			    + "          <tr>"
			    + "          <td width='276' height='46'>"
			    + "              <table cellpadding='0' cellspacing='0' width='274'>"
			    + "              <tr>"
			    + "                  <td width='178' height='43'><font face='돋움' color='#666666'><span style='font-size:10pt;'>캠페인생성일: {2}<br>최종 수정일: {3}</span></font></td>"
			    + "                  <td width='96' height='43'>"
			    + "                <table cellpadding='0' cellspacing='0' width='95'>"
		        + "                    <tr>"
		        + "	                <td width='51' height='31' align='center'>"
	            + "	                    <img src='img/icon_view.png' width='30' height='22' border='0'>"
		        + "	                </td>"
		        + "	                <td width='44' height='31'><span style='font-size:11pt;'><font face='돋움' color='#666666'>{4}</font></span></td>"
			    + "                    </tr>"
			    + "                </table>"
			    + "                  </td>"
			    + "              </tr>"
			    + "              </table>"
			    + "          </td>"
			    + "          </tr>"
		        + "      </table>"
		        + "      </td>"
			    + "  </tr>"
		        + "  </table>"
                + " <table class='marker_edt' id='td_{5}' style='position:absolute;left:23px;top:10px;display:none;' cellpadding='0' cellspacing='0' align='center'>"
                + "     <tr>"
                + "         <td width='132' height='46'>"
                + "             <input type='button' class='clsButton' style='background:#666666; width:114px; height:27px; font-weight:bold;' value='캠페인 복사' onclick='onConfirmCopyCampain({5})' />"
                + "         </td>"
                + "         <td width='132' height='46'>"
                + "             <input type='button' class='clsButton' style='background:#666666; width:114px; height:27px; font-weight:bold;' value='Edit' onclick='onEditCampain({5})' />"
                + "         </td>"
                + "     </tr>"
                
                + " </table>"
                + " </div>"
		        + " </td>";
            string strEmptyItem = "<td width='310' height='420'>"
	            + "     <table cellpadding='0' cellspacing='0' align='center' style='border-collapse:collapse;' bgcolor='white' width='292'>"
		        + "         <tr>"
			    + "             <td width='290' height='398' align='center' style='border-width:1px; border-color:rgb(195,197,201); border-style:solid;'>"
                + "                 <img onclick='onAddCampain()' class='image-btn' src='img/cam_plus.png' width='95' height='94' border='0' name='image5'>"
			    + "             </td>"
		        + "         </tr>"
	            + "     </table>"
                + " </td>";
            for (int i = 0; i < DataSetUtil.RowCount(PageDataSource); i+=4)
            {
                string strTable = "<table cellpadding='0' cellspacing='0' align='center' width='1240'> "
                   + "<tr>" ;
                for(int j = 0 ; j < 4 ; j++) {
                    int row = i+j;
                    if(row < DataSetUtil.RowCount(PageDataSource)) {
                        string url = DataSetUtil.RowStringValue(PageDataSource, "marker_url", row);
                        string strSize="height=298";
                        if (!url.Equals(""))
                        {
                            try
                            {
                                System.Drawing.Image image = System.Drawing.Image.FromFile(this.Server.MapPath("../markers/" + url));
                                if (image.Width <= image.Height)
                                    strSize = "width=280";
                            }
                            catch (Exception ex)
                            {
                                strSize = "width=280";
                            }
                        }
                        string item = string.Format(strItem, url==""?"":("/markers/" + url)
                            , DataSetUtil.RowStringValue(PageDataSource, "title", row)
                            , DateTime.Parse(DataSetUtil.RowStringValue(PageDataSource, "regdate", row)).ToString("yyyy-MM-dd")
                            , DateTime.Parse(DataSetUtil.RowStringValue(PageDataSource, "changedate", row)).ToString("yyyy-MM-dd")
                            , DataSetUtil.RowStringValue(PageDataSource, "api_requests", row)
                            , DataSetUtil.RowStringValue(PageDataSource, "id", row)
                            , strSize
                            , DataSetUtil.RowStringValue(PageDataSource, "description", row)
                            , DataSetUtil.RowStringValue(PageDataSource, "is_board", row)
                            , sns
                            );
                        strTable += item; 
                    }
                    else {
                        strTable += strEmptyItem;
                        for(int k = j+1 ; k < 4 ; k++) {
                            strTable += "<td width='310' height='420'>&nbsp;</td>";
                        }
                        break;
                    }
                }
                strTable += "</tr></table>";
                strLtrData += strTable;
            }

            if (DataSetUtil.RowCount(PageDataSource) % 4 == 0)
            {
                string strTable = "<table cellpadding='0' cellspacing='0' align='center' width='1240'> "
                   + "<tr>";
                strTable += strEmptyItem;
                for (int k = 1; k < 4; k++)
                {
                    strTable += "<td width='310' height='420'>&nbsp;</td>";
                }
                strTable += "</tr></table>";
                strLtrData += strTable;
            }

            ltrData.Text = strLtrData;
        }
        protected override void LoadData()
        {
            base.LoadData();

            if (txtSearchKey.Text.Trim().Length > 0)
            {
                PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents WHERE userid={0} AND CHARINDEX({1}, title) > 0 ORDER BY id",
                    new string[] { "@userid", "@key" },
                    new object[] { AuthUser.ID, txtSearchKey.Text.Trim() }
                );
            }
            else
            {
                PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents WHERE userid={0} ORDER BY id",
                    new string[] { "@userid" },
                    new object[] { AuthUser.ID }
                );
            }

            DataSet dsTemp = DBConn.RunSelectQuery("SELECT use_product FROM users WHERE id = @id", new string[] { "@id" }, new object[] { AuthUser.ID });
            if (!DataSetUtil.IsNullOrEmpty(dsTemp)) {
                sns = string.IsNullOrEmpty(DataSetUtil.RowStringValue(DBConn.RunSelectQuery("SELECT sns FROM products WHERE id = @id", new string[] { "@id" }, new object[] { DataSetUtil.RowStringValue(dsTemp, "use_product", 0) }), "sns", 0)) ? "0" : DataSetUtil.RowStringValue(DBConn.RunSelectQuery("SELECT sns FROM products WHERE id = @id", new string[] { "@id" }, new object[] { DataSetUtil.RowStringValue(dsTemp, "use_product", 0) }), "sns", 0);
            }

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            PageDataSource = null;
            BindData();
        }

        protected void btnRegCampain_Click(object sender, EventArgs e)
        {
            string title = txtTitle.Text.Trim();
            if (title.Length == 0)
            {
                ShowMessageBox("컴페인명을 입력하세요.");
                return;
            }
            long content_id = DataSetUtil.GetID(DBConn.RunStoreProcedure(Constants.SP_ADDCONTENT,
            new string[] {
                                "@userid",
                                "@project_id",
                                "@title"
                            },
            new object[] {
                                AuthUser.ID,
                                0,
                                title
                            }));
            DBConn.RunStoreProcedure(Constants.SP_ADDEVENTLOG,
                new string[] {
                        "@event",
                        "@userid",
                        "@user_ip"
                    },
                new object[] {
                        Constants.EVENT_ADDCAMPAIGN,
                        AuthUser.ID,
                        Request.ServerVariables["REMOTE_ADDR"]
                    });
            Response.Redirect("CampainList.aspx");
        }
        
        protected void btnDelCampain_Click1(object sender, EventArgs e)
        {
            long content_id = Int32.Parse(hdCampainID.Value);
            if (content_id < 0)
            {
                ShowMessageBox("비정상적인 접근입니다.", "CampainList.aspx");
                return;
            }

            DataSet dsContent = DBConn.RunSelectQuery("SELECT contents.marker_url, contents.regdate, GETDATE() AS curdate FROM contents WHERE id={0}",
                new string[] { "@id" }, new object[] { content_id });

            if (DataSetUtil.IsNullOrEmpty(dsContent))
            {
                ShowMessageBox("비정상적인 접근입니다.", "ProjectList.aspx");
                return;
            }

            if (!string.IsNullOrEmpty(DataSetUtil.RowStringValue(dsContent, "marker_url", 0))) {
                TimeSpan timeDiff = DateTime.Parse(DataSetUtil.RowStringValue(dsContent, "curdate", 0)) - DateTime.Parse(DataSetUtil.RowStringValue(dsContent, "regdate", 0));
                if (timeDiff.TotalMinutes < 10)
                {
                    ShowMessageBox("마커등록중이므로 마커를 삭제할수 없습니다. 잠시후 다시 시도해 주십시오.", "CampainList.aspx");
                    return;
                }
            }

            DBConn.RunStoreProcedure(Constants.SP_DELETECONTENT,
                new string[] {
                "@id"                
            },
                new object[] {
                content_id
            });
            DBConn.RunStoreProcedure(Constants.SP_ADDEVENTLOG,
                    new string[] {
                        "@event",
                        "@userid",
                        "@user_ip"
                    },
                    new object[] {
                        Constants.EVENT_DELCAMPAIGN,
                        AuthUser.ID,
                        Request.ServerVariables["REMOTE_ADDR"]
                    });

            if (!string.IsNullOrEmpty(DataSetUtil.RowStringValue(dsContent, "marker_url", 0))) {
                RunVUpload("COAR remove " + "COAR_" + content_id);
            }
            
            Response.Redirect("CampainList.aspx");
        }
    }
}