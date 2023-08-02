<%@ Page Title="" Language="C#" MasterPageFile="~/Account/MemberShip.master" AutoEventWireup="true" CodeBehind="campainhist.aspx.cs" Inherits="nocutAR.Account.campainhist" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        $(document).ready(function () {
            selLeftMenu(1);
        });
    </script>
    <asp:Literal ID="ltlData" runat="server">
        <script type="text/javascript">
            var graphdata = "";
        </script>
    </asp:Literal>
    <style >
        .clsMarkerHeader
        {
            width:83px;
            height:40px;
            background-color:#C2C6CF;
            border-width:1px;
            border-color:rgb(239,239,239);
            border-style:solid;
            text-align:center;
            font-weight:bold;
            font-size:11pt;
            font-family:돋움;
            color:#67707E;
        }
        .clsMarkerData
        {
            width:83px;
            height:46px;
            border-width:1px;
            border-color:rgb(239,239,239);
            border-style:solid;
            background-color:#D9DCE2;
            text-align:center;
            font-size:11pt;
            font-family:돋움;
            color:#333333;
        }
    </style>
    <script>
        function onShowMarker(marker) {
            url = "\\markers\\" + marker;
            $("#imgMarker").attr("src", url);
            showPopup("dvPreviewMarker");
        }
        $(function () {
            $('#container').highcharts({
                chart: {
                    type: 'column'
                },
                title: {
                    text: ''
                },
                subtitle: {
                    text: ''
                },
                xAxis: {
                    min: 0,
                    allowDecimals: false,
                    labels: {
                        formatter: function () {
                            return (this.value + 1) + "월";
                        }
                    }
                },
                yAxis: {
                    enabled: false,
                    title: {
                        text: ''
                    },
                    labels: {
                        formatter: function () {
                            return this.value;
                        }
                    },
                    min: 0
                },
                tooltip: {
                    enabled: false,
                    pointFormat: '{point.y}'
                },
                plotOptions: {
                    area: {
                        pointStart: 0,
                        marker: {
                            enabled: false,
                            symbol: 'circle',
                            radius: 0,
                            states: {
                                hover: {
                                    enabled: false
                                }
                            }
                        }
                    }
                },
                series: [{
                    color: '#33B5E6',
                    name: '',
                    data: graphdata,
                    dataLabels: {
                        enabled: true,
                        rotation: 0,
                        color: '#FFFFFF',
                        align: 'center',
                        //format: '{point.y:.1f}', // one decimal
                        y: 30, // 10 pixels down from the top
                        style: {
                            fontSize: '10pt',
                            fontFamily: '돋움'
                        }
                    }
                }]
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderSearch" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<asp:HiddenField runat="server" ID="hfdID" />
<div>
<table cellpadding="0" cellspacing="0" width="1091" align="center" bgcolor="#F7F8F8" style="border-collapse:collapse;">
    <tr>
        <td width="1089" height="55" style="border-width:1px; border-top-color:black; border-right-color:black; border-bottom-color:rgb(229,233,235); border-left-color:black; border-top-style:none; border-right-style:none; border-bottom-style:solid; border-left-style:none;" valign="bottom">
            <table cellpadding="0" cellspacing="0" align="center" width="1068">
                <tr>
                    <td width="652" height="47">
                        <table cellpadding="0" cellspacing="0" width="630">
                            <tr>
                                <td width="26" height="37">&nbsp;</td>
                                <td width="198" height="37"><b><font face="돋움" color="#666666"><span style="font-size:12pt;">등록한 캠페인</span></font></b></td>
                                <td width="172" height="37">&nbsp;</td>
                                <td width="234" height="37">&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                    <td width="416" height="47">
                        <div align="right">&nbsp;</div>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td width="1089" height="1187" align="center" valign="top" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-top-style:solid; border-right-style:none; border-bottom-style:none; border-left-style:none;">
            <br /><br />
            <table cellpadding="0" cellspacing="0" align="center" width="1041">
                <tr>
                    <td width="1041" height="40">
                        <table cellpadding="0" cellspacing="0" align="center" width="1016">
                            <tr>
                                <td width="453" height="35"><span style="font-size:11pt;"><b><font face="돋움" color="#727272">&nbsp;등록한 마커수</font></b></span></td>
                                <td width="563" height="35">
                                    <div align="right">
                                        <table cellpadding="0" cellspacing="0" width="302">
                                            <tr>
                                                <td width="302" height="31" align="right">
                                                    <asp:DropDownList ID="ddlMarkers" CssClass="control" Width="72px"
                                                        runat="server" onselectedindexchanged="ddlMarkers_SelectedIndexChanged" AutoPostBack="true">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" width="1020" style="border-collapse:collapse;" align="center">
                <tr>
                    <td class="clsMarkerHeader">1월</td>
                    <td class="clsMarkerHeader">2월</td>
                    <td class="clsMarkerHeader">3월</td>
                    <td class="clsMarkerHeader">4월</td>
                    <td class="clsMarkerHeader">5월</td>
                    <td class="clsMarkerHeader">6월</td>
                    <td class="clsMarkerHeader">7월</td>
                    <td class="clsMarkerHeader">8월</td>
                    <td class="clsMarkerHeader">9월</td>
                    <td class="clsMarkerHeader">10월</td>
                    <td class="clsMarkerHeader">11월</td>
                    <td class="clsMarkerHeader">12월</td>
                </tr>
                <tr>
                    <td class="clsMarkerData"><asp:Literal runat="server" ID="ltrMarker1"></asp:Literal></td>
                    <td class="clsMarkerData"><asp:Literal runat="server" ID="ltrMarker2"></asp:Literal></td>
                    <td class="clsMarkerData"><asp:Literal runat="server" ID="ltrMarker3"></asp:Literal></td>
                    <td class="clsMarkerData"><asp:Literal runat="server" ID="ltrMarker4"></asp:Literal></td>
                    <td class="clsMarkerData"><asp:Literal runat="server" ID="ltrMarker5"></asp:Literal></td>
                    <td class="clsMarkerData"><asp:Literal runat="server" ID="ltrMarker6"></asp:Literal></td>
                    <td class="clsMarkerData"><asp:Literal runat="server" ID="ltrMarker7"></asp:Literal></td>
                    <td class="clsMarkerData"><asp:Literal runat="server" ID="ltrMarker8"></asp:Literal></td>
                    <td class="clsMarkerData"><asp:Literal runat="server" ID="ltrMarker9"></asp:Literal></td>
                    <td class="clsMarkerData"><asp:Literal runat="server" ID="ltrMarker10"></asp:Literal></td>
                    <td class="clsMarkerData"><asp:Literal runat="server" ID="ltrMarker11"></asp:Literal></td>
                    <td class="clsMarkerData"><asp:Literal runat="server" ID="ltrMarker12"></asp:Literal></td>
                </tr>
            </table>
            <br /><br />
            <table cellpadding="0" cellspacing="0" align="center" width="1041">
                <tr>
                    <td width="1041" height="40">
                        <table cellpadding="0" cellspacing="0" align="center" width="1016" style="border-collapse:collapse;">
                            <tr>
                                <td width="453" height="35" style="border-width:1px; border-top-color:black; border-right-color:black; border-bottom-color:rgb(153,153,153); border-left-color:black; border-top-style:none; border-right-style:none; border-bottom-style:solid; border-left-style:none;"><span style="font-size:11pt;"><b><font face="돋움" color="#727272">&nbsp;월간 스캔수</font></b></span></td>
                                <td width="563" height="35" style="border-width:1px; border-top-color:black; border-right-color:black; border-bottom-color:rgb(153,153,153); border-left-color:black; border-top-style:none; border-right-style:none; border-bottom-style:solid; border-left-style:none;">
                                    <div align="right">
                                        <table cellpadding="0" cellspacing="0" width="302">
                                            <tr>
                                                <td width="302" height="31" align="right">
                                                    <asp:DropDownList ID="ddlScans" CssClass="control" Width="72px" runat="server"
                                                        onselectedindexchanged="ddlScans_SelectedIndexChanged" AutoPostBack="true">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;">
                <tr>
                    <td width="1010" height="304" valign="bottom" style="border-width:1px; border-top-color:black; border-right-color:black; border-bottom-color:rgb(153,153,153); border-left-color:black; border-top-style:none; border-right-style:none; border-bottom-style:solid; border-left-style:none;">
                        <div style="width:1010px; height: 304px; overflow: hidden">
                            <div id="container" style="min-width: 1010px; height: 354px; margin: 0"></div>
                        </div>
                    </td>
                </tr>
            </table>
            <br /><br />
            <table cellpadding="0" cellspacing="0" align="center" width="1041">
                <tr>
                    <td width="1041" height="40">
                        <table cellpadding="0" cellspacing="0" align="center" width="1016" style="border-collapse:collapse;">
                            <tr>
                                <td width="453" height="35" style="border-width:1px; border-top-color:black; border-right-color:black; border-bottom-color:rgb(153,153,153); border-left-color:black; border-style:none;"><span style="font-size:11pt;"><b><font face="돋움" color="#727272">&nbsp;캠페인 리스트</font></b></span></td>
                                <td width="563" height="35" style="border-width:1px; border-top-color:black; border-right-color:black; border-bottom-color:rgb(153,153,153); border-left-color:black; border-style:none;"></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <asp:GridView ID="gvContent" runat="server" CellPadding="0" CellSpacing="0"
                AllowPaging="true" AllowSorting="false"
                Width="1008px"
                GridLines="None"
                AutoGenerateColumns="false"
                OnRowDataBound="gvContent_RowDataBound"
                OnPageIndexChanging="gvContent_PageIndexChange" CssClass="clsGrid">
                <Columns>
                    <asp:TemplateField HeaderText="번호">
                        <ItemTemplate>
                            <%#Container.DataItemIndex + 1%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Width="73px" Wrap="false" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="캠페인명">
                        <ItemTemplate>
                            <%#Eval("title") %>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Width="254px" Wrap="false" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="등록일▼">
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem, "regdate", "{0:yyyy-MM-dd HH:mm}")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Width="146px" Wrap="false" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="최종수정일">
                        <ItemTemplate>
                            <%# DataBinder.Eval(Container.DataItem, "changedate", "{0:yyyy-MM-dd HH:mm}")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Width="141px" Wrap="false" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="마커">
                        <ItemTemplate>
                            <input type="button" class="clsBigButton" value="미리보기" onclick='onShowMarker("<%#Eval("marker_url") %>")' style="width:76px; height:22px"/>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Width="139px" Wrap="false" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="등록한<br/>오브젝트">
                        <ItemTemplate>
                            <asp:Literal ID="ltrObjCount" runat="server"></asp:Literal>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Width="143px" Wrap="false" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="스캔수">
                        <ItemTemplate>
                            <%#Eval("api_requests")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Width="115px" Wrap="false" />
                    </asp:TemplateField>
                </Columns>
                <RowStyle CssClass="clsGrid" Height="50px"/>
                <SelectedRowStyle CssClass="clsSelGrid" Height="50px" />
                <AlternatingRowStyle CssClass="clsSelGrid" />
                <HeaderStyle CssClass="clsGridHeader" Height="35px"/>
                <EmptyDataRowStyle VerticalAlign="Middle" />
                <EmptyDataTemplate>
                    <table width="100%" border="0">
                    <tr>
                        <td class="clsemptyrow" style="height: 350px">
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
                <PagerStyle CssClass="clspager" HorizontalAlign="Center" />
            </asp:GridView>
        </td>
    </tr>
</table>
</div>
<div id="dvPreviewMarker" class="clspopup">
<table cellpadding="0" cellspacing="0" width="530" style="border-collapse:collapse;" bgcolor="#F0F0F0">
    <tr>
        <td width="100%" height="40" style="border-width:1px; border-color:rgb(216,216,216); border-style:solid;" bgcolor="#D8D8D8">
            <table cellpadding="0" cellspacing="0" align="center" width="485">
                <tr>
                    <td width="50%" height="36"><b><font face="돋움" color="#4C4C4C"><span style="font-size:11pt;">마커확인</span></font></b></td>
                    <td width="50%" height="36" align="right">
                        <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="20" height="20" border="0" name="image1">
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td width="528" height="476" align="center" valign="middle" style="border-width:1px; border-color:rgb(216,216,216); border-style:solid;" bgcolor="#F6F6F6">
            <img id="imgMarker" alt="" />
        </td>
    </tr>
</table>
</div>
</asp:Content>
