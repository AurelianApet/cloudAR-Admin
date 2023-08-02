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
    public partial class ProductMng : Common.PageBase
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
            DataSet dsProductNames = null;

            dsContents = DBConn.RunStoreProcedure(Constants.SP_GETPRODUCTLIST);

            PageDataSource = dsContents;
            BindData();
            if (!IsPostBack)
            {
                dsProductNames = DBConn.RunSelectQuery("SELECT * FROM products");
                ddlOrgProductList.Items.Clear();
                for (int i = 0; i < DataSetUtil.RowCount(dsProductNames); i++)
                {
                    ddlOrgProductList.Items.Add(new ListItem(DataSetUtil.RowStringValue(dsProductNames, "product_name", i)
                        , DataSetUtil.RowStringValue(dsProductNames, "id", i)
                                + ":" + DataSetUtil.RowStringValue(dsProductNames, "markers", i)
                                + ":" + DataSetUtil.RowStringValue(dsProductNames, "hardused", i)
                                + ":" + DataSetUtil.RowStringValue(dsProductNames, "api_requests", i)
                                + ":" + DataSetUtil.RowStringValue(dsProductNames, "traffic", i)
                                + ":" + DataSetUtil.RowStringValue(dsProductNames, "video_obj", i)
                                + ":" + DataSetUtil.RowStringValue(dsProductNames, "web_obj", i)
                                + ":" + DataSetUtil.RowStringValue(dsProductNames, "slide_obj", i)
                                + ":" + DataSetUtil.RowStringValue(dsProductNames, "image_obj", i)
                                + ":" + DataSetUtil.RowStringValue(dsProductNames, "capture_obj", i)
                                + ":" + DataSetUtil.RowStringValue(dsProductNames, "three_model_obj", i)
                                + ":" + DataSetUtil.RowStringValue(dsProductNames, "tel_obj", i)
                                + ":" + DataSetUtil.RowStringValue(dsProductNames, "googlemap_obj", i)
                                + ":" + DataSetUtil.RowStringValue(dsProductNames, "notepad_obj", i)
                                + ":" + DataSetUtil.RowStringValue(dsProductNames, "bgm_obj", i)
                                + ":" + DataSetUtil.RowStringValue(dsProductNames, "chromakey_obj", i)
                                + ":" + DataSetUtil.RowStringValue(dsProductNames, "three_template", i)
                                + ":" + DataSetUtil.RowStringValue(dsProductNames, "linkvideo_obj", i)
                                + ":" + DataSetUtil.RowStringValue(dsProductNames, "pdf_obj", i)
                                + ":" + DataSetUtil.RowStringValue(dsProductNames, "sns", i)));
                }

                int[] arrMarkers = new int[] { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250, 260, 270, 280, 290, 300 };
                int[] arrScans = new int[] { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 50, 100, 200, 300, 500, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000, 15000, 20000 };

                ddlMarkers.Items.Clear();
                ddlAPI.Items.Clear();
                for (int i = 0; i < arrMarkers.Length; i++)
                {
                    ddlMarkers.Items.Add(new ListItem(arrMarkers[i].ToString() + "개", arrMarkers[i].ToString()));
                }
                for (int i = 0; i < arrScans.Length; i++)
                {
                    ddlAPI.Items.Add(new ListItem(arrScans[i].ToString() + "회", arrScans[i].ToString()));
                }
            }
        }

        protected void btnAddProductOK_Click(object sender, EventArgs e)
        {
            long lProductID = 0;
            if (!string.IsNullOrEmpty(Request.Params["hdProductID"]))
                lProductID = long.Parse(Request.Params["hdProductID"]);
            if (lProductID == 0)
            {
                // 상품명중복검사
                if (!DataSetUtil.IsNullOrEmpty(DBConn.RunSelectQuery("SELECT product_name FROM products WHERE product_name={0}",
                    new string[] {
                    "@product_name"
                },
                    new object[] {
                    txtProductName.Text
                })))
                {
                    ValidationSummary1.ShowMessageBox = true;
                    ShowMessageBox("상품명이 중복되었습니다.", "ProductMng.aspx");
                    return;
                }

                lProductID = DataSetUtil.GetID(DBConn.RunStoreProcedure(Constants.SP_CREATEPRODUCT,
                new string[] {
                    "@product_name",
                    "@markers",
                    "@hardused",
                    "@traffic",
                    "@api_requests",
                    "@product_tag",
                    "@video_obj",
                    "@web_obj",
                    "@slide_obj",
                    "@image_obj",
                    "@cap_obj",
                    "@three_obj",
                    "@tel_obj",
                    "@google_obj",
                    "@notepad_obj",
                    "@sound_obj",
                    "@chromakey_obj",
                    "@three_template",
                    "@linkvideo_obj",
                    "@pdf_obj",
                    "@sns"
                },
                new object[] {
                    txtProductName.Text,
                    ddlMarkers.SelectedValue,
                    ddlLimitHard.SelectedValue,
                    ddlTraffic.SelectedValue,
                    ddlAPI.SelectedValue,
                    txtProductTag.Text,
                    cbxVideo.Checked?1:0,
                    cbxWebSite.Checked?1:0,
                    cbxImageSlide.Checked?1:0,
                    cbxImage.Checked?1:0,
                    cbxChromakeyPhoto.Checked?1:0,
                    cbx3DObj.Checked?1:0,
                    cbxTel.Checked?1:0,
                    cbxGoogleMap.Checked?1:0,
                    cbxText.Checked?1:0,
                    cbxBGM.Checked?1:0,
                    cbxChromakeyVideo.Checked?1:0,
                    rdo3DTemp1.Checked?1:0,
                    cbxLinkVideo.Checked?1:0,
                    cbxPDFObj.Checked?1:0,
                    rdoSNS1.Checked?1:0
                }));
                DBConn.RunStoreProcedure(Constants.SP_ADDEVENTLOG,
                        new string[] {
                        "@event",
                        "@userid",
                        "@user_ip"
                    },
                        new object[] {
                        Constants.EVENT_ADDPRODUCT,
                        AuthUser.ID,
                        Request.ServerVariables["REMOTE_ADDR"]
                    });
                Page.Response.Redirect(Page.Request.Url.ToString(), true);
            }
            else
            {
                // 상품명중복검사
                if (!DataSetUtil.IsNullOrEmpty(DBConn.RunSelectQuery("SELECT product_name FROM products WHERE product_name={0} AND id<>{1}",
                    new string[] {
                    "@product_name", "@id"
                },
                    new object[] {
                    txtProductName.Text, lProductID
                })))
                {
                    ValidationSummary1.ShowMessageBox = true;
                    ShowMessageBox("상품명이 중복되었습니다.", "ProductMng.aspx");
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
                    "@slide_obj",
                    "@image_obj",
                    "@cap_obj",
                    "@three_obj",
                    "@tel_obj",
                    "@google_obj",
                    "@notepad_obj",
                    "@sound_obj",
                    "@chromakey_obj",
                    "@three_template",
                    "@linkvideo_obj",
                    "@pdf_obj",
                    "@sns"
                },
                new object[] {
                    lProductID,
                    txtProductName.Text,
                    ddlMarkers.SelectedValue,
                    ddlLimitHard.SelectedValue,
                    ddlTraffic.SelectedValue,
                    ddlAPI.SelectedValue,
                    txtProductTag.Text,
                    cbxVideo.Checked?1:0,
                    cbxWebSite.Checked?1:0,
                    cbxImageSlide.Checked?1:0,
                    cbxImage.Checked?1:0,
                    cbxChromakeyPhoto.Checked?1:0,
                    cbx3DObj.Checked?1:0,
                    cbxTel.Checked?1:0,
                    cbxGoogleMap.Checked?1:0,
                    cbxText.Checked?1:0,
                    cbxBGM.Checked?1:0,
                    cbxChromakeyVideo.Checked?1:0,
                    rdo3DTemp1.Checked?1:0,
                    cbxLinkVideo.Checked?1:0,
                    cbxPDFObj.Checked?1:0,
                    rdoSNS1.Checked?1:0
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
                Page.Response.Redirect(Page.Request.Url.ToString(), true);
            }
        }

        protected void btnRemoveOk_Click(object sender, EventArgs e)
        {
            long lProductID = 0;
            if (!string.IsNullOrEmpty(Request.Params["hdRemoveID"]))
            {
                lProductID = long.Parse(Request.Params["hdRemoveID"]);
                DataSet dsCanRemove = DBConn.RunSelectQuery("SELECT *,products.product_name FROM users INNER JOIN products ON users.use_product=products.id WHERE products.id={0}",
                        new string[]{
                            "@id"
                        },
                        new object[]{
                            Convert.ToInt64(lProductID)
                    });

                if (!DataSetUtil.IsNullOrEmpty(dsCanRemove))
                {
                    ShowMessageBox("상품이 이용중이므로 삭제 할수 없습니다.");
                    return;
                }

                DBConn.RunDeleteQuery("DELETE FROM products WHERE id={0}",
                    new string[] {
                        "@id"

                    },
                    new object[] {
                        Convert.ToInt64(lProductID)

                    });
                DBConn.RunStoreProcedure(Constants.SP_ADDEVENTLOG,
                new string[] {
                        "@event",
                        "@userid",
                        "@user_ip"
                    },
                new object[] {
                        Constants.EVENT_DELPRODUCT,
                        AuthUser.ID,
                        Request.ServerVariables["REMOTE_ADDR"]
                    });
                Page.Response.Redirect(Page.Request.Url.ToString(), true);
            }
        }
    }
}