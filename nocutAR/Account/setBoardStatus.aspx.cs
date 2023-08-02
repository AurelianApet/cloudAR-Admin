using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using DataAccess;

namespace nocutAR.Account
{
    public partial class setBoardStatus : Common.AjaxPageBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            Response.Clear();
            Response.ContentType = "text/html";
            Response.ContentEncoding = System.Text.Encoding.UTF8;

            int is_board = Int32.Parse(Request.Params["is_board"]);
            long content_id = Int32.Parse(Request.Params["id"]);

            DBConn.RunUpdateQuery("UPDATE contents SET is_board={0} WHERE id={1}",
                new string[] { "@is_board",
                               "@id"},
                new object[] { is_board,
                               content_id });
            Response.Write("게시판 on/off 상태가 정확히 등록되었습니다.");
            Response.End();
        }
    }
}