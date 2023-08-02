using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using DataAccess;
using nocutAR.Common;

namespace nocutAR.Manager
{
    public partial class DetailProduct : Common.PageBase
    {
        int IID = 0;
        DataSet dsProductDetail = null;
        DataSet dsProductList = null;
        protected override void Page_Load(object sender, EventArgs e)
        {
            IID = Int32.Parse(Request.Params["id"]);
            base.Page_Load(sender, e);
            if (!IsPostBack)
            {
                dsProductList = DBConn.RunSelectQuery("SELECT * FROM products");
                ddlOrgProductList.Items.Clear();
                for (int i = 0; i < DataSetUtil.RowCount(dsProductList); i++)
                {
                    ddlOrgProductList.Items.Add(new ListItem(DataSetUtil.RowStringValue(dsProductList, "product_name", i), i.ToString()));
                }

                dsProductDetail = DBConn.RunSelectQuery("SELECT * FROM products WHERE id={0}",
                    new string[] {
                    "@d"

                },
                    new object[] {
                    IID
                });
                if (!DataSetUtil.IsNullOrEmpty(dsProductDetail))
                {
                    txtProductNameA.Text = DataSetUtil.RowStringValue(dsProductDetail, "product_name", 0);
                    //ddlOrgProductList.SelectedIndex = DataSetUtil.RowStringValue(dsProductDetail, "product_name", 0);
                    ddlMarkers.SelectedValue = DataSetUtil.RowStringValue(dsProductDetail, "markers", 0);
                    ddlLimitHard.SelectedValue = DataSetUtil.RowStringValue(dsProductDetail, "hardused", 0);
                    ddlTraffic.SelectedValue = DataSetUtil.RowStringValue(dsProductDetail, "traffic", 0);
                    ddlAPI.SelectedValue = DataSetUtil.RowStringValue(dsProductDetail, "api_requests", 0);
                    txtProductTag.Text = DataSetUtil.RowStringValue(dsProductDetail, "product_tag", 0);
                    chkObjects.Items[0].Selected = DataSetUtil.RowIntValue(dsProductDetail, "video_obj", 0) == 1 ? true : false;
                    chkObjects.Items[1].Selected = DataSetUtil.RowIntValue(dsProductDetail, "web_obj", 0) == 1 ? true : false;
                    chkObjects.Items[2].Selected = DataSetUtil.RowIntValue(dsProductDetail, "image_obj", 0) == 1 ? true : false;
                    chkObjects.Items[3].Selected = DataSetUtil.RowIntValue(dsProductDetail, "capture_obj", 0) == 1 ? true : false;
                    chkObjects2.Items[0].Selected = DataSetUtil.RowIntValue(dsProductDetail, "three_model_obj", 0) == 1 ? true : false;
                    chkObjects2.Items[1].Selected = DataSetUtil.RowIntValue(dsProductDetail, "tel_obj", 0) == 1 ? true : false;
                    chkObjects2.Items[2].Selected = DataSetUtil.RowIntValue(dsProductDetail, "googlemap_obj", 0) == 1 ? true : false;
                    chkObjects2.Items[3].Selected = DataSetUtil.RowIntValue(dsProductDetail, "notepad_obj", 0) == 1 ? true : false;
                    chkObjects2.Items[4].Selected = DataSetUtil.RowIntValue(dsProductDetail, "bgm_obj", 0) == 1 ? true : false;
                    chkObjects2.Items[5].Selected = DataSetUtil.RowIntValue(dsProductDetail, "chromakey_obj", 0) == 1 ? true : false;
                    rdThreeTemplate.SelectedValue = DataSetUtil.RowIntValue(dsProductDetail, "three_template", 0).ToString();

                }
            }
        }
        protected void btnModProductOK_Click(object sender, EventArgs e)
        {
            // 상품명중복검사
            if (!DataSetUtil.IsNullOrEmpty(DBConn.RunSelectQuery("SELECT product_name FROM products WHERE product_name={0} AND id!={1}",
                new string[] {
                "@product_name",
                "@id"
            },
                new object[] {
                txtProductNameA.Text,
                IID
            })))
            {
                ShowMessageBox("상품명이 중복되었습니다.");
                return;
            }
            DBConn.RunStoreProcedure(Constants.SP_MODIFYPRODUCT,
            new string[] {
                "@id",
                "@product_name",
                "@markers",
                "@hardused",
                "@traffic",
                "@api_requests",
                "@product_tag",
                "@video_obj",
                "@web_obj",
                "@image_obj",
                "@cap_obj",
                "@three_obj",
                "@tel_obj",
                "@google_obj",
                "@notepad_obj",
                "@sound_obj",
                "@chromakey_obj",
                "@three_template"
            },
            new object[] {
                IID,
                txtProductNameA.Text,
                ddlMarkers.SelectedValue,
                ddlLimitHard.SelectedValue,
                ddlTraffic.SelectedValue,
                ddlAPI.SelectedValue,
                txtProductTag.Text,
                chkObjects.Items[0].Selected,
                chkObjects.Items[1].Selected,
                chkObjects.Items[2].Selected,
                chkObjects.Items[3].Selected,
                chkObjects2.Items[0].Selected,
                chkObjects2.Items[1].Selected,
                chkObjects2.Items[2].Selected,
                chkObjects2.Items[3].Selected,
                chkObjects2.Items[4].Selected,
                chkObjects2.Items[5].Selected,
                rdThreeTemplate.SelectedValue
            });
            DBConn.RunStoreProcedure(Constants.SP_ADDEVENTLOG,
                    new string[] {
                        "@event",
                        "@userid",
                        "@user_ip"
                    },
                    new object[] {
                        Constants.EVENT_MODPRODUCT,
                        AuthUser.ID,
                        Request.ServerVariables["REMOTE_ADDR"]
                    });

            this.ClientScript.RegisterClientScriptBlock(this.GetType(), "Close", "window.opener.location.href = window.opener.location.href;self.close()", true);
        }
        protected void ddlOrgProductList_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataSet dsProduct = DBConn.RunSelectQuery("SELECT * FROM products");
            if (!DataSetUtil.IsNullOrEmpty(dsProduct))
            {
                ddlMarkers.SelectedValue = DataSetUtil.RowStringValue(dsProduct, "markers", ddlOrgProductList.SelectedIndex);
                ddlLimitHard.SelectedValue = DataSetUtil.RowStringValue(dsProduct, "hardused", ddlOrgProductList.SelectedIndex);
                ddlAPI.SelectedValue = DataSetUtil.RowStringValue(dsProduct, "api_requests", ddlOrgProductList.SelectedIndex);
                chkObjects.Items[0].Selected = DataSetUtil.RowIntValue(dsProduct, "video_obj", ddlOrgProductList.SelectedIndex) == 1 ? true : false;
                chkObjects.Items[1].Selected = DataSetUtil.RowIntValue(dsProduct, "web_obj", ddlOrgProductList.SelectedIndex) == 1 ? true : false;
                chkObjects.Items[2].Selected = DataSetUtil.RowIntValue(dsProduct, "image_obj", ddlOrgProductList.SelectedIndex) == 1 ? true : false;
                chkObjects.Items[3].Selected = DataSetUtil.RowIntValue(dsProduct, "capture_obj", ddlOrgProductList.SelectedIndex) == 1 ? true : false;
                chkObjects2.Items[0].Selected = DataSetUtil.RowIntValue(dsProduct, "three_model_obj", ddlOrgProductList.SelectedIndex) == 1 ? true : false;
                chkObjects2.Items[1].Selected = DataSetUtil.RowIntValue(dsProduct, "tel_obj", ddlOrgProductList.SelectedIndex) == 1 ? true : false;
                chkObjects2.Items[2].Selected = DataSetUtil.RowIntValue(dsProduct, "googlemap_obj", ddlOrgProductList.SelectedIndex) == 1 ? true : false;
                chkObjects2.Items[3].Selected = DataSetUtil.RowIntValue(dsProduct, "notepad_obj", ddlOrgProductList.SelectedIndex) == 1 ? true : false;
                chkObjects2.Items[4].Selected = DataSetUtil.RowIntValue(dsProduct, "bgm_obj", ddlOrgProductList.SelectedIndex) == 1 ? true : false;
                chkObjects2.Items[5].Selected = DataSetUtil.RowIntValue(dsProduct, "chromakey_obj", ddlOrgProductList.SelectedIndex) == 1 ? true : false;
                rdThreeTemplate.SelectedValue = DataSetUtil.RowIntValue(dsProduct, "three_template", ddlOrgProductList.SelectedIndex).ToString();
            }
        }
    }
}