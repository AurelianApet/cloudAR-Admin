<%@ Page Title="" Language="C#" MasterPageFile="~/Account/UserPage.Master" AutoEventWireup="true"
    CodeBehind="detailContent.aspx.cs" Inherits="nocutAR.Account.detailContent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="/Scripts/detailcontents_opt.js" type="text/javascript"></script>
    <script src="/Scripts/init_obj.js" type="text/javascript"></script>
    <script src="/Scripts/edit_obj.js" type="text/javascript"></script>
    <script src="/Scripts/toolbar.js" type="text/javascript"></script>
    <asp:Literal ID="ltlScript" runat="server" Text=""></asp:Literal>
    <script type="text/javascript">
        var objName = "";
        var imgList = new Array();
        var slideList = new Array();
        var webList = new Array();
        var videoList = new Array();
        var captureList = new Array();
        var threeList = new Array();
        var telList = new Array();
        var googlemapList = new Array();
        var notepadList = new Array();
        var audioList = new Array();
        var chromakeyList = new Array();
        var pdfList = new Array();
        var linkvideoList = new Array();
        counter = 0;
        video_counter = 0;
        web_counter = 0;
        img_counter = 0;
        slide_counter = 0;
        capture_counter = 0;
        three_counter = 0;
        tel_counter = 0;
        googlemap_counter = 0;
        notepad_counter = 0;
        audio_counter = 0;
        chromakey_counter = 0;
        capprev_counter = 0;
        pdf_counter = 0;
        linkvideo_counter = 0;
        var addIndex = 0;
        var prevIndex = 0;
        var capCount = 0;
        var capprevIndex = 0;
        $(document).ready(function () {
            selTopMenu(4);
            $("#txtTitle").val(CAMPAIN_NAME);


            //이용상품에 따라 오브젝트 현시
            $.ajax({
                url: "getUseProduct.aspx",
                dataType: 'json',
                async: false,
                type: 'POST',
                success: function (data) {
                    HideProgress();
                    var iVideo_obj = data.video_obj;
                    var iWeb_obj = data.web_obj;
                    var iImage_obj = data.image_obj;
                    var iSlide_obj = data.slide_obj;
                    var iCapture_obj = data.capture_obj;
                    var iThree_model_obj = data.three_model_obj;
                    var iTel_obj = data.tel_obj;
                    var iGooglemap_obj = data.googlemap_obj;
                    var iNotepad_obj = data.notepad_obj;
                    var iBgm_obj = data.bgm_obj;
                    var iChromakey = data.chromakey_obj;
                    var iThreeTemplate = data.three_template;
                    var iLinkvideo_obj = data.linkvideo_obj;
                    var iPdf_obj = data.pdf_obj;
                    var iSns = data.sns;

                    onShowTrMenu("trLeftmenu1", iVideo_obj);
                    onShowTrMenu("trLeftmenu2", iImage_obj);
                    onShowTrMenu("trLeftmenu3", iWeb_obj);
                    onShowTrMenu("trLeftmenu4", iTel_obj);
                    onShowTrMenu("trLeftmenu5", iGooglemap_obj);
                    onShowTrMenu("trLeftmenu6", iNotepad_obj);
                    onShowTrMenu("trLeftmenu7", iBgm_obj);
                    onShowTrMenu("trLeftmenu8", iSlide_obj);
                    onShowTrMenu("trLeftmenu9", iCapture_obj);
                    onShowTrMenu("trLeftmenu10", iChromakey);
                    onShowTrMenu("trLeftmenu11", iThree_model_obj);
                    onShowTrMenu("trLeftmenu12", iPdf_obj);
                    onShowTrMenu("trLeftmenu13", iLinkvideo_obj);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HideProgress();
                    alert("이용상품이 없습니다. 상품을 구입해주세요.");
                    document.location = "CampainList.aspx";
                }
            });
            init_mark();

            selLeftMenu(0);
            capprevdrop();
        });

        function onToggleGrid() {
            if ($("#dvGrid").css("display") == "none")
                $("#dvGrid").css("display", "");
            else
                $("#dvGrid").css("display", "none");
        }
        
        
        function OnBack() {
            document.location = "CampainList.aspx";
        }

        function setMarkerImg(marker_url) {
            $.ajax({
                url: "setMarkerData.aspx?marker_url=" + encodeURI(marker_url) + "&id=" + CONTENT_ID,
                type: 'POST',
                success: function (data) {
                    //alert("마커이미지가 등록되었 습니다. 관리자의 승인이 있을때까지 기다려주십시오.");

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("error");
                }
            });
        }
        function onShowTrMenu(ctrl, value) {
            $("#" + ctrl).css("display", value == 1 ? "" : "none");
        }

        function onRegMarker() {
            showPopup("dvRegMarker");
        }

        function selLeftMenu(id) {
            if (id == 0) {
                $("#trMenu1r").css("display", "");
                $("#trMenu1").css("display", "none");
                $("#trMenu2r").css("display", "none");
                $("#trMenu2").css("display", "");
                $("#tblMenu2").css("display", "none");
            }
            else {
                if ($("#markImg").attr("src") == "") {
                    alert("마커를 등록하셔야 합니다.");
                    return;
                }
                $("#trMenu1r").css("display", "none");
                $("#trMenu1").css("display", "");
                $("#trMenu2r").css("display", "");
                $("#trMenu2").css("display", "none");
                $("#tblMenu2").css("display", "");
            }
        }
        function onRegMarkerImg() {
            //파일 유무체크
            if ($("#fileImg").val() == "") {
                "마커 파일을 지정하세요.";
                return false;
            }
            //확장자체크
            if (!checkImgExtention("fileImg", "img")) {
                return false;
            }
            //용량체크
            /***확장자체크***/
            var file = document.getElementById("fileImg");
            if (file.files[0] != null) {
                /*용량제한*/
                if ((file.files[0].size / 1053317.6) > 5) {
                    alert("5MB 이상의 이미지는 등록하실수 없습니다.");
                    return false;
                }
                
                $("#dvRegMarker").css("display", "none");
                showPopupUpload();

                //create new FormData instance to transfer as Form Type
                var data = new FormData();
                // add the file intended to be upload to the created FormData instance
                data.append("upfile", file.files[0]);
                setTimeout(function () {
                    $.ajax({
                        url: 'PostUpload.aspx?type=0&content_id=' + CONTENT_ID,
                        type: "post",
                        data: data,
                        // cache: false,
                        processData: false,
                        contentType: false,
                        async: false,
                        success: function (data, textStatus, jqXHR) {
                            $("#markImg").attr("src", data);
                            $("#editframe").css("display", "");
                            $("#req_cover").css("display", "none");

                            $("#markImg").one("load", function () {
                                $(".markdiv").css({ "width": document.getElementById("markImg").width });
                                hidePopupUpload();
                                closePopup();
                                selLeftMenu(1);
                            }).each(function () {
                                if (this.complete) $(this).load();
                            });
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            HideProgress();
                            alert("마커이미지 등록과정에 오류가 발생하였습니다.");
                        }
                    });
                }, 500);
            }
        }

        function onVideoRun_rd(type) {
            if (type == 0 || type == 1) {
                //버튼사용안함
                $(".trNorVideoMode").css("display", "none");
                $(".trCustomVideoMode").css("display", "none");
            }
            else if (type == 2) {
                //비디오 재생버튼
                $(".trNorVideoMode").css("display", "");
                $(".trCustomVideoMode").css("display", "none");
            } else if (type == 3) {
                //비디오 커스텀버튼
                $(".trNorVideoMode").css("display", "none");
                $(".trCustomVideoMode").css("display", "");
            }
        }

        function onPdfRun_rd(type) {
            if (type == 0) {
                //버튼사용안함
                $(".trNorPdfMode").css("display", "none");
                $(".trCustomPdfMode").css("display", "none");
            }
            else if (type == 1) {
                //이미지 재생버튼
                $(".trNorPdfMode").css("display", "");
                $(".trCustomPdfMode").css("display", "none");
            } else if (type == 2) {
                //이미지 커스텀버튼
                $(".trNorPdfMode").css("display", "none");
                $(".trCustomPdfMode").css("display", "");
            }
        }

        function onImageRun_rd(type) {
            if (type == 0) {
                //버튼사용안함
                $(".trNorImageMode").css("display", "none");
                $(".trCustomImageMode").css("display", "none");
            }
            else if (type == 1) {
                //이미지 재생버튼
                $(".trNorImageMode").css("display", "");
                $(".trCustomImageMode").css("display", "none");
            } else if (type == 2) {
                //이미지 커스텀버튼
                $(".trNorImageMode").css("display", "none");
                $(".trCustomImageMode").css("display", "");
            }
        }

        function onSlideRun_rd(type) {
            if (type == 0) {
                //버튼사용안함
                $(".trNorSlideMode").css("display", "none");
                $(".trCustomSlideMode").css("display", "none");
            }
            else if (type == 1) {
                //이미지 재생버튼
                $(".trNorSlideMode").css("display", "");
                $(".trCustomSlideMode").css("display", "none");
            } else if (type == 2) {
                //이미지 커스텀버튼
                $(".trNorSlideMode").css("display", "none");
                $(".trCustomSlideMode").css("display", "");
            }
        }

        function onChromakeyRun_rd(type) {
            if (type == 0 || type == 1) {
                //버튼사용안함
                $(".trNorChromakeyMode").css("display", "none");
                $(".trCustomChromakeyMode").css("display", "none");
            }
            else if (type == 2) {
                //이미지 재생버튼
                $(".trNorChromakeyMode").css("display", "");
                $(".trCustomChromakeyMode").css("display", "none");
            } else if (type == 3) {
                //이미지 커스텀버튼
                $(".trNorChromakeyMode").css("display", "none");
                $(".trCustomChromakeyMode").css("display", "");
            }
        }

        function onSetBoardStatus() {
            var is_board = 0;
            if ($('#cbxBoardStatus').is(":checked")) {
                is_board = 1;
            }

            $.ajax({
                url: "setBoardStatus.aspx?is_board=" + is_board + "&id=" + CONTENT_ID,
                type: 'POST',
                success: function (data) {
                    //alert("게시판 on/off 상태가 정확히 등록되었습니다.");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("게시판 on/off 상태 등록시 오류가 발생하였습니다.");
                }
            });
        }

        function onToggleHelp() {
            showPopup("dvToggleHelp");
        }

        function onCampainDescription() {
            showPopup("dvCampainDescription");
        }

        function onApplyCampainDescription() {
            var description = $('#campain_description').val();

            $.ajax({
                url: "setCampainDescription.aspx?description=" + description + "&id=" + CONTENT_ID,
                type: 'POST',
                success: function (data) {
                    //alert("캠페인설명이 정확히 등록되었습니다.");
                    if (description == "") {
                        $("#img_cam_description").attr("src", "img/cam_description1.png");
                    } else {
                        $("#img_cam_description").attr("src", "img/cam_description2.png");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("캠페인설명 등록시 오류가 발생하였습니다.");
                }
            });
            closePopup();

        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderSearch" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input type="hidden" id="edtObjID" />
    <div>
        <table cellpadding="0" cellspacing="0" width="1320" align="center" background="img/top_bg02.png">
            <tr>
                <td width="1327" height="71" align="left">
                    <table cellpadding="0" cellspacing="0" width="1315">
                        <tr>
                            <td width="652" height="71" align="left">
                                <table cellpadding="0" cellspacing="0" width="638">
                                    <tr>
                                        <td width="299" height="71">
                                            <img src="img/cam_menutitle.png" width="224" height="71" border="0">
                                        </td>
                                        <td width="339" height="71">
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="663" height="71" align="right">
                                <table cellpadding="0" cellspacing="0" width="240">
                                    <tr>
                                        <td width="120" height="35">
                                            <input id="btnSave" type="button" value="저장" onclick="OnSave()" class="cls99Button"
                                                style="width: 110px; height: 27px;" />
                                        </td>
                                        <td width="120" height="35">
                                            <input id="btnBack" type="button" value="나가기" class="cls99Button" onclick="OnBack()"
                                                style="width: 110px; height: 27px;" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table cellpadding="0" cellspacing="0" align="center" width="1320" style="border-collapse: collapse;">
            <tr>
                <td width="223" height="506" bgcolor="white" style="border-top-width: 1px; border-right-width: 2;
                    border-bottom-width: 1px; border-left-width: 1px; border-top-color: black; border-right-color: rgb(224,226,228);
                    border-bottom-color: black; border-left-color: black; border-top-style: none;
                    border-right-style: solid; border-bottom-style: none; border-left-style: none;"
                    valign="top">
                    <table cellpadding="0" cellspacing="0" align="center" width="201">
                        <tr>
                            <td width="35" height="20">
                                &nbsp;
                            </td>
                            <td width="107" height="20">
                                &nbsp;
                            </td>
                            <td width="59" height="20">
                                &nbsp;
                            </td>
                        </tr>
                        <tr id="trMenu1r" style="display:none;">
                            <td width="35" height="50">
                                <img src="img/cam_menunum01_r.png" width="26" height="27" border="0">
                            </td>
                            <td width="107" height="50">
                                <span style="font-size: 11pt;"><b><font face="돋움" color="#666666">마커 등록</font></b></span>
                            </td>
                            <td width="59" height="50">
                                &nbsp;
                            </td>
                        </tr>
                        <tr id="trMenu1" style="display:none;">
                            <td width="35" height="50">
                                <img src="img/cam_menunum01.png" class="image-btn" width="26" height="27" border="0">
                            </td>
                            <td width="107" height="50">
                                <span style="font-size: 11pt;"><b><font face="돋움" color="#999999">마커 등록</font></b></span>
                            </td>
                            <td width="59" height="50" align="right">
                                <input type="button" class="cls99Button" value="확인" style="width: 50px; height: 23px"
                                    onclick="selLeftMenu(0)" />
                            </td>
                        </tr>
                        <tr id="trMenu2r" style="display:none;">
                            <td width="35" height="50">
                                <img src="img/cam_menunum02_r.png" width="26" height="27" border="0">
                            </td>
                            <td width="107" height="50">
                                <span style="font-size: 11pt;"><b><font face="돋움" color="#666666">오브젝트 등록</font></b></span>
                            </td>
                            <td width="59" height="50">
                                &nbsp;
                            </td>
                        </tr>
                        <tr id="trMenu2" style="display:none;">
                            <td width="35" height="50">
                                <img src="img/cam_menunum02.png" width="26" height="27" border="0">
                            </td>
                            <td width="107" height="50">
                                <span style="font-size: 11pt;"><b><font face="돋움" color="#999999">오브젝트 등록</font></b></span>
                            </td>
                            <td width="59" height="50" align="right">
                                <input type="button" class="cls99Button" value="수정" style="width: 50px; height: 23px"
                                    onclick="selLeftMenu(1)" />
                            </td>
                        </tr>
                    </table>
                    <table id="tblMenu2" cellpadding="0" cellspacing="0" width="200" align="center">
                        <tr id="trLeftmenu1" style="display:none;">
                            <td width="200" height="50">
                                <div class="clsImagechange" id="imgEditMenu1" onclick="onSelItem(1)">
                                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                                        bgcolor="#F7F7F7">
                                        <tr>
                                            <td class="leftmenu" id="leftmenu1" width="190" height="40">
                                                <table cellpadding="0" cellspacing="0" width="175">
                                                    <tr>
                                                        <td width="35" height="27" align="right">
                                                            <img src="img/cam_icon01.png" width="19" height="19" border="0" />
                                                        </td>
                                                        <td width="140" height="27" align="center">
                                                            Video
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                        <tr id="trLeftmenu13" style="display:none;">
                            <td width="200" height="50">
                                <div class="clsImagechange" id="imgEditMenu13" onclick="onSelItem(13)">
                                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                                        bgcolor="#F7F7F7">
                                        <tr>
                                            <td class="leftmenu" id="leftmenu13" width="190" height="40">
                                                <table cellpadding="0" cellspacing="0" width="175">
                                                    <tr>
                                                        <td width="35" height="27" align="right">
                                                            <img src="img/cam_icon11.png" width="19" height="19" border="0" />
                                                        </td>
                                                        <td width="140" height="27" align="center">
                                                            Link video
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                        <tr id="trLeftmenu2" style="display:none;">
                            <td width="200" height="50">
                                <div class="clsImagechange" id="imgEditMenu2" onclick="onSelItem(2)">
                                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                                        bgcolor="#F7F7F7">
                                        <tr>
                                            <td class="leftmenu" id="leftmenu2" width="190" height="40">
                                                <table cellpadding="0" cellspacing="0" width="175">
                                                    <tr>
                                                        <td width="35" height="27" align="right">
                                                            <img src="img/cam_icon02.png" width="19" height="19" border="0" />
                                                        </td>
                                                        <td width="140" height="27" align="center">
                                                            Image
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                        <tr id="trLeftmenu3" style="display:none;">
                            <td width="200" height="50">
                                <div class="clsImagechange" id="imgEditMenu3" onclick="onSelItem(3)">
                                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                                        bgcolor="#F7F7F7">
                                        <tr>
                                            <td class="leftmenu" id="leftmenu3" width="190" height="40">
                                                <table cellpadding="0" cellspacing="0" width="175">
                                                    <tr>
                                                        <td width="35" height="27" align="right">
                                                            <img src="img/cam_icon03.png" width="19" height="19" border="0" />
                                                        </td>
                                                        <td width="140" height="27" align="center">
                                                            Website
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                        <tr id="trLeftmenu4" style="display:none;">
                            <td width="200" height="50">
                                <div class="clsImagechange" id="imgEditMenu4" onclick="onSelItem(4)">
                                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                                        bgcolor="#F7F7F7">
                                        <tr>
                                            <td class="leftmenu" id="leftmen4" width="190" height="40">
                                                <table cellpadding="0" cellspacing="0" width="175">
                                                    <tr>
                                                        <td width="35" height="27" align="right">
                                                            <img src="img/cam_icon04.png" width="19" height="19" border="0" />
                                                        </td>
                                                        <td width="140" height="27" align="center">
                                                            Phone number
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                        <tr id="trLeftmenu5" style="display:none;">
                            <td width="200" height="50">
                                <div class="clsImagechange" id="imgEditMenu5" onclick="onSelItem(5)">
                                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                                        bgcolor="#F7F7F7">
                                        <tr>
                                            <td class="leftmenu" id="leftmenu5" width="190" height="40">
                                                <table cellpadding="0" cellspacing="0" width="175">
                                                    <tr>
                                                        <td width="35" height="27" align="right">
                                                            <img src="img/cam_icon05.png" width="19" height="19" border="0" />
                                                        </td>
                                                        <td width="140" height="27" align="center">
                                                            Google map
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                        <tr id="trLeftmenu6" style="display:none;">
                            <td width="200" height="50">
                                <div class="clsImagechange" id="imgEditMenu6" onclick="onSelItem(6)">
                                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                                        bgcolor="#F7F7F7">
                                        <tr>
                                            <td class="leftmenu" id="leftmenu6" width="190" height="40">
                                                <table cellpadding="0" cellspacing="0" width="175">
                                                    <tr>
                                                        <td width="35" height="27" align="right">
                                                            <img src="img/cam_icon06.png" width="19" height="19" border="0" />
                                                        </td>
                                                        <td width="140" height="27" align="center">
                                                            TEXT
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                        <tr id="trLeftmenu7" style="display:none;">
                            <td width="200" height="50">
                                <div class="clsImagechange" id="imgEditMenu7" onclick="onSelItem(7)">
                                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                                        bgcolor="#F7F7F7">
                                        <tr>
                                            <td class="leftmenu" id="leftmenu7" width="190" height="40">
                                                <table cellpadding="0" cellspacing="0" width="175">
                                                    <tr>
                                                        <td width="35" height="27" align="right">
                                                            <img src="img/cam_icon07.png" width="19" height="19" border="0" />
                                                        </td>
                                                        <td width="140" height="27" align="center">
                                                            BGM
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                        <tr id="trLeftmenu8" style="display:none;">
                            <td width="200" height="50">
                                <div class="clsImagechange" id="imgEditMenu8" onclick="onSelItem(8)">
                                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                                        bgcolor="#F7F7F7">
                                        <tr>
                                            <td class="leftmenu" id="leftmenu8" width="190" height="40">
                                                <table cellpadding="0" cellspacing="0" width="175">
                                                    <tr>
                                                        <td width="35" height="27" align="right">
                                                            <img src="img/cam_icon08.png" width="19" height="19" border="0" />
                                                        </td>
                                                        <td width="140" height="27" align="center">
                                                            Image slide
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                        <tr id="trLeftmenu9" style="display:none;">
                            <td width="200" height="50">
                                <div class="clsImagechange" id="imgEditMenu9" onclick="onSelItem(9)">
                                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                                        bgcolor="#F7F7F7">
                                        <tr>
                                            <td class="leftmenu" id="leftmenu9" width="190" height="40">
                                                <table cellpadding="0" cellspacing="0" width="175">
                                                    <tr>
                                                        <td width="35" height="27" align="right">
                                                            <img src="img/cam_icon09.png" width="19" height="19" border="0" />
                                                        </td>
                                                        <td width="140" height="27" align="center">
                                                            Chroma-key photo
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                        <tr id="trLeftmenu10" style="display:none;">
                            <td width="200" height="50">
                                <div class="clsImagechange" id="imgEditMenu10" onclick="onSelItem(10)">
                                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                                        bgcolor="#F7F7F7">
                                        <tr>
                                            <td class="leftmenu" id="leftmenu10" width="190" height="40">
                                                <table cellpadding="0" cellspacing="0" width="175">
                                                    <tr>
                                                        <td width="35" height="27" align="right">
                                                            <img src="img/cam_icon10.png" width="19" height="19" border="0" />
                                                        </td>
                                                        <td width="140" height="27" align="center">
                                                            Chroma-key video
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                        <tr id="trLeftmenu11" style="display:none;">
                            <td width="200" height="50">
                                <div class="clsImagechange" id="imgEditMenu11" onclick="onSelItem(11)">
                                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                                        bgcolor="#F7F7F7">
                                        <tr>
                                            <td class="leftmenu" id="leftmenu11" width="190" height="40">
                                                <table cellpadding="0" cellspacing="0" width="175">
                                                    <tr>
                                                        <td width="35" height="27" align="right">
                                                            <img src="img/cam_icon11.png" width="19" height="19" border="0" />
                                                        </td>
                                                        <td width="140" height="27" align="center">
                                                            3D object
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                        <tr id="trLeftmenu12" style="display:none;">
                            <td width="200" height="50">
                                <div class="clsImagechange" id="imgEditMenu12" onclick="onSelItem(12)">
                                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                                        bgcolor="#F7F7F7">
                                        <tr>
                                            <td class="leftmenu" id="leftmenu12" width="190" height="40">
                                                <table cellpadding="0" cellspacing="0" width="175">
                                                    <tr>
                                                        <td width="35" height="27" align="right">
                                                            <img src="img/cam_icon11.png" width="19" height="19" border="0" />
                                                        </td>
                                                        <td width="140" height="27" align="center">
                                                            PDF viewer
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
                <td width="1093" height="721" bgcolor="#F7F8F8" valign="top" style="border-top-width: 1px;
                    border-right-width: 1px; border-bottom-width: 1px; border-left-width: 2; border-top-color: black;
                    border-right-color: black; border-bottom-color: black; border-left-color: rgb(224,226,228);
                    border-top-style: none; border-right-style: none; border-bottom-style: none;
                    border-left-style: solid;">
                    <table cellpadding="0" cellspacing="0" width="1090" align="center" bgcolor="#F7F8F8"
                        style="border-collapse: collapse;">
                        <tr>
                            <td width="1088" height="55" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-top-style: none;
                                border-right-style: none; border-bottom-style: solid; border-left-style: none;"
                                valign="bottom">
                                <table cellpadding="0" cellspacing="0" align="center" width="1068">
                                    <tr>
                                        <td width="652" height="47">
                                            <table cellpadding="0" cellspacing="0" width="630">
                                                <tr>
                                                    <td width="26" height="37">
                                                        &nbsp;
                                                    </td>
                                                    <td width="198" height="37" style="font-weight: bold; font-family: 돋음; color: #666666;
                                                        font-size: 12pt;">
                                                        <input type="text" id="txtTitle" style="border-style: none; background: transparent;
                                                            font-size: 12pt" />
                                                    </td>
                                                    <td width="172" height="37">
                                                        &nbsp;
                                                    </td>
                                                    <td width="234" height="37">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="130" height="47" align="right" style="font-weight: bold; font-family: 돋음; color: #666666; font-size: 12pt;">
                                            <input id="cbxBoardStatus" type="checkbox" onclick="onSetBoardStatus();" />
                                            <label for="cbxBoardStatus">게시판 노출</label>
                                        </td>
                                        <td width="50" height="47" align="left" valign="middle">
                                            <img src="img/cam_help.png" style="cursor:pointer" onclick="onToggleHelp()" width="32"
                                                height="32" border="0" >
                                        </td>
                                        <td width="136" height="47" align="right">
                                            <img id="img_cam_description" src="img/cam_description1.png" onclick="onCampainDescription()" class="image-btn" width="120"
                                                height="32" border="0" >
                                        </td>
                                        <td width="100" height="47" align="right">
                                            <img src="img/cam_grid_bt.png" onclick="onToggleGrid()" class="image-btn" width="75"
                                                height="32" border="0" >
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td id="tdWorkArea" width="1088" height="617" align="center" valign="middle" style="background-repeat: repeat;
                                border-width: 1px; border-top-color: rgb(229,233,235); border-right-color: black;
                                border-bottom-color: black; border-left-color: black; border-top-style: solid;
                                border-right-style: none; border-bottom-style: none; border-left-style: none;position:relative">
                                <div id="dvGrid" style="width:1088px;height:617px;background:url(img/gridback.png); position:absolute;top:0px;z-index:2;display:none" >
                                </div>
                                <div id="editframe" class="markdiv" style="margin-left: auto; margin-right: auto;
                                    z-index: 1px; display: none; position: relative;">
                                    <img id="markImg" class="clsMarkerImg" src="" alt="markerImg" />
                                </div>
                                <div id="req_cover" class="req_cover" style="display: none;">
                                    <table id="tblRegMarker" cellpadding="0" cellspacing="0" width="760" align="center">
                                        <tr>
                                            <td width="760" height="113">
                                                <table cellpadding="0" cellspacing="0" width="411" align="center">
                                                    <tr>
                                                        <td width="411" height="41" align="center">
                                                            <b><font face="돋움" color="#666666"><span style="font-size: 12pt;">마커를 등록하세요.<br><br></span></font></b>
                                                            <div id="req_cover_warning" class="req_cover" style="display: none;">
                                                                <b><font face="돋움" color="#FFOOOO"><span style="font-size: 10pt;">주의:<br> 복사된 캠페인의 경우 원본과 가로세로 사이즈가 <br>같은 마커를 등록해 주세요.<br>마커의 사이즈가 다른경우 오브젝트가 정상적으로 <br>표시 되지 않을 수 있습니다.</span></font></b>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="411" height="50" align="center">
                                                            <input type="button" class="cls99BigButton" style="width: 310px; height: 35px;" value="마커 등록하기"
                                                                onclick="onRegMarker()" />
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
    </div>
    <div id="dvRegMarker" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="557" align="center" style="border-collapse: collapse;"
            bgcolor="white">
            <tr>
                <td width="555" height="148" style="border-width: 1px; border-color: lightgrey; border-style: solid;">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="531">
                        <tr>
                            <td width="529" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="512">
                                    <tr>
                                        <td width="384" height="36">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">마커 등록</span></font></b>
                                        </td>
                                        <td width="128" height="36" align="right">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="529" height="48" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="514">
                                    <tr>
                                        <td width="514" height="41" align="center">
                                            <input type="button" value="파일 선택" onclick="javascript:OnBrowse('fileImg')" /><!--
                                        --><input type="text" id="fileImg_text" size="30" placeholder="선택된 파일 없음" readonly="readonly" />
                                            <input type="file" id="fileImg" name="fileImg" accept="image/png, image/jpeg" class="clsBrowser"
                                                style="display: none" size="49" onchange="document.getElementById('fileImg_text').value=this.value" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="529" height="49" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="521">
                                    <tr>
                                        <td width="521" height="41" align="center">
                                            <input type="button" style="width: 508px; height: 30px;" class="cls99BigButton" value="업로드"
                                                onclick="onRegMarkerImg()" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="dvRegVideo" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="background-color: White">
            <tr>
                <td width="520" height="269" style="border-width: 1px; border-color: rgb(255,102,0);
                    border-style: solid;">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td width="500" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="31">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">비디오&nbsp;편집</span></font></b>
                                        </td>
                                        <td width="91" height="31" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="137" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="487">
                                    <tr>
                                        <td width="110" height="61" align="center" class="clsTitleLabel">
                                            업로드
                                        </td>
                                        <td width="377" height="61" style="padding-left:5px">
                                            <input type="button" value="파일 선택" onclick="javascript:OnBrowse('video_file')" /><!--
                                        --><input type="text" id="video_file_text" size="30" placeholder="wmv, mp4, avi" readonly="readonly" />
                                            <input id="video_file" type="file" name="video_path" accept="video/mp4, video/x-ms-wmv, video/x-msvideo， video/avi" class="clsBrowser" style="display: none" 
                                                size="35" onchange="document.getElementById('video_file_text').value=this.value"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="110" height="76" align="center" class="clsTitleLabel">
                                            실행옵션
                                        </td>
                                        <td width="377" height="76">
                                            <table cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="videorun_rd1" type="radio" name="videorun_rd" title="자동실행" value="0" onclick="onVideoRun_rd(0)" checked/>
                                                        <label for="videorun_rd1">동영상이 자동으로 재생됩니다.(버튼사용 안함)</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="videorun_rd2" type="radio" name="videorun_rd" title="터치시 실행" value="1" onclick="onVideoRun_rd(1)"/>
                                                        <label for="videorun_rd2">동영상이 터치 시 재생됩니다.(버튼사용 안함)</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="videorun_rd3" type="radio" name="videorun_rd" value="2" onclick="onVideoRun_rd(2)"/>
                                                        <label for="videorun_rd3">재생 버튼 사용</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="videorun_rd4" type="radio" name="videorun_rd" value="3" onclick="onVideoRun_rd(3)"/>
                                                        <label for="videorun_rd4">커스텀 버튼 사용</label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>

                                    <tr class="trNorVideoMode">
                                        <td width="110" height="76" align="center" class="clsTitleLabel">
                                            버튼모양
                                        </td>
                                        <td width="361" height="119" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="360">
                                                <tr>
                                                    <td width="180" height="47" id="tdVideoModeBtn1" class="clsModeBtn">
                                                        <table class="btnDefaultWebMode_Web" cellpadding="0" cellspacing="0" align="center"
                                                            onclick="onChangeDefaultVideoBtn('Video',1)" style="cursor: pointer; border-collapse: collapse;"
                                                            bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon01.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">Video</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="180" height="47" id="tdVideoModeBtn2" class="clsModeBtn">
                                                        <table class="btnDefaultWebMode_App" cellpadding="0" cellspacing="0" align="center"
                                                            onclick="onChangeDefaultVideoBtn('영상재생',2)" style="cursor: pointer; border-collapse: collapse;"
                                                            bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon01.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">영상재생</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="180" height="46" id="tdVideoModeBtn3" class="clsModeBtn">
                                                        <table class="btnDefaultWebMode_Direct" cellpadding="0" cellspacing="0" align="center"
                                                            onclick="onChangeDefaultVideoBtn('|>',3)" style="cursor: pointer; border-collapse: collapse;"
                                                            bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon01.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">|></span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="180" height="46" id="tdVideoModeBtn4" class="clsModeBtn">
                                                        <table class="btnDefaultWebMode_Buy" cellpadding="0" cellspacing="0" align="center"
                                                            onclick="onChangeDefaultVideoBtn('PLAY',4)" style="cursor: pointer; border-collapse: collapse;"
                                                            bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon01.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">PLAY</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="trNorVideoMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        버튼색상
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="350">
                                                <tr>
                                                    <td width="35" height="35" id="tdVideoColorBtn11" class="clsColorBtn" onclick="onChangeVideoColor('#FFFFFF',11);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFFFF">
                                                            <tr>
                                                                <td width="23" height="23" style="border:1px solid #DDDDDD;">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdVideoColorBtn1" class="clsColorBtn" onclick="onChangeVideoColor('#DDDDDD',1);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdVideoColorBtn2" class="clsColorBtn" onclick="onChangeVideoColor('#999999',2);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdVideoColorBtn3" class="clsColorBtn" onclick="onChangeVideoColor('black',3);">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="black">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdVideoColorBtn4" class="clsColorBtn" onclick="onChangeVideoColor('#079DEC',4);">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="#079DEC">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdVideoColorBtn5" class="clsColorBtn" onclick="onChangeVideoColor('#1234AB',5);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdVideoColorBtn6" class="clsColorBtn" onclick="onChangeVideoColor('red',6);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdVideoColorBtn7" class="clsColorBtn" onclick="onChangeVideoColor('#FF7700',7);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdVideoColorBtn8" class="clsColorBtn" onclick="onChangeVideoColor('#FFDD00',8);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdVideoColorBtn9" class="clsColorBtn" onclick="onChangeVideoColor('#33AA22',9);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdVideoColorBtn10" class="clsColorBtn" onclick="onChangeVideoColor('#BB33AA',10);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="trNorVideoMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        버튼 글 색상
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="350">
                                                <tr>
                                                    <td width="35" height="35" id="tdVideoTextColorBtn11" class="clsTextColorBtn" onclick="onChangeTextColor('spVideoPreviewText','#FFFFFF','tdVideoTextColorBtn',11,'hdVideoTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFFFF">
                                                            <tr>
                                                                <td width="23" height="23" style="border:1px solid #DDDDDD;">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdVideoTextColorBtn1" class="clsTextColorBtn" onclick="onChangeTextColor('spVideoPreviewText','#DDDDDD','tdVideoTextColorBtn',1,'hdVideoTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdVideoTextColorBtn2" class="clsTextColorBtn" onclick="onChangeTextColor('spVideoPreviewText','#999999','tdVideoTextColorBtn',2,'hdVideoTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdVideoTextColorBtn3" class="clsTextColorBtn" onclick="onChangeTextColor('spVideoPreviewText','black','tdVideoTextColorBtn',3,'hdVideoTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="black">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdVideoTextColorBtn4" class="clsTextColorBtn" onclick="onChangeTextColor('spVideoPreviewText','#079DEC','tdVideoTextColorBtn',4,'hdVideoTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="#079DEC">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdVideoTextColorBtn5" class="clsTextColorBtn" onclick="onChangeTextColor('spVideoPreviewText','#1234AB','tdVideoTextColorBtn',5,'hdVideoTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdVideoTextColorBtn6" class="clsTextColorBtn" onclick="onChangeTextColor('spVideoPreviewText','red','tdVideoTextColorBtn',6,'hdVideoTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdVideoTextColorBtn7" class="clsTextColorBtn" onclick="onChangeTextColor('spVideoPreviewText','#FF7700','tdVideoTextColorBtn',7,'hdVideoTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdVideoTextColorBtn8" class="clsTextColorBtn" onclick="onChangeTextColor('spVideoPreviewText','#FFDD00','tdVideoTextColorBtn',8,'hdVideoTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdVideoTextColorBtn9" class="clsTextColorBtn" onclick="onChangeTextColor('spVideoPreviewText','#33AA22','tdVideoTextColorBtn',9,'hdVideoTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdVideoTextColorBtn10" class="clsTextColorBtn" onclick="onChangeTextColor('spVideoPreviewText','#BB33AA','tdVideoTextColorBtn',10,'hdVideoTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="trNorVideoMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        버튼미리보기
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="316">
                                                <tr>
                                                    <td width="180" height="47" valign="top">
                                                        <table id="tblVideoPreviewBtn" cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                                                            bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon01.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움"><span style="font-size: 10pt; color: #8C959A;" id="spVideoPreviewText">Video</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="136" height="47">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="trCustomVideoMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        업로드
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="367" height="32">
                                                        <input id="videobtn_path" type="file" name="videobtn_path" accept="image/png" class="clsBrowser"
                                                            size="30">
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>


                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="55" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="485">
                                    <tr>
                                        <td width="485" height="41" align="right">
                                            <input type="hidden" id="hdVideoModeIndex" value="1" />
                                            <input type="hidden" id="hdVideoColorIndex" value="1" />
                                            <input type="hidden" id="hdVideoTextColorIndex" value="1" />
                                            <input type="button" style="width: 103px; height: 30px; font-weight: bold;" class="clsButton"
                                                value="적용하기" onclick="OnVideoApply1()" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="dvVideo3D" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="background-color: White">
            <tr>
                <td width="520" height="251" style="border-width: 1px; border-color: rgb(255,102,0);
                    border-style: solid;">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td width="500" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="31">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">비디오 - 3D&nbsp;템플릿</span></font></b>
                                        </td>
                                        <td width="91" height="31" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="137" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="469">
                                    <tr>
                                        <td width="469" height="127">
                                            <table cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="video_rd1" type="radio" name="video_rd" value="0" checked />적용 안함
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="video_rd2" type="radio" name="video_rd" value="1" />3D 클래식 TV형
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="video_rd3" type="radio" name="video_rd" value="2" />
                                                        3D 와이드 평면 TV형
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="45" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="485">
                                    <tr>
                                        <td width="485" height="41" align="right">
                                            <input type="button" style="width: 103px; height: 30px; font-weight: bold;" class="clsButton"
                                                value="적용하기" onclick="OnVideoApply2()" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>

    <div id="dvRegLinkVideo" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="background-color: White">
            <tr>
                <td width="520" height="269" style="border-width: 1px; border-color: rgb(255,102,0);
                    border-style: solid;">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td width="500" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="31">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">링크비디오&nbsp;편집</span></font></b>
                                        </td>
                                        <td width="91" height="31" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="137" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="487">
                                    <tr>
                                        <td width="110" height="30" align="center" class="clsTitleLabel">
                                            유튜브 링크
                                        </td>
                                        <td width="377" height="30" style="padding-left:5px;">
                                            <input type="text" id="txt_link" size="40" placeholder="youtube link" value=""/>
                                            <input type="hidden" id="hd_link" size="40" value="" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="110" height="40" align="center" class="clsTitleLabel">
                                        </td>
                                        <td width="360" height="40" style="padding-left:5px; color:Gray; font-size:12px;">
                                            링크되는 유튜브 영상의 경우 콘텐츠의 저작권자의 요청에 의해<br /> 외부링크가 불가능한 경우도 있습니다. 
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="110" height="76" align="center" class="clsTitleLabel">
                                            실행옵션
                                        </td>
                                        <td width="377" height="76">
                                            <table cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="linkvideorun_rd1" type="radio" name="linkvideorun_rd" title="자동실행" value="0" checked/>
                                                        <label for="linkvideorun_rd1">동영상이 자동으로 재생됩니다.</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="linkvideorun_rd2" type="radio" name="linkvideorun_rd" title="터치시 실행" value="1"/>
                                                        <label for="videorun_rd2">동영상이 터치 시 재생됩니다.</label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="55" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="485">
                                    <tr>
                                        <td width="485" height="41" align="right">
                                            <input type="button" style="width: 103px; height: 30px; font-weight: bold;" class="clsButton"
                                                value="적용하기" onclick="OnLinkVideoApply1()" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="dvLinkVideo3D" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="background-color: White">
            <tr>
                <td width="520" height="251" style="border-width: 1px; border-color: rgb(255,102,0);
                    border-style: solid;">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td width="500" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="31">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">링크비디오 - 3D&nbsp;템플릿</span></font></b>
                                        </td>
                                        <td width="91" height="31" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="137" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="469">
                                    <tr>
                                        <td width="469" height="127">
                                            <table cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="linkvideo_rd1" type="radio" name="linkvideo_rd" value="0" checked />적용 안함
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="linkvideo_rd2" type="radio" name="linkvideo_rd" value="1" />3D 클래식 TV형
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="linkvideo_rd3" type="radio" name="linkvideo_rd" value="2" />
                                                        3D 와이드 평면 TV형
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="45" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="485">
                                    <tr>
                                        <td width="485" height="41" align="right">
                                            <input type="button" style="width: 103px; height: 30px; font-weight: bold;" class="clsButton"
                                                value="적용하기" onclick="OnLinkVideoApply2()" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>


    <div id="dvImage" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="background-color: White">
            <tr>
                <td width="520" height="195" style="border-width: 1px; border-color: rgb(255,102,0);
                    border-style: solid;">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td colspan="2" width="500" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="31">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">이미지&nbsp;편집</span></font></b>
                                        </td>
                                        <td width="91" height="31" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" width="500" height="86" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="487">
                                    <tr>
                                        <td width="110" height="61" align="center" class="clsTitleLabel">
                                            업로드
                                        </td>
                                        <td width="377" height="61" align="center">
                                            <input type="text" id="fileimage_text" size="30" placeholder="jpg,jpeg,png,gif 파일" readonly="readonly" />
                                            <input type="button" value="찾아보기..." onclick="javascript:OnBrowse('image_file')" />
                                            <input id="image_file" type="file" name="img_path" accept="image/png, image/jpeg, image/gif"
                                                class="clsBrowser" style="display: none" size="31" onchange="document.getElementById('fileimage_text').value=this.value">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="110" height="76" align="center" class="clsTitleLabel">
                                실행옵션
                            </td>
                            <td width="377" height="76">
                                <table cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td width="367" height="32" class="clsLabel">
                                            <input id="imagerun_rd1" type="radio" name="imagerun_rd" value="0" onclick="onImageRun_rd(0)" checked/>
                                            <label for="imagerun_rd1">스캔시 이미지 바로 표시(버튼사용 안함)</label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="367" height="32" class="clsLabel">
                                            <input id="imagerun_rd2" type="radio" name="imagerun_rd" value="1" onclick="onImageRun_rd(1)"/>
                                            <label for="imagerun_rd2">이미지보기 버튼 사용</label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="367" height="32" class="clsLabel">
                                            <input id="imagerun_rd3" type="radio" name="imagerun_rd" value="2" onclick="onImageRun_rd(2)"/>
                                            <label for="imagerun_rd3">커스텀 버튼 사용</label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr class="trNorImageMode">
                            <td width="110" height="76" align="center" class="clsTitleLabel">
                                버튼모양
                            </td>
                            <td width="361" height="119" valign="top">
                                <table cellpadding="0" cellspacing="0" width="360">
                                    <tr>
                                        <td width="180" height="47" id="tdImageModeBtn1" class="clsModeBtn">
                                            <table cellpadding="0" cellspacing="0" align="center"
                                                onclick="onChangeDefaultImageBtn('Image',1)" style="cursor: pointer; border-collapse: collapse;"
                                                bgcolor="#F7F7F7" width="169">
                                                <tr>
                                                    <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                        border-style: solid;">
                                                        <table cellpadding="0" cellspacing="0" width="159">
                                                            <tr>
                                                                <td width="35" height="27" align="right">
                                                                    <img src="img/cam_icon02.png" width="19" height="19" border="0">
                                                                </td>
                                                                <td width="124" height="27" align="center">
                                                                    <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">Image</span></font></b>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="180" height="47" id="tdImageModeBtn2" class="clsModeBtn">
                                            <table cellpadding="0" cellspacing="0" align="center"
                                                onclick="onChangeDefaultImageBtn('참조이미지',2)" style="cursor: pointer; border-collapse: collapse;"
                                                bgcolor="#F7F7F7" width="169">
                                                <tr>
                                                    <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                        border-style: solid;">
                                                        <table cellpadding="0" cellspacing="0" width="159">
                                                            <tr>
                                                                <td width="35" height="27" align="right">
                                                                    <img src="img/cam_icon02.png" width="19" height="19" border="0">
                                                                </td>
                                                                <td width="124" height="27" align="center">
                                                                    <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">참조이미지</span></font></b>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="180" height="46" id="tdImageModeBtn3" class="clsModeBtn">
                                            <table cellpadding="0" cellspacing="0" align="center"
                                                onclick="onChangeDefaultImageBtn('||',3)" style="cursor: pointer; border-collapse: collapse;"
                                                bgcolor="#F7F7F7" width="169">
                                                <tr>
                                                    <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                        border-style: solid;">
                                                        <table cellpadding="0" cellspacing="0" width="159">
                                                            <tr>
                                                                <td width="35" height="27" align="right">
                                                                    <img src="img/cam_icon02.png" width="19" height="19" border="0">
                                                                </td>
                                                                <td width="124" height="27" align="center">
                                                                    <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">||</span></font></b>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="180" height="46" id="tdImageModeBtn4" class="clsModeBtn">
                                            <table cellpadding="0" cellspacing="0" align="center"
                                                onclick="onChangeDefaultImageBtn('Photo',4)" style="cursor: pointer; border-collapse: collapse;"
                                                bgcolor="#F7F7F7" width="169">
                                                <tr>
                                                    <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                        border-style: solid;">
                                                        <table cellpadding="0" cellspacing="0" width="159">
                                                            <tr>
                                                                <td width="35" height="27" align="right">
                                                                    <img src="img/cam_icon02.png" width="19" height="19" border="0">
                                                                </td>
                                                                <td width="124" height="27" align="center">
                                                                    <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">Photo</span></font></b>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr class="trNorImageMode">
                            <td width="115" height="10" valign="top">
                                <table cellpadding="0" cellspacing="0" width="105" align="center">
                                    <tr>
                                        <td width="105" height="32" align="center" class="clsTitleLabel">
                                            버튼색상
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="361" height="61" valign="top">
                                <table cellpadding="0" cellspacing="0" width="350">
                                    <tr>
                                        <td width="35" height="35" id="tdImageColorBtn11" class="clsColorBtn" onclick="onChangeImageColor('#FFFFFF',11);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFFFF">
                                                <tr>
                                                    <td width="23" height="23" style="border:1px solid #DDDDDD;">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdImageColorBtn1" class="clsColorBtn" onclick="onChangeImageColor('#DDDDDD',1);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdImageColorBtn2" class="clsColorBtn" onclick="onChangeImageColor('#999999',2);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdImageColorBtn3" class="clsColorBtn" onclick="onChangeImageColor('black',3);">
                                            <table cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td width="25" height="25" bgcolor="black">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdImageColorBtn4" class="clsColorBtn" onclick="onChangeImageColor('#079DEC',4);">
                                            <table cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td width="25" height="25" bgcolor="#079DEC">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdImageColorBtn5" class="clsColorBtn" onclick="onChangeImageColor('#1234AB',5);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdImageColorBtn6" class="clsColorBtn" onclick="onChangeImageColor('red',6);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdImageColorBtn7" class="clsColorBtn" onclick="onChangeImageColor('#FF7700',7);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdImageColorBtn8" class="clsColorBtn" onclick="onChangeImageColor('#FFDD00',8);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdImageColorBtn9" class="clsColorBtn" onclick="onChangeImageColor('#33AA22',9);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdImageColorBtn10" class="clsColorBtn" onclick="onChangeImageColor('#BB33AA',10);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr class="trNorImageMode">
                            <td width="115" height="10" valign="top">
                                <table cellpadding="0" cellspacing="0" width="105" align="center">
                                    <tr>
                                        <td width="105" height="32" align="center" class="clsTitleLabel">
                                            버튼 글 색상
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="361" height="61" valign="top">
                                <table cellpadding="0" cellspacing="0" width="350">
                                    <tr>
                                        <td width="35" height="35" id="tdImageTextColorBtn11" class="clsTextColorBtn" onclick="onChangeTextColor('spImagePreviewText','#FFFFFF','tdImageTextColorBtn',11,'hdImageTextColorIndex');">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFFFF">
                                                <tr>
                                                    <td width="23" height="23" style="border:1px solid #DDDDDD;">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdImageTextColorBtn1" class="clsTextColorBtn" onclick="onChangeTextColor('spImagePreviewText','#DDDDDD','tdImageTextColorBtn',1,'hdImageTextColorIndex');">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdImageTextColorBtn2" class="clsTextColorBtn" onclick="onChangeTextColor('spImagePreviewText','#999999','tdImageTextColorBtn',2,'hdImageTextColorIndex');">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdImageTextColorBtn3" class="clsTextColorBtn" onclick="onChangeTextColor('spImagePreviewText','black','tdImageTextColorBtn',3,'hdImageTextColorIndex');">
                                            <table cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td width="25" height="25" bgcolor="black">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdImageTextColorBtn4" class="clsTextColorBtn" onclick="onChangeTextColor('spImagePreviewText','#079DEC','tdImageTextColorBtn',4,'hdImageTextColorIndex');">
                                            <table cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td width="25" height="25" bgcolor="#079DEC">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdImageTextColorBtn5" class="clsTextColorBtn" onclick="onChangeTextColor('spImagePreviewText','#1234AB','tdImageTextColorBtn',5,'hdImageTextColorIndex');">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdImageTextColorBtn6" class="clsTextColorBtn" onclick="onChangeTextColor('spImagePreviewText','red','tdImageTextColorBtn',6,'hdImageTextColorIndex');">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdImageTextColorBtn7" class="clsTextColorBtn" onclick="onChangeTextColor('spImagePreviewText','#FF7700','tdImageTextColorBtn',7,'hdImageTextColorIndex');">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdImageTextColorBtn8" class="clsTextColorBtn" onclick="onChangeTextColor('spImagePreviewText','#FFDD00','tdImageTextColorBtn',8,'hdImageTextColorIndex');">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdImageTextColorBtn9" class="clsTextColorBtn" onclick="onChangeTextColor('spImagePreviewText','#33AA22','tdImageTextColorBtn',9,'hdImageTextColorIndex');">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdImageTextColorBtn10" class="clsTextColorBtn" onclick="onChangeTextColor('spImagePreviewText','#BB33AA','tdImageTextColorBtn',10,'hdImageTextColorIndex');">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr class="trNorImageMode">
                            <td width="115" height="10" valign="top">
                                <table cellpadding="0" cellspacing="0" width="105" align="center">
                                    <tr>
                                        <td width="105" height="32" align="center" class="clsTitleLabel">
                                            버튼미리보기
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="361" height="61" valign="top">
                                <table cellpadding="0" cellspacing="0" width="316">
                                    <tr>
                                        <td width="180" height="47" valign="top">
                                            <table id="tblImagePreviewBtn" cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                                                bgcolor="#F7F7F7" width="169">
                                                <tr>
                                                    <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                        border-style: solid;">
                                                        <table cellpadding="0" cellspacing="0" width="159">
                                                            <tr>
                                                                <td width="35" height="27" align="right">
                                                                    <img src="img/cam_icon02.png" width="19" height="19" border="0">
                                                                </td>
                                                                <td width="124" height="27" align="center">
                                                                    <b><font face="돋움"><span style="font-size: 10pt; color: #8C959A;" id="spImagePreviewText">Image</span></font></b>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="136" height="47">
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr class="trCustomImageMode">
                            <td width="115" height="10" valign="top">
                                <table cellpadding="0" cellspacing="0" width="105" align="center">
                                    <tr>
                                        <td width="105" height="32" align="center" class="clsTitleLabel">
                                            업로드
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="361" height="61" valign="top">
                                <table cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td width="367" height="32">
                                            <input id="imagebtn_path" type="file" name="imagebtn_path" accept="image/png" class="clsBrowser"
                                                size="30">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" width="500" height="45" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="485">
                                    <tr>
                                        <td width="485" height="41" align="right">
                                            <input type="hidden" id="hdImageModeIndex" value="1" />
                                            <input type="hidden" id="hdImageColorIndex" value="1" />
                                            <input type="hidden" id="hdImageTextColorIndex" value="1" />
                                            <input type="button" style="width: 103px; height: 30px; font-weight: bold;" class="clsButton"
                                                value="적용하기" onclick="OnImageApply1()" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="dvImage3D" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="background-color: White">
            <tr>
                <td width="520" height="210" style="border-width: 1px; border-color: rgb(255,102,0);
                    border-style: solid;">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td width="500" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="31">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">이미지 - 3D&nbsp;템플릿</span></font></b>
                                        </td>
                                        <td width="91" height="31" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="98" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="469">
                                    <tr>
                                        <td width="469" height="88">
                                            <table cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="imgview_rd1" type="radio" name="imgview_rd" title="적용 안함" checked>
                                                        적용 안함
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="imgview_rd2" type="radio" name="imgview_rd" title="3D 스탠드 액자형">
                                                        3D 스탠드 액자형
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="45" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="485">
                                    <tr>
                                        <td width="485" height="41" align="right">
                                            <input type="button" id="Button14" onclick="OnImageApply2()" class="clsButton" value="적용하기"
                                                style="font-weight: bold; width: 103px; height: 30px;" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="dvWeb" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="border-width: 1px; border-color: rgb(255,102,0);
            border-style: solid; background-color: White">
            <tr>
                <td width="520" valign="top">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td height="33">
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="54">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">웹사이트&nbsp;편집</span></font></b>
                                        </td>
                                        <td width="91" height="54" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="86" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="476">
                                    <tr>
                                        <td width="115" height="70" align="center" class="clsTitleLabel">
                                            URL
                                        </td>
                                        <td width="361" height="70" align="left">
                                            <input type="text" id="web_url" name="web_url" style="width: 300px" maxlength="100" placeholder="http://xxx.xxx.xxx/xxxx 형식으로 입력하세요."
                                                class="control" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="115" height="88" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        VIEW 옵션
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="88" valign="top" align="left">
                                            <asp:RadioButtonList ID="rdbWeb2" CssClass="rdbWeb2 rdoBtnList" runat="server">
                                                <asp:ListItem Value="0" Selected="True">링크형</asp:ListItem>
                                                <asp:ListItem Value="1">자체&nbsp;브라우저형</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="115" height="64" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        버튼종류
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="64" valign="top">
                                            <asp:RadioButtonList ID="rdbWeb1" CssClass="rdbWeb1 rdoBtnList" runat="server">
                                                <asp:ListItem Value="0" Selected="True">기본 버튼</asp:ListItem>
                                                <asp:ListItem Value="1">커스텀 버튼형</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                    <tr class="trNorWebMode">
                                        <td>
                                        </td>
                                        <td width="361" height="119" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="360">
                                                <tr>
                                                    <td width="180" height="47" id="tdWebModeBtn1" class="clsModeBtn">
                                                        <table class="btnDefaultWebMode_Web" cellpadding="0" cellspacing="0" align="center"
                                                            onclick="onChangeDefaultWebBtn('Website',1)" style="cursor: pointer; border-collapse: collapse;"
                                                            bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon03.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">Website</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="180" height="47" id="tdWebModeBtn2" class="clsModeBtn">
                                                        <table class="btnDefaultWebMode_App" cellpadding="0" cellspacing="0" align="center"
                                                            onclick="onChangeDefaultWebBtn('APP다운로드',2)" style="cursor: pointer; border-collapse: collapse;"
                                                            bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon03.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">APP다운로드</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="180" height="46" id="tdWebModeBtn3" class="clsModeBtn">
                                                        <table class="btnDefaultWebMode_Direct" cellpadding="0" cellspacing="0" align="center"
                                                            onclick="onChangeDefaultWebBtn('바로가기',3)" style="cursor: pointer; border-collapse: collapse;"
                                                            bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon03.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">바로가기</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="180" height="46" id="tdWebModeBtn4" class="clsModeBtn">
                                                        <table class="btnDefaultWebMode_Buy" cellpadding="0" cellspacing="0" align="center"
                                                            onclick="onChangeDefaultWebBtn('구매하기',4)" style="cursor: pointer; border-collapse: collapse;"
                                                            bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon03.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">구매하기</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="trNorWebMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        버튼색상
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="350">
                                                <tr>
                                                    <td width="35" height="35" id="tdWebColorBtn11" class="clsColorBtn" onclick="onChangeWebColor('#FFFFFF',11);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFFFF">
                                                            <tr>
                                                                <td width="23" height="23" style="border:1px solid #DDDDDD;">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebColorBtn1" class="clsColorBtn" onclick="onChangeWebColor('#DDDDDD',1);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebColorBtn2" class="clsColorBtn" onclick="onChangeWebColor('#999999',2);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebColorBtn3" class="clsColorBtn" onclick="onChangeWebColor('black',3);">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="black">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebColorBtn4" class="clsColorBtn" onclick="onChangeWebColor('#079DEC',4);">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="#079DEC">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebColorBtn5" class="clsColorBtn" onclick="onChangeWebColor('#1234AB',5);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebColorBtn6" class="clsColorBtn" onclick="onChangeWebColor('red',6);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebColorBtn7" class="clsColorBtn" onclick="onChangeWebColor('#FF7700',7);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebColorBtn8" class="clsColorBtn" onclick="onChangeWebColor('#FFDD00',8);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebColorBtn9" class="clsColorBtn" onclick="onChangeWebColor('#33AA22',9);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebColorBtn10" class="clsColorBtn" onclick="onChangeWebColor('#BB33AA',10);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>

                                    <tr class="trNorWebMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        버튼 글 색상
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="350">
                                                <tr>
                                                    <td width="35" height="35" id="tdWebTextColorBtn11" class="clsTextColorBtn" onclick="onChangeTextColor('spWebPreviewText','#FFFFFF','tdWebTextColorBtn',11,'hdWebTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFFFF">
                                                            <tr>
                                                                <td width="23" height="23" style="border:1px solid #DDDDDD;">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebTextColorBtn1" class="clsTextColorBtn" onclick="onChangeTextColor('spWebPreviewText','#DDDDDD','tdWebTextColorBtn',1,'hdWebTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebTextColorBtn2" class="clsTextColorBtn" onclick="onChangeTextColor('spWebPreviewText','#999999','tdWebTextColorBtn',2,'hdWebTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebTextColorBtn3" class="clsTextColorBtn" onclick="onChangeTextColor('spWebPreviewText','black','tdWebTextColorBtn',3,'hdWebTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="black">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebTextColorBtn4" class="clsTextColorBtn" onclick="onChangeTextColor('spWebPreviewText','#079DEC','tdWebTextColorBtn',4,'hdWebTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="#079DEC">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebTextColorBtn5" class="clsTextColorBtn" onclick="onChangeTextColor('spWebPreviewText','#1234AB','tdWebTextColorBtn',5,'hdWebTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebTextColorBtn6" class="clsTextColorBtn" onclick="onChangeTextColor('spWebPreviewText','red','tdWebTextColorBtn',6,'hdWebTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebTextColorBtn7" class="clsTextColorBtn" onclick="onChangeTextColor('spWebPreviewText','#FF7700','tdWebTextColorBtn',7,'hdWebTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebTextColorBtn8" class="clsTextColorBtn" onclick="onChangeTextColor('spWebPreviewText','#FFDD00','tdWebTextColorBtn',8,'hdWebTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebTextColorBtn9" class="clsTextColorBtn" onclick="onChangeTextColor('spWebPreviewText','#33AA22','tdWebTextColorBtn',9,'hdWebTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebTextColorBtn10" class="clsTextColorBtn" onclick="onChangeTextColor('spWebPreviewText','#BB33AA','tdWebTextColorBtn',10,'hdWebTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>


                                    <tr class="trNorWebMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        버튼미리보기
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="316">
                                                <tr>
                                                    <td width="180" height="47" valign="top">
                                                        <table id="tblWebPreviewBtn" cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                                                            bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon03.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움"><span style="font-size: 10pt; color: #8C959A;" id="spWebPreviewText">Website</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="136" height="47">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="trCustomWebMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        업로드
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="367" height="32">
                                                        <input id="webbtn_path" type="file" name="webbtn_path" accept="image/png" class="clsBrowser"
                                                            size="30">
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="520" height="45" valign="top">
                                <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                                    width="502">
                                    <tr>
                                        <td width="500" height="45" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                            border-right-color: black; border-bottom-color: black; border-left-color: black;
                                            border-style: none;">
                                            <table cellpadding="0" cellspacing="0" align="center" width="466">
                                                <tr>
                                                    <td width="466" height="44" align="right">
                                                        <input type="hidden" id="hdWebModeIndex" value="1" />
                                                        <input type="hidden" id="hdWebColorIndex" value="1" />
                                                        <input type="hidden" id="hdWebTextColorIndex" value="1" />
                                                        <input type="button" id="btnWebApply" onclick="OnWebApply()" class="clsButton" value="적용하기"
                                                            style="font-weight: bold; width: 124px; height: 30px;" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td height="33">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="dvPhone" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="background-color: White">
            <tr>
                <td width="520" valign="top" style="border-width: 1px; border-color: rgb(255,102,0);
                    border-style: solid;">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td height="33">
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="38">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">전화번호&nbsp;편집&nbsp;</span></font></b>
                                        </td>
                                        <td width="91" height="38" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="37" valign="top" class="clsLabel">
                                            유선전화의 경우 지역번호도 함께 입력해주세요.
                                        </td>
                                        <td width="91" height="37" align="right">
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="86" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="476">
                                    <tr>
                                        <td width="115" height="70" align="center" class="clsTitleLabel">
                                            전화번호 입력
                                        </td>
                                        <td width="361" height="70" align="left">
                                            <input type="text" onkeypress="num_only()" id="tel_no" name="tel_no" maxlength="13" placeholder="'-' 생략"
                                                class="control" style="width: 90%; ime-mode: disabled;" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="115" height="64" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        버튼종류
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="64" valign="top">
                                            <asp:RadioButtonList ID="rdbTel1" CssClass="rdbTel1 rdoBtnList" runat="server">
                                                <asp:ListItem Value="0" Selected="True">기본 버튼</asp:ListItem>
                                                <asp:ListItem Value="1">커스텀 버튼형</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                    <tr class="trNorTelMode">
                                        <td>
                                        </td>
                                        <td width="361" height="108" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="360">
                                                <tr>
                                                    <td width="180" height="47" id="tdTelModeBtn1" class="clsModeBtn">
                                                        <table cellpadding="0" cellspacing="0" align="center" onclick="onChangeDefaultTelBtn('Phone Number',1)"
                                                            style="cursor: pointer; border-collapse: collapse;" bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon04.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">Phone Number</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="180" height="47" id="tdTelModeBtn2" class="clsModeBtn">
                                                        <table cellpadding="0" cellspacing="0" align="center" onclick="onChangeDefaultTelBtn('Office phone',2)"
                                                            style="cursor: pointer; border-collapse: collapse;" bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon04.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">Office phone</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="180" height="46" id="tdTelModeBtn3" class="clsModeBtn">
                                                        <table cellpadding="0" cellspacing="0" align="center" onclick="onChangeDefaultTelBtn('연락처',3)"
                                                            style="cursor: pointer; border-collapse: collapse;" bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon04.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">연락처</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="180" height="46" id="tdTelModeBtn4" class="clsModeBtn">
                                                        <table cellpadding="0" cellspacing="0" align="center" onclick="onChangeDefaultTelBtn('주문하기',4)"
                                                            style="cursor: pointer; border-collapse: collapse;" bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon04.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">주문하기</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="trNorTelMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        버튼색상
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="350">
                                                <tr>
                                                    <td width="35" height="35" id="tdTelColorBtn11" class="clsColorBtn" onclick="onChangeTelColor('#FFFFFF',11);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFFFF">
                                                            <tr>
                                                                <td width="23" height="23" style="border:1px solid #DDDDDD;">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelColorBtn1" class="clsColorBtn" onclick="onChangeTelColor('#DDDDDD',1);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelColorBtn2" class="clsColorBtn" onclick="onChangeTelColor('#999999',2);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelColorBtn3" class="clsColorBtn" onclick="onChangeTelColor('black',3);">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="black">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelColorBtn4" class="clsColorBtn" onclick="onChangeTelColor('#079DEC',4);">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="#079DEC">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelColorBtn5" class="clsColorBtn" onclick="onChangeTelColor('#1234AB',5);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelColorBtn6" class="clsColorBtn" onclick="onChangeTelColor('red',6);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelColorBtn7" class="clsColorBtn" onclick="onChangeTelColor('#FF7700',7);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelColorBtn8" class="clsColorBtn" onclick="onChangeTelColor('#FFDD00',8);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelColorBtn9" class="clsColorBtn" onclick="onChangeTelColor('#33AA22',9);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelColorBtn10" class="clsColorBtn" onclick="onChangeTelColor('#BB33AA',10);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="trNorTelMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        버튼 글 색상
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="350">
                                                <tr>
                                                    <td width="35" height="35" id="tdTelTextColorBtn11" class="clsTextColorBtn" onclick="onChangeTextColor('spTelPreviewText','#FFFFFF','tdTelTextColorBtn',11,'hdTelTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFFFF">
                                                            <tr>
                                                                <td width="23" height="23" style="border:1px solid #DDDDDD;">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelTextColorBtn1" class="clsTextColorBtn" onclick="onChangeTextColor('spTelPreviewText','#DDDDDD','tdTelTextColorBtn',1,'hdTelTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelTextColorBtn2" class="clsTextColorBtn" onclick="onChangeTextColor('spTelPreviewText','#999999','tdTelTextColorBtn',2,'hdTelTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelTextColorBtn3" class="clsTextColorBtn" onclick="onChangeTextColor('spTelPreviewText','black','tdTelTextColorBtn',3,'hdTelTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="black">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelTextColorBtn4" class="clsTextColorBtn" onclick="onChangeTextColor('spTelPreviewText','#079DEC','tdTelTextColorBtn',4,'hdTelTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="#079DEC">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelTextColorBtn5" class="clsTextColorBtn" onclick="onChangeTextColor('spTelPreviewText','#1234AB','tdTelTextColorBtn',5,'hdTelTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelTextColorBtn6" class="clsTextColorBtn" onclick="onChangeTextColor('spTelPreviewText','red','tdTelTextColorBtn',6,'hdTelTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelTextColorBtn7" class="clsTextColorBtn" onclick="onChangeTextColor('spTelPreviewText','#FF7700','tdTelTextColorBtn',7,'hdTelTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelTextColorBtn8" class="clsTextColorBtn" onclick="onChangeTextColor('spTelPreviewText','#FFDD00','tdTelTextColorBtn',8,'hdTelTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelTextColorBtn9" class="clsTextColorBtn" onclick="onChangeTextColor('spTelPreviewText','#33AA22','tdTelTextColorBtn',9,'hdTelTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelTextColorBtn10" class="clsTextColorBtn" onclick="onChangeTextColor('spTelPreviewText','#BB33AA','tdTelTextColorBtn',10,'hdTelTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="trNorTelMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        버튼미리보기
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="316">
                                                <tr>
                                                    <td width="180" height="47" valign="top">
                                                        <table id="tblTelPreviewBtn" cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                                                            bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon04.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움"><span style="font-size: 10pt; color: #8C959A;" id="spTelPreviewText">Phone Number</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="136" height="47">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="trCustomTelMode">
                                        <td height="25">
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr class="trCustomTelMode">
                                        <td width="115" height="65" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        업로드
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="65" valign="top">
                                            <table cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="367" height="32">
                                                        <input id="telbtn_path" type="file" name="telbtn_path" accept="image/jpeg, image/png"
                                                            class="clsBrowser" size="30">
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="45" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="466">
                                    <tr>
                                        <td width="466" height="44" align="right">
                                            <input type="hidden" id="hdTelColorIndex" value="1" />
                                            <input type="hidden" id="hdTelModeIndex" value="1" />
                                            <input type="hidden" id="hdTelTextColorIndex" value="1" />
                                            <input type="button" id="btnTelApply" onclick="OnTelApply1()" class="clsButton" value="적용하기"
                                                style="font-weight: bold; width: 124px; height: 30px;" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td height="33">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="dvPhone3D" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="background-color: White">
            <tr>
                <td width="520" height="210" style="border-width: 1px; border-color: rgb(255,102,0);
                    border-style: solid;">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td width="500" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="31">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">전화번호 - 3D&nbsp;템플릿</span></font></b>
                                        </td>
                                        <td width="91" height="31" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="98" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="469">
                                    <tr>
                                        <td width="469" height="88">
                                            <table cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="rdTel1" type="radio" name="rdTel" title="적용 안함" value="twoD" checked />
                                                        적용 안함
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="rdTel2" type="radio" name="rdTel" title="3D 클래식 전화기" value="threeD" />
                                                        3D 클래식 전화기
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="45" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="485">
                                    <tr>
                                        <td width="485" height="41" align="right">
                                            <input type="button" id="Button3" onclick="OnTelApply2()" class="clsButton" value="적용하기"
                                                style="font-weight: bold; width: 103px; height: 30px;" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="dvGoogleMap" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="background-color: White">
            <tr>
                <td width="520" style="border-width: 1px; border-color: rgb(255,102,0); border-style: solid;">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td height="33">
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="38">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">구글맵&nbsp;편집&nbsp;</span></font></b>
                                        </td>
                                        <td width="91" height="38" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="413" height="37" valign="top" class="clsLabel">
                                            유표시하고자 하는 장소의 구글맵 좌표를 확인하여 입력해주세요.
                                        </td>
                                        <td width="62" height="37" align="right">
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="86" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="476">
                                    <tr>
                                        <td width="115" height="70" align="center" class="clsTitleLabel">
                                            좌표입력
                                        </td>
                                        <td width="361" height="70" align="left">
                                            <input type="text" id="coordinate" name="coordinate" onkeypress="googlepos_only()" placeholder="X,Y 형식으로 입력하세요."
                                                size="49" style="font-family: 돋움; font-size: 10pt; color: rgb(153,153,153);">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="115" height="64" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        버튼종류
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="64" align="left" valign="top">
                                            <asp:RadioButtonList ID="rdbGoogle1" CssClass="rdbGoogle1 rdoBtnList" runat="server">
                                                <asp:ListItem Value="0" Selected="True">기본 버튼</asp:ListItem>
                                                <asp:ListItem Value="1">커스텀 버튼형</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                    <tr class="trNorGoogleMode">
                                        <td>
                                        </td>
                                        <td height="116" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="360">
                                                <tr>
                                                    <td width="180" height="47" id="tdGoogleModeBtn1" class="clsModeBtn">
                                                        <table cellpadding="0" cellspacing="0" align="center" onclick="onChangeDefaultGoogleBtn('Google Map',1)"
                                                            style="cursor: pointer; border-collapse: collapse;" bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon05.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">Google Map</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="180" height="47" id="tdGoogleModeBtn2" class="clsModeBtn">
                                                        <table cellpadding="0" cellspacing="0" align="center" onclick="onChangeDefaultGoogleBtn('지도보기',2)"
                                                            style="cursor: pointer; border-collapse: collapse;" bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon05.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">지도보기</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="180" height="46" id="tdGoogleModeBtn3" class="clsModeBtn">
                                                        <table cellpadding="0" cellspacing="0" align="center" onclick="onChangeDefaultGoogleBtn('행사장소',3)"
                                                            style="cursor: pointer; border-collapse: collapse;" bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon05.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">행사장소</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="180" height="46" id="tdGoogleModeBtn4" class="clsModeBtn">
                                                        <table cellpadding="0" cellspacing="0" align="center" onclick="onChangeDefaultGoogleBtn('매장위치',4)"
                                                            style="cursor: pointer; border-collapse: collapse;" bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon05.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">매장위치</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="trNorGoogleMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        버튼색상
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="350">
                                                <tr>
                                                    <td width="35" height="35" id="tdGoogleColorBtn11" class="clsColorBtn" onclick="onChangeGoogleColor('#FFFFFF',11);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFFFF">
                                                            <tr>
                                                                <td width="23" height="23" style="border:1px solid #DDDDDD" >
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleColorBtn1" class="clsColorBtn" onclick="onChangeGoogleColor('#DDDDDD',1);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleColorBtn2" class="clsColorBtn" onclick="onChangeGoogleColor('#999999',2);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleColorBtn3" class="clsColorBtn" onclick="onChangeGoogleColor('black',3);">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="black">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleColorBtn4" class="clsColorBtn" onclick="onChangeGoogleColor('#079DEC',4);">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="#079DEC">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleColorBtn5" class="clsColorBtn" onclick="onChangeGoogleColor('#1234AB',5);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleColorBtn6" class="clsColorBtn" onclick="onChangeGoogleColor('red',6);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleColorBtn7" class="clsColorBtn" onclick="onChangeGoogleColor('#FF7700',7);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleColorBtn8" class="clsColorBtn" onclick="onChangeGoogleColor('#FFDD00',8);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleColorBtn9" class="clsColorBtn" onclick="onChangeGoogleColor('#33AA22',9);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleColorBtn10" class="clsColorBtn" onclick="onChangeGoogleColor('#BB33AA',10);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="trNorGoogleMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        버튼 글 색상
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="350">
                                                <tr>
                                                    <td width="35" height="35" id="tdGoogleTextColorBtn11" class="clsTextColorBtn" onclick="onChangeTextColor('spGooglePreviewText','#FFFFFF','tdGoogleTextColorBtn',11,'hdGoogleTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFFFF">
                                                            <tr>
                                                                <td width="23" height="23" style="border:1px solid #DDDDDD" >
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleTextColorBtn1" class="clsTextColorBtn" onclick="onChangeTextColor('spGooglePreviewText','#DDDDDD','tdGoogleTextColorBtn',1,'hdGoogleTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleTextColorBtn2" class="clsTextColorBtn" onclick="onChangeTextColor('spGooglePreviewText','#999999','tdGoogleTextColorBtn',2,'hdGoogleTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleTextColorBtn3" class="clsTextColorBtn" onclick="onChangeTextColor('spGooglePreviewText','black','tdGoogleTextColorBtn',3,'hdGoogleTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="black">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleTextColorBtn4" class="clsTextColorBtn" onclick="onChangeTextColor('spGooglePreviewText','#079DEC','tdGoogleTextColorBtn',4,'hdGoogleTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="#079DEC">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleTextColorBtn5" class="clsTextColorBtn" onclick="onChangeTextColor('spGooglePreviewText','#1234AB','tdGoogleTextColorBtn',5,'hdGoogleTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleTextColorBtn6" class="clsTextColorBtn" onclick="onChangeTextColor('spGooglePreviewText','red','tdGoogleTextColorBtn',6,'hdGoogleTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleTextColorBtn7" class="clsTextColorBtn" onclick="onChangeTextColor('spGooglePreviewText','#FF7700','tdGoogleTextColorBtn',7,'hdGoogleTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleTextColorBtn8" class="clsTextColorBtn" onclick="onChangeTextColor('spGooglePreviewText','#FFDD00','tdGoogleTextColorBtn',8,'hdGoogleTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleTextColorBtn9" class="clsTextColorBtn" onclick="onChangeTextColor('spGooglePreviewText','#33AA22','tdGoogleTextColorBtn',9,'hdGoogleTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleTextColorBtn10" class="clsTextColorBtn" onclick="onChangeTextColor('spGooglePreviewText','#BB33AA','tdGoogleTextColorBtn',10,'hdGoogleTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="trNorGoogleMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        버튼미리보기
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" align="left" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="316">
                                                <tr>
                                                    <td width="180" height="47" valign="top">
                                                        <table id="tblGooglePreviewBtn" cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                                                            bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon05.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움"><span style="font-size: 10pt; color: #8C959A;" id="spGooglePreviewText">Google Map</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="136" height="47">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="trCustomGoogleMode">
                                        <td height="25">
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr class="trCustomGoogleMode">
                                        <td width="115" height="65" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        업로드
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="65" valign="top">
                                            <table cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="367" height="32">
                                                        <input id="googlebtn_path" type="file" name="googlebtn_path" accept="image/jpeg, image/png"
                                                            class="clsBrowser" size="30">
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="45" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="466">
                                    <tr>
                                        <td width="466" height="44" align="right">
                                            <input type="hidden" id="hdGoogleColorIndex" value="1" />
                                            <input type="hidden" id="hdGoogleTextColorIndex" value="1" />
                                            <input type="hidden" id="hdGoogleModeIndex" value="1" />
                                            <input type="button" id="Button4" onclick="OnGoogleMapApply()" class="clsButton"
                                                value="적용하기" style="font-weight: bold; width: 124px; height: 30px;" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td height="33">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="dvText" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="background-color: White">
            <tr>
                <td width="520" height="620" style="border-width: 1px; border-color: rgb(255,102,0);
                    border-style: solid;">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td width="500" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="60">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">텍스트&nbsp;편집&nbsp;</span></font></b>
                                        </td>
                                        <td width="91" height="60" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="86" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="476">
                                    <tr>
                                        <td width="115" height="105" align="center" class="clsTitleLabel">
                                            텍스트 문구
                                        </td>
                                        <td width="361" height="105">
                                            <table cellpadding="0" cellspacing="0" width="349" align="center">
                                                <tr>
                                                    <td width="327" height="69" align="left">
                                                        <textarea id="notepad_content" cols="20" rows="4" maxlength="60" style="width: 325px;"></textarea>
                                                    </td>
                                                    <td width="22" height="69" align="right" class="clsLabel" valign="top">
                                                        <span id="spLimitCharacters" style="font-family:돋움; color:666666; font-size: 10pt;">60</span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="115" height="70" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        텍스트 색상
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="350">
                                                <tr>
                                                    <td width="35" height="35" id="tdNotepadColorBtn11" class="clsColorBtnCopy" onclick="onChangeNotepadColor('#FFFFFF',11);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFFFF">
                                                            <tr>
                                                                <td width="23" height="23" style="border:1px solid #DDDDDD" >
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadColorBtn1" class="clsColorBtnCopy" onclick="onChangeNotepadColor('#DDDDDD',1);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadColorBtn2" class="clsColorBtnCopy" onclick="onChangeNotepadColor('#999999',2);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadColorBtn3" class="clsColorBtnCopy" onclick="onChangeNotepadColor('black',3);">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="black">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadColorBtn4" class="clsColorBtnCopy" onclick="onChangeNotepadColor('#079DEC',4);">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="#079DEC">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadColorBtn5" class="clsColorBtnCopy" onclick="onChangeNotepadColor('#1234AB',5);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadColorBtn6" class="clsColorBtnCopy" onclick="onChangeNotepadColor('red',6);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadColorBtn7" class="clsColorBtnCopy" onclick="onChangeNotepadColor('#FF7700',7);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadColorBtn8" class="clsColorBtnCopy" onclick="onChangeNotepadColor('#FFDD00',8);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadColorBtn9" class="clsColorBtnCopy" onclick="onChangeNotepadColor('#33AA22',9);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadColorBtn10" class="clsColorBtnCopy" onclick="onChangeNotepadColor('#BB33AA',10);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="115" height="72" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="46" align="center" class="clsTitleLabel">
                                                        텍스트 보드
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="72" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="360">
                                                <tr>
                                                    <td width="69" height="47" id="tdNotepadTypeBtn1" class="clsLabel clsBoardType" onclick="onChangeBoardType(0);">
                                                        없음
                                                    </td>
                                                    <td width="71" height="47" id="tdNotepadTypeBtn2" class="clsLabel clsBoardType" onclick="onChangeBoardType(1);">
                                                        <img src="img/icon_text01.png" width="38" height="33" border="0">
                                                    </td>
                                                    <td width="71" height="47" id="tdNotepadTypeBtn3" class="clsLabel clsBoardType" onclick="onChangeBoardType(2);">
                                                        <img src="img/icon_text02.png" width="38" height="33" border="0">
                                                    </td>
                                                    <td width="70" height="47" id="tdNotepadTypeBtn4" class="clsLabel clsBoardType" onclick="onChangeBoardType(3);">
                                                        <img src="img/icon_text03.png" width="38" height="33" border="0">
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="115" height="70" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="37" align="left" class="clsTitleLabel">
                                                        텍스트 보드 색상
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="350">
                                                <tr>
                                                    <td width="35" height="35" id="tdNotepadTextColorBtn11" class="clsColorBtn" onclick="onChangeBoardColor('#FFFFFF',11);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFFFF">
                                                            <tr>
                                                                <td width="23" height="23" style="border:1px solid #DDDDDD">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadTextColorBtn1" class="clsColorBtn" onclick="onChangeBoardColor('#DDDDDD',1);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadTextColorBtn2" class="clsColorBtn" onclick="onChangeBoardColor('#999999',2);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadTextColorBtn3" class="clsColorBtn" onclick="onChangeBoardColor('black',3);">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="black">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadTextColorBtn4" class="clsColorBtn" onclick="onChangeBoardColor('#079DEC',4);">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="#079DEC">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadTextColorBtn5" class="clsColorBtn" onclick="onChangeBoardColor('#1234AB',5);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadTextColorBtn6" class="clsColorBtn" onclick="onChangeBoardColor('red',6);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadTextColorBtn7" class="clsColorBtn" onclick="onChangeBoardColor('#FF7700',7);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadTextColorBtn8" class="clsColorBtn" onclick="onChangeBoardColor('#FFDD00',8);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadTextColorBtn9" class="clsColorBtn" onclick="onChangeBoardColor('#33AA22',9);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadTextColorBtn10" class="clsColorBtn" onclick="onChangeBoardColor('#BB33AA',10);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="115" height="110" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="37" align="left" class="clsTitleLabel">
                                                        텍스트 재생방법
                                                    </td>
                                                </tr>
                                            </table>
                                            &nbsp;
                                        </td>
                                        <td width="361" height="110" valign="top">
                                            <asp:RadioButtonList ID="rdoTextPlayMode" CssClass="rdoTextPlayMode rdoBtnList" runat="server">
                                                <asp:ListItem Value="0" Selected="True">없음</asp:ListItem>                                                
                                                <asp:ListItem Value="1">페이드 인 효과</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="115" height="100" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="26" align="left" class="clsTitleLabel">
                                                        &nbsp;&nbsp;&nbsp;미리보기
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="100" valign="top">
                                            <table id="tblNotepadPreviewBtn" width="323" height="100" cellpadding="0" cellspacing="0" background="" style="background-repeat:no-repeat">
                                                <tr>
                                                    <td width="351" class="clsLabel" style="padding-left:20px; padding-right:20px" >
                                                        <span id="spNotepadPreview" style="word-break:break-word"></span><span id="spBorderPreview" style="display: none;
                                                            color: #999999;">0</span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="78" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="466">
                                    <tr>
                                        <td width="466" height="44" align="right">
                                            <input type="hidden" id="hdNotepadTextColorIndex" value="1"/>
                                            <input type="hidden" id="hdNotepadColorIndex" value="1"/>
                                            <input type="hidden" id="hdNotepadColor" value="#FFFFFF"/>
                                            <input type="hidden" id="hdNotepadType" value="1"/>
                                            <input type="button" id="Button6" onclick="OnNotepadApply1()" class="clsButton" value="적용하기"
                                                style="font-weight: bold; width: 124px; height: 30px;" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="dvText3D" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="background-color: White">
            <tr>
                <td width="520" height="210" style="border-width: 1px; border-color: rgb(255,102,0);
                    border-style: solid;">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td width="500" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="31">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">TEXT - 3D&nbsp;템플릿</span></font></b>
                                        </td>
                                        <td width="91" height="31" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="98" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="469">
                                    <tr>
                                        <td width="469" height="88">
                                            <table cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="notepad_rd1" type="radio" name="notepad_rd" title="적용 안함" value="common"
                                                            checked />
                                                        적용 안함
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="notepad_rd2" type="radio" name="notepad_rd" title="3D 데스크 메모" value="3dmodel" />
                                                        3D 데스크 메모
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="45" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="485">
                                    <tr>
                                        <td width="485" height="41" align="right">
                                            <input type="button" id="Button7" onclick="OnNotepadApply2()" class="clsButton" value="적용하기"
                                                style="font-weight: bold; width: 103px; height: 30px;" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="dvBGM" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="background-color: White">
            <tr>
                <td width="520" style="border-width: 1px; border-color: rgb(255,102,0); border-style: solid;">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td height="33">
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="31">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">BGM&nbsp;편집</span></font></b>
                                        </td>
                                        <td width="91" height="31" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="182" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="487">
                                    <tr>
                                        <td width="110" height="30" align="center" class="clsTitleLabel">
                                            업로드
                                        </td>
                                        <td width="377" height="61" align="center">
                                            <input type="button" value="파일 선택" onclick="javascript:OnBrowse('audio_file')" />
                                            <input type="text" id="audio_file_text" size="30" placeholder="wma, mp3 파일" readonly="readonly" />
                                            <input type="file" id="audio_file" name="audio_file" accept="audio/mp3" class="clsBrowser"
                                                style="display: none" size="49" onchange="document.getElementById('audio_file_text').value=this.value" />                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="110" height="105" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        버튼종류
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="377" height="105" valign="top">
                                            <asp:RadioButtonList ID="rdbBGM1" CssClass="rdbBGM1 rdoBtnList" runat="server">
                                                <asp:ListItem Value="0" Selected="True">버튼 표시안함</asp:ListItem>
                                                <asp:ListItem Value="1">기본 버튼</asp:ListItem>
                                                <asp:ListItem Value="2">커스텀 버튼</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                    <tr class="trShowBGMMode">
                                        <td width="115" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="46" align="center" class="clsTitleLabel">
                                                        버튼모양
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" valign="top">
                                            <table class="tblNorBGMMode" cellpadding="0" cellspacing="0" width="359">
                                                <tr>
                                                    <td width="180" height="47" id="tdBGMModeBtn1" class="clsModeBtn">
                                                        <table cellpadding="0" cellspacing="0" width="169" align="center" onclick="onChangeBGMType(1);"
                                                            style="cursor: pointer; border-collapse: collapse;" bgcolor="#F7F7F7">
                                                            <tr>
                                                                <td width="167" height="35" bgcolor="#F7F7F7" style="border-width: 1px; border-color: rgb(193,193,193);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="161">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon07.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="126" height="27" align="center">
                                                                                <b><span style="font-size: 10pt;"><font face="돋움" color="#8C959A">BGM</font></span></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="179" height="47" id="tdBGMModeBtn2" class="clsModeBtn">
                                                        <table cellpadding="0" cellspacing="0" width="169" align="center" onclick="onChangeBGMType(2);"
                                                            style="cursor: pointer; border-collapse: collapse;">
                                                            <tr>
                                                                <td width="167" height="35" bgcolor="#F7F7F7" style="border-width: 1px; border-color: rgb(193,193,193);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="161">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon07.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="126" height="27" align="center">
                                                                                <b><span style="font-size: 10pt;"><font face="돋움" color="#8C959A">사운드</font></span></b>
                                                                            </td>
                                                                        </tr>                                                                        
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="180" height="60" id="tdBGMModeBtn3" class="clsModeBtn" align="center" onclick="onChangeBGMType(3);" style="cursor: pointer;" >
                                                        <img src="img/icon_bgm01.png" width="50" height="42" border="0">
                                                    </td>
                                                    <td width="179" height="60" id="tdBGMModeBtn4" class="clsModeBtn" align="center" onclick="onChangeBGMType(4);" style="cursor: pointer;">
                                                        <img src="img/icon_bgm02.png" width="33" height="42" border="0">
                                                    </td>
                                                </tr>
                                            </table>                                            
                                        </td>
                                        <td width="361" height="36">
                                        </td>
                                    </tr>
                                    <tr class="trShowBGMMode">
                                        <td width="115" height="70" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="37" align="center" class="clsTitleLabel">
                                                        버튼색상
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="350">
                                                <tr>
                                                    <td width="35" height="35" id="tdBGMColorBtn11" class="clsColorBtn" onclick="onChangeBGMColor('#FFFFFF',11);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFFFF">
                                                            <tr>
                                                                <td width="23" height="23" style="border:1px solid #DDDDDD">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMColorBtn1" class="clsColorBtn" onclick="onChangeBGMColor('#DDDDDD',1);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMColorBtn2" class="clsColorBtn" onclick="onChangeBGMColor('#999999',2);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMColorBtn3" class="clsColorBtn" onclick="onChangeBGMColor('black',3);">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="black">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMColorBtn4" class="clsColorBtn" onclick="onChangeBGMColor('#079DEC',4);">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="#079DEC">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMColorBtn5" class="clsColorBtn" onclick="onChangeBGMColor('#1234AB',5);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMColorBtn6" class="clsColorBtn" onclick="onChangeBGMColor('red',6);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMColorBtn7" class="clsColorBtn" onclick="onChangeBGMColor('#FF7700',7);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMColorBtn8" class="clsColorBtn" onclick="onChangeBGMColor('#FFDD00',8);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMColorBtn9" class="clsColorBtn" onclick="onChangeBGMColor('#33AA22',9);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMColorBtn10" class="clsColorBtn" onclick="onChangeBGMColor('#BB33AA',10);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>

                                    <tr class="trShowBGMMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        버튼 글 색상
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="350">
                                                <tr>
                                                    <td width="35" height="35" id="tdBGMTextColorBtn11" class="clsTextColorBtn" onclick="onChangeTextColor('spNorBGMLabel','#FFFFFF','tdBGMTextColorBtn',11,'hdBGMTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFFFF">
                                                            <tr>
                                                                <td width="23" height="23" style="border:1px solid #DDDDDD" >
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMTextColorBtn1" class="clsTextColorBtn" onclick="onChangeTextColor('spNorBGMLabel','#DDDDDD','tdBGMTextColorBtn',1,'hdBGMTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMTextColorBtn2" class="clsTextColorBtn" onclick="onChangeTextColor('spNorBGMLabel','#999999','tdBGMTextColorBtn',2,'hdBGMTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMTextColorBtn3" class="clsTextColorBtn" onclick="onChangeTextColor('spNorBGMLabel','black','tdBGMTextColorBtn',3,'hdBGMTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="black">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMTextColorBtn4" class="clsTextColorBtn" onclick="onChangeTextColor('spNorBGMLabel','#079DEC','tdBGMTextColorBtn',4,'hdBGMTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="#079DEC">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMTextColorBtn5" class="clsTextColorBtn" onclick="onChangeTextColor('spNorBGMLabel','#1234AB','tdBGMTextColorBtn',5,'hdBGMTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMTextColorBtn6" class="clsTextColorBtn" onclick="onChangeTextColor('spNorBGMLabel','red','tdBGMTextColorBtn',6,'hdBGMTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMTextColorBtn7" class="clsTextColorBtn" onclick="onChangeTextColor('spNorBGMLabel','#FF7700','tdBGMTextColorBtn',7,'hdBGMTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMTextColorBtn8" class="clsTextColorBtn" onclick="onChangeTextColor('spNorBGMLabel','#FFDD00','tdBGMTextColorBtn',8,'hdBGMTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMTextColorBtn9" class="clsTextColorBtn" onclick="onChangeTextColor('spNorBGMLabel','#33AA22','tdBGMTextColorBtn',9,'hdBGMTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMTextColorBtn10" class="clsTextColorBtn" onclick="onChangeTextColor('spNorBGMLabel','#BB33AA','tdBGMTextColorBtn',10,'hdBGMTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>

                                    <tr class="trShowBGMMode">
                                        <td width="115" height="63" valign="center">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="26" align="center" class="clsTitleLabel">
                                                        미리보기
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="63" valign="center">                                            
                                            <table id="tblBGMNorPreviewBtn" class="tblNorBGMMode" cellpadding="0" cellspacing="0" width="316">
                                                <tr>
                                                    <td width="180" height="47" valign="center">
                                                        <table id="tblBGMPreviewBtn" cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                                                            bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon07.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움"><span style="font-size: 10pt; color: #8C959A" id="spNorBGMLabel">
                                                                                    BGM</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="136" height="47">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="tblBGMCustomPreviewBtn" class="tblCustomBGMMode" cellpadding="0" cellspacing="0" width="180" style="display:none">
                                                <tr>
                                                    <td width="180" height="60" align="center">
                                                        <img id="imgCustomBGM" src="img/icon_bgm01.png" border="0">
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="trCustomBGMMode">
	                                    <td width="115" height="65" valign="top">
		                                    <table cellpadding="0" cellspacing="0" width="105" align="center">
			                                    <tr>
				                                    <td width="105" height="32" align="center" class="clsTitleLabel">
					                                    업로드
				                                    </td>
			                                    </tr>
		                                    </table>
	                                    </td>
	                                    <td width="361" height="65" valign="top">
		                                    <table cellpadding="0" cellspacing="0">
			                                    <tr>
				                                    <td width="367" height="32">
					                                    <input id="bgmbtn_path" type="file" name="bgmbtn_path" accept="image/jpeg, image/png"
						                                    class="clsBrowser" size="30">
				                                    </td>
			                                    </tr>
		                                    </table>
	                                    </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="44" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="485">
                                    <tr>
                                        <td width="485" height="41" align="right">
                                            <input type="hidden" id="hdBGMColorIndex" value="1"/>
                                            <input type="hidden" id="hdBGMModeIndex" value="1"/>
                                            <input type="hidden" id="hdBGMTextColorIndex" value="1"/>
                                            <input type="button" id="Button8" onclick="OnAudioApply1()" class="clsButton" value="적용하기"
                                                style="font-weight: bold; width: 103px; height: 30px;" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td height="33">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="dvBGM3D" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="background-color: White">
            <tr>
                <td width="520" height="232" style="border-width: 1px; border-color: rgb(255,102,0);
                    border-style: solid;">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td width="500" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="31">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">BGM&nbsp;편집 </span>
                                            </font></b>
                                        </td>
                                        <td width="91" height="31" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="98" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="469">
                                    <tr>
                                        <td width="469" height="111">
                                            <table cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="audiobtn_rd1" type="radio" name="audiobtn_rd" title="일반형" value="0" checked />
                                                        적용 안함
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="audiobtn_rd2" type="radio" name="audiobtn_rd" title="3D 사운드 플레이어형" value="1" />
                                                        3D 사운드 플레이어 형
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="audiobtn_rd3" type="radio" name="audiobtn_rd" title="3D 클래식 사운드 플레이어형"
                                                            value="2" />
                                                        3D 클래식 사운드 플레이어 형
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="54" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="485">
                                    <tr>
                                        <td width="485" height="41" align="right">
                                            <input type="button" id="Button10" onclick="OnAudioApply2()" class="clsButton" value="적용하기"
                                                style="font-weight: bold; width: 103px; height: 30px;" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="dvSlide" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="background-color: White">
            <tr>
                <td width="520" height="635" style="border-width: 1px; border-color: rgb(255,102,0);
                    border-style: solid;">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td colspan="2" width="500" height="96" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="31">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">이미지슬라이드&nbsp;편집</span></font></b>
                                        </td>
                                        <td width="91" height="31" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="43" class="clsLabel">
                                            '+'버튼으로 표시될 이미지를 선택해주세요.(최대 10매)<br>
                                            이미지의 사이즈가 같으면 더욱 효과적입니다.
                                        </td>
                                        <td width="91" height="43" align="right">
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" width="500" height="264" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <input type="hidden" id="addSlideImgID" />
                                <input id="slide_file" type="file" name="img_path" accept="image/png, image/jpeg"
                                    style="display: none;" />
                                <table cellpadding="0" cellspacing="0" bordercolordark="black" bordercolorlight="black"
                                    align="center" width="475">
                                    <tr>
                                        <td width="95" height="100">
                                            <table id="tdSlide1Image" cellpadding="0" cellspacing="0" align="center" style="display: none;
                                                border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="69" style="border-width: 1px; border-top-color: rgb(153,153,153);
                                                        border-right-color: rgb(153,153,153); border-bottom-color: black; border-left-color: rgb(153,153,153);
                                                        border-top-style: solid; border-right-style: solid; border-bottom-style: none;
                                                        border-left-style: solid;" align="center">
                                                        <img class="slideImg" src="" width="80" height="57" border="0">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="85" height="24" style="border-width: 1px; border-top-color: black; border-right-color: rgb(153,153,153);
                                                        border-bottom-color: rgb(153,153,153); border-left-color: rgb(153,153,153); border-top-style: none;
                                                        border-right-style: solid; border-bottom-style: solid; border-left-style: solid;"
                                                        bgcolor="#CCCCCC" align="center">
                                                        <img class="image-btn" onclick="onRemoveSlideImage(1)" src="img/cam_icon_trash.png"
                                                            width="18" height="21" border="0" name="image3">
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="tdSlide1Empty" class="clsSlideEmpty" onclick="onAddSlideImage(1)" cellpadding="0"
                                                cellspacing="0" align="center" style="cursor: pointer; border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="93" style="border-width: 1px; border-color: rgb(153,153,153);
                                                        border-style: solid;" align="center">
                                                        <span style="font-size: 24pt; color: #999999"></span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="95" height="100">
                                            <table id="tdSlide2Image" cellpadding="0" cellspacing="0" align="center" style="display: none;
                                                border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="69" style="border-width: 1px; border-top-color: rgb(153,153,153);
                                                        border-right-color: rgb(153,153,153); border-bottom-color: black; border-left-color: rgb(153,153,153);
                                                        border-top-style: solid; border-right-style: solid; border-bottom-style: none;
                                                        border-left-style: solid;" align="center">
                                                        <img class="slideImg" src="" width="80" height="57" border="0">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="85" height="24" style="border-width: 1px; border-top-color: black; border-right-color: rgb(153,153,153);
                                                        border-bottom-color: rgb(153,153,153); border-left-color: rgb(153,153,153); border-top-style: none;
                                                        border-right-style: solid; border-bottom-style: solid; border-left-style: solid;"
                                                        bgcolor="#CCCCCC" align="center">
                                                        <img class="image-btn" onclick="onRemoveSlideImage(2)" src="img/cam_icon_trash.png"
                                                            width="18" height="21" border="0" name="image3">
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="tdSlide2Empty" class="clsSlideEmpty" onclick="onAddSlideImage(2)" cellpadding="0"
                                                cellspacing="0" align="center" style="cursor: pointer; border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="93" style="border-width: 1px; border-color: rgb(153,153,153);
                                                        border-style: solid;" align="center">
                                                        <span style="font-size: 24pt; color: #999999"></span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="95" height="100">
                                            <table id="tdSlide3Image" cellpadding="0" cellspacing="0" align="center" style="display: none;
                                                border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="69" style="border-width: 1px; border-top-color: rgb(153,153,153);
                                                        border-right-color: rgb(153,153,153); border-bottom-color: black; border-left-color: rgb(153,153,153);
                                                        border-top-style: solid; border-right-style: solid; border-bottom-style: none;
                                                        border-left-style: solid;" align="center">
                                                        <img class="slideImg" src="" width="80" height="57" border="0">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="85" height="24" style="border-width: 1px; border-top-color: black; border-right-color: rgb(153,153,153);
                                                        border-bottom-color: rgb(153,153,153); border-left-color: rgb(153,153,153); border-top-style: none;
                                                        border-right-style: solid; border-bottom-style: solid; border-left-style: solid;"
                                                        bgcolor="#CCCCCC" align="center">
                                                        <img class="image-btn" onclick="onRemoveSlideImage(3)" src="img/cam_icon_trash.png"
                                                            width="18" height="21" border="0" name="image3">
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="tdSlide3Empty" class="clsSlideEmpty" onclick="onAddSlideImage(3)" cellpadding="0"
                                                cellspacing="0" align="center" style="cursor: pointer; border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="93" style="border-width: 1px; border-color: rgb(153,153,153);
                                                        border-style: solid;" align="center">
                                                        <span style="font-size: 24pt; color: #999999"></span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="95" height="100">
                                            <table id="tdSlide4Image" cellpadding="0" cellspacing="0" align="center" style="display: none;
                                                border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="69" style="border-width: 1px; border-top-color: rgb(153,153,153);
                                                        border-right-color: rgb(153,153,153); border-bottom-color: black; border-left-color: rgb(153,153,153);
                                                        border-top-style: solid; border-right-style: solid; border-bottom-style: none;
                                                        border-left-style: solid;" align="center">
                                                        <img class="slideImg" src="" width="80" height="57" border="0">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="85" height="24" style="border-width: 1px; border-top-color: black; border-right-color: rgb(153,153,153);
                                                        border-bottom-color: rgb(153,153,153); border-left-color: rgb(153,153,153); border-top-style: none;
                                                        border-right-style: solid; border-bottom-style: solid; border-left-style: solid;"
                                                        bgcolor="#CCCCCC" align="center">
                                                        <img class="image-btn" onclick="onRemoveSlideImage(4)" src="img/cam_icon_trash.png"
                                                            width="18" height="21" border="0" name="image3">
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="tdSlide4Empty" class="clsSlideEmpty" onclick="onAddSlideImage(4)" cellpadding="0"
                                                cellspacing="0" align="center" style="cursor: pointer; border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="93" style="border-width: 1px; border-color: rgb(153,153,153);
                                                        border-style: solid;" align="center">
                                                        <span style="font-size: 24pt; color: #999999"></span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="95" height="100">
                                            <table id="tdSlide5Image" cellpadding="0" cellspacing="0" align="center" style="display: none;
                                                border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="69" style="border-width: 1px; border-top-color: rgb(153,153,153);
                                                        border-right-color: rgb(153,153,153); border-bottom-color: black; border-left-color: rgb(153,153,153);
                                                        border-top-style: solid; border-right-style: solid; border-bottom-style: none;
                                                        border-left-style: solid;" align="center">
                                                        <img class="slideImg" src="" width="80" height="57" border="0">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="85" height="24" style="border-width: 1px; border-top-color: black; border-right-color: rgb(153,153,153);
                                                        border-bottom-color: rgb(153,153,153); border-left-color: rgb(153,153,153); border-top-style: none;
                                                        border-right-style: solid; border-bottom-style: solid; border-left-style: solid;"
                                                        bgcolor="#CCCCCC" align="center">
                                                        <img class="image-btn" onclick="onRemoveSlideImage(5)" src="img/cam_icon_trash.png"
                                                            width="18" height="21" border="0" name="image3">
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="tdSlide5Empty" class="clsSlideEmpty" onclick="onAddSlideImage(5)" cellpadding="0"
                                                cellspacing="0" align="center" style="cursor: pointer; border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="93" style="border-width: 1px; border-color: rgb(153,153,153);
                                                        border-style: solid;" align="center">
                                                        <span style="font-size: 24pt; color: #999999"></span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="95" height="100">
                                            <table id="tdSlide6Image" cellpadding="0" cellspacing="0" align="center" style="display: none;
                                                border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="69" style="border-width: 1px; border-top-color: rgb(153,153,153);
                                                        border-right-color: rgb(153,153,153); border-bottom-color: black; border-left-color: rgb(153,153,153);
                                                        border-top-style: solid; border-right-style: solid; border-bottom-style: none;
                                                        border-left-style: solid;" align="center">
                                                        <img class="slideImg" src="" width="80" height="57" border="0">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="85" height="24" style="border-width: 1px; border-top-color: black; border-right-color: rgb(153,153,153);
                                                        border-bottom-color: rgb(153,153,153); border-left-color: rgb(153,153,153); border-top-style: none;
                                                        border-right-style: solid; border-bottom-style: solid; border-left-style: solid;"
                                                        bgcolor="#CCCCCC" align="center">
                                                        <img class="image-btn" onclick="onRemoveSlideImage(6)" src="img/cam_icon_trash.png"
                                                            width="18" height="21" border="0" name="image3">
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="tdSlide6Empty" class="clsSlideEmpty" onclick="onAddSlideImage(6)" cellpadding="0"
                                                cellspacing="0" align="center" style="cursor: pointer; border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="93" style="border-width: 1px; border-color: rgb(153,153,153);
                                                        border-style: solid;" align="center">
                                                        <span style="font-size: 24pt; color: #999999"></span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="95" height="100">
                                            <table id="tdSlide7Image" cellpadding="0" cellspacing="0" align="center" style="display: none;
                                                border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="69" style="border-width: 1px; border-top-color: rgb(153,153,153);
                                                        border-right-color: rgb(153,153,153); border-bottom-color: black; border-left-color: rgb(153,153,153);
                                                        border-top-style: solid; border-right-style: solid; border-bottom-style: none;
                                                        border-left-style: solid;" align="center">
                                                        <img class="slideImg" src="" width="80" height="57" border="0">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="85" height="24" style="border-width: 1px; border-top-color: black; border-right-color: rgb(153,153,153);
                                                        border-bottom-color: rgb(153,153,153); border-left-color: rgb(153,153,153); border-top-style: none;
                                                        border-right-style: solid; border-bottom-style: solid; border-left-style: solid;"
                                                        bgcolor="#CCCCCC" align="center">
                                                        <img class="image-btn" onclick="onRemoveSlideImage(7)" src="img/cam_icon_trash.png"
                                                            width="18" height="21" border="0" name="image3">
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="tdSlide7Empty" class="clsSlideEmpty" onclick="onAddSlideImage(7)" cellpadding="0"
                                                cellspacing="0" align="center" style="cursor: pointer; border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="93" style="border-width: 1px; border-color: rgb(153,153,153);
                                                        border-style: solid;" align="center">
                                                        <span style="font-size: 24pt; color: #999999"></span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="95" height="100">
                                            <table id="tdSlide8Image" cellpadding="0" cellspacing="0" align="center" style="display: none;
                                                border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="69" style="border-width: 1px; border-top-color: rgb(153,153,153);
                                                        border-right-color: rgb(153,153,153); border-bottom-color: black; border-left-color: rgb(153,153,153);
                                                        border-top-style: solid; border-right-style: solid; border-bottom-style: none;
                                                        border-left-style: solid;" align="center">
                                                        <img class="slideImg" src="" width="80" height="57" border="0">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="85" height="24" style="border-width: 1px; border-top-color: black; border-right-color: rgb(153,153,153);
                                                        border-bottom-color: rgb(153,153,153); border-left-color: rgb(153,153,153); border-top-style: none;
                                                        border-right-style: solid; border-bottom-style: solid; border-left-style: solid;"
                                                        bgcolor="#CCCCCC" align="center">
                                                        <img class="image-btn" onclick="onRemoveSlideImage(8)" src="img/cam_icon_trash.png"
                                                            width="18" height="21" border="0" name="image3">
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="tdSlide8Empty" class="clsSlideEmpty" onclick="onAddSlideImage(8)" cellpadding="0"
                                                cellspacing="0" align="center" style="cursor: pointer; border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="93" style="border-width: 1px; border-color: rgb(153,153,153);
                                                        border-style: solid;" align="center">
                                                        <span style="font-size: 24pt; color: #999999"></span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="95" height="100">
                                            <table id="tdSlide9Image" cellpadding="0" cellspacing="0" align="center" style="display: none;
                                                border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="69" style="border-width: 1px; border-top-color: rgb(153,153,153);
                                                        border-right-color: rgb(153,153,153); border-bottom-color: black; border-left-color: rgb(153,153,153);
                                                        border-top-style: solid; border-right-style: solid; border-bottom-style: none;
                                                        border-left-style: solid;" align="center">
                                                        <img class="slideImg" src="" width="80" height="57" border="0">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="85" height="24" style="border-width: 1px; border-top-color: black; border-right-color: rgb(153,153,153);
                                                        border-bottom-color: rgb(153,153,153); border-left-color: rgb(153,153,153); border-top-style: none;
                                                        border-right-style: solid; border-bottom-style: solid; border-left-style: solid;"
                                                        bgcolor="#CCCCCC" align="center">
                                                        <img class="image-btn" onclick="onRemoveSlideImage(9)" src="img/cam_icon_trash.png"
                                                            width="18" height="21" border="0" name="image3">
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="tdSlide9Empty" class="clsSlideEmpty" onclick="onAddSlideImage(9)" cellpadding="0"
                                                cellspacing="0" align="center" style="cursor: pointer; border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="93" style="border-width: 1px; border-color: rgb(153,153,153);
                                                        border-style: solid;" align="center">
                                                        <span style="font-size: 24pt; color: #999999"></span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="95" height="100">
                                            <table id="tdSlide10Image" cellpadding="0" cellspacing="0" align="center" style="display: none;
                                                border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="69" style="border-width: 1px; border-top-color: rgb(153,153,153);
                                                        border-right-color: rgb(153,153,153); border-bottom-color: black; border-left-color: rgb(153,153,153);
                                                        border-top-style: solid; border-right-style: solid; border-bottom-style: none;
                                                        border-left-style: solid;" align="center">
                                                        <img class="slideImg" src="" width="80" height="57" border="0">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="85" height="24" style="border-width: 1px; border-top-color: black; border-right-color: rgb(153,153,153);
                                                        border-bottom-color: rgb(153,153,153); border-left-color: rgb(153,153,153); border-top-style: none;
                                                        border-right-style: solid; border-bottom-style: solid; border-left-style: solid;"
                                                        bgcolor="#CCCCCC" align="center">
                                                        <img class="image-btn" onclick="onRemoveSlideImage(10)" src="img/cam_icon_trash.png"
                                                            width="18" height="21" border="0" name="image3">
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="tdSlide10Empty" class="clsSlideEmpty" onclick="onAddSlideImage(10)" cellpadding="0"
                                                cellspacing="0" align="center" style="cursor: pointer; border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="93" style="border-width: 1px; border-color: rgb(153,153,153);
                                                        border-style: solid;" align="center">
                                                        <span style="font-size: 24pt; color: #999999"></span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="25">
                                            &nbsp;
                                        </td>
                                        <td width="91" height="25" align="right">
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                                <table cellpadding="0" cellspacing="0" align="center" width="476">
                                    <tr>
                                        <td width="115" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="38" align="left" class="clsTitleLabel">
                                                        이미지<br>
                                                        전환 연출
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="123" valign="top">
                                            <asp:RadioButtonList ID="rdoSlideShowType" CssClass="rdoSlideShowType rdoBtnList"
                                                runat="server">
                                                <asp:ListItem Value="0" Selected="True">없음</asp:ListItem>
                                                <asp:ListItem Value="1">페이드 인/아웃</asp:ListItem>
                                                <asp:ListItem Value="2">슬라이드</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="115" height="88" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="35" align="left" class="clsTitleLabel">
                                                        이미지 재생
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="88" valign="top">
                                            <asp:RadioButtonList ID="rdoSlidePlayType" CssClass="rdoSlidePlayType rdoBtnList"
                                                runat="server">
                                                <asp:ListItem Value="0" Selected="True">
                                                시간설정&nbsp;&nbsp;&nbsp;
                                                <select id="selTime">
                                                    <option value="3">3초</option>
                                                    <option value="4">4초</option>
                                                    <option value="5">5초</option>
                                                    <option value="6">6초</option>
                                                    <option value="7">7초</option>
                                                    <option value="8">8초</option>
                                                    <option value="9">9초</option>
                                                    <option value="10">10초</option>
                                                </select>
                                                </asp:ListItem>
                                                <asp:ListItem Value="1">이미지가 터치 시 전환됩니다.</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>

                        <tr>
                            <td width="110" height="76" align="center" class="clsTitleLabel">
                                실행옵션
                            </td>
                            <td width="377" height="76">
                                <table cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td width="367" height="32" class="clsLabel">
                                            <input id="sliderun_rd1" type="radio" name="sliderun_rd" value="0" onclick="onSlideRun_rd(0)" checked/>
                                            <label for="sliderun_rd1">스캔시 이미지 바로 표시(버튼사용 안함)</label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="367" height="32" class="clsLabel">
                                            <input id="sliderun_rd2" type="radio" name="sliderun_rd" value="1" onclick="onSlideRun_rd(1)"/>
                                            <label for="sliderun_rd2">이미지보기 버튼 사용</label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="367" height="32" class="clsLabel">
                                            <input id="sliderun_rd3" type="radio" name="sliderun_rd" value="2" onclick="onSlideRun_rd(2)"/>
                                            <label for="sliderun_rd3">커스텀 버튼 사용</label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr class="trNorSlideMode">
                            <td width="110" height="76" align="center" class="clsTitleLabel">
                                버튼모양
                            </td>
                            <td width="361" height="119" valign="top">
                                <table cellpadding="0" cellspacing="0" width="360">
                                    <tr>
                                        <td width="180" height="47" id="tdSlideModeBtn1" class="clsModeBtn">
                                            <table cellpadding="0" cellspacing="0" align="center"
                                                onclick="onChangeDefaultSlideBtn('Image slide',1)" style="cursor: pointer; border-collapse: collapse;"
                                                bgcolor="#F7F7F7" width="169">
                                                <tr>
                                                    <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                        border-style: solid;">
                                                        <table cellpadding="0" cellspacing="0" width="159">
                                                            <tr>
                                                                <td width="35" height="27" align="right">
                                                                    <img src="img/cam_icon08.png" width="19" height="19" border="0">
                                                                </td>
                                                                <td width="124" height="27" align="center">
                                                                    <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">Image slide</span></font></b>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="180" height="47" id="tdSlideModeBtn2" class="clsModeBtn">
                                            <table cellpadding="0" cellspacing="0" align="center"
                                                onclick="onChangeDefaultSlideBtn('이미지 슬라이드',2)" style="cursor: pointer; border-collapse: collapse;"
                                                bgcolor="#F7F7F7" width="169">
                                                <tr>
                                                    <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                        border-style: solid;">
                                                        <table cellpadding="0" cellspacing="0" width="159">
                                                            <tr>
                                                                <td width="35" height="27" align="right">
                                                                    <img src="img/cam_icon08.png" width="19" height="19" border="0">
                                                                </td>
                                                                <td width="124" height="27" align="center">
                                                                    <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">이미지 슬라이드</span></font></b>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="180" height="46" id="tdSlideModeBtn3" class="clsModeBtn">
                                            <table cellpadding="0" cellspacing="0" align="center"
                                                onclick="onChangeDefaultSlideBtn('||',3)" style="cursor: pointer; border-collapse: collapse;"
                                                bgcolor="#F7F7F7" width="169">
                                                <tr>
                                                    <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                        border-style: solid;">
                                                        <table cellpadding="0" cellspacing="0" width="159">
                                                            <tr>
                                                                <td width="35" height="27" align="right">
                                                                    <img src="img/cam_icon08.png" width="19" height="19" border="0">
                                                                </td>
                                                                <td width="124" height="27" align="center">
                                                                    <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">||</span></font></b>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="180" height="46" id="tdSlideModeBtn4" class="clsModeBtn">
                                            <table cellpadding="0" cellspacing="0" align="center"
                                                onclick="onChangeDefaultSlideBtn('Photo slide',4)" style="cursor: pointer; border-collapse: collapse;"
                                                bgcolor="#F7F7F7" width="169">
                                                <tr>
                                                    <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                        border-style: solid;">
                                                        <table cellpadding="0" cellspacing="0" width="159">
                                                            <tr>
                                                                <td width="35" height="27" align="right">
                                                                    <img src="img/cam_icon08.png" width="19" height="19" border="0">
                                                                </td>
                                                                <td width="124" height="27" align="center">
                                                                    <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">Photo slide</span></font></b>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr class="trNorSlideMode">
                            <td width="115" height="10" valign="top">
                                <table cellpadding="0" cellspacing="0" width="105" align="center">
                                    <tr>
                                        <td width="105" height="32" align="center" class="clsTitleLabel">
                                            버튼색상
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="361" height="61" valign="top">
                                <table cellpadding="0" cellspacing="0" width="350">
                                    <tr>
                                        <td width="35" height="35" id="tdSlideColorBtn11" class="clsColorBtn" onclick="onChangeSlideColor('#FFFFFF',11);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFFFF">
                                                <tr>
                                                    <td width="23" height="23" style="border:1px solid #DDDDDD;">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdSlideColorBtn1" class="clsColorBtn" onclick="onChangeSlideColor('#DDDDDD',1);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdSlideColorBtn2" class="clsColorBtn" onclick="onChangeSlideColor('#999999',2);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdSlideColorBtn3" class="clsColorBtn" onclick="onChangeSlideColor('black',3);">
                                            <table cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td width="25" height="25" bgcolor="black">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdSlideColorBtn4" class="clsColorBtn" onclick="onChangeSlideColor('#079DEC',4);">
                                            <table cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td width="25" height="25" bgcolor="#079DEC">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdSlideColorBtn5" class="clsColorBtn" onclick="onChangeSlideColor('#1234AB',5);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdSlideColorBtn6" class="clsColorBtn" onclick="onChangeSlideColor('red',6);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdSlideColorBtn7" class="clsColorBtn" onclick="onChangeSlideColor('#FF7700',7);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdSlideColorBtn8" class="clsColorBtn" onclick="onChangeSlideColor('#FFDD00',8);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdSlideColorBtn9" class="clsColorBtn" onclick="onChangeSlideColor('#33AA22',9);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdSlideColorBtn10" class="clsColorBtn" onclick="onChangeSlideColor('#BB33AA',10);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr class="trNorSlideMode">
                            <td width="115" height="10" valign="top">
                                <table cellpadding="0" cellspacing="0" width="105" align="center">
                                    <tr>
                                        <td width="105" height="32" align="center" class="clsTitleLabel">
                                            버튼 글 색상
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="361" height="61" valign="top">
                                <table cellpadding="0" cellspacing="0" width="350">
                                    <tr>
                                        <td width="35" height="35" id="tdSlideTextColorBtn11" class="clsTextColorBtn" onclick="onChangeTextColor('spSlidePreviewText','#FFFFFF','tdSlideTextColorBtn',11,'hdSlideTextColorIndex');">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFFFF">
                                                <tr>
                                                    <td width="23" height="23" style="border:1px solid #DDDDDD;">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdSlideTextColorBtn1" class="clsTextColorBtn" onclick="onChangeTextColor('spSlidePreviewText','#DDDDDD','tdSlideTextColorBtn',1,'hdSlideTextColorIndex');">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdSlideTextColorBtn2" class="clsTextColorBtn" onclick="onChangeTextColor('spSlidePreviewText','#999999','tdSlideTextColorBtn',2,'hdSlideTextColorIndex');">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdSlideTextColorBtn3" class="clsTextColorBtn" onclick="onChangeTextColor('spSlidePreviewText','black','tdSlideTextColorBtn',3,'hdSlideTextColorIndex');">
                                            <table cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td width="25" height="25" bgcolor="black">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdSlideTextColorBtn4" class="clsTextColorBtn" onclick="onChangeTextColor('spSlidePreviewText','#079DEC','tdSlideTextColorBtn',4,'hdSlideTextColorIndex');">
                                            <table cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td width="25" height="25" bgcolor="#079DEC">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdSlideTextColorBtn5" class="clsTextColorBtn" onclick="onChangeTextColor('spSlidePreviewText','#1234AB','tdSlideTextColorBtn',5,'hdSlideTextColorIndex');">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdSlideTextColorBtn6" class="clsTextColorBtn" onclick="onChangeTextColor('spSlidePreviewText','red','tdSlideTextColorBtn',6,'hdSlideTextColorIndex');">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdSlideTextColorBtn7" class="clsTextColorBtn" onclick="onChangeTextColor('spSlidePreviewText','#FF7700','tdSlideTextColorBtn',7,'hdSlideTextColorIndex');">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdSlideTextColorBtn8" class="clsTextColorBtn" onclick="onChangeTextColor('spSlidePreviewText','#FFDD00','tdSlideTextColorBtn',8,'hdSlideTextColorIndex');">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdSlideTextColorBtn9" class="clsTextColorBtn" onclick="onChangeTextColor('spSlidePreviewText','#33AA22','tdSlideTextColorBtn',9,'hdSlideTextColorIndex');">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdSlideTextColorBtn10" class="clsTextColorBtn" onclick="onChangeTextColor('spSlidePreviewText','#BB33AA','tdSlideTextColorBtn',10,'hdSlideTextColorIndex');">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr class="trNorSlideMode">
                            <td width="115" height="10" valign="top">
                                <table cellpadding="0" cellspacing="0" width="105" align="center">
                                    <tr>
                                        <td width="105" height="32" align="center" class="clsTitleLabel">
                                            버튼미리보기
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="361" height="61" valign="top">
                                <table cellpadding="0" cellspacing="0" width="316">
                                    <tr>
                                        <td width="180" height="47" valign="top">
                                            <table id="tblSlidePreviewBtn" cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                                                bgcolor="#F7F7F7" width="169">
                                                <tr>
                                                    <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                        border-style: solid;">
                                                        <table cellpadding="0" cellspacing="0" width="159">
                                                            <tr>
                                                                <td width="35" height="27" align="right">
                                                                    <img src="img/cam_icon02.png" width="19" height="19" border="0">
                                                                </td>
                                                                <td width="124" height="27" align="center">
                                                                    <b><font face="돋움"><span style="font-size: 10pt; color: #8C959A;" id="spSlidePreviewText">Image slide</span></font></b>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="136" height="47">
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr class="trCustomSlideMode">
                            <td width="115" height="10" valign="top">
                                <table cellpadding="0" cellspacing="0" width="105" align="center">
                                    <tr>
                                        <td width="105" height="32" align="center" class="clsTitleLabel">
                                            업로드
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="361" height="61" valign="top">
                                <table cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td width="367" height="32">
                                            <input id="slidebtn_path" type="file" name="slidebtn_path" accept="image/png" class="clsBrowser"
                                                size="30">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>

                        <tr>
                            <td colspan="2" width="500" height="79" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="485">
                                    <tr>
                                        <td width="485" height="41" align="right">
                                            <input type="hidden" id="hdSlideModeIndex" value="1" />
                                            <input type="hidden" id="hdSlideColorIndex" value="1" />
                                            <input type="hidden" id="hdSlideTextColorIndex" value="1" />
                                            <input type="button" id="Button11" onclick="OnSlideApply1()" class="clsButton" value="적용하기"
                                                style="font-weight: bold; width: 103px; height: 30px;" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="dvSlide3D" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="background-color: White">
            <tr>
                <td width="520" height="208" style="border-width: 1px; border-color: rgb(255,102,0);
                    border-style: solid;">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td width="500" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="31">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">이미지&nbsp;-&nbsp;3D템플릿
                                            </span></font></b>
                                        </td>
                                        <td width="91" height="31" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="98" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="469">
                                    <tr>
                                        <td width="469" height="87">
                                            <asp:RadioButtonList ID="rdoSlideViewType" CssClass="rdoSlideViewType rdoBtnList"
                                                runat="server">
                                                <asp:ListItem Value="0" Selected="True">적용 안함</asp:ListItem>
                                                <asp:ListItem Value="1">3D 스탠드 액자형</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="54" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="485">
                                    <tr>
                                        <td width="485" height="41" align="right">
                                            <input type="button" id="Button12" onclick="OnSlideApply2()" class="clsButton" value="적용하기"
                                                style="font-weight: bold; width: 103px; height: 30px;" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="dvCapture" class="clspopup">
        <table cellpadding="0" cellspacing="0" align="center" style="background-color: White;
            border-collapse: collapse;" width="502">
            <tr>
                <td width="500" height="96" style="border-width: 1px; border-top-color: black; border-right-color: black;
                    border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                    <table cellpadding="0" cellspacing="0" align="center" width="475">
                        <tr>
                            <td width="384" height="31">
                                <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">크로마키&nbsp;포토&nbsp;편집</span></font></b>
                            </td>
                            <td width="91" height="31" align="right">
                                <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                    height="16" border="0" name="image1" />
                            </td>
                        </tr>
                    </table>
                    <table cellpadding="0" cellspacing="0" align="center" width="475">
                        <tr>
                            <td width="421" height="43">
                                <span style="font-size: 10pt;"><font face="돋움" color="#4C4C4C">'+'버튼으로 표시될 이미지를 선택 후,
                                    아래에서 화면에 표시될 위치와<br>
                                    크기를 조정해 주세요.(이미지는 최대 5매 선택 가능합니다.)</font></span>
                            </td>
                            <td width="54" height="43" align="right">
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td width="500" height="264" align="center" style="border-width: 1px; border-top-color: rgb(229,233,235);
                    border-right-color: black; border-bottom-color: black; border-left-color: black;
                    border-style: none;">
                    <input type="hidden" id="addCaptureImgID" />
                    <input id="capture_file" type="file" name="capture_file" accept="image/png" style="position: absolute;
                        height: 46px; width: 260px; display: none;" />
                    <table cellpadding="0" cellspacing="0" bordercolordark="black" bordercolorlight="black"
                        align="center" width="475">
                        <tr>
                            <td width="95" height="100">
                                <table id="tdCapture1Image" cellpadding="0" cellspacing="0" align="center" style="display: none;
                                    border-collapse: collapse;">
                                    <tr>
                                        <td width="85" height="69" style="border-width: 1px; border-top-color: rgb(153,153,153);
                                            border-right-color: rgb(153,153,153); border-bottom-color: black; border-left-color: rgb(153,153,153);
                                            border-top-style: solid; border-right-style: solid; border-bottom-style: none;
                                            border-left-style: solid;" align="center">
                                            <img class="clscapprev" id="capimgPrev1" src="" width="80" height="57" border="0">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="85" height="24" style="border-width: 1px; border-top-color: black; border-right-color: rgb(153,153,153);
                                            border-bottom-color: rgb(153,153,153); border-left-color: rgb(153,153,153); border-top-style: none;
                                            border-right-style: solid; border-bottom-style: solid; border-left-style: solid;"
                                            bgcolor="#CCCCCC" align="center">
                                            <img class="image-btn" onclick="onRemoveSlideImage(11)" src="img/cam_icon_trash.png"
                                                width="18" height="21" border="0" name="image3">
                                        </td>
                                    </tr>
                                </table>
                                <table id="tdCapture1Empty" class="clsCaptureEmpty" onclick="onAddCaptureImage(1)"
                                    cellpadding="0" cellspacing="0" align="center" style="cursor: pointer; border-collapse: collapse;">
                                    <tr>
                                        <td width="85" height="93" style="border-width: 1px; border-color: rgb(153,153,153);
                                            border-style: solid;" align="center">
                                            <span style="font-size: 24pt; color: #999999"></span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="95" height="100">
                                <table id="tdCapture2Image" cellpadding="0" cellspacing="0" align="center" style="display: none;
                                    border-collapse: collapse;">
                                    <tr>
                                        <td width="85" height="69" style="border-width: 1px; border-top-color: rgb(153,153,153);
                                            border-right-color: rgb(153,153,153); border-bottom-color: black; border-left-color: rgb(153,153,153);
                                            border-top-style: solid; border-right-style: solid; border-bottom-style: none;
                                            border-left-style: solid;" align="center">
                                            <img class="clscapprev" id="capimgPrev2" src="" width="80" height="57" border="0">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="85" height="24" style="border-width: 1px; border-top-color: black; border-right-color: rgb(153,153,153);
                                            border-bottom-color: rgb(153,153,153); border-left-color: rgb(153,153,153); border-top-style: none;
                                            border-right-style: solid; border-bottom-style: solid; border-left-style: solid;"
                                            bgcolor="#CCCCCC" align="center">
                                            <img class="image-btn" onclick="onRemoveSlideImage(12)" src="img/cam_icon_trash.png"
                                                width="18" height="21" border="0" name="image3">
                                        </td>
                                    </tr>
                                </table>
                                <table id="tdCapture2Empty" class="clsCaptureEmpty" onclick="onAddCaptureImage(2)"
                                    cellpadding="0" cellspacing="0" align="center" style="cursor: pointer; border-collapse: collapse;">
                                    <tr>
                                        <td width="85" height="93" style="border-width: 1px; border-color: rgb(153,153,153);
                                            border-style: solid;" align="center">
                                            <span style="font-size: 24pt; color: #999999"></span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="95" height="100">
                                <table id="tdCapture3Image" cellpadding="0" cellspacing="0" align="center" style="display: none;
                                    border-collapse: collapse;">
                                    <tr>
                                        <td width="85" height="69" style="border-width: 1px; border-top-color: rgb(153,153,153);
                                            border-right-color: rgb(153,153,153); border-bottom-color: black; border-left-color: rgb(153,153,153);
                                            border-top-style: solid; border-right-style: solid; border-bottom-style: none;
                                            border-left-style: solid;" align="center">
                                            <img class="clscapprev" id="capimgPrev3" src="" width="80" height="57" border="0">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="85" height="24" style="border-width: 1px; border-top-color: black; border-right-color: rgb(153,153,153);
                                            border-bottom-color: rgb(153,153,153); border-left-color: rgb(153,153,153); border-top-style: none;
                                            border-right-style: solid; border-bottom-style: solid; border-left-style: solid;"
                                            bgcolor="#CCCCCC" align="center">
                                            <img class="image-btn" onclick="onRemoveSlideImage(13)" src="img/cam_icon_trash.png"
                                                width="18" height="21" border="0" name="image3">
                                        </td>
                                    </tr>
                                </table>
                                <table id="tdCapture3Empty" class="clsCaptureEmpty" onclick="onAddCaptureImage(3)"
                                    cellpadding="0" cellspacing="0" align="center" style="cursor: pointer; border-collapse: collapse;">
                                    <tr>
                                        <td width="85" height="93" style="border-width: 1px; border-color: rgb(153,153,153);
                                            border-style: solid;" align="center">
                                            <span style="font-size: 24pt; color: #999999"></span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="95" height="100">
                                <table id="tdCapture4Image" cellpadding="0" cellspacing="0" align="center" style="display: none;
                                    border-collapse: collapse;">
                                    <tr>
                                        <td width="85" height="69" style="border-width: 1px; border-top-color: rgb(153,153,153);
                                            border-right-color: rgb(153,153,153); border-bottom-color: black; border-left-color: rgb(153,153,153);
                                            border-top-style: solid; border-right-style: solid; border-bottom-style: none;
                                            border-left-style: solid;" align="center">
                                            <img class="clscapprev" id="capimgPrev4" src="" width="80" height="57" border="0">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="85" height="24" style="border-width: 1px; border-top-color: black; border-right-color: rgb(153,153,153);
                                            border-bottom-color: rgb(153,153,153); border-left-color: rgb(153,153,153); border-top-style: none;
                                            border-right-style: solid; border-bottom-style: solid; border-left-style: solid;"
                                            bgcolor="#CCCCCC" align="center">
                                            <img class="image-btn" onclick="onRemoveSlideImage(14)" src="img/cam_icon_trash.png"
                                                width="18" height="21" border="0" name="image3">
                                        </td>
                                    </tr>
                                </table>
                                <table id="tdCapture4Empty" class="clsCaptureEmpty" onclick="onAddCaptureImage(4)"
                                    cellpadding="0" cellspacing="0" align="center" style="cursor: pointer; border-collapse: collapse;">
                                    <tr>
                                        <td width="85" height="93" style="border-width: 1px; border-color: rgb(153,153,153);
                                            border-style: solid;" align="center">
                                            <span style="font-size: 24pt; color: #999999"></span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="95" height="100">
                                <table id="tdCapture5Image" cellpadding="0" cellspacing="0" align="center" style="display: none;
                                    border-collapse: collapse;">
                                    <tr>
                                        <td width="85" height="69" style="border-width: 1px; border-top-color: rgb(153,153,153);
                                            border-right-color: rgb(153,153,153); border-bottom-color: black; border-left-color: rgb(153,153,153);
                                            border-top-style: solid; border-right-style: solid; border-bottom-style: none;
                                            border-left-style: solid;" align="center">
                                            <img class="clscapprev" id="capimgPrev5" src="" width="80" height="57" border="0">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="85" height="24" style="border-width: 1px; border-top-color: black; border-right-color: rgb(153,153,153);
                                            border-bottom-color: rgb(153,153,153); border-left-color: rgb(153,153,153); border-top-style: none;
                                            border-right-style: solid; border-bottom-style: solid; border-left-style: solid;"
                                            bgcolor="#CCCCCC" align="center">
                                            <img class="image-btn" onclick="onRemoveSlideImage(15)" src="img/cam_icon_trash.png"
                                                width="18" height="21" border="0" name="image3">
                                        </td>
                                    </tr>
                                </table>
                                <table id="tdCapture5Empty" class="clsCaptureEmpty" onclick="onAddCaptureImage(5)"
                                    cellpadding="0" cellspacing="0" align="center" style="cursor: pointer; border-collapse: collapse;">
                                    <tr>
                                        <td width="85" height="93" style="border-width: 1px; border-color: rgb(153,153,153);
                                            border-style: solid;" align="center">
                                            <span style="font-size: 24pt; color: #999999"></span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <div id="capture_detail_div" style="position: relative; width: 475px; height: 250px;
                        background-color: #CCCCCC; z-index: 1">
                    </div>
                    <table cellpadding="0" cellspacing="0" align="center" width="475">
                        <tr>
                            <td width="384" height="25">
                                &nbsp;
                            </td>
                            <td width="91" height="25" align="right">
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                    <table cellpadding="0" cellspacing="0" align="center" width="476">
                        <tr>
                            <td width="115" height="86" valign="top">
                                <table cellpadding="0" cellspacing="0" width="105" align="center">
                                    <tr>
                                        <td width="105" height="38" align="left" class="clsTitleLabel">
                                            버튼종류
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="361" height="86" valign="top" align="left">
                                <asp:RadioButtonList ID="rdbCapture" CssClass="rdbCapture rdoBtnList" runat="server">
                                    <asp:ListItem Value="0" Selected="True">기본버튼</asp:ListItem>
                                    <asp:ListItem Value="1">커스텀버튼</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr class="clsCustomCaptureMode">
                            <td width="115" height="35" valign="top">
                                <table cellpadding="0" cellspacing="0" width="105" align="center">
                                    <tr>
                                        <td width="105" height="35" align="left" class="clsTitleLabel">
                                            업로드
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="361" height="35" valign="top">
                                <table cellpadding="0" cellspacing="0" width="356">
                                    <tr>
                                        <td width="180" height="35">
                                            <input id="capturebtn_path" type="file" name="capturebtn_path" accept="image/jpeg, image/png"
                                                class="clsBrowser" size="35" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr class="clsNorCaptureMode">
                            <td width="115" height="55" valign="center">
                                <table cellpadding="0" cellspacing="0" width="105" align="center">
                                    <tr>
                                        <td width="105" height="35" align="left" class="clsTitleLabel">
                                            버튼 종류
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="361" height="55" valign="center">
                                <table cellpadding="0" cellspacing="0" width="356">
                                    <tr>
                                        <td width="180" height="47" valign="center" id="tdCaptureModeBtn1" class="clsModeBtn" >
                                            <table cellpadding="0" cellspacing="0" align="center" onclick="onChangeCaptureType(0);"
                                                style="cursor: pointer; border-collapse: collapse;" bgcolor="#F7F7F7" width="169">
                                                <tr>
                                                    <td width="167" height="35" style="border-width: 1px; border-color: rgb(187,187,187);
                                                        border-style: solid;">
                                                        <div align="left">
                                                            <table cellpadding="0" cellspacing="0" width="161">
                                                                <tr>
                                                                    <td width="35" height="27" align="right">
                                                                        <img src="img/cam_icon09.png" width="19" height="19" border="0">
                                                                    </td>
                                                                    <td width="126" height="27" align="center">
                                                                        <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">Chroma-key photo</span></font></b>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="176" height="47" valign="center" id="tdCaptureModeBtn2" class="clsModeBtn">
                                            <table cellpadding="0" cellspacing="0" align="center" onclick="onChangeCaptureType(1);"
                                                style="cursor: pointer; border-collapse: collapse;" bgcolor="#F7F7F7" width="169">
                                                <tr>
                                                    <td width="167" height="35" style="border-width: 1px; border-color: rgb(187,187,187);
                                                        border-style: solid;">
                                                        <div align="left">
                                                            <table cellpadding="0" cellspacing="0" width="161">
                                                                <tr>
                                                                    <td width="35" height="27" align="right">
                                                                        <img src="img/cam_icon09.png" width="19" height="19" border="0">
                                                                    </td>
                                                                    <td width="126" height="27" align="center">
                                                                        <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">함께사진찍기</span></font></b>
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
                            </td>
                        </tr>
                    </table>
                    <table class="clsNorCaptureMode" cellpadding="0" cellspacing="0" align="center" width="476">
                        <tr>
                            <td width="115" height="10" valign="center">
                                <table cellpadding="0" cellspacing="0" width="105" align="center">
                                    <tr>
                                        <td width="105" height="32" align="center" class="clsTitleLabel">
                                            색상
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="361" height="61" valign="center">
                                <table cellpadding="0" cellspacing="0" width="350">
                                    <tr>
                                        <td width="35" height="35" id="tdCaptureColorBtn11" class="clsColorBtn" onclick="onChangeCaptureColor('#FFFFFF',11);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFFFF">
                                                <tr>
                                                    <td width="25" height="25" style="border:1px solid #DDDDDD">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdCaptureColorBtn1" class="clsColorBtn" onclick="onChangeCaptureColor('#DDDDDD',1);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdCaptureColorBtn2" class="clsColorBtn" onclick="onChangeCaptureColor('#999999',2);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdCaptureColorBtn3" class="clsColorBtn" onclick="onChangeCaptureColor('black',3);">
                                            <table cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td width="25" height="25" bgcolor="black">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdCaptureColorBtn4" class="clsColorBtn" onclick="onChangeCaptureColor('#079DEC',4);">
                                            <table cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td width="25" height="25" bgcolor="#079DEC">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdCaptureColorBtn5" class="clsColorBtn" onclick="onChangeCaptureColor('#1234AB',5);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdCaptureColorBtn6" class="clsColorBtn" onclick="onChangeCaptureColor('red',6);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdCaptureColorBtn7" class="clsColorBtn" onclick="onChangeCaptureColor('#FF7700',7);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdCaptureColorBtn8" class="clsColorBtn" onclick="onChangeCaptureColor('#FFDD00',8);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdCaptureColorBtn9" class="clsColorBtn" onclick="onChangeCaptureColor('#33AA22',9);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdCaptureColorBtn10" class="clsColorBtn" onclick="onChangeCaptureColor('#BB33AA',10);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <table class="clsNorCaptureMode" cellpadding="0" cellspacing="0" align="center" width="476">
                        <tr>
                            <td width="115" height="10" valign="top">
                                <table cellpadding="0" cellspacing="0" width="105" align="center">
                                    <tr>
                                        <td width="105" height="32" align="center" class="clsTitleLabel">
                                            버튼미리보기
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="361" height="61" valign="top">
                                <table cellpadding="0" cellspacing="0" width="355">
                                    <tr>
                                        <td width="180" height="47" valign="top">                                            
                                            <table id="tblCapturePreviewBtn" cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                                                bgcolor="#F7F7F7" width="169">
                                                <tr>
                                                    <td width="167" height="35" style="border-width: 1px; border-color: rgb(187,187,187);
                                                        border-style: solid;">
                                                        <div align="left">
                                                            <table cellpadding="0" cellspacing="0" width="161">
                                                                <tr>
                                                                    <td width="35" height="27" align="right">
                                                                        <img src="img/cam_icon09.png" width="19" height="19" border="0">
                                                                    </td>
                                                                    <td width="126" height="27" align="center">
                                                                        <b><font face="돋움"><span style="font-size: 10pt; color: #8C959A;" id="spCapture">Chroma-key photo</span></font></b>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="175" height="47">
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td width="500" height="69" style="border-width: 1px; border-top-color: rgb(229,233,235);
                    border-right-color: black; border-bottom-color: black; border-left-color: black;
                    border-style: none;">
                    <div align="right">
                        <table cellpadding="0" cellspacing="0" align="center" width="485">
                            <tr>
                                <td align="right" width="485" height="41">
                                    <input type="hidden" id="hdCaptureType" value="0" />
                                    <input type="hidden" id="hdCaptureColorIndex" value="0" />
                                    <input type="button" id="Button1" onclick="OnCaptureApply()" class="clsButton" value="적용하기"
                                        style="font-weight: bold; width: 103px; height: 30px;" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <div id="dvChromaKey" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="background-color: White">
            <tr>
                <td width="520" height="363" style="border-width: 1px; border-color: rgb(255,102,0);
                    border-style: solid;">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td width="500" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="31">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">크로마키&nbsp;비디오&nbsp;편집</span></font></b>
                                        </td>
                                        <td width="91" height="31" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="161" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="487">
                                    <tr>
                                        <td width="110" height="65" align="center" class="clsTitleLabel">
                                            업로드
                                        </td>
                                        <td width="377" height="65" align="center">
                                            <input type="button" value="파일 선택" onclick="javascript:OnBrowse('chromakey_file')" /><!--
                                        --><input type="text" id="chromakey_file_text" size="30" placeholder="MOV" readonly="readonly" />
                                            <input type="file" id="chromakey_file" name="fileImg" accept="video/mp4, video/quicktime" class="clsBrowser"
                                                style="display: none" size="49" onchange="document.getElementById('chromakey_file_text').value=this.value" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="110" height="88" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="34" align="center" class="clsTitleLabel">
                                                        재생방향
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="377" height="88" valign="top">
                                            <table cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="chromakeyview_rd1" type="radio" name="chromakeyview_rd" title="마커와 평행"
                                                            value="0" checked />
                                                        마커와 평행
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="chromakeyview_rd2" type="radio" name="chromakeyview_rd" title="마커와 90도"
                                                            value="1" />
                                                        마커와 90도
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="110" height="89" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="34" align="center" class="clsTitleLabel">
                                                        자동재생
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="377" height="89" valign="top">
                                            <table cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="chromakeyrun_rd1" type="radio" name="chromakeyrun_rd" value="0" onclick="onChromakeyRun_rd(0)" checked />
                                                        <label for="chromakeyrun_rd1">동영상이 자동으로 재생됩니다.(버튼사용 안함)</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="chromakeyrun_rd2" type="radio" name="chromakeyrun_rd" value="1" onclick="onChromakeyRun_rd(1)"/>
                                                        <label for="chromakeyrun_rd2">동영상이 수동으로 재생됩니다.(버튼사용 안함)</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="chromakeyrun_rd3" type="radio" name="chromakeyrun_rd" value="2" onclick="onChromakeyRun_rd(2)"/>
                                                        <label for="chromakeyrun_rd3">이미지보기 버튼 사용</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="chromakeyrun_rd4" type="radio" name="chromakeyrun_rd" value="3" onclick="onChromakeyRun_rd(3)"/>
                                                        <label for="chromakeyrun_rd4">커스텀 버튼 사용</label>
                                                    </td>
                                                </tr>

                                            </table>
                                        </td>
                                    </tr>

                                    <tr class="trNorChromakeyMode">
                                        <td width="110" height="76" align="center" class="clsTitleLabel">
                                            버튼모양
                                        </td>
                                        <td width="361" height="119" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="360">
                                                <tr>
                                                    <td width="180" height="47" id="tdChromakeyModeBtn1" class="clsModeBtn">
                                                        <table cellpadding="0" cellspacing="0" align="center"
                                                            onclick="onChangeDefaultChromakeyBtn('Video',1)" style="cursor: pointer; border-collapse: collapse;"
                                                            bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon10.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">Video</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="180" height="47" id="tdChromakeyModeBtn2" class="clsModeBtn">
                                                        <table cellpadding="0" cellspacing="0" align="center"
                                                            onclick="onChangeDefaultChromakeyBtn('영상재생',2)" style="cursor: pointer; border-collapse: collapse;"
                                                            bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon10.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">영상재생</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="180" height="46" id="tdChromakeyModeBtn3" class="clsModeBtn">
                                                        <table cellpadding="0" cellspacing="0" align="center"
                                                            onclick="onChangeDefaultChromakeyBtn('|>',3)" style="cursor: pointer; border-collapse: collapse;"
                                                            bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon10.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">|></span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="180" height="46" id="tdChromakeyModeBtn4" class="clsModeBtn">
                                                        <table cellpadding="0" cellspacing="0" align="center"
                                                            onclick="onChangeDefaultChromakeyBtn('PLAY',4)" style="cursor: pointer; border-collapse: collapse;"
                                                            bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon10.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">PLAY</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="trNorChromakeyMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        버튼색상
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="350">
                                                <tr>
                                                    <td width="35" height="35" id="tdChromakeyColorBtn11" class="clsColorBtn" onclick="onChangeChromakeyColor('#FFFFFF',11);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFFFF">
                                                            <tr>
                                                                <td width="23" height="23" style="border:1px solid #DDDDDD;">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdChromakeyColorBtn1" class="clsColorBtn" onclick="onChangeChromakeyColor('#DDDDDD',1);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdChromakeyColorBtn2" class="clsColorBtn" onclick="onChangeChromakeyColor('#999999',2);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdChromakeyColorBtn3" class="clsColorBtn" onclick="onChangeChromakeyColor('black',3);">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="black">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdChromakeyColorBtn4" class="clsColorBtn" onclick="onChangeChromakeyColor('#079DEC',4);">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="#079DEC">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdChromakeyColorBtn5" class="clsColorBtn" onclick="onChangeChromakeyColor('#1234AB',5);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdChromakeyColorBtn6" class="clsColorBtn" onclick="onChangeChromakeyColor('red',6);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdChromakeyColorBtn7" class="clsColorBtn" onclick="onChangeChromakeyColor('#FF7700',7);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdChromakeyColorBtn8" class="clsColorBtn" onclick="onChangeChromakeyColor('#FFDD00',8);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdChromakeyColorBtn9" class="clsColorBtn" onclick="onChangeChromakeyColor('#33AA22',9);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdChromakeyColorBtn10" class="clsColorBtn" onclick="onChangeChromakeyColor('#BB33AA',10);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="trNorChromakeyMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        버튼 글 색상
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="350">
                                                <tr>
                                                    <td width="35" height="35" id="tdChromakeyTextColorBtn11" class="clsTextColorBtn" onclick="onChangeTextColor('spChromakeyPreviewText','#FFFFFF','tdChromakeyTextColorBtn',11,'hdChromakeyTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFFFF">
                                                            <tr>
                                                                <td width="23" height="23" style="border:1px solid #DDDDDD;">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdChromakeyTextColorBtn1" class="clsTextColorBtn" onclick="onChangeTextColor('spChromakeyPreviewText','#DDDDDD','tdChromakeyTextColorBtn',1,'hdChromakeyTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdChromakeyTextColorBtn2" class="clsTextColorBtn" onclick="onChangeTextColor('spChromakeyPreviewText','#999999','tdChromakeyTextColorBtn',2,'hdChromakeyTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdChromakeyTextColorBtn3" class="clsTextColorBtn" onclick="onChangeTextColor('spChromakeyPreviewText','black','tdChromakeyTextColorBtn',3,'hdChromakeyTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="black">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdChromakeyTextColorBtn4" class="clsTextColorBtn" onclick="onChangeTextColor('spChromakeyPreviewText','#079DEC','tdChromakeyTextColorBtn',4,'hdChromakeyTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="#079DEC">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdChromakeyTextColorBtn5" class="clsTextColorBtn" onclick="onChangeTextColor('spChromakeyPreviewText','#1234AB','tdChromakeyTextColorBtn',5,'hdChromakeyTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdChromakeyTextColorBtn6" class="clsTextColorBtn" onclick="onChangeTextColor('spChromakeyPreviewText','red','tdChromakeyTextColorBtn',6,'hdChromakeyTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdChromakeyTextColorBtn7" class="clsTextColorBtn" onclick="onChangeTextColor('spChromakeyPreviewText','#FF7700','tdChromakeyTextColorBtn',7,'hdChromakeyTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdChromakeyTextColorBtn8" class="clsTextColorBtn" onclick="onChangeTextColor('spChromakeyPreviewText','#FFDD00','tdChromakeyTextColorBtn',8,'hdChromakeyTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdChromakeyTextColorBtn9" class="clsTextColorBtn" onclick="onChangeTextColor('spChromakeyPreviewText','#33AA22','tdChromakeyTextColorBtn',9,'hdChromakeyTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdChromakeyTextColorBtn10" class="clsTextColorBtn" onclick="onChangeTextColor('spChromakeyPreviewText','#BB33AA','tdChromakeyTextColorBtn',10,'hdChromakeyTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="trNorChromakeyMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        버튼미리보기
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="316">
                                                <tr>
                                                    <td width="180" height="47" valign="top">
                                                        <table id="tblChromakeyPreviewBtn" cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                                                            bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon10.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움"><span style="font-size: 10pt; color: #8C959A;" id="spChromakeyPreviewText">Video</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="136" height="47">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="trCustomChromakeyMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        업로드
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="367" height="32">
                                                        <input id="chromakeybtn_path" type="file" name="chromakeybtn_path" accept="image/png" class="clsBrowser"
                                                            size="30">
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>

                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="55" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="485">
                                    <tr>
                                        <td width="485" height="41" align="right">
                                            <input type="hidden" id="hdChromakeyModeIndex" value="1" />
                                            <input type="hidden" id="hdChromakeyColorIndex" value="1" />
                                            <input type="hidden" id="hdChromakeyTextColorIndex" value="1" />
                                            <input type="button" id="Button13" onclick="OnChromakeyApply()" class="clsButton"
                                                value="적용하기" style="font-weight: bold; width: 103px; height: 30px;" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="dv3DObj" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="background-color: White">
            <tr>
                <td width="520" height="559" style="border-width: 1px; border-color: rgb(255,102,0);
                    border-style: solid;">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td width="500" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="48">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">3D 오브젝트&nbsp;편집</span></font></b>
                                        </td>
                                        <td width="91" height="48" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="161" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="487">
                                    <tr>
                                        <td width="110" height="65" align="center" class="clsTitleLabel">
                                            업로드
                                        </td>
                                        <td width="377" height="65" align="left">
                                            <input type="text" id="fileunity3d_text" size="30" placeholder="unity3d 파일" readonly="readonly" />
                                            <input type="button" value="찾아보기..." onclick="javascript:OnBrowse('three_file1')" />
                                            <input id="three_file1" type="file" name="three_file1" accept="application/unity3d"
                                                class="clsBrowser" style="display: none" size="31" onchange="document.getElementById('fileunity3d_text').value=this.value">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="110" height="65" align="center" class="clsTitleLabel">
                                        </td>
                                        <td width="377" height="65" align="left">
                                            <input type="text" id="fileassetbundle_text" size="30" placeholder="assetbundle 파일" readonly="readonly" />
                                            <input type="button" value="찾아보기..." onclick="javascript:OnBrowse('three_file2')" />
                                            <input id="three_file2" type="file" name="three_file2" accept="application/assetbundle"
                                                class="clsBrowser" style="display: none" size="31" onchange="document.getElementById('fileassetbundle_text').value=this.value">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="110" height="65" align="center" class="clsTitleLabel">
                                            객체 정면방향
                                        </td>
                                        <td width="377" height="65">
                                            <table cellpadding="0" cellspacing="0" width="366">
                                                <tr>
                                                    <td width="223" height="39" align="left">
                                                        <input type="text" id="front_angle" name="front_angle" onkeypress="num_only()" style="float: left"
                                                            size="28">
                                                    </td>
                                                    <td width="143" height="39" class="clsLabel">
                                                        <font color="#727272">(1~360, 정면방향=180도)</font>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="110" height="53" align="center" class="clsTitleLabel">
                                            밝기
                                        </td>
                                        <td width="377" height="53">
                                            <table cellpadding="0" cellspacing="0" width="366">
                                                <tr>
                                                    <td width="45" height="24" align="left" class="clsLabel">
                                                        어두움
                                                    </td>
                                                    <td width="282" height="24" background="img/3D_scrollbar.png">
                                                        <input type="hidden" id="hdBright" />
                                                        <table cellpadding="0" cellspacing="0" width="282" align="center">
                                                            <tr>
                                                                <td width="5">
                                                                </td>
                                                                <td width="24" id="tdBright1" align="center" class="brightless" onclick="onSelBrightLess(1)"
                                                                    style="cursor: pointer">
                                                                    <img src="img/3D_scrollbarhandle.png" width="24" height="25" border="0">
                                                                </td>
                                                                <td width="39">
                                                                </td>
                                                                <td width="24" id="tdBright25" align="center" class="brightless" onclick="onSelBrightLess(25)"
                                                                    style="cursor: pointer">
                                                                    <img src="img/3D_scrollbarhandle.png" width="24" height="25" border="0">
                                                                </td>
                                                                <td width="40">
                                                                </td>
                                                                <td width="24" id="tdBright50" align="center" class="brightless" onclick="onSelBrightLess(50)"
                                                                    style="cursor: pointer">
                                                                    <img src="img/3D_scrollbarhandle.png" width="24" height="25" border="0">
                                                                </td>
                                                                <td width="38">
                                                                </td>
                                                                <td width="24" id="tdBright75" align="center" class="brightless" onclick="onSelBrightLess(75)"
                                                                    style="cursor: pointer">
                                                                    <img src="img/3D_scrollbarhandle.png" width="24" height="25" border="0">
                                                                </td>
                                                                <td width="35">
                                                                </td>
                                                                <td width="24" id="tdBright100" align="center" class="brightless" onclick="onSelBrightLess(100)"
                                                                    style="cursor: pointer">
                                                                    <img src="img/3D_scrollbarhandle.png" width="24" height="25" border="0">
                                                                </td>
                                                                <td width="5">
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="42" height="24" class="clsLabel">
                                                        밝음
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="110" height="60" align="center" class="clsTitleLabel">
                                            실행횟수
                                        </td>
                                        <td width="377" height="60">
                                            <table cellpadding="0" cellspacing="0" width="366">
                                                <tr>
                                                    <td width="223" height="39" align="left">
                                                        <input type="text" id="run_times" name="run_times" onkeypress="num_only()" size="28">
                                                    </td>
                                                    <td width="143" height="39" class="clsLabel">
                                                        회<font color="#727272">(0의 경우 무제한)</font>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="110" height="113" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="34" align="center" class="clsTitleLabel">
                                                        재생방향
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="377" height="113" valign="top">
                                            <asp:RadioButtonList ID="RadioButtonList1" CssClass="rdoBtnList rdbThree" runat="server"
                                                BackColor="#FBFBFB">
                                                <asp:ListItem Value="0" Selected>일반형</asp:ListItem>
                                                <asp:ListItem Value="1">상하형</asp:ListItem>
                                                <asp:ListItem Value="2">페이드인 형</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="55" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="485">
                                    <tr>
                                        <td width="485" height="41" align="right">
                                            <input type="button" id="Button15" onclick="OnThreeApply()" class="clsButton" value="편집적용"
                                                style="font-weight: bold; width: 103px; height: 30px;" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>

    <div id="dvPdf" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="background-color: White">
            <tr>
                <td width="520" height="195" style="border-width: 1px; border-color: rgb(255,102,0);
                    border-style: solid;">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td colspan="2" width="500" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="31">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">PDF&nbsp;viewer&nbsp;편집</span></font></b>
                                        </td>
                                        <td width="91" height="31" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" width="500" height="86" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="487">
                                    <tr>
                                        <td width="110" height="40" align="center" class="clsTitleLabel">
                                            PDF등록
                                        </td>
                                        <td width="377" height="40" align="center">
                                            <input type="text" id="filepdf_text" size="30" placeholder="pdf 파일" readonly="readonly" />
                                            <input type="button" value="찾아보기..." onclick="javascript:OnBrowse('pdf_file')" />
                                            <input id="pdf_file" type="file" name="pdf_path" accept="application/pdf"
                                                class="clsBrowser" style="display: none" size="31" onchange="document.getElementById('filepdf_text').value=this.value">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="110" height="40" align="center" class="clsTitleLabel">
                                        </td>
                                        <td width="377" height="40" align="center" class="clsTitleLabel">
                                          ※ 등록하는 파일은 10M이하의 Pdf파일만 가능합니다.
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" colspan="2" width="500" height="190" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="487">
                                    <tr>
                                        <td width="110" height="170" align="center" class="clsTitleLabel">
                                            PDF등록
                                        </td>
                                        <td width="377" height="170" align="center">
                                            <table cellpadding="0" cellspacing="0" width="377" align="center">
                                                <tr>
                                                    <td width="370" height="170">
                                                        <div align="center" style="overflow-x:scroll; width:350px; height:160px; background-color:Gray; border-width:1px; border-color:#e5a3c9; border-style: solid;">
                                                            <div style=" margin-top:5px;">
                                                                <table id="prev_tbl" cellpadding="0" cellspacing="0" width="350">
                                                                    <tr>
                                                                        <td width="100" height="120">
                                                                            <table cellpadding="0" cellspacing="0" style="border-collapse: collapse;" width="100"
                                                                                align="center">
                                                                                <tbody>
                                                                                    <tr>
                                                                                        <td width="100" height="120" style="border-width: 1; border-color: rgb(68,68,68);
                                                                                            border-style: solid;" background="img/a_04_cimg01.png">
                                                                                        </td>
                                                                                    </tr>
                                                                                </tbody>
                                                                            </table>
                                                                        </td>
                                                                        <td width="100" height="120">
                                                                            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                                                                                width="100">
                                                                                <tr>
                                                                                    <td width="100" height="120" style="border-width: 1; border-color: rgb(68,68,68);
                                                                                        border-style: solid;" background="img/a_04_cimg01.png">
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                        <td width="100" height="120">
                                                                            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                                                                                width="100">
                                                                                <tr>
                                                                                    <td width="100" height="120" style="border-width: 1; border-color: rgb(68,68,68);
                                                                                        border-style: solid;" background="img/a_04_cimg01.png">
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                            <input type="hidden" id="hdPdfName" value="" />
                                            <input type="hidden" id="hdPdfSize" value="" />
                                            <input type="hidden" id="hdPdfPageCount" value="" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="110" height="76" align="center" class="clsTitleLabel">
                                실행옵션
                            </td>
                            <td width="377" height="76" valign="middle">
                                <table cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td width="367" height="32" class="clsLabel">
                                            <input id="pdfrun_rd1" type="radio" name="pdfrun_rd" value="0" onclick="onPdfRun_rd(0)" checked/>
                                            <label for="pdfrun_rd1">전체화면사용<br />(스캔직후 PDF뷰어가 전체화면으로 표시됨)</label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="367" height="32" class="clsLabel">
                                            <input id="pdfrun_rd2" type="radio" name="pdfrun_rd" value="1" onclick="onPdfRun_rd(1)"/>
                                            <label for="pdfrun_rd2">재생 버튼 사용</label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="367" height="32" class="clsLabel">
                                            <input id="pdfrun_rd3" type="radio" name="pdfrun_rd" value="2" onclick="onPdfRun_rd(2)"/>
                                            <label for="pdfrun_rd3">커스텀 버튼 사용</label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr class="trNorPdfMode">
                            <td width="110" height="80" valign="middle" align="center" class="clsTitleLabel">
                                버튼모양
                            </td>
                            <td width="361" height="80" valign="middle">
                                <table cellpadding="0" cellspacing="0" width="360">
                                    <tr>
                                        <td width="180" height="47" id="tdPdfModeBtn1" class="clsModeBtn">
                                            <table cellpadding="0" cellspacing="0" align="center"
                                                onclick="onChangeDefaultPdfBtn('PDF viewer',1)" style="cursor: pointer; border-collapse: collapse;"
                                                bgcolor="#F7F7F7" width="169">
                                                <tr>
                                                    <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                        border-style: solid;">
                                                        <table cellpadding="0" cellspacing="0" width="159">
                                                            <tr>
                                                                <td width="35" height="27" align="right">
                                                                    <img src="img/cam_icon11.png" width="19" height="19" border="0">
                                                                </td>
                                                                <td width="124" height="27" align="center">
                                                                    <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">PDF viewer</span></font></b>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="180" height="47" id="tdPdfModeBtn2" class="clsModeBtn">
                                            <table cellpadding="0" cellspacing="0" align="center"
                                                onclick="onChangeDefaultPdfBtn('안내 책자',2)" style="cursor: pointer; border-collapse: collapse;"
                                                bgcolor="#F7F7F7" width="169">
                                                <tr>
                                                    <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                        border-style: solid;">
                                                        <table cellpadding="0" cellspacing="0" width="159">
                                                            <tr>
                                                                <td width="35" height="27" align="right">
                                                                    <img src="img/cam_icon11.png" width="19" height="19" border="0">
                                                                </td>
                                                                <td width="124" height="27" align="center">
                                                                    <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">안내 책자</span></font></b>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr class="trNorPdfMode">
                            <td width="115" height="10" valign="top">
                                <table cellpadding="0" cellspacing="0" width="105" align="center">
                                    <tr>
                                        <td width="105" height="32" align="center" class="clsTitleLabel">
                                            버튼색상
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="361" height="61" valign="top">
                                <table cellpadding="0" cellspacing="0" width="350">
                                    <tr>
                                        <td width="35" height="35" id="tdPdfColorBtn11" class="clsColorBtn" onclick="onChangePdfColor('#FFFFFF',11);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFFFF">
                                                <tr>
                                                    <td width="23" height="23" style="border:1px solid #DDDDDD;">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdPdfColorBtn1" class="clsColorBtn" onclick="onChangePdfColor('#DDDDDD',1);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdPdfColorBtn2" class="clsColorBtn" onclick="onChangePdfColor('#999999',2);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdPdfColorBtn3" class="clsColorBtn" onclick="onChangePdfColor('black',3);">
                                            <table cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td width="25" height="25" bgcolor="black">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdPdfColorBtn4" class="clsColorBtn" onclick="onChangePdfColor('#079DEC',4);">
                                            <table cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td width="25" height="25" bgcolor="#079DEC">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdPdfColorBtn5" class="clsColorBtn" onclick="onChangePdfColor('#1234AB',5);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdPdfColorBtn6" class="clsColorBtn" onclick="onChangePdfColor('red',6);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdPdfColorBtn7" class="clsColorBtn" onclick="onChangePdfColor('#FF7700',7);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdPdfColorBtn8" class="clsColorBtn" onclick="onChangePdfColor('#FFDD00',8);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdPdfColorBtn9" class="clsColorBtn" onclick="onChangePdfColor('#33AA22',9);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdPdfColorBtn10" class="clsColorBtn" onclick="onChangePdfColor('#BB33AA',10);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr class="trNorPdfMode">
                            <td width="115" height="10" valign="top">
                                <table cellpadding="0" cellspacing="0" width="105" align="center">
                                    <tr>
                                        <td width="105" height="32" align="center" class="clsTitleLabel">
                                            버튼 글 색상
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="361" height="61" valign="top">
                                <table cellpadding="0" cellspacing="0" width="350">
                                    <tr>
                                        <td width="35" height="35" id="tdPdfTextColorBtn11" class="clsTextColorBtn" onclick="onChangeTextColor('spPdfPreviewText','#FFFFFF','tdPdfTextColorBtn',11,'hdPdfTextColorIndex');">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFFFF">
                                                <tr>
                                                    <td width="23" height="23" style="border:1px solid #DDDDDD;">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdPdfTextColorBtn1" class="clsTextColorBtn" onclick="onChangeTextColor('spPdfPreviewText','#DDDDDD','tdPdfTextColorBtn',1,'hdPdfTextColorIndex');">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdPdfTextColorBtn2" class="clsTextColorBtn" onclick="onChangeTextColor('spPdfPreviewText','#999999','tdPdfTextColorBtn',2,'hdPdfTextColorIndex');">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdPdfTextColorBtn3" class="clsTextColorBtn" onclick="onChangeTextColor('spPdfPreviewText','black','tdPdfTextColorBtn',3,'hdPdfTextColorIndex');">
                                            <table cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td width="25" height="25" bgcolor="black">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdPdfTextColorBtn4" class="clsTextColorBtn" onclick="onChangeTextColor('spPdfPreviewText','#079DEC','tdPdfTextColorBtn',4,'hdPdfTextColorIndex');">
                                            <table cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td width="25" height="25" bgcolor="#079DEC">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdPdfTextColorBtn5" class="clsTextColorBtn" onclick="onChangeTextColor('spPdfPreviewText','#1234AB','tdPdfTextColorBtn',5,'hdPdfTextColorIndex');">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdPdfTextColorBtn6" class="clsTextColorBtn" onclick="onChangeTextColor('spPdfPreviewText','red','tdPdfTextColorBtn',6,'hdPdfTextColorIndex');">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdPdfTextColorBtn7" class="clsTextColorBtn" onclick="onChangeTextColor('spPdfPreviewText','#FF7700','tdPdfTextColorBtn',7,'hdPdfTextColorIndex');">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdPdfTextColorBtn8" class="clsTextColorBtn" onclick="onChangeTextColor('spPdfPreviewText','#FFDD00','tdPdfTextColorBtn',8,'hdPdfTextColorIndex');">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdPdfTextColorBtn9" class="clsTextColorBtn" onclick="onChangeTextColor('spPdfPreviewText','#33AA22','tdPdfTextColorBtn',9,'hdPdfTextColorIndex');">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdPdfTextColorBtn10" class="clsTextColorBtn" onclick="onChangeTextColor('spPdfPreviewText','#BB33AA','tdPdfTextColorBtn',10,'hdPdfTextColorIndex');">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr class="trNorPdfMode">
                            <td width="115" height="10" valign="top">
                                <table cellpadding="0" cellspacing="0" width="105" align="center">
                                    <tr>
                                        <td width="105" height="32" align="center" class="clsTitleLabel">
                                            버튼미리보기
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="361" height="61" valign="top">
                                <table cellpadding="0" cellspacing="0" width="316">
                                    <tr>
                                        <td width="180" height="47" valign="top">
                                            <table id="tblPdfPreviewBtn" cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                                                bgcolor="#F7F7F7" width="169">
                                                <tr>
                                                    <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                        border-style: solid;">
                                                        <table cellpadding="0" cellspacing="0" width="159">
                                                            <tr>
                                                                <td width="35" height="27" align="right">
                                                                    <img src="img/cam_icon11.png" width="19" height="19" border="0">
                                                                </td>
                                                                <td width="124" height="27" align="center">
                                                                    <b><font face="돋움"><span style="font-size: 10pt; color: #8C959A;" id="spPdfPreviewText">PDF viewer</span></font></b>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="136" height="47">
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr class="trCustomPdfMode">
                            <td width="115" height="10" valign="top">
                                <table cellpadding="0" cellspacing="0" width="105" align="center">
                                    <tr>
                                        <td width="105" height="32" align="center" class="clsTitleLabel">
                                            업로드
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="361" height="61" valign="top">
                                <table cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td width="367" height="32">
                                            <input id="pdfbtn_path" type="file" name="pdfbtn_path" accept="image/png" class="clsBrowser"
                                                size="30">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" width="500" height="45" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="485">
                                    <tr>
                                        <td width="485" height="41" align="right">
                                            <input type="hidden" id="hdPdfModeIndex" value="1" />
                                            <input type="hidden" id="hdPdfColorIndex" value="1" />
                                            <input type="hidden" id="hdPdfTextColorIndex" value="1" />
                                            <input type="button" style="width: 103px; height: 30px; font-weight: bold;" class="clsButton"
                                                value="적용하기" onclick="OnPdfApply()" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>


    <div id="dvCopyCampaignAlert" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="451" style="border-collapse:collapse;" bgcolor="#F0F0F0">
            <tr>
                <td width="449" height="163" style="border-width:1; border-color:rgb(216,216,216); border-style:solid;" bgcolor="#F6F6F6">
                    <table cellpadding="0" cellspacing="0" align="center" width="387">
                        <tr>
                            <td width="387" height="77" valign="bottom" align="center">
                                <b><font face="돋움" color="#FFOOOO"><span style="font-size: 10pt;">복사된 캠페인의 경우 원본과 가로세로 사이즈가 같은 <br> 마커를 등록해 주세요.<br>마커의 사이즈가 다른경우 오브젝트가 정상적으로 <br> 표시 되지 않을 수 있습니다.</span></font></b>
                            </td>
                        </tr>
                        <tr>
                            <td width="387" height="77" align="center">
                               <input name="confirm" type="button" value="확 인" onclick="closePopup()" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>

    <div id="dvToggleHelp" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="border-width: 1px; border-color: rgb(255,102,0);
            border-style: solid; background-color: White">
            <tr>
                <td width="520" valign="top">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td width="500" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="54">
                                            <b><font face="돋움" color="black"><span style="font-size: 16pt;">게시판&nbsp;노출</span></font></b>
                                        </td>
                                        <td width="91" height="54" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="50" style="font-size:16px; font-family:돋움; color:Black;">
                                Check 입력시 해당 “마커” 및 “캠페인 설명”이  <br />앱상의 마커 게시판(등록된 COAR)에 노출됩니다.
                                <br />
                                <br />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>

    <div id="dvCampainDescription" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="border-width: 1px; border-color: rgb(255,102,0);
            border-style: solid; background-color: White">
            <tr>
                <td width="520" valign="top">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td width="500" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="54">
                                            <b><font face="돋움" color="black"><span style="font-size: 16pt;">캠페인&nbsp;설명</span></font></b>
                                        </td>
                                        <td width="91" height="54" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="50" style="font-size:14px; font-family:돋움; color:Black;">
                                등록한 마커와 캠페인에 대한 간단한 설명을 입력할수 있습니다.(200자 제한)
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="50">
                                <textarea id="campain_description" cols="20" rows="4" maxlength="200" style="width:480px;"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="50" align="center">
                               <input type="button" style="width: 80px; height: 30px; font-weight: bold;" class="clsButton" value="취 소" onclick="closePopup()" />&nbsp;&nbsp;
                               <input type="button" style="width: 80px; height: 30px; font-weight: bold;" class="clsButton" value="확 인" onclick="onApplyCampainDescription()" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>

</asp:Content>
