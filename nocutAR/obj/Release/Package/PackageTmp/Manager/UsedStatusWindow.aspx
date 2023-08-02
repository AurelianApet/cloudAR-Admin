<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UsedStatusWindow.aspx.cs" Inherits="nocutAR.Manager.UsedStatusWindow" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>이용현황</title>
    <link href="~/Styles/Site.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../Scripts/jquery-1.11.2.js"></script>
    <script language="javascript" type="text/javascript" src="../Scripts/popup.js"></script>
    <meta http-equiv="X-UA-Compatible" content="IE=9"/>
    <asp:Literal ID="ltlScript" runat="server" Text="" ></asp:Literal>
    <script type="text/javascript" language="javascript">
        $(document).ready(function () {
            ShowProgress();
            $.ajax({
                url: "getUsedStatus.aspx?id=" + USER_ID,
                dataType: 'json',
                type: 'POST',
                success: function (data) {
                    HideProgress();
                    var iCompany = data.company;
                    var iMarkers = parseInt(data.markers);
                    var iUsedHard = parseFloat(data.usedhard).toFixed(2);

                    var iTraffics = parseFloat(data.traffic).toFixed(2);
                    var iApiRequests = parseInt(data.api_requests);

                    $("#popCompany").html(iCompany);
                    $("#popMarkers").html(iMarkers + "개");
                    $("#popUsedHard").html(iUsedHard + "G/10G");
                    $("#popUsedHardBar").css({ "width": iUsedHard / 10 * 100 + '%' });
                    $("#popTraffic").html(iTraffics + "G/60G");
                    $("#popTrafficBar").css({ "width": iTraffics / 60 * 100 + '%' });
                    $("#popAPIRequests").html(iApiRequests + "회/10000회");
                    $("#popAPIRequestsBar").css({ "width": "0%" });
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HideProgress();
                    alert("이용현황정보를 가져오는중 오류가 발생하었습니다.");
                }
            });
        });
    </script>
