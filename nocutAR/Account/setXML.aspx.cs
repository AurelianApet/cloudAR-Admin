using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using DataAccess;
using System.Text;
using System.Net.Json;
using nocutAR.Common;

namespace nocutAR.Account
{
    public partial class setXML : Common.AjaxPageBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            string data=Request.Params[2];
            data = Server.UrlDecode(data);
            long content_id = Int32.Parse(Request.Params["id"]);
            string title = HttpUtility.UrlDecode(Request.Params["title"]);
            float content_size = 0;
            JsonTextParser parser = new JsonTextParser();
            JsonObjectCollection col = (JsonObjectCollection)parser.Parse(data);
            List<JsonObject> objects = (List<JsonObject>)col["data"].GetValue();

            StringBuilder responseXml = new StringBuilder();
            responseXml.Append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
            //responseXml.Append("<response >");

            responseXml.Append("<contents>");
            responseXml.Append("<apis_over>0</apis_over>");
            if (objects.Count > 0)
            {
                for (int i = 0; i < objects.Count; i++)
                {
                    JsonObjectCollection obj = (JsonObjectCollection)objects[i];
                    string objtype = obj["obj"].GetValue().ToString();

                    /*마커이미지이면*/
                    if ("marker".Equals(objtype))
                    {
                        responseXml.Append(string.Format("<marker id=\"{0}\">" +
                                "<url>{1}</url>" +
                                "<posX>{2}</posX>" +
                                "<posY>{3}</posY>" +
                                "<width>{4}</width>" +
                                "<height>{5}</height>" +
                                "<rate>{6}</rate>" +
                                "<depth>{7}</depth>" +
                            "</marker>",
                            i + 1,
                            obj["url"].GetValue().ToString().Replace(".png", ".jpg"),
                            obj["posX"].GetValue().ToString(),
                            obj["posY"].GetValue().ToString(),
                            obj["width"].GetValue().ToString(),
                            obj["height"].GetValue().ToString(),
                            obj["rate"].GetValue().ToString(),
                            obj["depth"].GetValue().ToString()));
                    }
                    /***마커이미지이면***/

                    /*오브젝트이미지이면*/
                    else if ("image".Equals(objtype))
                    {
                        content_size += float.Parse(obj["objsize"].GetValue().ToString());

                        if (obj["run_opt"].GetValue().ToString() == "0")
                        {
                            responseXml.Append(string.Format("<image id=\"{0}\">" +
                                                "<url>{1}</url>" +
                                                "<type>{2}</type>" +
                                                "<run_opt>{3}</run_opt>" +
                                                "<posX>{4}</posX>" +
                                                "<posY>{5}</posY>" +
                                                "<width>{6}</width>" +
                                                "<height>{7}</height>" +
                                                "<rate>{8}</rate>" +
                                                "<depth>{9}</depth>" +
                                                "<objsize>{10}</objsize>" +
                                            "</image>",
                                            i + 1,
                                            obj["url"].GetValue().ToString(),
                                            obj["type"].GetValue().ToString(),
                                            obj["run_opt"].GetValue().ToString(),
                                            obj["posX"].GetValue().ToString(),
                                            obj["posY"].GetValue().ToString(),
                                            obj["width"].GetValue().ToString(),
                                            obj["height"].GetValue().ToString(),
                                            0,
                                            obj["depth"].GetValue().ToString(),
                                            obj["objsize"].GetValue().ToString())
                                            );
                        }
                        else if (obj["run_opt"].GetValue().ToString() == "1")
                        {
                            responseXml.Append(string.Format("<image id=\"{0}\">" +
                                                "<url>{1}</url>" +
                                                "<type>{2}</type>" +
                                                "<run_opt>{3}</run_opt>" +
                                                "<posX>{4}</posX>" +
                                                "<posY>{5}</posY>" +
                                                "<width>{6}</width>" +
                                                "<height>{7}</height>" +
                                                "<rate>{8}</rate>" +
                                                "<depth>{9}</depth>" +
                                                "<objsize>{10}</objsize>" +
                                                "<btn_title>{11}</btn_title>" +
                                                "<btn_mode_index>{12}</btn_mode_index>" +
                                                "<btn_color>{13}</btn_color>" +
                                                "<btn_color_index>{14}</btn_color_index>" +
                                                "<btn_textcolor>{15}</btn_textcolor>" +
                                                "<btn_textcolor_index>{16}</btn_textcolor_index>" +
                                                "<btn_width>{17}</btn_width>" +
                                                "<btn_height>{18}</btn_height>" +
                                                "<btn_posX>{19}</btn_posX>" +
                                                "<btn_posY>{20}</btn_posY>" +
                                                "</image>",
                                            i + 1,
                                            obj["url"].GetValue().ToString(),
                                            obj["type"].GetValue().ToString(),
                                            obj["run_opt"].GetValue().ToString(),
                                            obj["posX"].GetValue().ToString(),
                                            obj["posY"].GetValue().ToString(),
                                            obj["width"].GetValue().ToString(),
                                            obj["height"].GetValue().ToString(),
                                            0,
                                            obj["depth"].GetValue().ToString(),
                                            obj["objsize"].GetValue().ToString(),
                                            obj["btn_title"].GetValue().ToString(),
                                            obj["btn_mode_index"].GetValue().ToString(),
                                            obj["btn_color"].GetValue().ToString(),
                                            obj["btn_color_index"].GetValue().ToString(),
                                            obj["btn_textcolor"].GetValue().ToString(),
                                            obj["btn_textcolor_index"].GetValue().ToString(),
                                            obj["btn_width"].GetValue().ToString(),
                                            obj["btn_height"].GetValue().ToString(),
                                            obj["btn_posX"].GetValue().ToString(),
                                            obj["btn_posY"].GetValue().ToString())
                                            );
                        }
                        else if (obj["run_opt"].GetValue().ToString() == "2")
                        {
                            responseXml.Append(string.Format("<image id=\"{0}\">" +
                                                "<url>{1}</url>" +
                                                "<type>{2}</type>" +
                                                "<run_opt>{3}</run_opt>" +
                                                "<posX>{4}</posX>" +
                                                "<posY>{5}</posY>" +
                                                "<width>{6}</width>" +
                                                "<height>{7}</height>" +
                                                "<rate>{8}</rate>" +
                                                "<depth>{9}</depth>" +
                                                "<objsize>{10}</objsize>" +
                                                "<imgbtn_url>{11}</imgbtn_url>" +
                                                "<imgbtn_width>{12}</imgbtn_width>" +
                                                "<imgbtn_height>{13}</imgbtn_height>" +
                                                "<imgbtn_posX>{14}</imgbtn_posX>" +
                                                "<imgbtn_posY>{15}</imgbtn_posY>" +
                                                "</image>",
                                            i + 1,
                                            obj["url"].GetValue().ToString(),
                                            obj["type"].GetValue().ToString(),
                                            obj["run_opt"].GetValue().ToString(),
                                            obj["posX"].GetValue().ToString(),
                                            obj["posY"].GetValue().ToString(),
                                            obj["width"].GetValue().ToString(),
                                            obj["height"].GetValue().ToString(),
                                            0,
                                            obj["depth"].GetValue().ToString(),
                                            obj["objsize"].GetValue().ToString(),
                                            obj["imgbtn_url"].GetValue().ToString(),
                                            obj["imgbtn_width"].GetValue().ToString(),
                                            obj["imgbtn_height"].GetValue().ToString(),
                                            obj["imgbtn_posX"].GetValue().ToString(),
                                            obj["imgbtn_posY"].GetValue().ToString())
                                            );
                        }

                        /*
                        DBConn.RunInsertQuery("INSERT INTO images (content_id, url, type, xpos, ypos, width, height, depth, size) VALUES (@content_id, @url, @type, @xpos, @ypos, @width, @height, @depth, @size)",
                            new string[] { "@content_id",
                                            "@url",
                                            "@type",
                                            "@xpos",
                                            "@ypos",
                                            "@width",
                                            "@height",
                                            "@depth",
                                            "@size"
                            },
                            new object[] { content_id,
                                            obj["url"].GetValue().ToString(),
                                            obj["type"].GetValue().ToString(),
                                            obj["posX"].GetValue().ToString(),
                                            obj["posY"].GetValue().ToString(),
                                            obj["width"].GetValue().ToString(),
                                            obj["height"].GetValue().ToString(),
                                            obj["depth"].GetValue().ToString(),
                                            obj["objsize"].GetValue().ToString()
                                            });
                        */
                    }
                    /***오브젝트이미지이면***/

                    /*슬라이드이미지이면*/
                    else if ("slide".Equals(objtype))
                    {
                        content_size += float.Parse(obj["objsize"].GetValue().ToString());

                        if (obj["run_opt"].GetValue().ToString() == "0")
                        {
                            responseXml.Append(string.Format("<slide id=\"{0}\">" +
                                                "<url1>{1}</url1>" +
                                                "<url2>{2}</url2>" +
                                                "<url3>{3}</url3>" +
                                                "<url4>{4}</url4>" +
                                                "<url5>{5}</url5>" +
                                                "<url6>{6}</url6>" +
                                                "<url7>{7}</url7>" +
                                                "<url8>{8}</url8>" +
                                                "<url9>{9}</url9>" +
                                                "<url10>{10}</url10>" +
                                                "<run_opt>{11}</run_opt>" +
                                                "<type>{12}</type>" +
                                                "<playtype>{13}</playtype>" +
                                                "<timediff>{14}</timediff>" +
                                                "<showtype>{15}</showtype>" +
                                                "<prev_count>{16}</prev_count>" +
                                                "<posX>{17}</posX>" +
                                                "<posY>{18}</posY>" +
                                                "<width>{19}</width>" +
                                                "<height>{20}</height>" +
                                                "<rate>{21}</rate>" +
                                                "<depth>{22}</depth>" +
                                                "<objsize>{23}</objsize>" +
                                            "</slide>",
                                            i + 1,
                                            obj["url1"].GetValue().ToString(),
                                            obj["url2"].GetValue().ToString(),
                                            obj["url3"].GetValue().ToString(),
                                            obj["url4"].GetValue().ToString(),
                                            obj["url5"].GetValue().ToString(),
                                            obj["url6"].GetValue().ToString(),
                                            obj["url7"].GetValue().ToString(),
                                            obj["url8"].GetValue().ToString(),
                                            obj["url9"].GetValue().ToString(),
                                            obj["url10"].GetValue().ToString(),
                                            obj["run_opt"].GetValue().ToString(),
                                            obj["type"].GetValue().ToString(),
                                            obj["playtype"].GetValue().ToString(),
                                            obj["timediff"].GetValue().ToString(),
                                            obj["showtype"].GetValue().ToString(),
                                            obj["prev_count"].GetValue().ToString(),
                                            obj["posX"].GetValue().ToString(),
                                            obj["posY"].GetValue().ToString(),
                                            obj["width"].GetValue().ToString(),
                                            obj["height"].GetValue().ToString(),
                                            0,
                                            obj["depth"].GetValue().ToString(),
                                            obj["objsize"].GetValue().ToString())
                                            );
                        }
                        else if (obj["run_opt"].GetValue().ToString() == "1")
                        {
                            responseXml.Append(string.Format("<slide id=\"{0}\">" +
                                                "<url1>{1}</url1>" +
                                                "<url2>{2}</url2>" +
                                                "<url3>{3}</url3>" +
                                                "<url4>{4}</url4>" +
                                                "<url5>{5}</url5>" +
                                                "<url6>{6}</url6>" +
                                                "<url7>{7}</url7>" +
                                                "<url8>{8}</url8>" +
                                                "<url9>{9}</url9>" +
                                                "<url10>{10}</url10>" +
                                                "<run_opt>{11}</run_opt>" +
                                                "<type>{12}</type>" +
                                                "<playtype>{13}</playtype>" +
                                                "<timediff>{14}</timediff>" +
                                                "<showtype>{15}</showtype>" +
                                                "<prev_count>{16}</prev_count>" +
                                                "<posX>{17}</posX>" +
                                                "<posY>{18}</posY>" +
                                                "<width>{19}</width>" +
                                                "<height>{20}</height>" +
                                                "<rate>{21}</rate>" +
                                                "<depth>{22}</depth>" +
                                                "<objsize>{23}</objsize>" +
                                                "<btn_title>{24}</btn_title>" +
                                                "<btn_mode_index>{25}</btn_mode_index>" +
                                                "<btn_color>{26}</btn_color>" +
                                                "<btn_color_index>{27}</btn_color_index>" +
                                                "<btn_textcolor>{28}</btn_textcolor>" +
                                                "<btn_textcolor_index>{29}</btn_textcolor_index>" +
                                                "<btn_width>{30}</btn_width>" +
                                                "<btn_height>{31}</btn_height>" +
                                                "<btn_posX>{32}</btn_posX>" +
                                                "<btn_posY>{33}</btn_posY>" +
                                                "</slide>",
                                            i + 1,
                                            obj["url1"].GetValue().ToString(),
                                            obj["url2"].GetValue().ToString(),
                                            obj["url3"].GetValue().ToString(),
                                            obj["url4"].GetValue().ToString(),
                                            obj["url5"].GetValue().ToString(),
                                            obj["url6"].GetValue().ToString(),
                                            obj["url7"].GetValue().ToString(),
                                            obj["url8"].GetValue().ToString(),
                                            obj["url9"].GetValue().ToString(),
                                            obj["url10"].GetValue().ToString(),
                                            obj["run_opt"].GetValue().ToString(),
                                            obj["type"].GetValue().ToString(),
                                            obj["playtype"].GetValue().ToString(),
                                            obj["timediff"].GetValue().ToString(),
                                            obj["showtype"].GetValue().ToString(),
                                            obj["prev_count"].GetValue().ToString(),
                                            obj["posX"].GetValue().ToString(),
                                            obj["posY"].GetValue().ToString(),
                                            obj["width"].GetValue().ToString(),
                                            obj["height"].GetValue().ToString(),
                                            0,
                                            obj["depth"].GetValue().ToString(),
                                            obj["objsize"].GetValue().ToString(),
                                            obj["btn_title"].GetValue().ToString(),
                                            obj["btn_mode_index"].GetValue().ToString(),
                                            obj["btn_color"].GetValue().ToString(),
                                            obj["btn_color_index"].GetValue().ToString(),
                                            obj["btn_textcolor"].GetValue().ToString(),
                                            obj["btn_textcolor_index"].GetValue().ToString(),
                                            obj["btn_width"].GetValue().ToString(),
                                            obj["btn_height"].GetValue().ToString(),
                                            obj["btn_posX"].GetValue().ToString(),
                                            obj["btn_posY"].GetValue().ToString())
                                            );
                        }
                        else if (obj["run_opt"].GetValue().ToString() == "2")
                        {
                            responseXml.Append(string.Format("<slide id=\"{0}\">" +
                                                "<url1>{1}</url1>" +
                                                "<url2>{2}</url2>" +
                                                "<url3>{3}</url3>" +
                                                "<url4>{4}</url4>" +
                                                "<url5>{5}</url5>" +
                                                "<url6>{6}</url6>" +
                                                "<url7>{7}</url7>" +
                                                "<url8>{8}</url8>" +
                                                "<url9>{9}</url9>" +
                                                "<url10>{10}</url10>" +
                                                "<run_opt>{11}</run_opt>" +
                                                "<type>{12}</type>" +
                                                "<playtype>{13}</playtype>" +
                                                "<timediff>{14}</timediff>" +
                                                "<showtype>{15}</showtype>" +
                                                "<prev_count>{16}</prev_count>" +
                                                "<posX>{17}</posX>" +
                                                "<posY>{18}</posY>" +
                                                "<width>{19}</width>" +
                                                "<height>{20}</height>" +
                                                "<rate>{21}</rate>" +
                                                "<depth>{22}</depth>" +
                                                "<objsize>{23}</objsize>" +
                                                "<imgbtn_url>{24}</imgbtn_url>" +
                                                "<imgbtn_width>{25}</imgbtn_width>" +
                                                "<imgbtn_height>{26}</imgbtn_height>" +
                                                "<imgbtn_posX>{27}</imgbtn_posX>" +
                                                "<imgbtn_posY>{28}</imgbtn_posY>" +
                                                "</slide>",
                                            i + 1,
                                            obj["url1"].GetValue().ToString(),
                                            obj["url2"].GetValue().ToString(),
                                            obj["url3"].GetValue().ToString(),
                                            obj["url4"].GetValue().ToString(),
                                            obj["url5"].GetValue().ToString(),
                                            obj["url6"].GetValue().ToString(),
                                            obj["url7"].GetValue().ToString(),
                                            obj["url8"].GetValue().ToString(),
                                            obj["url9"].GetValue().ToString(),
                                            obj["url10"].GetValue().ToString(),
                                            obj["run_opt"].GetValue().ToString(),
                                            obj["type"].GetValue().ToString(),
                                            obj["playtype"].GetValue().ToString(),
                                            obj["timediff"].GetValue().ToString(),
                                            obj["showtype"].GetValue().ToString(),
                                            obj["prev_count"].GetValue().ToString(),
                                            obj["posX"].GetValue().ToString(),
                                            obj["posY"].GetValue().ToString(),
                                            obj["width"].GetValue().ToString(),
                                            obj["height"].GetValue().ToString(),
                                            0,
                                            obj["depth"].GetValue().ToString(),
                                            obj["objsize"].GetValue().ToString(),
                                            obj["imgbtn_url"].GetValue().ToString(),
                                            obj["imgbtn_width"].GetValue().ToString(),
                                            obj["imgbtn_height"].GetValue().ToString(),
                                            obj["imgbtn_posX"].GetValue().ToString(),
                                            obj["imgbtn_posY"].GetValue().ToString())
                                            );
                        }

                        /*
                        DBConn.RunInsertQuery("INSERT INTO slides (content_id, url1, url2, url3, url4, url5, url6, url7, url8, url9, url10, type, playtype, showtype, prev_count, xpos, ypos, width, height, depth, size) VALUES (@content_id, @url1, @url2, @url3, @url4, @url5, @url6, @url7, @url8, @url9, @url10, @type, @playtype, @showtype, @prev_count, @xpos, @ypos, @width, @height, @depth, @size)",
                            new string[] { "@content_id",
                                            "@url1",
                                            "@url2",
                                            "@url3",
                                            "@url4",
                                            "@url5",
                                            "@url6",
                                            "@url7",
                                            "@url8",
                                            "@url9",
                                            "@url10",
                                            "@type",
                                            "@playtype",
                                            "@showtype",
                                            "@prev_count",
                                            "@xpos",
                                            "@ypos",
                                            "@width",
                                            "@height",
                                            "@depth",
                                            "@size"
                            },
                            new object[] { content_id,
                                            obj["url1"].GetValue().ToString(),
                                            obj["url2"].GetValue().ToString(),
                                            obj["url3"].GetValue().ToString(),
                                            obj["url4"].GetValue().ToString(),
                                            obj["url5"].GetValue().ToString(),
                                            obj["url6"].GetValue().ToString(),
                                            obj["url7"].GetValue().ToString(),
                                            obj["url8"].GetValue().ToString(),
                                            obj["url9"].GetValue().ToString(),
                                            obj["url10"].GetValue().ToString(),
                                            obj["type"].GetValue().ToString(),
                                            obj["playtype"].GetValue().ToString(),
                                            obj["showtype"].GetValue().ToString(),
                                            obj["prev_count"].GetValue().ToString(),
                                            obj["posX"].GetValue().ToString(),
                                            obj["posY"].GetValue().ToString(),
                                            obj["width"].GetValue().ToString(),
                                            obj["height"].GetValue().ToString(),
                                            obj["depth"].GetValue().ToString(),
                                            obj["objsize"].GetValue().ToString()
                                            });
                         */
                    }
                    /***슬라이드이미지이면***/

                    /*비디오이면*/
                    else if ("video".Equals(objtype))
                    {
                        content_size += float.Parse(obj["objsize"].GetValue().ToString());
                        if (obj["run_opt"].GetValue().ToString() == "0" || obj["run_opt"].GetValue().ToString() == "1")
                        {
                            responseXml.Append(string.Format("<video id=\"{0}\">" +
                                                "<url>{1}</url>" +
                                                "<type>{2}</type>" +
                                                "<run_opt>{3}</run_opt>" +
                                                "<posX>{4}</posX>" +
                                                "<posY>{5}</posY>" +
                                                "<width>{6}</width>" +
                                                "<height>{7}</height>" +
                                                "<rate>{8}</rate>" +
                                                "<depth>{9}</depth>" +
                                                "<objsize>{10}</objsize>" +
                                                "</video>",
                                            i+1,
                                            obj["url"].GetValue().ToString(),
                                            obj["type"].GetValue().ToString(),
                                            obj["run_opt"].GetValue().ToString(),
                                            obj["posX"].GetValue().ToString(),
                                            obj["posY"].GetValue().ToString(),
                                            obj["width"].GetValue().ToString(),
                                            obj["height"].GetValue().ToString(),
                                            0,
                                            obj["depth"].GetValue().ToString(),
                                            obj["objsize"].GetValue().ToString())
                                            );
                        }
                        else if (obj["run_opt"].GetValue().ToString() == "2")
                        {
                            responseXml.Append(string.Format("<video id=\"{0}\">" +
                                                "<url>{1}</url>" +
                                                "<type>{2}</type>" +
                                                "<run_opt>{3}</run_opt>" +
                                                "<posX>{4}</posX>" +
                                                "<posY>{5}</posY>" +
                                                "<width>{6}</width>" +
                                                "<height>{7}</height>" +
                                                "<rate>{8}</rate>" +
                                                "<depth>{9}</depth>" +
                                                "<objsize>{10}</objsize>" +
                                                "<btn_title>{11}</btn_title>" +
                                                "<btn_mode_index>{12}</btn_mode_index>" +
                                                "<btn_color>{13}</btn_color>" +
                                                "<btn_color_index>{14}</btn_color_index>" +
                                                "<btn_textcolor>{15}</btn_textcolor>" +
                                                "<btn_textcolor_index>{16}</btn_textcolor_index>" +
                                                "<btn_width>{17}</btn_width>" +
                                                "<btn_height>{18}</btn_height>" +
                                                "<btn_posX>{19}</btn_posX>" +
                                                "<btn_posY>{20}</btn_posY>" +
                                                "</video>",
                                            i + 1,
                                            obj["url"].GetValue().ToString(),
                                            obj["type"].GetValue().ToString(),
                                            obj["run_opt"].GetValue().ToString(),
                                            obj["posX"].GetValue().ToString(),
                                            obj["posY"].GetValue().ToString(),
                                            obj["width"].GetValue().ToString(),
                                            obj["height"].GetValue().ToString(),
                                            0,
                                            obj["depth"].GetValue().ToString(),
                                            obj["objsize"].GetValue().ToString(),
                                            obj["btn_title"].GetValue().ToString(),
                                            obj["btn_mode_index"].GetValue().ToString(),
                                            obj["btn_color"].GetValue().ToString(),
                                            obj["btn_color_index"].GetValue().ToString(),
                                            obj["btn_textcolor"].GetValue().ToString(),
                                            obj["btn_textcolor_index"].GetValue().ToString(),
                                            obj["btn_width"].GetValue().ToString(),
                                            obj["btn_height"].GetValue().ToString(),
                                            obj["btn_posX"].GetValue().ToString(),
                                            obj["btn_posY"].GetValue().ToString())
                                            );
                        }
                        else if (obj["run_opt"].GetValue().ToString() == "3")
                        {
                            responseXml.Append(string.Format("<video id=\"{0}\">" +
                                                "<url>{1}</url>" +
                                                "<type>{2}</type>" +
                                                "<run_opt>{3}</run_opt>" +
                                                "<posX>{4}</posX>" +
                                                "<posY>{5}</posY>" +
                                                "<width>{6}</width>" +
                                                "<height>{7}</height>" +
                                                "<rate>{8}</rate>" +
                                                "<depth>{9}</depth>" +
                                                "<objsize>{10}</objsize>" +
                                                "<imgbtn_url>{11}</imgbtn_url>" +
                                                "<imgbtn_width>{12}</imgbtn_width>" +
                                                "<imgbtn_height>{13}</imgbtn_height>" +
                                                "<imgbtn_posX>{14}</imgbtn_posX>" +
                                                "<imgbtn_posY>{15}</imgbtn_posY>" +
                                                "</video>",
                                            i + 1,
                                            obj["url"].GetValue().ToString(),
                                            obj["type"].GetValue().ToString(),
                                            obj["run_opt"].GetValue().ToString(),
                                            obj["posX"].GetValue().ToString(),
                                            obj["posY"].GetValue().ToString(),
                                            obj["width"].GetValue().ToString(),
                                            obj["height"].GetValue().ToString(),
                                            0,
                                            obj["depth"].GetValue().ToString(),
                                            obj["objsize"].GetValue().ToString(),
                                            obj["imgbtn_url"].GetValue().ToString(),
                                            obj["imgbtn_width"].GetValue().ToString(),
                                            obj["imgbtn_height"].GetValue().ToString(),
                                            obj["imgbtn_posX"].GetValue().ToString(),
                                            obj["imgbtn_posY"].GetValue().ToString())
                                            );
                        }

                        /*
                        DBConn.RunInsertQuery("INSERT INTO videos (content_id, view_opt, run_opt, url, xpos, ypos, width, height, depth,size) VALUES (@content_id, @view_opt, @run_opt, @url, @xpos, @ypos, @width, @height, @depth, @size)",
                                new string[] { "@content_id",
                                               "@view_opt",
                                               "@run_opt",
                                               "@url",
                                               "@xpos",
                                               "@ypos",
                                               "@width",
                                               "@height",
                                               "@depth",
                                               "@size"
                                },
                                new object[] { content_id,
                                               obj["type"].GetValue().ToString(),
                                               obj["run_opt"].GetValue().ToString(),
                                               obj["url"].GetValue().ToString(),
                                               obj["posX"].GetValue().ToString(),
                                               obj["posY"].GetValue().ToString(),
                                               obj["width"].GetValue().ToString(),
                                               obj["height"].GetValue().ToString(),
                                               obj["depth"].GetValue().ToString(),
                                               float.Parse(obj["objsize"].GetValue().ToString())
                                               });
                         */
                    }
                    /***비디오이면***/

                    /*링크비디오이면*/
                    else if ("linkvideo".Equals(objtype))
                    {
                        content_size += float.Parse(obj["objsize"].GetValue().ToString());
                        responseXml.Append(string.Format("<linkvideo id=\"{0}\">" +
                                            "<link_url>{1}</link_url>" +
                                            "<data_url>{2}</data_url>" +
                                            "<type>{3}</type>" +
                                            "<run_opt>{4}</run_opt>" +
                                            "<posX>{5}</posX>" +
                                            "<posY>{6}</posY>" +
                                            "<width>{7}</width>" +
                                            "<height>{8}</height>" +
                                            "<rate>{9}</rate>" +
                                            "<depth>{10}</depth>" +
                                            "<objsize>{11}</objsize>" +
                                            "</linkvideo>",
                                        i + 1,
                                        obj["link_url"].GetValue().ToString(),
                                        obj["data_url"].GetValue().ToString(),
                                        obj["type"].GetValue().ToString(),
                                        obj["run_opt"].GetValue().ToString(),
                                        obj["posX"].GetValue().ToString(),
                                        obj["posY"].GetValue().ToString(),
                                        obj["width"].GetValue().ToString(),
                                        obj["height"].GetValue().ToString(),
                                        0,
                                        obj["depth"].GetValue().ToString(),
                                        obj["objsize"].GetValue().ToString())
                                        );
                    }
                    /*링크비디오이면*/

                    /*웹이면*/
                    else if ("web".Equals(objtype))
                    {
                        content_size += float.Parse(obj["objsize"].GetValue().ToString());
                        responseXml.Append(string.Format("<web id=\"{0}\">" +
                                            "<url>{1}</url>" +
                                            "<type>{2}</type>" +
                                            "<posX>{3}</posX>" +
                                            "<posY>{4}</posY>" +
                                            "<width>{5}</width>" +
                                            "<height>{6}</height>" +
                                            "<rate>{7}</rate>" +
                                            "<depth>{8}</depth>" +
                                            "<view>{9}</view>" +
                                            "<color>{10}</color>" +
                                            "<title>{11}</title>" +
                                            "<backurl>{12}</backurl>" +
                                            "<objsize>{13}</objsize>" +
                                            "<color_index>{14}</color_index>" +
                                            "<mode_index>{15}</mode_index>" +
                                            "<textcolor>{16}</textcolor>" +
                                            "<textcolor_index>{17}</textcolor_index>" +
                                            "</web>",
                                        i + 1,
                                        HttpUtility.UrlEncode(obj["url"].GetValue().ToString()),
                                        obj["type"].GetValue().ToString(),
                                        obj["posX"].GetValue().ToString(),
                                        obj["posY"].GetValue().ToString(),
                                        obj["width"].GetValue().ToString(),
                                        obj["height"].GetValue().ToString(),
                                        0,
                                        obj["depth"].GetValue().ToString(),
                                        obj["view"].GetValue().ToString(),
                                        obj["color"].GetValue().ToString(),
                                        obj["title"].GetValue().ToString(),
                                        obj["backurl"].GetValue().ToString(),
                                        obj["objsize"].GetValue().ToString(),
                                        obj["color_index"].GetValue().ToString(),
                                        obj["mode_index"].GetValue().ToString(),
                                        obj["textcolor"].GetValue().ToString(),
                                        obj["textcolor_index"].GetValue().ToString()
                                        ));
                        /*
                        DBConn.RunInsertQuery("INSERT INTO websites (content_id, view_opt, url, xpos, ypos, width, height, depth, btn_opt, btn_url, color,title, size ) VALUES (@content_id, @view_opt, @url, @xpos, @ypos, @width, @height, @depth, @btn_opt, @btn_url, @color, @title, @size)",
                                new string[] { "@content_id",
                                               "@view_opt",
                                               "@url",
                                               "@xpos",
                                               "@ypos",
                                               "@width",
                                               "@height",
                                               "@depth",
                                               "@btn_opt",
                                               "@btn_url",
                                               "@color",
                                               "@title",
                                               "@size"
                                },
                                new object[] { content_id,
                                               obj["view"].GetValue().ToString(),
                                               obj["url"].GetValue().ToString(),
                                               obj["posX"].GetValue().ToString(),
                                               obj["posY"].GetValue().ToString(),
                                               obj["width"].GetValue().ToString(),
                                               obj["height"].GetValue().ToString(),
                                               obj["depth"].GetValue().ToString(),
                                               obj["type"].GetValue().ToString(),
                                               obj["backurl"].GetValue().ToString(),
                                               obj["color"].GetValue().ToString(),
                                               obj["title"].GetValue().ToString(),
                                               obj["objsize"].GetValue().ToString()
                                               });
                         */
                    }
                    /***웹이면***/

                    /*PDF이면*/
                    else if ("pdf".Equals(objtype))
                    {
                        content_size += float.Parse(obj["objsize"].GetValue().ToString());
                        if (obj["run_opt"].GetValue().ToString() == "0") {
                            responseXml.Append(string.Format("<pdf id=\"{0}\">" +
                                                "<backurl>{1}</backurl>" +
                                                "<name>{2}</name>" +
                                                "<pagecount>{3}</pagecount>" +
                                                "<run_opt>{4}</run_opt>" +
                                                "<objsize>{5}</objsize>" +
                                                "<depth>{6}</depth>" +
                                                "<width>{7}</width>" +
                                                "<height>{8}</height>" +
                                                "<posX>{9}</posX>" +
                                                "<posY>{10}</posY>" +
                                                "</pdf>",
                                            i + 1,
                                            obj["backurl"].GetValue().ToString(),
                                            obj["name"].GetValue().ToString(),
                                            obj["pagecount"].GetValue().ToString(),
                                            obj["run_opt"].GetValue().ToString(),
                                            obj["objsize"].GetValue().ToString(),
                                            obj["depth"].GetValue().ToString(),
                                            obj["width"].GetValue().ToString(),
                                            obj["height"].GetValue().ToString(),
                                            obj["posX"].GetValue().ToString(),
                                            obj["posY"].GetValue().ToString()
                                            ));
                        } else if (obj["run_opt"].GetValue().ToString() == "1") {
                            responseXml.Append(string.Format("<pdf id=\"{0}\">" +
                                                "<backurl>{1}</backurl>" +
                                                "<name>{2}</name>" +
                                                "<pagecount>{3}</pagecount>" +
                                                "<run_opt>{4}</run_opt>" +
                                                "<objsize>{5}</objsize>" +
                                                "<depth>{6}</depth>" +
                                                "<width>{7}</width>" +
                                                "<height>{8}</height>" +
                                                "<posX>{9}</posX>" +
                                                "<posY>{10}</posY>" +
                                                "<title>{11}</title>" +
                                                "<mode_index>{12}</mode_index>" +
                                                "<color>{13}</color>" +
                                                "<color_index>{14}</color_index>" +
                                                "<textcolor>{15}</textcolor>" +
                                                "<textcolor_index>{16}</textcolor_index>" +
                                                "</pdf>",
                                            i + 1,
                                            obj["backurl"].GetValue().ToString(),
                                            obj["name"].GetValue().ToString(),
                                            obj["pagecount"].GetValue().ToString(),
                                            obj["run_opt"].GetValue().ToString(),
                                            obj["objsize"].GetValue().ToString(),
                                            obj["depth"].GetValue().ToString(),
                                            obj["width"].GetValue().ToString(),
                                            obj["height"].GetValue().ToString(),
                                            obj["posX"].GetValue().ToString(),
                                            obj["posY"].GetValue().ToString(),
                                            obj["title"].GetValue().ToString(),
                                            obj["mode_index"].GetValue().ToString(),
                                            obj["color"].GetValue().ToString(),
                                            obj["color_index"].GetValue().ToString(),
                                            obj["textcolor"].GetValue().ToString(),
                                            obj["textcolor_index"].GetValue().ToString()
                                            ));
                        } else if (obj["run_opt"].GetValue().ToString() == "2") {
                            responseXml.Append(string.Format("<pdf id=\"{0}\">" +
                                                "<backurl>{1}</backurl>" +
                                                "<name>{2}</name>" +
                                                "<pagecount>{3}</pagecount>" +
                                                "<run_opt>{4}</run_opt>" +
                                                "<objsize>{5}</objsize>" +
                                                "<depth>{6}</depth>" +
                                                "<width>{7}</width>" +
                                                "<height>{8}</height>" +
                                                "<posX>{9}</posX>" +
                                                "<posY>{10}</posY>" +
                                                "</pdf>",
                                            i + 1,
                                            obj["backurl"].GetValue().ToString(),
                                            obj["name"].GetValue().ToString(),
                                            obj["pagecount"].GetValue().ToString(),
                                            obj["run_opt"].GetValue().ToString(),
                                            obj["objsize"].GetValue().ToString(),
                                            obj["depth"].GetValue().ToString(),
                                            obj["width"].GetValue().ToString(),
                                            obj["height"].GetValue().ToString(),
                                            obj["posX"].GetValue().ToString(),
                                            obj["posY"].GetValue().ToString()
                                            ));
                        }
                    }
                    /***PDF이면***/


                    /*캡쳐이미지이면*/
                    else if ("capture".Equals(objtype))
                    {
                        content_size += float.Parse(obj["objsize"].GetValue().ToString());
                        responseXml.Append(string.Format("<capture id=\"{0}\">" +
                                            "<type>{1}</type>" +
                                            "<prev_count>{2}</prev_count>" +
                                            "<posX>{3}</posX>" +
                                            "<posY>{4}</posY>" +
                                            "<width>{5}</width>" +
                                            "<height>{6}</height>" +

                                            "<slide1>{7}</slide1><posX1>{8}</posX1><posY1>{9}</posY1><width1>{10}</width1><height1>{11}</height1>" +
                                            "<slide2>{12}</slide2><posX2>{13}</posX2><posY2>{14}</posY2><width2>{15}</width2><height2>{16}</height2>" +
                                            "<slide3>{17}</slide3><posX3>{18}</posX3><posY3>{19}</posY3><width3>{20}</width3><height3>{21}</height3>" +
                                            "<slide4>{22}</slide4><posX4>{23}</posX4><posY4>{24}</posY4><width4>{25}</width4><height4>{26}</height4>" +
                                            "<slide5>{27}</slide5><posX5>{28}</posX5><posY5>{29}</posY5><width5>{30}</width5><height5>{31}</height5>" +

                                            "<rate>{32}</rate>" +
                                            "<depth>{33}</depth>" +
                                            "<backurl>{34}</backurl>" +

                                            "<color>{35}</color>" +
                                            "<title>{36}</title>" +
                                            "<buttontype>{37}</buttontype>" +
                                            "<objsize>{38}</objsize>" +
                                            "<color_index>{39}</color_index>" +
                                            "</capture>",
                                        i + 1,
                                        obj["type"].GetValue().ToString(),
                                        obj["prev_count"].GetValue().ToString(),
                                        obj["posX"].GetValue().ToString(),
                                        obj["posY"].GetValue().ToString(),
                                        obj["width"].GetValue().ToString(),
                                        obj["height"].GetValue().ToString(),

                                        obj["slide1"].GetValue().ToString(), obj["posX1"].GetValue().ToString(), obj["posY1"].GetValue().ToString(), obj["width1"].GetValue().ToString(), obj["height1"].GetValue().ToString(),
                                        obj["slide2"].GetValue().ToString(), obj["posX2"].GetValue().ToString(), obj["posY2"].GetValue().ToString(), obj["width2"].GetValue().ToString(), obj["height2"].GetValue().ToString(),
                                        obj["slide3"].GetValue().ToString(), obj["posX3"].GetValue().ToString(), obj["posY3"].GetValue().ToString(), obj["width3"].GetValue().ToString(), obj["height3"].GetValue().ToString(),
                                        obj["slide4"].GetValue().ToString(), obj["posX4"].GetValue().ToString(), obj["posY4"].GetValue().ToString(), obj["width4"].GetValue().ToString(), obj["height4"].GetValue().ToString(),
                                        obj["slide5"].GetValue().ToString(), obj["posX5"].GetValue().ToString(), obj["posY5"].GetValue().ToString(), obj["width5"].GetValue().ToString(), obj["height5"].GetValue().ToString(),

                                        0,
                                        obj["depth"].GetValue().ToString(),
                                        obj["backurl"].GetValue().ToString(),

                                        obj["color"].GetValue().ToString(),
                                        obj["title"].GetValue().ToString(),
                                        obj["buttontype"].GetValue().ToString(),

                                        obj["objsize"].GetValue().ToString(),
                                        obj["color_index"].GetValue().ToString()
                                        ));
                        /*
                        DBConn.RunInsertQuery("INSERT INTO captures (content_id, type, prev_count, xpos, ypos, width, height, depth, btn_url, url1, url2, url3, url4 , url5 ,size) VALUES (@content_id, @type, @prev_count, @xpos, @ypos, @width, @height, @depth, @btn_url, @url1, @url2, @url3, @url4, @url5, @size )",
                                new string[] { "@content_id",
                                               "@type",
                                               "@prev_count",
                                               "@xpos",
                                               "@ypos",
                                               "@width",
                                               "@height",
                                               "@depth",
                                               "@btn_url",
                                               "@url1",
                                               "@url2",
                                               "@url3",
                                               "@url4",
                                               "@url5",
                                               "@size",
                                },
                                new object[] { content_id,
                                               obj["type"].GetValue().ToString(),
                                               obj["prev_count"].GetValue().ToString(),
                                               obj["posX"].GetValue().ToString(),
                                               obj["posY"].GetValue().ToString(),
                                               obj["width"].GetValue().ToString(),
                                               obj["height"].GetValue().ToString(),
                                               obj["depth"].GetValue().ToString(),
                                               obj["backurl"].GetValue().ToString(),
                                               obj["slide1"].GetValue().ToString(),
                                               obj["slide2"].GetValue().ToString(),
                                               obj["slide3"].GetValue().ToString(),
                                               obj["slide4"].GetValue().ToString(),
                                               obj["slide5"].GetValue().ToString(),
                                               obj["objsize"].GetValue().ToString()
                                               });
                         */
                    }
                    /***캡쳐이미지이면***/

                    /*3D 오브젝트이면*/
                    else if ("three".Equals(objtype))
                    {
                        content_size += float.Parse(obj["objsize"].GetValue().ToString());
                        responseXml.Append(string.Format("<three id=\"{0}\">" +
                                            "<type>{1}</type>" +
                                            "<posX>{2}</posX>" +
                                            "<posY>{3}</posY>" +
                                            "<width>{4}</width>" +
                                            "<height>{5}</height>" +
                                            "<rate>{6}</rate>" +
                                            "<depth>{7}</depth>" +
                                            "<url1>{8}</url1>" +
                                            "<url2>{9}</url2>" +
                                            "<angle>{10}</angle>" +
                                            "<brightness>{11}</brightness>" +
                                            "<times>{12}</times>" +
                                            "<objsize>{13}</objsize>" +
                                            "</three>",
                                        i + 1,
                                        obj["type"].GetValue().ToString(),
                                        obj["posX"].GetValue().ToString(),
                                        obj["posY"].GetValue().ToString(),
                                        obj["width"].GetValue().ToString(),
                                        obj["height"].GetValue().ToString(),
                                        0,
                                        obj["depth"].GetValue().ToString(),
                                        obj["url1"].GetValue().ToString(),
                                        obj["url2"].GetValue().ToString(),
                                        obj["front_angle"].GetValue().ToString(),
                                        obj["brightness"].GetValue().ToString(),
                                        obj["run_times"].GetValue().ToString(),
                                        obj["objsize"].GetValue().ToString()
                                        ));
                        /*
                        DBConn.RunInsertQuery("INSERT INTO threes (content_id, type, xpos, ypos, width, height, depth, url1, url2, front_angle, run_times, size ) VALUES (@content_id, @type, @xpos, @ypos, @width, @height, @depth, @url1, @url2,@front_angle, @run_times, @size)",
                                new string[] { "@content_id",
                                               "@type",
                                               "@xpos",
                                               "@ypos",
                                               "@width",
                                               "@height",
                                               "@depth",
                                               "@url1",
                                               "@url2",
                                               "@front_angle",
                                               "@run_times",
                                               "@size"
                                },
                                new object[] { content_id,
                                               obj["type"].GetValue().ToString(),
                                               obj["posX"].GetValue().ToString(),
                                               obj["posY"].GetValue().ToString(),
                                               obj["width"].GetValue().ToString(),
                                               obj["height"].GetValue().ToString(),
                                               obj["depth"].GetValue().ToString(),
                                               obj["url1"].GetValue().ToString(),
                                               obj["url2"].GetValue().ToString(),
                                               obj["front_angle"].GetValue().ToString(),
                                               obj["run_times"].GetValue().ToString(),
                                               obj["objsize"].GetValue().ToString()
                                               });
                         */
                    }
                    /***3D 오브젝트이면***/

                    /*전화기 오브젝트이면*/
                    else if ("tel".Equals(objtype))
                    {
                        content_size += float.Parse(obj["objsize"].GetValue().ToString());
                        responseXml.Append(string.Format("<tel id=\"{0}\">" +
                                            "<type>{1}</type>" +
                                            "<posX>{2}</posX>" +
                                            "<posY>{3}</posY>" +
                                            "<width>{4}</width>" +
                                            "<height>{5}</height>" +
                                            "<rate>{6}</rate>" +
                                            "<depth>{7}</depth>" +
                                            "<tel_no>{8}</tel_no>" +
                                            "<backurl>{9}</backurl>" +
                                            "<color>{10}</color>" +
                                            "<title>{11}</title>" +                                            
                                            "<threemode>{12}</threemode>" +
                                            "<objsize>{13}</objsize>" +
                                            "<color_index>{14}</color_index>" +
                                            "<mode_index>{15}</mode_index>" +
                                            "<textcolor>{16}</textcolor>" +
                                            "<textcolor_index>{17}</textcolor_index>" +
                                            "</tel>",
                                        i + 1,
                                        obj["type"].GetValue().ToString(),
                                        obj["posX"].GetValue().ToString(),
                                        obj["posY"].GetValue().ToString(),
                                        obj["width"].GetValue().ToString(),
                                        obj["height"].GetValue().ToString(),
                                        0,
                                        obj["depth"].GetValue().ToString(),
                                        obj["tel_no"].GetValue().ToString(),
                                        obj["backurl"].GetValue().ToString(),
                                        obj["color"].GetValue().ToString(),
                                        obj["title"].GetValue().ToString(),
                                        obj["threemode"].GetValue().ToString(),
                                        obj["objsize"].GetValue().ToString(),
                                        obj["color_index"].GetValue().ToString(),
                                        obj["mode_index"].GetValue().ToString(),
                                        obj["textcolor"].GetValue().ToString(),
                                        obj["textcolor_index"].GetValue().ToString()
                                        ));
                        /*
                        DBConn.RunInsertQuery("INSERT INTO telephones (content_id, type, xpos, ypos, width, height, depth, tel_no, size, color, title, threemode) VALUES (@content_id, @type, @xpos, @ypos, @width, @height, @depth, @tel_no, @size, @color, @title, @threemode)",
                                new string[] { "@content_id",
                                               "@type",
                                               "@xpos",
                                               "@ypos",
                                               "@width",
                                               "@height",
                                               "@depth",
                                               "@tel_no",
                                               "@size",
                                               "@color",
                                               "@title",
                                               "@threemode"
                                },
                                new object[] { content_id,
                                               obj["type"].GetValue().ToString(),
                                               obj["posX"].GetValue().ToString(),
                                               obj["posY"].GetValue().ToString(),
                                               obj["width"].GetValue().ToString(),
                                               obj["height"].GetValue().ToString(),
                                               obj["depth"].GetValue().ToString(),
                                               obj["tel_no"].GetValue().ToString(),
                                               obj["objsize"].GetValue().ToString(),
                                               obj["color"].GetValue().ToString(),
                                               obj["title"].GetValue().ToString(),
                                               obj["threemode"].GetValue().ToString()
                                               });
                         */
                    }
                    /***전화기 오브젝트이면***/

                    /*구글맵 오브젝트이면*/
                    else if ("googlemap".Equals(objtype))
                    {
                        content_size += float.Parse(obj["objsize"].GetValue().ToString());
                        responseXml.Append(string.Format("<googlemap id=\"{0}\">" +
                                            "<type>{1}</type>" +
                                            "<posX>{2}</posX>" +
                                            "<posY>{3}</posY>" +
                                            "<width>{4}</width>" +
                                            "<height>{5}</height>" +
                                            "<rate>{6}</rate>" +
                                            "<depth>{7}</depth>" +
                                            "<coordinate>{8}</coordinate>" +
                                            "<backurl>{9}</backurl>" +
                                            "<color>{10}</color>" +
                                            "<title>{11}</title>" +
                                            "<objsize>{12}</objsize>" +
                                            "<color_index>{13}</color_index>" +
                                            "<mode_index>{14}</mode_index>" +
                                            "<textcolor>{15}</textcolor>" +
                                            "<textcolor_index>{16}</textcolor_index>" +
                                            "</googlemap>",
                                        i + 1,
                                        obj["type"].GetValue().ToString(),
                                        obj["posX"].GetValue().ToString(),
                                        obj["posY"].GetValue().ToString(),
                                        obj["width"].GetValue().ToString(),
                                        obj["height"].GetValue().ToString(),
                                        0,
                                        obj["depth"].GetValue().ToString(),
                                        obj["coordinate"].GetValue().ToString(),
                                        obj["backurl"].GetValue().ToString(),
                                        obj["color"].GetValue().ToString(),
                                        obj["title"].GetValue().ToString(),
                                        obj["objsize"].GetValue().ToString(),
                                        obj["color_index"].GetValue().ToString(),
                                        obj["mode_index"].GetValue().ToString(),
                                        obj["textcolor"].GetValue().ToString(),
                                        obj["textcolor_index"].GetValue().ToString()
                                        ));
                        /*
                        DBConn.RunInsertQuery("INSERT INTO googlemaps (content_id, type, xpos, ypos, width, height, depth, coordinate, size, color, title, color_index, mode_index) VALUES (@content_id, @type, @xpos, @ypos, @width, @height, @depth, @coordinate, @size, @color, @title, @color_index, @mode_index)",
                                new string[] { "@content_id",
                                               "@type",
                                               "@xpos",
                                               "@ypos",
                                               "@width",
                                               "@height",
                                               "@depth",
                                               "@coordinate",
                                               "@size",
                                               "@color",
                                               "@title",
                                               "@color_index",
                                               "@mode_index"
                                },
                                new object[] { content_id,
                                               obj["type"].GetValue().ToString(),
                                               obj["posX"].GetValue().ToString(),
                                               obj["posY"].GetValue().ToString(),
                                               obj["width"].GetValue().ToString(),
                                               obj["height"].GetValue().ToString(),
                                               obj["depth"].GetValue().ToString(),
                                               obj["coordinate"].GetValue().ToString(),
                                               obj["objsize"].GetValue().ToString(),
                                               obj["color"].GetValue().ToString(),
                                               obj["title"].GetValue().ToString(),
                                               obj["color_index"].GetValue().ToString(),
                                               obj["color_index"].GetValue().ToString()
                                               });
                         */
                    }
                    /***구글맵 오브젝트이면***/

                    /*문자판 오브젝트이면*/
                    else if ("notepad".Equals(objtype))
                    {
                        responseXml.Append(string.Format("<notepad id=\"{0}\">" +
                                            "<view>{1}</view>" +
                                            "<posX>{2}</posX>" +
                                            "<posY>{3}</posY>" +
                                            "<width>{4}</width>" +
                                            "<height>{5}</height>" +
                                            "<rate>{6}</rate>" +
                                            "<depth>{7}</depth>" +
                                            "<content>{8}</content>" +
                                            "<color>{9}</color>" +
                                            "<boardtype>{10}</boardtype>" +
                                            "<boardcolor>{11}</boardcolor>" +
                                            "<textplaymode>{12}</textplaymode>" +
                                            "<board_color_index>{13}</board_color_index>" +
                                            "<text_color_index>{14}</text_color_index>" +
                                            "</notepad>",
                                        i + 1,
                                        obj["view"].GetValue().ToString(),
                                        obj["posX"].GetValue().ToString(),
                                        obj["posY"].GetValue().ToString(),
                                        obj["width"].GetValue().ToString(),
                                        obj["height"].GetValue().ToString(),
                                        0,
                                        obj["depth"].GetValue().ToString(),
                                        HttpUtility.UrlEncode(obj["content"].GetValue().ToString()),
                                        obj["color"].GetValue().ToString(),
                                        obj["boardtype"].GetValue().ToString(),
                                        obj["boardcolor"].GetValue().ToString(),
                                        obj["textplaymode"].GetValue().ToString(),
                                        obj["board_color_index"].GetValue().ToString(),
                                        obj["text_color_index"].GetValue().ToString()
                                        ));
                        /*
                        DBConn.RunInsertQuery("INSERT INTO notepads (content_id, [view], xpos, ypos, width, height, depth, [content], boardtype, boardcolor, textplaymode) VALUES (@content_id, @view, @xpos, @ypos, @width, @height, @depth, @content, @boardtype, @boardcolor, @textplaymode)",
                                new string[] { "@content_id",
                                               "@view",
                                               "@xpos",
                                               "@ypos",
                                               "@width",
                                               "@height",
                                               "@depth",
                                               "@content",
                                               "@boardtype",
                                               "@boardcolor",
                                               "@textplaymode"
                                },
                                new object[] { content_id,
                                               obj["view"].GetValue().ToString(),
                                               obj["posX"].GetValue().ToString(),
                                               obj["posY"].GetValue().ToString(),
                                               obj["width"].GetValue().ToString(),
                                               obj["height"].GetValue().ToString(),
                                               obj["depth"].GetValue().ToString(),
                                               obj["content"].GetValue().ToString(),
                                               obj["boardtype"].GetValue().ToString(),
                                               obj["boardcolor"].GetValue().ToString(),
                                               obj["textplaymode"].GetValue().ToString()
                                               });
                         */
                    }
                    /***문자판 오브젝트이면***/

                    /*사운드 오브젝트이면*/
                    else if ("audio".Equals(objtype))
                    {
                        content_size += float.Parse(obj["objsize"].GetValue().ToString());
                        responseXml.Append(string.Format("<audio id=\"{0}\">" +
                                            "<url>{1}</url>" +
                                            "<type>{2}</type>" +
                                            "<run_opt>{3}</run_opt>" +
                                            "<posX>{4}</posX>" +
                                            "<posY>{5}</posY>" +
                                            "<width>{6}</width>" +
                                            "<height>{7}</height>" +
                                            "<rate>{8}</rate>" +
                                            "<depth>{9}</depth>" +
                                            "<btnkind>{10}</btnkind>" +                                            
                                            "<color>{11}</color>" +
                                            "<objsize>{12}</objsize>" +
                                            "<color_index>{13}</color_index>" +
                                            "<mode_index>{14}</mode_index>" +
                                            "<btn_url>{15}</btn_url>" +
                                            "<textcolor>{16}</textcolor>" +
                                            "<textcolor_index>{17}</textcolor_index>" +
                                            "</audio>",
                                        i + 1,
                                        obj["url"].GetValue().ToString(),
                                        obj["type"].GetValue().ToString(),
                                        obj["run_opt"].GetValue().ToString(),
                                        obj["posX"].GetValue().ToString(),
                                        obj["posY"].GetValue().ToString(),
                                        obj["width"].GetValue().ToString(),
                                        obj["height"].GetValue().ToString(),
                                        0,
                                        obj["depth"].GetValue().ToString(),
                                        obj["btnkind"].GetValue().ToString(),                                        
                                        obj["color"].GetValue().ToString(),
                                        obj["objsize"].GetValue().ToString(),
                                        obj["color_index"].GetValue().ToString(),
                                        obj["mode_index"].GetValue().ToString(),
                                        obj["btn_url"].GetValue().ToString(),
                                        obj["textcolor"].GetValue().ToString(),
                                        obj["textcolor_index"].GetValue().ToString()
                                        ));
                        /*
                        DBConn.RunInsertQuery("INSERT INTO sounds (content_id, type, run_opt, url, xpos, ypos, width, height, depth, size) VALUES (@content_id, @type, @run_opt, @url, @xpos, @ypos, @width, @height, @depth, @size)",
                                new string[] { "@content_id",
                                               "@type",
                                               "@run_opt",
                                               "@url",
                                               "@xpos",
                                               "@ypos",
                                               "@width",
                                               "@height",
                                               "@depth",
                                               "@size"
                                },
                                new object[] { content_id,
                                               obj["type"].GetValue().ToString(),
                                               obj["run_opt"].GetValue().ToString(),
                                               obj["url"].GetValue().ToString(),
                                               obj["posX"].GetValue().ToString(),
                                               obj["posY"].GetValue().ToString(),
                                               obj["width"].GetValue().ToString(),
                                               obj["height"].GetValue().ToString(),
                                               obj["depth"].GetValue().ToString(),
                                               obj["objsize"].GetValue().ToString()
                                               });
                         */
                    }
                    /***사운드 오브젝트이면***/

                    /*크로마키 오브젝트이면*/
                    else if ("chromakey".Equals(objtype))
                    {
                        content_size += float.Parse(obj["objsize"].GetValue().ToString());

                        if (obj["run_opt"].GetValue().ToString() == "0" || obj["run_opt"].GetValue().ToString() == "1")
                        {
                            responseXml.Append(string.Format("<chromakey id=\"{0}\">" +
                                                "<url>{1}</url>" +
                                                "<type>{2}</type>" +
                                                "<run_opt>{3}</run_opt>" +
                                                "<posX>{4}</posX>" +
                                                "<posY>{5}</posY>" +
                                                "<width>{6}</width>" +
                                                "<height>{7}</height>" +
                                                "<rate>{8}</rate>" +
                                                "<depth>{9}</depth>" +
                                                "<objsize>{10}</objsize>" +
                                                "</chromakey>",
                                            i + 1,
                                            obj["url"].GetValue().ToString(),
                                            obj["type"].GetValue().ToString(),
                                            obj["run_opt"].GetValue().ToString(),
                                            obj["posX"].GetValue().ToString(),
                                            obj["posY"].GetValue().ToString(),
                                            obj["width"].GetValue().ToString(),
                                            obj["height"].GetValue().ToString(),
                                            0,
                                            obj["depth"].GetValue().ToString(),
                                            obj["objsize"].GetValue().ToString())
                                            );
                        }
                        else if (obj["run_opt"].GetValue().ToString() == "2")
                        {
                            responseXml.Append(string.Format("<chromakey id=\"{0}\">" +
                                                "<url>{1}</url>" +
                                                "<type>{2}</type>" +
                                                "<run_opt>{3}</run_opt>" +
                                                "<posX>{4}</posX>" +
                                                "<posY>{5}</posY>" +
                                                "<width>{6}</width>" +
                                                "<height>{7}</height>" +
                                                "<rate>{8}</rate>" +
                                                "<depth>{9}</depth>" +
                                                "<objsize>{10}</objsize>" +
                                                "<btn_title>{11}</btn_title>" +
                                                "<btn_mode_index>{12}</btn_mode_index>" +
                                                "<btn_color>{13}</btn_color>" +
                                                "<btn_color_index>{14}</btn_color_index>" +
                                                "<btn_textcolor>{15}</btn_textcolor>" +
                                                "<btn_textcolor_index>{16}</btn_textcolor_index>" +
                                                "<btn_width>{17}</btn_width>" +
                                                "<btn_height>{18}</btn_height>" +
                                                "<btn_posX>{19}</btn_posX>" +
                                                "<btn_posY>{20}</btn_posY>" +
                                                "</chromakey>",
                                            i + 1,
                                            obj["url"].GetValue().ToString(),
                                            obj["type"].GetValue().ToString(),
                                            obj["run_opt"].GetValue().ToString(),
                                            obj["posX"].GetValue().ToString(),
                                            obj["posY"].GetValue().ToString(),
                                            obj["width"].GetValue().ToString(),
                                            obj["height"].GetValue().ToString(),
                                            0,
                                            obj["depth"].GetValue().ToString(),
                                            obj["objsize"].GetValue().ToString(),
                                            obj["btn_title"].GetValue().ToString(),
                                            obj["btn_mode_index"].GetValue().ToString(),
                                            obj["btn_color"].GetValue().ToString(),
                                            obj["btn_color_index"].GetValue().ToString(),
                                            obj["btn_textcolor"].GetValue().ToString(),
                                            obj["btn_textcolor_index"].GetValue().ToString(),
                                            obj["btn_width"].GetValue().ToString(),
                                            obj["btn_height"].GetValue().ToString(),
                                            obj["btn_posX"].GetValue().ToString(),
                                            obj["btn_posY"].GetValue().ToString())
                                            );
                        }
                        else if (obj["run_opt"].GetValue().ToString() == "3")
                        {
                            responseXml.Append(string.Format("<chromakey id=\"{0}\">" +
                                                "<url>{1}</url>" +
                                                "<type>{2}</type>" +
                                                "<run_opt>{3}</run_opt>" +
                                                "<posX>{4}</posX>" +
                                                "<posY>{5}</posY>" +
                                                "<width>{6}</width>" +
                                                "<height>{7}</height>" +
                                                "<rate>{8}</rate>" +
                                                "<depth>{9}</depth>" +
                                                "<objsize>{10}</objsize>" +
                                                "<imgbtn_url>{11}</imgbtn_url>" +
                                                "<imgbtn_width>{12}</imgbtn_width>" +
                                                "<imgbtn_height>{13}</imgbtn_height>" +
                                                "<imgbtn_posX>{14}</imgbtn_posX>" +
                                                "<imgbtn_posY>{15}</imgbtn_posY>" +
                                                "</chromakey>",
                                            i + 1,
                                            obj["url"].GetValue().ToString(),
                                            obj["type"].GetValue().ToString(),
                                            obj["run_opt"].GetValue().ToString(),
                                            obj["posX"].GetValue().ToString(),
                                            obj["posY"].GetValue().ToString(),
                                            obj["width"].GetValue().ToString(),
                                            obj["height"].GetValue().ToString(),
                                            0,
                                            obj["depth"].GetValue().ToString(),
                                            obj["objsize"].GetValue().ToString(),
                                            obj["imgbtn_url"].GetValue().ToString(),
                                            obj["imgbtn_width"].GetValue().ToString(),
                                            obj["imgbtn_height"].GetValue().ToString(),
                                            obj["imgbtn_posX"].GetValue().ToString(),
                                            obj["imgbtn_posY"].GetValue().ToString())
                                            );
                        }

                        /*
                        DBConn.RunInsertQuery("INSERT INTO chromakeys (content_id, type, run_opt, url, xpos, ypos, width, height, depth,size) VALUES (@content_id, @type, @run_opt, @url, @xpos, @ypos, @width, @height, @depth, @size)",
                                new string[] { "@content_id",
                                               "@type",
                                               "@run_opt",
                                               "@url",
                                               "@xpos",
                                               "@ypos",
                                               "@width",
                                               "@height",
                                               "@depth",
                                               "@size"
                                },
                                new object[] { content_id,
                                               obj["type"].GetValue().ToString(),
                                               obj["run_opt"].GetValue().ToString(),
                                               obj["url"].GetValue().ToString(),
                                               obj["posX"].GetValue().ToString(),
                                               obj["posY"].GetValue().ToString(),
                                               obj["width"].GetValue().ToString(),
                                               obj["height"].GetValue().ToString(),
                                               obj["depth"].GetValue().ToString(),
                                               obj["objsize"].GetValue().ToString()
                                               });
                         */
                    }
                    /***크로마키 오브젝트이면***/

                }
            }

            responseXml.Append("</contents>");
            DBConn.RunUpdateQuery("UPDATE contents SET xml={0}, size={1}, title={3}, changedate=GETDATE() WHERE id={2}",
                new string[] { "@xml",
                               "@size",
                               "@id", 
                               "@title" },
                new object[] { responseXml.ToString(),
                                content_size,
                                content_id, 
                                title });
            DBConn.RunStoreProcedure(Constants.SP_ADDEVENTLOG,
                    new string[] {
                        "@event",
                        "@userid",
                        "@user_ip"
                    },
                    new object[] {
                        Constants.EVENT_MODCAMPAIGN,
                        AuthUser.ID,
                        Request.ServerVariables["REMOTE_ADDR"]
                    });
            Response.Write(content_id.ToString());
        }
    }
}