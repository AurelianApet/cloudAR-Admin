<%@ Page Title="" Language="C#" MasterPageFile="~/Manager/Account.master" AutoEventWireup="true" CodeBehind="trafficdetail.aspx.cs" Inherits="nocutAR.Manager.trafficdetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .clsMarkerHeader
        {
            width:78px;
            height:40px;
            background-color:#D0D5DE;
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
            width:78px;
            height:46px;
            border-width:1px;
            border-color:rgb(239,239,239);
            border-style:solid;
            background-color:#D0D5DE;
            text-align:center;
            font-size:11pt;
            font-family:돋움;
            color:#333333;
        }
    </style>
    <asp:Literal ID="ltlData" runat="server"> <script type="text/javascript">
            var graphdata = "";
        </script></asp:Literal>

    <script>
        $(document).ready(function () {
            selTopMenu(1);
            selLeftMenu(3);
        });
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
                            return (this.value+1) + "월";
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:HiddenField runat="server" ID="hfdID" />
    <table cellpadding="0" cellspacing="0" bgcolor="#4E5867" width="1010">
        <tr>
            <td width="1010" height="45">
                <table cellpadding="0" cellspacing="0" align="center" width="983">
                    <tr>
                        <td width="497" height="37">
                            <p><span style="font-size:12pt;"><font face="돋움" color="white"><b>&nbsp;&nbsp;</b></font></span><b><font face="돋움" color="white"><span style="font-size:11pt;">이용현황 상세</span></font></b></p>
                        </td>
                        <td width="486" height="37">
                            <div align="right">
                            <table cellpadding="0" cellspacing="0" width="323">
                                <tr>
                                    <td width="72" height="31">
                                        <asp:DropDownList ID="ddlSearchKey" CssClass="control" Width="72px" runat="server">
                                            <asp:ListItem Value="0">회사(고객명)</asp:ListItem>
                                            <asp:ListItem Value="1">로그인ID</asp:ListItem>
                                            <asp:ListItem Value="2">담당자</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td width="170" height="31" align="center">
                                        <asp:TextBox ID="txtSearchKey" CssClass="control" MaxLength="20"  Width="170px" runat="server"></asp:TextBox>
                                    </td>
                                    <td width="81" height="31">
                                        <table cellpadding="0" cellspacing="0" width="76" bgcolor="#33B5E5" align="center">
                                            <tr>
                                                <td width="76" height="22" align="center">
                                                    <asp:Button ID="btnSearch" runat="server"  CssClass="clsButton" Width="76px"
                                                        Text="검색" onclick="btnSearch_Click" />
                                                </td>
                                            </tr>
                                        </table>
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
    <table cellpadding="0" cellspacing="0">
        <tr>
            <td width="1010" height="25">&nbsp;</td>
        </tr>
    </table>
    <table cellpadding="0" cellspacing="0" align="center" bgcolor="#D0D5DE" width="1008">
        <tr>
            <td width="1008" height="60">
                <table cellpadding="0" cellspacing="0" align="center" width="980">
                    <tr>
                        <td width="170" height="35"><b><font face="돋움" color="#67707E"><span style="font-size:11pt;">유저명</span></font></b></td>
                        <td width="810" height="35">
                            <div align="right">
                                <p align="left"><b><font face="돋움" color="#67707E"><span style="font-size:11pt;"><asp:Literal runat="server" ID="ltrCompany"></asp:Literal></span></font></b></p>
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table cellpadding="0" cellspacing="0">
        <tr>
            <td width="1010" height="15"></td>
        </tr>
    </table>
    <table cellpadding="0" cellspacing="0" align="center" width="1006">
        <tr>
            <td width="335" height="60">
                <table cellpadding="0" cellspacing="0" width="330" bgcolor="#D0D5DE">
                    <tr>
                        <td width="330" height="60">
                            <table cellpadding="0" cellspacing="0" align="center" width="303">
                                <tr>
                                    <td width="157" height="35">
                                        <p><b><font face="돋움" color="#67707E"><span style="font-size:11pt;">등록된 마커(금월)</span></font></b></p>
                                    </td>
                                    <td width="146" height="35" align="center">
                                        <b><font face="돋움" color="#67707E"><span style="font-size:20pt;"><asp:Literal runat="server" ID="ltrMarkers"></asp:Literal></span></font></b>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="333" height="60">
                <table cellpadding="0" cellspacing="0" width="330" bgcolor="#D0D5DE" align="center">
                    <tr>
                        <td width="330" height="60">
                            <table cellpadding="0" cellspacing="0" align="center" width="300">
                                <tr>
                                    <td width="109" height="35">
                                        <p><b><font face="돋움" color="#67707E"><span style="font-size:11pt;">API요청(금월)</span></font></b></p>
                                    </td>
                                    <td width="191" height="35" align="right">
                                        <b><font face="돋움" color="#67707E"><span style="font-size:20pt;"><asp:Literal runat="server" ID="ltrScans"></asp:Literal></span></font></b>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="338" height="60">
                <div align="right">
                <table cellpadding="0" cellspacing="0" width="330" bgcolor="#D0D5DE">
                    <tr>
                        <td width="330" height="60">
                            <table cellpadding="0" cellspacing="0" align="center" width="300">
                                <tr>
                                    <td width="77" height="35">
                                        <b><font face="돋움" color="#67707E"><span style="font-size:11pt;">이용기간</span></font></b>
                                    </td>
                                    <td width="223" height="35" align="right">
                                        <b><font face="돋움" color="#67707E"><span style="font-size:11pt;"><asp:Literal runat="server" ID="ltrDate"></asp:Literal></span></font></b>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                </div>
            </td>
        </tr>
    </table>
    <table cellpadding="0" cellspacing="0">
        <tr>
            <td width="1010" height="15"></td>
        </tr>
    </table>
    <table cellpadding="0" cellspacing="0" align="center" width="1006">
        <tr>
            <td width="335" height="60">
                <table cellpadding="0" cellspacing="0" width="330" bgcolor="#D0D5DE">
                    <tr>
                        <td width="330" height="60">

                            <table cellpadding="0" cellspacing="0" align="center" width="277">
                                <tr>
                                    <td width="93" height="35" align="center">
                                        <asp:Literal runat="server" ID="ltrCondition"></asp:Literal>
                                    </td>
                                    <td width="184" height="35" align="center">
                                        <b><font face="돋움" color="#67707E"><span style="font-size:16pt;"><asp:Literal runat="server" ID="ltrStatus"></asp:Literal></span></font></b>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="671" height="60">
                <table cellpadding="0" cellspacing="0" align="center" width="639">
                    <tr>
                        <td width="160" height="28">
                            <p><b><font face="돋움" color="#67707E"><span style="font-size:11pt;">사용중인 하드용량</span></font></b></p>
                        </td>
                        <td width="479" height="28">
                            <table cellpadding="0" cellspacing="0" width="476" style="border-collapse:collapse;">
                                <tr>
                                    <td width="474" height="20" style="border-width:1px; border-color:rgb(191,192,195); border-style:solid;">
                                        <table cellpadding="0" cellspacing="0" width="474" runat="server" id="tdHard">
                                            <tr>
                                                <td width="100%" height="20" bgcolor="#33B5E6"></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <div style="margin-top:-18px;"><b><font face="돋움" color="#67707E"><span style="font-size:11pt;"><asp:Literal runat="server" ID="tdHard_div"></asp:Literal></span></font></b></div>
                        </td>
                    </tr>
                    <tr>
                        <td width="160" height="28">
                            <p><b><font face="돋움" color="#67707E"><span style="font-size:11pt;">사용된 트레픽(금월)</span></font></b></p>
                        </td>
                        <td width="479" height="28">
                            <table cellpadding="0" cellspacing="0" width="476" style="border-collapse:collapse;">
                                <tr>
                                    <td width="474" height="20" style="border-width:1px; border-color:rgb(191,192,195); border-style:solid;">
                                        <table cellpadding="0" cellspacing="0" width="474" runat="server" id="tdTraffic">
                                            <tr>
                                                <td width="100%" height="20" bgcolor="#33B5E6"></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <div style="margin-top:-18px;"><b><font face="돋움" color="#67707E"><span style="font-size:11pt;"><asp:Literal runat="server" ID="tdTraffic_div"></asp:Literal></span></font></b></div>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <p>&nbsp;</p>
    <table cellpadding="0" cellspacing="0" align="center" bgcolor="#4E5867" width="1010">
        <tr>
            <td width="1010" height="40">
                <table cellpadding="0" cellspacing="0" align="center" width="980">
                    <tr>
                        <td width="453" height="35"><span style="font-size:11pt;"><font face="돋움" color="white"><b>&nbsp;&nbsp;등록한 마커수</b></font></span></td>
                        <td width="527" height="35">
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
    <table cellpadding="0" cellspacing="0">
        <tr>
            <td width="1010" height="15"></td>
        </tr>
    </table>
    <table cellpadding="0" cellspacing="0" width="1010" style="border-collapse:collapse;">
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
    <p>&nbsp;</p>
    <table cellpadding="0" cellspacing="0" align="center" bgcolor="#4E5867" width="1010">
        <tr>
            <td width="1010" height="40">
                <table cellpadding="0" cellspacing="0" align="center" width="980">
                    <tr>
                        <td width="453" height="35"><span style="font-size:11pt;"><font face="돋움" color="white"><b>&nbsp;&nbsp;월간 스캔수</b></font></span></td>
                        <td width="527" height="35">
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
    <table cellpadding="0" cellspacing="0">
        <tr>
            <td width="1010" height="304" valign="bottom">
                <div style="width:1010px; height: 304px; overflow: hidden">
                    <div id="container" style="min-width: 1010px; height: 354px; margin: 0"></div>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