</head>
<body style="background-color:#fff">
    <form id="form1" runat="server">
    <div id="trafficstatus_div" style="width:500px; height:540px;  display:block;position:relative; font-family:맑은 고딕;color: Black;	">
        <table border="0" cellpadding="0" cellspacing="0">
            <tr height="60px" style="font-size:14pt; font-weight:900">
                <td align="left"  >
                    이용현황
                </td>
            </tr>
            <tr>
                <td style="height:1px; background-color:#000;"></td>
            </tr>
            <tr>
                <td style="height:10px;"></td>
            </tr>
            <tr >
                <td >
                    <table >
                        <tr style="font-size:9pt; height:20px">
                            <td style="padding-left:15px;">
                                회사(고객)명
                            </td>
                            <td >
                                <div id="popCompany"></div>
                            </td>
                        </tr>
                        <tr style="font-size:9pt; height:20px">
                            <td style="padding-left:15px">
                                등록된 마커
                            </td>
                            <td >
                                <div id="popMarkers"></div>
                            </td>
                        </tr>
                        <tr style="font-size:9pt; height:20px">
                            <td style="padding-left:15px">
                                사용중인 하드용량
                            </td>
                            <td>
                                <div style="width:100%; height:18px; position:relative; border:1px solid #ACACAC; border-radius :5px; overflow:hidden">
                                    <span id="popUsedHard" style="position:absolute; width:100%; text-align:center" ></span>
                                    <img id="popUsedHardBar" src="img/chartback.png" style="height:100%;"/>
                                </div>
                            </td>
                        </tr>
                        <tr style="font-size:9pt; height:20px">
                            <td style="padding-left:15px">
                                사용중인 트래픽(금월)
                            </td>
                            <td>
                                <div style="width:100%; height:18px; position:relative; border:1px solid #ACACAC; border-radius :5px; overflow:hidden">
                                    <span id="popTraffic" style="position:absolute; width:100%; text-align:center" ></span>
                                    <img id="popTrafficBar" src="img/chartback.png" style="height:100%;"/>
                                </div>
                            </td>
                        </tr>
                        <tr style="font-size:9pt; height:20px">
                            <td style="padding-left:15px">
                                API요청(금월)
                            </td>
                            <td >
                                <div style="width:100%; height:18px; position:relative; border:1px solid #ACACAC; border-radius :5px; overflow:hidden">
                                    <span id="popAPIRequests" style="position:absolute; width:100%; text-align:center" ></span>
                                    <img id="popAPIRequestsBar" src="img/chartback.png" style="height:100%;"/>
                                </div>
                            </td>
                        </tr>
                        <tr style="font-size:9pt; height:20px">
                            <td style="padding-left:15px">
                                켐페인 리스트
                            </td>
                            <td style="width:320px; text-align:right;">
                                <asp:DropDownList ID="ddlSearchDate" runat="server" AutoPostBack="true">
                                    <asp:ListItem Value="0">전체</asp:ListItem>
                                    <asp:ListItem Value="1">금월</asp:ListItem>
                                    <asp:ListItem Value="2">1개월전</asp:ListItem>
                                    <asp:ListItem Value="3">2개월전</asp:ListItem>
                                    <asp:ListItem Value="4">3개월전</asp:ListItem>
                                    <asp:ListItem Value="5">4개월전</asp:ListItem>
                                    <asp:ListItem Value="6">5개월전</asp:ListItem>
                                    <asp:ListItem Value="7">6개월전</asp:ListItem>
                                    <asp:ListItem Value="8">7개월전</asp:ListItem>
                                    <asp:ListItem Value="9">8개월전</asp:ListItem>
                                    <asp:ListItem Value="10">9개월전</asp:ListItem>
                                    <asp:ListItem Value="11">10개월전</asp:ListItem>
                                    <asp:ListItem Value="12">11개월전</asp:ListItem>
                                    <asp:ListItem Value="13">12개월전</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr style="font-size:9pt; ">
                            <td style="padding-left:15px" colspan="2">
                                <table cellpadding="0" cellspacing="0" style="width:100%; background-color:#F6F6F6; border-top-style:solid;border-bottom-style:solid; border-width:1px">
                                    <tr >
                                        <td class="topfield_cell" style="width:169px">켐페인명</td>
                                        <td class="topfield_cell" style="width:152px">등록일</td>
                                        <td class="topfield_cell" style="width:100px">API요청</td>
                                    </tr>
                                </table>
                                <asp:GridView ID="gvContent" runat="server" CellPadding="0" CellSpacing="0"
                                    AllowPaging="true" AllowSorting="false"
                                    Width="480px"
                                    GridLines="Horizontal"
                                    ShowHeader="false"
                                    AutoGenerateColumns="false"
                                    OnRowCreated="gvContent_RowCreated"
                                    OnPageIndexChanging="gvContent_PageIndexChange" CssClass="grdPopup ">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemStyle Width="169px" HorizontalAlign="Center" />
                                            <ItemTemplate>
                                                <span title='<%#Eval("title") %>'><%#cutString(Convert.ToString(Eval("title")), 10)%></span>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemStyle Width="152px" HorizontalAlign="Center" />
                                            <ItemTemplate>
                                                <%# DataBinder.Eval(Container.DataItem, "regdate", "{0:yyyy/MM/dd}")%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemStyle Width="100px" HorizontalAlign="Center" />
                                            <ItemTemplate>
                                                <%#Eval("api_requests") %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <RowStyle Height="22px" />
                                    <HeaderStyle Height="28px" BackColor="#cccccc" Font-Bold="true" />
                                    <EmptyDataRowStyle VerticalAlign="Middle" />
                                    <EmptyDataTemplate>
                                        <table width="100%" border="0">
                                        <tr>
                                            <td class="clsemptyrow" style="height: 100px">
                                                <asp:Literal ID="Literal1" runat="server" Text="<%$Resources:Str, STR_NODATA %>"></asp:Literal>
                                            </td>
                                        </tr>
                                        </table>
                                    </EmptyDataTemplate>
                                    <PagerSettings Mode="Numeric" Position="Bottom"
                                        FirstPageText="<%$Resources:Str, STR_FIRST %>"
                                        PreviousPageText="<%$Resources:Str, STR_PREV %>"
                                        NextPageText="<%$Resources:Str, STR_NEXT %>"
                                        LastPageText="&nbsp;<%$Resources:Str, STR_LAST %>"
                                        PageButtonCount="10" />
                                    <PagerStyle CssClass="clspager" Height="30px" HorizontalAlign="Center" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="right" style="height:35px;padding-right:5px">
                    <input type="button" value="확인" style="width:62px; height:33px; font-size:12pt; "
                        onclick="closeDivPop()" />
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
