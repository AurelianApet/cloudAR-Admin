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
    public partial class ProjectList : Common.PageBase
    {
        protected string _popupHTML = "<div id=\"popDiv_{7}\" class=\"clspopup\" style=\"left: {0}px; top: {1}px; width: {3}px; height: {4}px;\">" +
                                  "     <table width=\"{3}px\" height=\"{4}px\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">" +
                                  "     <tr height=\"30px\">" +
                                  "         <td width=\"16px\">새로운 캠페인</td>" +
                                  "         <td align=\"right\" background=\"/img/pop/pop_gb_02.png\" valign=\"top\" style=\"padding-top: 20px\">" +
                                  "             <a href=\"javascript:;\" onclick=\"closePopup('popDiv_{7}');\"><img src=\"/img/pop/close.png\" alt=\"닫기\" border=\"0\" /></a>" +
                                  "         </td>" +
                                  "     </tr>" +
                                  "     <tr height=\"30px\">" +
                                  "         <td>켐페인제목</td>" +
                                  "         <td><input type=\"text\" maxlength=\"50\"/></td>" +
                                  "     </tr>" +
                                  "     <tr height=\"30px\">" +
                                  "         <td>켐페인제목을 입력해주세요.</td>" +
                                  "     </tr>" +
                                  "     <tr height=\"30px\">" +
                                  "         <td><input type=\"submit\" /></td>" +
                                  "     </tr>" +
                                  "     </table>" +
                                  "</div>";

        protected string m_strKeyword = null;

        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);

        }

        protected override void BindData()
        {
            base.BindData();
        }
        protected override void LoadData()
        {
            base.LoadData();

            DataSet dsProjects = null;

            m_strKeyword = "";
            if ("검색어 입력".Equals(m_strKeyword))
                m_strKeyword = "";
            if (m_strKeyword == "")
            {
                dsProjects = DBConn.RunStoreProcedure(Constants.SP_GETPROJECTSLIST,
                     new string[] {
                        "@userid"
                    },
                     new object[] {
                        AuthUser.ID
                    });
            }
            else
            {
                dsProjects = DBConn.RunStoreProcedure(Constants.SP_SEARCHEDPROJECT,
                new string[] {
                    "@userid",
                    "@keyword"
                },
                new object[] {
                    AuthUser.ID,
                    m_strKeyword
                });
            }

            rptProjects.DataSource = dsProjects;
            rptProjects.DataBind();
        }
        protected void onEditContent(object sender, EventArgs e)
        {
            long content_id=Int32.Parse(((ImageButton)sender).CommandArgument);
            Response.Redirect("EditContent.aspx?id=" + content_id);
        }
        protected void onDeleteContent(object sender, EventArgs e)
        {
            long content_id = Int32.Parse(((ImageButton)sender).CommandArgument);
            if (content_id < 0)
            {
                ShowMessageBox("비정상적인 접근입니다.", "ProjectList.aspx");
                return;
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
            RunVUpload("Test1 remove " + "Test1_" + content_id);
            Response.Redirect("ProjectList.aspx");
        }
        protected void onSaveContent(object sender, EventArgs e)
        {

        }
        protected void onEditProject(object sender, EventArgs e)
        {

        }
        protected void onDeleteProject(object sender, EventArgs e)
        {
            long project_id = Int32.Parse(((ImageButton)sender).CommandArgument);
            if (project_id<0)
            {
                ShowMessageBox("비정상적인 접근입니다.", "ProjectList.aspx");
                return;
            }
            DataSet dsDelID = DBConn.RunSelectQuery("SELECT id FROM contents WHERE project_id={0}",
                new string[] {
                "@id"
            },
                new object[] {
                project_id
            });
            if (!DataSetUtil.IsNullOrEmpty(dsDelID))
            {
                for (int i = 0; i < DataSetUtil.RowCount(dsDelID); i++)
                {
                    RunVUpload("Test1 remove " + "Test1_" + DataSetUtil.RowLongValue(dsDelID, 0, i));
                }
            }
            DBConn.RunStoreProcedure(Constants.SP_DELETEPROJECT,
                new string[] {
                "@id"

            },
                new object[] {
                project_id
            });
            DBConn.RunStoreProcedure(Constants.SP_ADDEVENTLOG,
                    new string[] {
                        "@event",
                        "@userid",
                        "@user_ip"
                    },
                    new object[] {
                        Constants.EVENT_DELPROJECT,
                        AuthUser.ID,
                        Request.ServerVariables["REMOTE_ADDR"]
                    });
            Response.Redirect("ProjectList.aspx");
        }

        protected void rptProjects_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            DataRowView dv=e.Item.DataItem as DataRowView;
            if(dv!=null)
            {
                Repeater rptContents=e.Item.FindControl("rptContents") as Repeater;
                if(rptContents != null)
                {
                    DataSet dsContents = null;
                    if (m_strKeyword != "")
                    {
                        dsContents = DBConn.RunStoreProcedure(Constants.SP_GETCONTENTSLIST,
                            new string[] {
                            "@project_id",
                            "@keyword"
                        },
                            new object[] {
                            dv.Row.ItemArray[0],
                            m_strKeyword
                        });
                    }
                    else
                    {
                        dsContents = DBConn.RunStoreProcedure(Constants.SP_GETCONTENTSLIST,
                            new string[] {
                            "@project_id"
                        },
                            new object[] {
                            dv.Row.ItemArray[0]
                        });
                    }

                    for (int i = 0; i < DataSetUtil.RowCount(dsContents); i++)
                    {
                        if (DataSetUtil.RowStringValue(dsContents, "marker_url", i) == "")
                            dsContents.Tables[0].Rows[i]["marker_url"] = "no_image.png";
                    }
                    rptContents.DataSource = dsContents;
                    rptContents.DataBind();

                }
            }
        }

        protected void btn_newContent_Click(object sender, EventArgs e)
        {
            int isNew = int.Parse(Request.Form["isNew"].ToString());
            if (isNew == 0)
            {
                long content_id = Int32.Parse(Request.Form["content_id"].ToString());
                DBConn.RunStoreProcedure(Constants.SP_MODIFYCONTENTNAME,
                    new string[] {
                        "@content_id",
                        "@title"
                    },
                    new object[] {
                        content_id,
                        txtContentName.Text
                    });
                Response.Redirect("ProjectList.aspx");
            }
            else
            {
                if (!string.IsNullOrEmpty(Request.Form["project_id"]))
                {
                    long pproject_id = Int32.Parse(Request.Form["project_id"].ToString());
                    long content_id2 = DataSetUtil.GetID(DBConn.RunStoreProcedure(Constants.SP_ADDCONTENT,
                    new string[] {
                                "@userid",
                                "@project_id",
                                "@title"
                            },
                    new object[] {
                                AuthUser.ID,
                                pproject_id,
                                txtContentName.Text
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
                    Response.Redirect("ProjectList.aspx");
                }
            }
        }

        protected void rptProjects_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            string a = e.CommandArgument.ToString();
        }

        protected void btn_newProject_Click(object sender, EventArgs e)
        {
            int isNewProject = int.Parse(Request.Form["isNewProject"].ToString());
            if (isNewProject == 0)
            {
                long project_id = Int32.Parse(Request.Form["modify_projectid"].ToString());
                DBConn.RunStoreProcedure(Constants.SP_MODIFYPROJECTNAME,
                    new string[] {
                        "@project_id",
                        "@title"
                    },
                    new object[] {
                        project_id,
                        txtProjectName.Text
                    });
                Response.Redirect("ProjectList.aspx");
            }
            else
            {
                long content_id = DataSetUtil.GetID(DBConn.RunStoreProcedure(Constants.SP_ADDPROJECT,
                    new string[] {
                                "@userid",
                                "@title"
                            },
                    new object[] {
                                AuthUser.ID,
                                txtProjectName.Text
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
                Response.Redirect("ProjectList.aspx");
            }
        }

    }
}