using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using DataAccess;

namespace nocutAR.Account
{
    public partial class getUseProduct : Common.AjaxPageBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            Response.Clear();
            Response.ContentType = "text/html";
            Response.ContentEncoding = System.Text.Encoding.UTF8;
            DataSet dsContent = null;

            string strData = null;

            dsContent = DBConn.RunSelectQuery("SELECT products.* FROM products INNER JOIN users ON users.use_product = products.id WHERE users.id = {0}",
                new string[] { "@id" },
                new object[] { AuthUser.ID});

            if (!DataSetUtil.IsNullOrEmpty(dsContent))
            {

                string strItemFormat = "{{\"video_obj\":\"{0}\", " +
                                   "\"web_obj\":\"{1}\", " +
                                   "\"slide_obj\":\"{2}\", " +
                                   "\"image_obj\":\"{3}\", " +
                                   "\"capture_obj\":\"{4}\", " +
                                   "\"three_model_obj\":\"{5}\", " +
                                   "\"tel_obj\":\"{6}\", " +
                                   "\"googlemap_obj\":\"{7}\", " +
                                   "\"notepad_obj\":\"{8}\", " +
                                   "\"bgm_obj\":\"{9}\", " +
                                   "\"chromakey_obj\":\"{10}\", " +
                                   "\"three_template\":\"{11}\", " +
                                   "\"linkvideo_obj\":\"{12}\", " +
                                   "\"pdf_obj\":\"{13}\", " +
                                   "\"sns\":\"{14}\" " +
                                   "}}";

                strData = string.Format(strItemFormat,
                    DataSetUtil.RowIntValue(dsContent, "video_obj", 0),
                    DataSetUtil.RowIntValue(dsContent, "web_obj", 0),
                    DataSetUtil.RowIntValue(dsContent, "slide_obj", 0),
                    DataSetUtil.RowIntValue(dsContent, "image_obj", 0),
                    DataSetUtil.RowIntValue(dsContent, "capture_obj", 0),
                    DataSetUtil.RowIntValue(dsContent, "three_model_obj", 0),
                    DataSetUtil.RowIntValue(dsContent, "tel_obj", 0),
                    DataSetUtil.RowIntValue(dsContent, "googlemap_obj", 0),
                    DataSetUtil.RowIntValue(dsContent, "notepad_obj", 0),
                    DataSetUtil.RowIntValue(dsContent, "bgm_obj", 0),
                    DataSetUtil.RowIntValue(dsContent, "chromakey_obj", 0),
                    DataSetUtil.RowIntValue(dsContent, "three_template", 0),
                    DataSetUtil.RowIntValue(dsContent, "linkvideo_obj", 0),
                    DataSetUtil.RowIntValue(dsContent, "pdf_obj", 0),
                    DataSetUtil.RowIntValue(dsContent, "sns", 0));
            }
            Response.Write(strData);
            Response.End();
        }
    }
}