using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using DataAccess;
using System.Text;
using System.Data;

namespace nocutAR.Account
{
    public partial class getXML : Common.PageBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            long IID = 0;
            string server_id;
            //if (string.IsNullOrEmpty(Request.Params["server_id"]) && string.IsNullOrEmpty(Request.Params["content_id"]))
            //{
            //    return;
            //}
            //if (string.IsNullOrEmpty(Request.Params["server_id"]))
            //    IID = Int32.Parse(Request.Params["content_id"]);
            if (string.IsNullOrEmpty(Request.Params["content_id"]))
                return;
            server_id = Request.Params["content_id"];

            DataSet dsContent = null;
            DataSet dsUsedStatus = null;
            DataSet dsUsedProduct = null;
            //켐페인자료 디비로부터 조회하여 xml을 만들어 내려보낸다.
            dsContent = DBConn.RunSelectQuery("SELECT contents.xml, contents.userid, GETDATE() as cur_date FROM contents WHERE server_id={0}",
                new string[] { "@server_id" },
                new object[] { server_id });
            if (!DataSetUtil.IsNullOrEmpty(dsContent))
            try
            {
                IID = DataSetUtil.RowLongValue(dsContent, "userid", 0);
                string sdate = DateTime.Parse(DataSetUtil.RowStringValue(dsContent, "cur_date", 0)).ToString("yyyy-MM-01");
                StringBuilder responseXml = new StringBuilder();
                //dsUsedStatus = DBConn.RunSelectQuery("SELECT SUM(api_requests) AS api_requests, SUM(size) AS usedhard, COUNT(*) AS markers FROM contents WHERE userid = {0}",
                //new string[] { "@userid" },
                //new object[] { IID });
                dsUsedStatus = DBConn.RunSelectQuery("SELECT COUNT(*) as api_requests FROM contentsusehist WHERE userid = {0} AND CONVERT(NVARCHAR(10), regdate, 23) >= {1}",
                new string[] { "@userid","@sdate" },
                new object[] { IID, sdate });
                
                dsUsedProduct = DBConn.RunSelectQuery("SELECT products.* FROM products INNER JOIN users ON users.use_product = products.id WHERE users.id = {0}",
                    new string[] { "@id" },
                    new object[] { IID });
                if (DataSetUtil.RowIntValue(dsUsedProduct, "api_requests", 0) <= DataSetUtil.RowIntValue(dsUsedStatus, "api_requests", 0))
                {
                    //마커갯수가 초과되었다는 xml출력
                    responseXml.Append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
                    responseXml.Append("<contents>");
                    responseXml.Append("<apis_over>1</apis_over>");
                    responseXml.Append("</contents>");

                }
                else
                {
                    responseXml.Append(DataSetUtil.RowStringValue(dsContent, "xml", 0));
                }
                Response.Write(responseXml.ToString());
            }
            catch (Exception)
            {
                StringBuilder responseXml = new StringBuilder();
                responseXml.Append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
                responseXml.Append("<contents >");
                responseXml.Append("</contents>");

                Response.Write(responseXml.ToString());
            }

            //api_requests API요청수 증가시키는 부분
            if (!string.IsNullOrEmpty(Request.Params["isscan"]) && Request.Params["isscan"] == "1")
            {
                DBConn.RunUpdateQuery("UPDATE contents SET api_requests=api_requests+1 WHERE server_id={0}",
                new string[] { "@server_id" },
                new object[] { server_id });

                //컨텐츠 사용내역에 추가한다.
                DBConn.RunInsertQuery("INSERT INTO contentsusehist (userid, contentid) SELECT userid, id FROM contents WHERE (server_id = {0})",
                    new string[] { "@server_id" },
                    new object[] { server_id });
            }
            
        }
        protected override void Page_Init(object sender, EventArgs e)
        {

        }
    }
}