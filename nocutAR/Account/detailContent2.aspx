<%@ Page Title="" Language="C#" MasterPageFile="~/Account/UserPage.Master" AutoEventWireup="true" CodeBehind="detailContent.aspx.cs" Inherits="nocutAR.Account.detailContent" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="/Scripts/detailcontents_opt.js" type="text/javascript"></script>
    <asp:Literal ID="ltlScript" runat="server" Text=""></asp:Literal>
    <script type="text/javascript">
        var objName = "";
        var imgList = new Array();
        var webList = new Array();
        var videoList = new Array();
        var captureList = new Array();
        var threeList = new Array();
        var telList = new Array();
        var googlemapList = new Array();
        var notepadList = new Array();
        var audioList = new Array();
        var chromakeyList = new Array();
        counter = 0;
        video_counter = 0;
        web_counter = 0;
        img_counter = 0;
        capture_counter = 0;
        three_counter = 0;
        tel_counter = 0;
        googlemap_counter = 0;
        notepad_counter = 0;
        audio_counter = 0;
        chromakey_counter = 0;
        capprev_counter = 0;
        var addIndex = 0;
        var prevIndex = 0;
        var capCount = 0;
        var capprevIndex = 0;
        $(document).ready(function () {
            selTopMenu(4);
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
                    if (iThreeTemplate == 0) {
                        $("#template1").css("display", "none");
                        $("#template2").css("display", "none");
                        $("#template3").css("display", "none");
                        $("#template4").css("display", "none");
                        $("#template5").css("display", "none");
                        $("#template6").css("display", "none");
                        $("#template7").css("display", "none");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HideProgress();
                    alert("이용상품이 없습니다. 상품을 구입해주세요.");
                    document.location = "ProjectList.aspx";
                }
            });
            init_mark();
            init_objects();
            selLeftMenu(0);
        });
        function init_objects() {
            ShowProgress();
            $.ajax({
                url: "getXML.aspx?content_id=" + SERVER_ID,
                type: 'POST',
                datatype: "xml",
                async: false,
                success: function (data) {
                    //xml을 받아서 파싱해야 한다.
                    setTimeout(function () {
                        var unitX = $("#markImg").width() / 100;
                        var unitY = $("#markImg").height() / 100;
                        var oX = $("#markImg").position().left;
                        var oY = $("#markImg").position().top + $("#markImg").height();

                        xmlDoc = data;
                        xmlDoc = xmlDoc.replace(/<image /g, '<picture ');
                        xmlDoc = xmlDoc.replace(/image>/g, 'picture>');
                        var marker = $(xmlDoc).find("marker");
                        var images = $(xmlDoc).find("picture");
                        var videos = $(xmlDoc).find("video");
                        var webs = $(xmlDoc).find("web");
                        var captures = $(xmlDoc).find("capture");
                        var imgsliders = $(xmlDoc).find("imgslider");
                        var threes = $(xmlDoc).find("three");
                        var tels = $(xmlDoc).find("tel");
                        var googlemaps = $(xmlDoc).find("googlemap");
                        var notepads = $(xmlDoc).find("notepad");
                        var audios = $(xmlDoc).find("audio");
                        var chromakeys = $(xmlDoc).find("chromakey");

                        //초기 이미지,비디오 및 오브젝트들의 갯수를 설정한다. 새로 만드는 오브젝트들을 그 다음번호부터 가진다.
                        img_counter = images.length;
                        video_counter = videos.length;
                        web_counter = webs.length;
                        capture_counter = captures.length;
                        three_counter = threes.length;
                        imgslider_counter = imgsliders.length;
                        tel_counter = tels.length;
                        googlemap_counter = googlemaps.length;
                        notepad_counter = notepads.length;
                        audio_counter = audios.length;
                        chromakey_counter = chromakeys.length;

                        //총 갯수 초기화
                        counter = img_counter + video_counter + web_counter + capture_counter + three_counter + imgslider_counter + tel_counter + googlemap_counter + notepad_counter + audio_counter + chromakey_counter;

                        /*마커이미지 구현*/
                        $(marker).each(function () {
                            imgList[0] = { url: encodeURI($(this).find("url").text()) }
                        });
                        /***마커이미지 구현***/

                        /*이미지 오브젝트 구현*/
                        i = 0;
                        $(images).each(function () {
                            i++;
                            var url1 = encodeURI($(this).find("url1").text());
                            var url2 = encodeURI($(this).find("url2").text());
                            var url3 = encodeURI($(this).find("url3").text());
                            var url4 = encodeURI($(this).find("url4").text());
                            var url5 = encodeURI($(this).find("url5").text());
                            var url6 = encodeURI($(this).find("url6").text());
                            var url7 = encodeURI($(this).find("url7").text());
                            var url8 = encodeURI($(this).find("url8").text());
                            var url9 = encodeURI($(this).find("url9").text());
                            var type = $(this).find("type").text();
                            var prev_count = $(this).find("prev_count").text();
                            var posX = $(this).find("posX").text();
                            var posY = $(this).find("posY").text();
                            var width = $(this).find("width").text();
                            var height = $(this).find("height").text();
                            var depth = $(this).find("depth").text();
                            var width = $(this).find("width").text();
                            var objsize = $(this).find("objsize").text();
                            //var rate = $images.find("rate");
                            var element = "<div id='temp' style='position:absolute'>";
                            element += "<img width='100%' height='100%' src='" + url1 + "'>";
                            //패널 추가
                            element += "<div class='panel'>";
                            element += "<a class='delete-btn'>Delete</a>";
                            element += "<a class='edit-btn'>Edit</a>";
                            element += "</div>";

                            element += "</div>";
                            jQuery(element).appendTo("#editframe");
                            $("#temp").css({ "width": width * unitX, "height": height * unitY });
                            $("#temp").css({ "left": oX + posX * unitX - width * unitX / 2, "top": oY - posY * unitY - height * unitY / 2 });
                            $("#temp").css({ "z-index": depth });
                            $("#temp").addClass("dragged_object");
                            $("#temp").attr("id", "img_" + i);
                            imgList[i] = { url1: url1, url2: url2, url3: url3, url4: url4, url5: url5, url6: url6, url7: url7, url8: url8, url9: url9, type: type, prev_count: prev_count, objsize: objsize };

                            addIndex = prev_count;
                            prevIndex = prev_count;
                            //크기조종
                            $("#img_" + i).draggable({
                                containment: "parent"

                            });
                            $("#img_" + i).resizable({
                                aspectRatio: true,
                                containment: "parent"

                            });

                        });
                        /***이미지 오브젝트 구현***/

                        /*비디오 오브젝트 구현*/
                        i = 0;
                        $(videos).each(function () {
                            i++;
                            var url = encodeURI($(this).find("url").text());
                            var type = $(this).find("type").text();
                            var run_opt = $(this).find("run_opt").text();
                            var posX = $(this).find("posX").text();
                            var posY = $(this).find("posY").text();
                            var width = $(this).find("width").text();
                            var height = $(this).find("height").text();
                            var depth = $(this).find("depth").text();
                            var width = $(this).find("width").text();
                            var objsize = $(this).find("objsize").text();
                            //var rate = $images.find("rate");
                            var element = "<div id='temp' style='position:absolute'>";
                            element += "<video width='100%' height='100%' controls>";
                            element += "<source src=" + url + ">";
                            element += "</video>";
                            //패널 추가
                            element += "<div class='panel'>";
                            element += "<a class='delete-btn'>Delete</a>";
                            element += "<a class='edit-btn'>Edit</a>";
                            element += "</div>";

                            element += "</div>";
                            jQuery(element).appendTo("#editframe");
                            $("#temp").css({ "width": width * unitX, "height": height * unitY });
                            $("#temp").css({ "left": oX + posX * unitX - width * unitX / 2, "top": oY - posY * unitY - height * unitY / 2 });
                            $("#temp").css({ "z-index": depth });
                            $("#temp").addClass("dragged_object");
                            $("#temp").attr("id", "video_" + i);


                            videoList[i] = { url: url, type: type, run_opt: run_opt, objsize: objsize };
                            //크기조종
                            //$(".dragged_object").resizable().draggable();

                            $("#video_" + i).draggable({
                                containment: "parent"
                            });
                            $("#video_" + i).resizable({
                                aspectRatio: true,
                                containment: "parent"
                            });

                        });
                        /***비디오 오브젝트 구현***/

                        /*웹구현*/
                        i = 0;
                        $(webs).each(function () {
                            i++;
                            var url = $(this).find("url").text();
                            var type = $(this).find("type").text();
                            var posX = $(this).find("posX").text();
                            var posY = $(this).find("posY").text();
                            var width = $(this).find("width").text();
                            var height = $(this).find("height").text();
                            var depth = $(this).find("depth").text();
                            var color = $(this).find("color").text();
                            var string = $(this).find("string").text();
                            var view = $(this).find("view").text();
                            var backurl = encodeURI($(this).find("backurl").text());
                            var objsize = $(this).find("objsize").text();
                            //var rate = $images.find("rate");

                            var element = "<div id='temp' style='min-width:80px; width:100px; height:auto; position:absolute'>";
                            //element += "<p style='background-color:#0099FF; margin-bottom:0px;margin-top: 0px; text-align:center'>웹사이트</p>";
                            if (type == 1)
                                element += "<img style='width:100%; height;100%' src=" + backurl + ">";
                            else
                                element += '<img style="width:100%; height:auto; border:1px solid Gray;" src="img/web_1.png"></img>';
                            //element += "<p>" + string + "</p>";
                            //패널 추가
                            element += "<div class='panel'>";
                            element += "<a class='delete-btn'>Delete</a>";
                            element += "<a class='edit-btn'>Edit</a>";
                            element += "</div>";

                            element += "</div>";
                            jQuery(element).appendTo("#editframe");
                            if (type == 1)
                                $("#temp").css({ "width": width * unitX, "height": height * unitY });

                            $("#temp").css({ "left": oX + posX * unitX - width * unitX / 2, "top": oY - posY * unitY - height * unitY / 2 });
                            $("#temp").css({ "z-index": depth });
                            $("#temp").addClass("dragged_object");
                            $("#temp").attr("id", "web_" + i);

                            webList[i] = { backurl: backurl, url: url, view: view, type: type, objsize: objsize };
                            //크기조종
                            if (type == 0) {
                                $("#web_" + i).draggable({
                                    containment: "parent"
                                });
                            }
                            else {
                                $("#web_" + i).draggable({
                                    containment: "parent"
                                });
                                $("#web_" + i).resizable({
                                    aspectRatio: true,
                                    containment: "parent"
                                });
                            }
                        });
                        /***웹구현***/


                        /*캡쳐이미지초기화*/
                        i = 0;
                        $(captures).each(function () {
                            i++;
                            var type = $(this).find("type").text();
                            var prev_count = $(this).find("prev_count").text();
                            var posX = $(this).find("posX").text();
                            var posY = $(this).find("posY").text();
                            var width = $(this).find("width").text();
                            var height = $(this).find("height").text();

                            var posX1 = $(this).find("posX1").text();
                            var posY1 = $(this).find("posY1").text();
                            var width1 = $(this).find("width1").text();
                            var height1 = $(this).find("height1").text();
                            var posX2 = $(this).find("posX2").text();
                            var posY2 = $(this).find("posY2").text();
                            var width2 = $(this).find("width2").text();
                            var height2 = $(this).find("height2").text();
                            var posX3 = $(this).find("posX3").text();
                            var posY3 = $(this).find("posY3").text();
                            var width3 = $(this).find("width3").text();
                            var height3 = $(this).find("height3").text();

                            var depth = $(this).find("depth").text();
                            var backurl = encodeURI($(this).find("backurl").text());
                            var slide1 = encodeURI($(this).find("slide1").text());
                            var slide2 = encodeURI($(this).find("slide2").text());
                            var slide3 = encodeURI($(this).find("slide3").text());
                            var objsize = $(this).find("objsize").text();

                            var element = "<div id='temp' style='position:absolute'>";
                            if (type != 0)
                                element += "<img width='100%' height='100%' src=" + backurl + ">";
                            else
                                element += "<img width='100%' height='100%' src='/img/capturebtn.png'>";
                            //패널 추가
                            element += "<div class='panel'>";
                            element += "<a class='delete-btn'>Delete</a>";
                            element += "<a class='edit-btn'>Edit</a>";
                            element += "</div>";

                            element += "</div>";
                            jQuery(element).appendTo("#editframe");
                            $("#temp").css({ "width": width * unitX, "height": height * unitY });
                            $("#temp").css({ "left": oX + posX * unitX - width * unitX / 2, "top": oY - posY * unitY - height * unitY / 2 });
                            $("#temp").css({ "z-index": depth });
                            $("#temp").addClass("dragged_object");
                            $("#temp").attr("id", "capture_" + i);

                            captureList[i] = { backurl: backurl, slide1: slide1, slide2: slide2, slide3: slide3, type: type, prev_count: prev_count,
                                width1: width1,
                                height1: height1,
                                posX1: posX1,
                                posY1: posY1,
                                width2: width2,
                                height2: height2,
                                posX2: posX2,
                                posY2: posY2,
                                width3: width3,
                                height3: height3,
                                posX3: posX3,
                                posY3: posY3,
                                objsize: objsize
                            };

                            capCount = prev_count;
                            capprevIndex = prev_count;
                            //크기조종

                            $("#capture_" + i).draggable({
                                containment: "parent"
                            });
                            $("#capture_" + i).resizable({
                                aspectRatio: true,
                                containment: "parent"
                            });

                        });
                        /***캡쳐이미지초기화***/

                        /*3D 오브젝트 구현*/
                        i = 0;
                        $(threes).each(function () {
                            i++;
                            var type = $(this).find("type").text();
                            var posX = $(this).find("posX").text();
                            var posY = $(this).find("posY").text();
                            var width = $(this).find("width").text();
                            var height = $(this).find("height").text();
                            var depth = $(this).find("depth").text();
                            var url1 = encodeURI($(this).find("url1").text());
                            var url2 = encodeURI($(this).find("url2").text());
                            var front_angle = $(this).find("angle").text();
                            var brightness = $(this).find("brightness").text();
                            var run_times = $(this).find("times").text();
                            var objsize = $(this).find("objsize").text();
                            //var rate = $(this).find("rate").text();

                            var element = "<div id='temp' style='position:absolute'>";
                            //element += "<p style='background-color:#0099FF; margin-bottom:0px;margin-top: 0px; text-align:center'>3D 모델</p>";
                            element += "<img width='100%' height='100%' src=" + "/img/three_backurl.png" + ">";
                            //패널 추가
                            element += "<div class='panel'>";
                            element += "<a class='delete-btn'>Delete</a>";
                            element += "<a class='edit-btn'>Edit</a>";
                            element += "</div>";

                            element += "</div>";
                            jQuery(element).appendTo("#editframe");


                            $("#temp").css({ "width": width * unitX, "height": height * unitY });
                            $("#temp").css({ "left": oX + posX * unitX - width * unitX / 2, "top": oY - posY * unitY - height * unitY / 2 });
                            $("#temp").css({ "z-index": depth });
                            $("#temp").addClass("dragged_object");
                            $("#temp").attr("id", "three_" + i);

                            threeList[i] = { url1: url1, url2: url2, front_angle: front_angle, brightness: brightness, run_times: run_times, type: type, objsize: objsize };
                            //크기조종
                            //$(".dragged_object").resizable().draggable();
                            $("#three_" + i).draggable({
                                containment: "parent"
                            });
                            $("#three_" + i).resizable({
                                aspectRatio: true,
                                containment: "parent"
                            });
                        });
                        /***3D 오브젝트 구현***/

                        /*전화하기 구현*/
                        i = 0;
                        $(tels).each(function () {
                            i++;
                            var type = $(this).find("type").text();
                            var posX = $(this).find("posX").text();
                            var posY = $(this).find("posY").text();
                            var width = $(this).find("width").text();
                            var height = $(this).find("height").text();
                            var depth = $(this).find("depth").text();
                            var tel_no = $(this).find("tel_no").text();
                            var backurl = encodeURI($(this).find("backurl").text());
                            var objsize = $(this).find("objsize").text();
                            //var rate = $(this).find("rate").text();

                            var element = '<div id="temp" style=" position:absolute">';
                            if (type != 1)
                                element += '<img style="width:100%; height:100%;border:1px solid Gray" src="img/tel_1.png"></img>';
                            else
                                element += '<img width="100%" height="100%" src=' + backurl + '>';

                            //패널 추가
                            element += "<div class='panel'>";
                            element += "<a class='delete-btn'>Delete</a>";
                            element += "<a class='edit-btn'>Edit</a>";
                            element += "</div>";

                            element += "</div>";
                            jQuery(element).appendTo("#editframe");

                            if (type == 1)
                                $("#temp").css({ "width": width * unitX, "height": height * unitY });
                            $("#temp").css({ "left": oX + posX * unitX - width * unitX / 2, "top": oY - posY * unitY - height * unitY / 2 });
                            $("#temp").css({ "z-index": depth });
                            $("#temp").addClass("dragged_object");
                            $("#temp").attr("id", "tel_" + i);



                            telList[i] = { tel_no: tel_no, type: type, backurl: backurl, objsize: objsize };
                            //크기조종
                            if (type == 0 || type == 2) {
                                $("#tel_" + i).draggable({
                                    containment: "parent"
                                });
                            }
                            else {
                                $("#tel_" + i).draggable({
                                    containment: "parent"
                                });
                                $("#tel_" + i).resizable({
                                    aspectRatio: true,
                                    containment: "parent"
                                });
                            }
                        });
                        /***전화하기 구현***/

                        /*구글맵 구현*/
                        i = 0;
                        $(googlemaps).each(function () {
                            i++;
                            var type = $(this).find("type").text();
                            var posX = $(this).find("posX").text();
                            var posY = $(this).find("posY").text();
                            var width = $(this).find("width").text();
                            var height = $(this).find("height").text();
                            var depth = $(this).find("depth").text();
                            var coordinate = $(this).find("coordinate").text();
                            var backurl = encodeURI($(this).find("backurl").text());
                            var objsize = $(this).find("objsize").text();

                            var element = '<div id="temp" style="min-width:80px; position:absolute">';
                            if (type == 0) {
                                element += '<img style="width:100%; height:100%;border:1px solid Gray" src="img/google_1.png"></img>';
                            }
                            if (type == 1)
                                element += '<img width="100%" height="100%" src=' + backurl + '>';

                            //패널 추가
                            element += "<div class='panel'>";
                            element += "<a class='delete-btn'>Delete</a>";
                            element += "<a class='edit-btn'>Edit</a>";
                            element += "</div>";

                            element += "</div>";
                            jQuery(element).appendTo("#editframe");

                            if (type == 1)
                                $("#temp").css({ "width": width * unitX, "height": height * unitY });
                            $("#temp").css({ "left": oX + posX * unitX - width * unitX / 2, "top": oY - posY * unitY - height * unitY / 2 });
                            $("#temp").css({ "z-index": depth });
                            $("#temp").addClass("dragged_object");
                            $("#temp").attr("id", "googlemap_" + i);

                            googlemapList[i] = { coordinate: coordinate, type: type, backurl: backurl, objsize: objsize };
                            //크기조종
                            if (type == 0) {
                                $("#googlemap_" + i).draggable({
                                    containment: "parent"
                                });
                            }
                            else {
                                $("#googlemap_" + i).draggable({
                                    containment: "parent"
                                });
                                $("#googlemap_" + i).resizable({
                                    aspectRatio: true,
                                    containment: "parent"
                                });
                            }
                        });
                        /***구글맵 구현***/

                        /*문자판 구현*/
                        i = 0;
                        $(notepads).each(function () {
                            i++;
                            var posX = $(this).find("posX").text();
                            var posY = $(this).find("posY").text();
                            var width = $(this).find("width").text();
                            var height = $(this).find("height").text();
                            var depth = $(this).find("depth").text();
                            var content = $(this).find("content").text();
                            var view = $(this).find("view").text();

                            var element = "<div id='temp' style='position:absolute; min-height:60px;min-width:90px'>";
                            element += "<div class='emptyobject' >";
                            element += "<span class='objtitle'>문자판</span>"
                            element += "</div>"
                            //패널 추가
                            element += "<div class='panel'>";
                            element += "<a class='delete-btn'>Delete</a>";
                            element += "<a class='edit-btn'>Edit</a>";
                            element += "</div>";
                            element += "</div>";

                            element += "</div>";
                            jQuery(element).appendTo("#editframe");
                            $("#temp").css({ "width": width * unitX, "height": height * unitY });
                            $("#temp").css({ "left": oX + posX * unitX - width * unitX / 2, "top": oY - posY * unitY - height * unitY / 2 });
                            $("#temp").css({ "z-index": depth });
                            $("#temp").addClass("dragged_object");
                            $("#temp").attr("id", "notepad_" + i);

                            notepadList[i] = { content: content, view: view };
                            //크기조종
                            $("#notepad_" + i).draggable({
                                containment: "parent"
                            });
                            $("#notepad_" + i).resizable({
                                aspectRatio: true,
                                containment: "parent"
                            });

                        });
                        /***문자판 구현***/

                        /*사운드 구현*/
                        i = 0;
                        $(audios).each(function () {
                            i++;
                            var url = encodeURI($(this).find("url").text());
                            var type = $(this).find("type").text();
                            var run_opt = $(this).find("run_opt").text();
                            var posX = $(this).find("posX").text();
                            var posY = $(this).find("posY").text();
                            var width = $(this).find("width").text();
                            var height = $(this).find("height").text();
                            var depth = $(this).find("depth").text();
                            var width = $(this).find("width").text();
                            var objsize = $(this).find("objsize").text();

                            var element = "<div id='temp' style='position:absolute'>";
                            element += "<audio style='width:100%; height:100%' controls>";
                            element += "<source src=" + url + ">";
                            element += "</audio>";
                            //패널 추가
                            element += "<div class='panel'>";
                            element += "<a class='delete-btn'>Delete</a>";
                            element += "<a class='edit-btn'>Edit</a>";
                            element += "</div>";

                            element += "</div>";
                            jQuery(element).appendTo("#editframe");
                            $("#temp").css({ "width": width * unitX, "height": height * unitY });
                            $("#temp").css({ "left": oX + posX * unitX - width * unitX / 2, "top": oY - posY * unitY - height * unitY / 2 });
                            $("#temp").css({ "z-index": depth });
                            $("#temp").addClass("dragged_object");
                            $("#temp").attr("id", "audio_" + i);


                            audioList[i] = { url: url, type: type, run_opt: run_opt, objsize: objsize };
                            //크기조종

                            $("#audio_" + i).draggable({
                                containment: "parent"
                            });
                            $("#audio_" + i).resizable({
                                aspectRatio: true,
                                containment: "parent"
                            });
                        });
                        /***사운드 구현***/

                        /*크로마키 구현*/
                        i = 0;
                        $(chromakeys).each(function () {
                            i++;
                            var url = encodeURI($(this).find("url").text());
                            var type = $(this).find("type").text();
                            var run_opt = $(this).find("run_opt").text();
                            var posX = $(this).find("posX").text();
                            var posY = $(this).find("posY").text();
                            var width = $(this).find("width").text();
                            var height = $(this).find("height").text();
                            var depth = $(this).find("depth").text();
                            var width = $(this).find("width").text();
                            var objsize = $(this).find("objsize").text();

                            var element = "<div id='temp' style='position:absolute'>";
                            element += "<video style='width:100%; height:100%' controls>";
                            element += "<source src=" + url + ">";
                            element += "</video>";
                            //패널 추가
                            element += "<div class='panel'>";
                            element += "<a class='delete-btn'>Delete</a>";
                            element += "<a class='edit-btn'>Edit</a>";
                            element += "</div>";

                            element += "</div>";
                            jQuery(element).appendTo("#editframe");
                            $("#temp").css({ "width": width * unitX, "height": height * unitY });
                            $("#temp").css({ "left": oX + posX * unitX - width * unitX / 2, "top": oY - posY * unitY - height * unitY / 2 });
                            $("#temp").css({ "z-index": depth });
                            $("#temp").addClass("dragged_object");
                            $("#temp").attr("id", "chromakey_" + i);


                            chromakeyList[i] = { url: url, type: type, run_opt: run_opt, objsize: objsize };
                            //크기조종

                            $("#chromakey_" + i).draggable({
                                containment: "parent"
                            });
                            $("#chromakey_" + i).resizable({
                                aspectRatio: true,
                                containment: "parent"
                            });

                        });
                        /***크로마키 구현***/

                        //편집 및 삭제단추 추가
                        add_DoubleClickEvent();

                    }, 1000);
                    HideProgress();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HideProgress();
                    alert("error");
                }
            });
        }
        function init_mark() {
            ShowProgress();
            $.ajax({
                url: "getContentData.aspx?id=" + CONTENT_ID,
                dataType: 'json',
                type: 'POST',
                success: function (data) {
                    HideProgress();
                    var iContentID = parseInt(data.content_id);
                    var marker_url = data.marker_url;
                    if (marker_url != "") {
                        $("#editframe").css("display", "");
                        $("#tblRegMarker").css("display", "none");
                        $("#markImg").attr("src", "/markers/" + marker_url);
                        setTimeout(function () {
                            $("#editframe").css({ "width": $("#markImg").attr("width") });
                        }, 500);
                    }
                    else {
                        $("#editframe").css("display", "none");
                        $("#tblRegMarker").css("display", "");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HideProgress();
                    alert("마커이미지를 불러오는동안 오류가 발생하였습니다.");
                }
            });
        }

        function delObject(id) {
            $("#" + id).remove();

            closeConfirmPopup();
            //$("#delpopup").remove();

        }
        function removePopup() {
            closeConfirmPopup();
            //$("#delpopup").remove();
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
        function add_DoubleClickEvent() {
            //double click event 구현
            var dataToPass = { objid: "This is what I wanted to say" };
            var objectid;
            $(".dragged_object").click(dataToPass, function (event) {
                //해당 오브젝트밑의 패널만 보이게 한다.
                showPanel(event.currentTarget.id);
                objectid = event.currentTarget.id;
            });
            $(".delete-btn").click(objectid, function (event) {
                //alert("deleted");

                $("#del_objectid").val(objectid);
                $("#delpopup2").css({ "left": (event.clientX - 180), "top": (event.clientY - 150) });
                $("#delpopup2").fadeIn("slow");

                //$("#delpopup").fadeIn("slow");
                $("#popBack").css({
                    "opacity": "0.7"
                });
                $("#popBack").fadeIn("slow");
            });
            $(".edit-btn").click(objectid, function (event) {
                //alert("edited");
                //세부옵션이 활성화되어야 한다. objectid를 문자열처리하여 video_ img_ web_와 같은 문자열에 따라 처리가 되어야 한다.
                objName = "#" + objectid;

                if (objectid.indexOf("video_") == 0) {
                    select_option(0);
                    enable_applybtn();
                    var index = objectid.substr(6);
                    if (videoList[index] == null) {
                        $("#video_path").val("비디오파일");
                        $("#video_rd1")[0].checked = true;
                        //$('.rdbVideo').find('input')[0].checked = true;
                        $("#videorun_rd1")[0].checked = true;
                        return;
                    }
                    if (videoList[index].type == 0)
                        $("#video_rd1")[0].checked = true;
                    else if (videoList[index].type == 1)
                        $("#video_rd2")[0].checked = true;
                    //$('.rdbVideo').find('input')[1].checked = true;
                    else if (videoList[index].type == 2)
                        $("#video_rd1")[0].checked = true;
                    //$('.rdbVideo').find('input')[2].checked = true;
                    if (videoList[index].run_opt == 0)
                        $("#videorun_rd1")[0].checked = true;
                    else if (videoList[index].run_opt == 1)
                        $("#videorun_rd2")[0].checked = true;
                    $("#video_path").val(videoList[index].url);
                }
                else if (objectid.indexOf("web_") == 0) {
                    select_option(1);
                    enable_applybtn();
                    var index = objectid.substr(4);
                    if (webList[index] == null) {
                        $('.rdbWeb1').find('input')[0].checked = true;
                        $('.rdbWeb2').find('input')[0].checked = true;
                        $("#web_url").val("URL");
                        $("#webbtn_path").attr("disabled", "disabled");
                        $("#btnWebbtnBrowse").attr("disabled", "disabled");
                        $("#webbtn_path_text").attr("disabled", "disabled");
                        return;
                    }
                    if (webList[index].type == 0) {
                        $('.rdbWeb1').find('input')[0].checked = true;
                        $("#webbtn_path").attr("disabled", "disabled");
                        $("#btnWebbtnBrowse").attr("disabled", "disabled");
                    }
                    else {
                        $('.rdbWeb1').find('input')[1].checked = true;
                        $("#webbtn_path").removeAttr("disabled");
                        $("#btnWebbtnBrowse").removeAttr("disabled");
                    }

                    if (webList[index].view == 0)
                        $('.rdbWeb2').find('input')[0].checked = true;
                    else {
                        $('.rdbWeb2').find('input')[1].checked = true;
                    }

                    $("#web_url").val(decodeURIComponent(webList[index].url));

                }
                else if (objectid.indexOf("img_") == 0) {
                    select_option(2);
                    enable_applybtn();
                    $("#prevcontainer_div").html("");
                    var index = objectid.substr(4);
                    if (imgList[index] == null) {
                        $("#imgview_rd1")[0].checked = true;
                        addIndex = 0;
                        return;
                    }
                    if (imgList[index].type == 0) {
                        $("#imgview_rd1")[0].checked = true;
                    }
                    else if (imgList[index].type == 1) {
                        $("#imgview_rd2")[0].checked = true;
                    }

                    for (i = 1; i < parseInt(imgList[index].prev_count) + 1; i++) {
                        var prev_element = '<div id="prev_div' + i + '" style="width: 80px; height:95px;float:left">';
                        if (i == 1)
                            prev_element += '<img id="imgPrev' + i + '" width="75px" height="75px" style="background-color:#7f7f7f"  src="' + imgList[index].url1 + '" />';
                        else if (i == 2)
                            prev_element += '<img id="imgPrev' + i + '" width="75px" height="75px" style="background-color:#7f7f7f"  src="' + imgList[index].url2 + '" />';
                        else if (i == 3)
                            prev_element += '<img id="imgPrev' + i + '" width="75px" height="75px" style="background-color:#7f7f7f"  src="' + imgList[index].url3 + '" />';
                        else if (i == 4)
                            prev_element += '<img id="imgPrev' + i + '" width="75px" height="75px" style="background-color:#7f7f7f"  src="' + imgList[index].url4 + '" />';
                        else if (i == 5)
                            prev_element += '<img id="imgPrev' + i + '" width="75px" height="75px" style="background-color:#7f7f7f"  src="' + imgList[index].url5 + '" />';
                        else if (i == 6)
                            prev_element += '<img id="imgPrev' + i + '" width="75px" height="75px" style="background-color:#7f7f7f"  src="' + imgList[index].url6 + '" />';
                        else if (i == 7)
                            prev_element += '<img id="imgPrev' + i + '" width="75px" height="75px" style="background-color:#7f7f7f"  src="' + imgList[index].url7 + '" />';
                        else if (i == 8)
                            prev_element += '<img id="imgPrev' + i + '" width="75px" height="75px" style="background-color:#7f7f7f"  src="' + imgList[index].url8 + '" />';
                        else if (i == 9)
                            prev_element += '<img id="imgPrev' + i + '" width="75px" height="75px" style="background-color:#7f7f7f"  src="' + imgList[index].url9 + '" />';
                        prev_element += '<div style="height:25px;background-color:#cfcfcf;width:75px">';
                        prev_element += '<a class="cap_delete-btn" onclick="On_delPrev_img(' + i + ')">Delete</a>';
                        prev_element += '</div>';
                        prev_element += '</div>';
                        jQuery(prev_element).appendTo("#prevcontainer_div");
                    }
                    addIndex = imgList[index].prev_count;
                }
                else if (objectid.indexOf("capture_") == 0) {
                    select_option(3);
                    enable_applybtn();
                    var index = objectid.substr(8);
                    $("#capcontainer_div").html("");
                    $("#capture_detail_div").html("");
                    if (captureList[index] == null) {
                        capCount = 0;
                        $('.rdbCapture').find('input')[0].checked = true;
                        $("#capturebtn_path").attr("disabled", "disabled");
                        $("#btnCaptureBrowse").attr("disabled", "disabled");
                        $("#capturebtn_path_text").attr("disabled", "disabled");
                        capdropflag = 0;
                        no_drop = false;
                        n_setteddprevs = 0;
                        $("#capture_detail_div").html("");
                        return;
                    }
                    if (captureList[index].type == 0) {
                        $('.rdbCapture').find('input')[0].checked = true;
                        $("#capturebtn_path").attr("disabled", "disabled");
                        $("#btnCaptureBrowse").attr("disabled", "disabled");
                        $("#capturebtn_path_text").attr("disabled", "disabled");

                    }
                    else {
                        $('.rdbCapture').find('input')[1].checked = true;
                        $("#capturebtn_path").removeAttr("disabled");
                        $("#btnCaptureBrowse").removeAttr("disabled");
                        $("#capturebtn_path_text").removeAttr("disabled");
                    }
                    var unitX2 = $("#capture_detail_div").width() / 100;
                    var unitY2 = $("#capture_detail_div").height() / 100;
                    var oX2 = $("#capture_detail_div").position().left;
                    var oY2 = $("#capture_detail_div").position().top + $("#capture_detail_div").height();
                    n_setteddprevs = captureList[index].prev_count;
                    for (i = 1; i < parseInt(captureList[index].prev_count) + 1; i++) {
                        var prev_element = '<div id="capprev_div' + i + '" style="width: 80px; height:95px;float:left">';
                        if (i == 1) {
                            prev_element += '<img class="clscapprev" id="capimgPrev' + i + '" width="75px" height="75px" style="z-index:1000;background-color:#7f7f7f"  src="' + captureList[index].slide1 + '" />';
                            capsize_img = '<div id="controlcapprev1" style="position: absolute; width: 75px; height: 75px;">' +
                            '<img style="width:100%; height:100%"  src="' + captureList[index].slide1 + '" />' +
                            '</div>';
                            jQuery(capsize_img).appendTo("#capture_detail_div");
                            $("#controlcapprev1").css({ "width": captureList[index].width1 * unitX2, "height": captureList[index].height1 * unitY2 });
                            $("#controlcapprev1").css({ "left": captureList[index].posX1 * unitX2, "top": captureList[index].posY1 * unitY2 });
                            n_selectedprev = "#controlcapprev1";
                        }
                        else if (i == 2) {
                            prev_element += '<img class="clscapprev" id="capimgPrev' + i + '" width="75px" height="75px" style="z-index:1000;background-color:#7f7f7f"  src="' + captureList[index].slide2 + '" />';
                            capsize_img = '<div id="controlcapprev2" style="position: absolute; width: 75px; height: 75px;">' +
                            '<img style="width:100%; height:100%"  src="' + captureList[index].slide2 + '" />' +
                            '</div>';
                            jQuery(capsize_img).appendTo("#capture_detail_div");
                            $("#controlcapprev2").css({ "width": captureList[index].width2 * unitX2, "height": captureList[index].height2 * unitY2 });
                            $("#controlcapprev2").css({ "left": captureList[index].posX2 * unitX2, "top": captureList[index].posY2 * unitY2 });
                            n_selectedprev = "#controlcapprev2";
                        }
                        else if (i == 3) {
                            prev_element += '<img class="clscapprev" id="capimgPrev' + i + '" width="75px" height="75px" style="z-index:1000;background-color:#7f7f7f"  src="' + captureList[index].slide3 + '" />';
                            capsize_img = '<div id="controlcapprev3" style="position: absolute; width: 75px; height: 75px;">' +
                            '<img style="width:100%; height:100%"  src="' + captureList[index].slide3 + '" />' +
                            '</div>';
                            jQuery(capsize_img).appendTo("#capture_detail_div");
                            $("#controlcapprev3").css({ "width": captureList[index].width3 * unitX2, "height": captureList[index].height3 * unitY2 });
                            $("#controlcapprev3").css({ "left": captureList[index].posX3 * unitX2, "top": captureList[index].posY3 * unitY2 });
                            n_selectedprev = "#controlcapprev3";
                        }
                        prev_element += '<div style="height:25px;background-color:#cfcfcf;width:75px">';
                        prev_element += '<a class="cap_delete-btn" onclick="OnRemoveCapPrev(' + i + ')">Delete</a>';
                        prev_element += '</div>';
                        prev_element += '</div>';
                        jQuery(prev_element).appendTo("#capcontainer_div");
                        capprevdrag(i);
                        dragdrop2();
                        capdropflag = 1;

                    }
                    capCount = captureList[index].prev_count;
                }
                else if (objectid.indexOf("three_") == 0) {
                    select_option(4);
                    enable_applybtn();
                    var index = objectid.substr(6);
                    if (threeList[index] == null) {
                        $('#three_file1_path').val("unity3d파일");
                        $('#three_file2_path').val("assetbundle파일");
                        $('#front_angle').val("객체 정면 방향");
                        $('#brightness').val("밝기");
                        $('#run_times').val("실행횟수");
                        $('.rdbThree').find('input')[0].checked = true;
                        return;
                    }
                    if (threeList[index].type == 0) {
                        $('.rdbThree').find('input')[0].checked = true;
                    }
                    else if (threeList[index].type == 1) {
                        $('.rdbThree').find('input')[1].checked = true;
                    }
                    else if (threeList[index].type == 2) {
                        $('.rdbThree').find('input')[2].checked = true;
                    }
                    $('#three_file1_path').val(threeList[index].url1);
                    $('#three_file2_path').val(threeList[index].url2);
                    $("#front_angle").val(threeList[index].front_angle);
                    $("#brightness").val(threeList[index].brightness);
                    $("#run_times").val(threeList[index].run_times);
                }
                else if (objectid.indexOf("tel_") == 0) {
                    select_option(5);
                    enable_applybtn();
                    var index = objectid.substr(4);
                    if (telList[index] == null) {
                        $("#tel_no").val("전화번호 '-' 생략");
                        $("#rdTel1")[0].checked = true;
                        $("#rdCommon")[0].checked = true;
                        $("#rdCommon").removeAttr("disabled");
                        $("#rdCustom").removeAttr("disabled");
                        $("#telbtn_path").attr("disabled", "disabled");
                        $("#btnTelbtnBrowse").attr("disabled", "disabled");
                        $("#telbtn_path_text").attr("disabled", "disabled");
                        return;
                    }
                    if (telList[index].type == 0) {
                        $("#rdCommon").removeAttr("disabled");
                        $("#rdCustom").removeAttr("disabled");
                        $("#rdTel1")[0].checked = true;
                        $("#rdCommon")[0].checked = true;
                        $("#telbtn_path").attr("disabled", "disabled");
                        $("#btnTelbtnBrowse").attr("disabled", "disabled");
                        $("#telbtn_path_text").attr("disabled", "disabled");
                    }
                    else if (telList[index].type == 1) {
                        $("#rdCommon").removeAttr("disabled");
                        $("#rdCustom").removeAttr("disabled");
                        $("#rdTel1")[0].checked = true;
                        $("#rdCustom")[0].checked = true;
                        $("#telbtn_path").removeAttr("disabled");
                        $("#btnTelbtnBrowse").removeAttr("disabled");
                        $("#telbtn_path_text").removeAttr("disabled");
                    }
                    else if (telList[index].type == 2) {
                        $("#rdCommon").attr("disabled", "disabled");
                        $("#rdCustom").attr("disabled", "disabled");
                        $("#rdTel2")[0].checked = true;
                        $("#telbtn_path").attr("disabled", "disabled");
                        $("#btnTelbtnBrowse").attr("disabled", "disabled");
                    }
                    $("#tel_no").val(telList[index].tel_no);
                }
                else if (objectid.indexOf("googlemap_") == 0) {
                    select_option(6);
                    enable_applybtn();
                    var index = objectid.substr(10);
                    if (googlemapList[index] == null) {
                        $("#coordinate").val("좌표값:Lat,Lng");
                        $("#googlebtn_rd1")[0].checked = true;
                        $("#googlebtn_path").attr("disabled", "disabled");
                        $("#btnGoogleBrowse").attr("disabled", "disabled");
                        $("#googlebtn_path_text").attr("disabled", "disabled");
                        return;
                    }
                    if (googlemapList[index].type == 0) {
                        $("#googlebtn_rd1")[0].checked = true;
                        $("#googlebtn_path").attr("disabled", "disabled");
                        $("#btnGoogleBrowse").attr("disabled", "disabled");
                        $("#googlebtn_path_text").attr("disabled", "disabled");
                    }
                    else if (googlemapList[index].type == 1) {
                        $("#googlebtn_rd2")[0].checked = true;
                        $("#googlebtn_path").removeAttr("disabled");
                        $("#btnGoogleBrowse").removeAttr("disabled");
                        $("#googlebtn_path_text").removeAttr("disabled");

                    }
                    $("#coordinate").val(googlemapList[index].coordinate);
                }
                else if (objectid.indexOf("notepad_") == 0) {
                    select_option(7);
                    enable_applybtn();
                    var index = objectid.substr(8);
                    if (notepadList[index] == null) {
                        $("#notepad_rd1")[0].checked = true;
                        return;
                    }
                    if (notepadList[index].view == 0) {
                        $("#notepad_rd1")[0].checked = true;
                    }
                    else if (notepadList[index].view == 1) {
                        $("#notepad_rd2")[0].checked = true;
                    }
                    $("#notepad_content").val(decodeURIComponent(notepadList[index].content));
                }
                else if (objectid.indexOf("audio_") == 0) {
                    select_option(8);
                    enable_applybtn();
                    var index = objectid.substr(6);
                    if (audioList[index] == null) {
                        $("#audio_file_text").val("사운드파일");
                        $("#audiobtn_rd1")[0].checked = true;
                        $("#audiorun_rd1")[0].checked = true;
                        return;
                    }
                    if (audioList[index].type == 0) {
                        $("#audiobtn_rd1")[0].checked = true;
                    }
                    else if (audioList[index].type == 1) {
                        $("#audiobtn_rd2")[0].checked = true;
                    }
                    else if (audioList[index].type == 2) {
                        $("#audiobtn_rd3")[0].checked = true;
                    }
                    if (audioList[index].run_opt == 0) {
                        $("#audiorun_rd1")[0].checked = true;
                    }
                    else if (audioList[index].run_opt == 1) {
                        $("#audiorun_rd2")[0].checked = true;
                    }
                    $("#audio_file_text").val(audioList[index].url);
                }
                else if (objectid.indexOf("chromakey_") == 0) {
                    select_option(9);
                    enable_applybtn();
                    var index = objectid.substr(10);
                    if (chromakeyList[index] == null) {
                        $("#chromakey_file_text").val("MOV");
                        $("#chromakeyview_rd1")[0].checked = true;
                        $("#chromakeyrun_rd1")[0].checked = true;
                        return;
                    }
                    if (chromakeyList[index].type == 0) {
                        $("#chromakeyview_rd1")[0].checked = true;
                    }
                    else if (chromakeyList[index].type == 1) {
                        $("#chromakeyview_rd2")[0].checked = true;
                    }
                    if (chromakeyList[index].run_opt == 0) {
                        $("#chromakeyrun_rd1")[0].checked = true;
                    }
                    else if (chromakeyList[index].run_opt == 1) {
                        $("#chromakeyrun_rd2")[0].checked = true;
                    }
                    $("#chromakey_file_text").val(chromakeyList[index].url);
                }
                else if (objectid.indexOf("imgslide_") == 0) {
                    select_option(6);
                    enable_applybtn();
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
                if ($("#tblRegMarker").css("display") != "none") {
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
        function onSelItem(id) {
            if ($("#leftmenu" + id).hasClass("leftmenu")) {
                for (var i = 1; i < 12; i++) {
                    $("#leftmenu" + i).addClass("leftmenu").removeClass("leftmenu_sel");
                }
                $("#leftmenu" + id).removeClass("leftmenu").addClass("leftmenu_sel");
            }

            counter++;
            dropflag = 1;

            var empty_obj = "<div class='tempclass ' style='width:180px; height:120px; position:absolute; min-height:60px;min-width:90px'>";
            empty_obj += "<div class='emptyobject' >";
            empty_obj += "<span class='objtitle' style=''></span>"
            empty_obj += "</div>"
            empty_obj += "<div class='panel'>";
            empty_obj += "<a class='delete-btn'>Delete</a>";
            empty_obj += "<a class='edit-btn'>Edit</a>";
            empty_obj += "</div>";
            empty_obj += "</div>";

            var element = $(ui.draggable).clone();
            element.addClass("tempclass");

            if (ui.helper.context.id == "imgEditMenu1") {
                jQuery(empty_obj).appendTo("#editframe");
                video_counter++;
                $(".tempclass").attr("id", "video_" + video_counter);
                $(".tempclass" + " span").html("비디오");
                $("#video_" + video_counter).removeClass("tempclass");
                objName = "#video_" + video_counter;
            }
            else if (ui.helper.context.id == "imgEditMenu2") {
                var web_obj = '<div class="tempclass" style="width:100px; height:auto; position:absolute">';
                web_obj += '<img style="width:100%; height:100%; border:1px solid Gray" src="img/web_1.png"></img>';
                //패널 추가
                web_obj += "<div class='panel'>";
                web_obj += "<a class='delete-btn'>Delete</a>";
                web_obj += "<a class='edit-btn'>Edit</a>";
                web_obj += "</div>";
                web_obj += "</div>";

                $(this).append(web_obj);
                web_counter++;
                $(".tempclass").attr("id", "web_" + web_counter);
                $("#web_" + web_counter).removeClass("tempclass").addClass("dragged_object");
                objName = "#web_" + web_counter;
            }
            else if (ui.helper.context.id == "imgEditMenu3") {
                jQuery(empty_obj).appendTo("#editframe");
                img_counter++;
                $(".tempclass").attr("id", "img_" + img_counter);
                $(".tempclass" + " span").html("이미지");
                $("#img_" + img_counter).removeClass("tempclass").addClass("dragged_object");
                objName = "#img_" + img_counter;
            }
            else if (ui.helper.context.id == "imgEditMenu4") {
                var capture_obj = '<div class="tempclass" style="width:123px; height:49px; position:absolute">';
                capture_obj += '<img style="width:100%; height:100%;" src="img/capturebtn.png"></img>';
                //패널 추가
                capture_obj += "<div class='panel'>";
                capture_obj += "<a class='delete-btn'>Delete</a>";
                capture_obj += "<a class='edit-btn'>Edit</a>";
                capture_obj += "</div>";

                capture_obj += "</div>";
                $(this).append(capture_obj);
                capture_counter++;
                $(".tempclass").attr("id", "capture_" + capture_counter);
                $("#capture_" + capture_counter).removeClass("tempclass").addClass("dragged_object");
                objName = "#capture_" + capture_counter;
            }
            else if (ui.helper.context.id == "imgEditMenu5") {
                $(this).append(element);
                three_counter++;
                $(".tempclass").attr("id", "three_" + three_counter);
                $("#three_" + three_counter).removeClass("tempclass").addClass("dragged_object");
                objName = "#three_" + three_counter;
            }
            else if (ui.helper.context.id == "imgEditMenu6") {
                $(this).append(element);
                tel_counter++;
                $(".tempclass").attr("id", "tel_" + tel_counter);
                $("#tel_" + tel_counter).removeClass("tempclass").addClass("dragged_object");
                objName = "#tel_" + tel_counter;
            }
            else if (ui.helper.context.id == "imgEditMenu7") {
                $(this).append(element);
                googlemap_counter++;
                $(".tempclass").attr("id", "googlemap_" + googlemap_counter);
                $("#googlemap_" + googlemap_counter).removeClass("tempclass").addClass("dragged_object");
                objName = "#googlemap_" + googlemap_counter;
            }
            else if (ui.helper.context.id == "imgEditMenu8") {
                jQuery(empty_obj).appendTo("#editframe");
                notepad_counter++;
                $(".tempclass").attr("id", "notepad_" + notepad_counter);
                $(".tempclass" + " span").html("문자판");
                $("#notepad_" + notepad_counter).removeClass("tempclass").addClass("dragged_object");
                objName = "#notepad_" + notepad_counter;
            }
            else if (ui.helper.context.id == "imgEditMenu9") {
                $(this).append(element);
                audio_counter++;
                $(".tempclass").attr("id", "audio_" + audio_counter);
                $("#audio_" + audio_counter).removeClass("tempclass").addClass("dragged_object");
                objName = "#audio_" + audio_counter;
            }
            else if (ui.helper.context.id == "imgEditMenu10") {
                jQuery(empty_obj).appendTo("#editframe");
                chromakey_counter++;
                $(".tempclass").attr("id", "chromakey_" + chromakey_counter);
                $(".tempclass" + " span").html("비디오");
                $("#chromakey_" + chromakey_counter).removeClass("tempclass").addClass("dragged_object");
                objName = "#chromakey_" + chromakey_counter;
            }

            $(objName).css({ "left": $("#editframe").position.x + $("#editframe").width / 2 - $(objName).width / 2, "top": $("#editframe").position.y + $("#editframe").height/2 - $(objName).height / 2 });
            $(objName).draggable({
                containment: "parent"
            });
        }
        function checkImgExtention(ctrl, type) {
            if (type == "img") {
                var _validFileExtensions = [".jpg", ".png"];
                var blnValid = false;
                var sFileName = $("#fileImg").val();
                for (var j = 0; j < _validFileExtensions.length; j++) {
                    var sCurExtension = _validFileExtensions[j];
                    if (sFileName.substr(sFileName.length - sCurExtension.length, sCurExtension.length).toLowerCase() == sCurExtension.toLowerCase()) {
                        blnValid = true;
                        break;
                    }
                }
                if (!blnValid) {
                    alert("파일형식이 잘못되었습니다.");
                    return false;
                }
                return true;
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
                /***용량제한***/
                closePopup();
                ShowProgress();
                //create new FormData instance to transfer as Form Type
                var data = new FormData();
                // add the file intended to be upload to the created FormData instance
                data.append("upfile", file.files[0]);
                $.ajax({
                    url: 'PostUpload.aspx?type=0&content_id=' + CONTENT_ID,
                    type: "post",
                    data: data,
                    // cache: false,
                    processData: false,
                    contentType: false,
                    async: false,
                    success: function (data, textStatus, jqXHR) {
                        setTimeout(function () {
                            HideProgress();
                            $("#markImg").attr("src", data);
                            $("#editframe").css("display", "");
                            $("#tblRegMarker").css("display", "none");
                            setTimeout(function () {
                                $("#editframe").css({ "width": $("#markImg").attr("width") });
                            }, 500);
                            OnSave();
                            closePopup();
                            selLeftMenu(1);
                        }, 3000);
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        HideProgress();
                        alert("마커이미지 등록과정에 오류가 발생하였습니다.");
                    }
                });
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderSearch" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div>
    <table cellpadding="0" cellspacing="0" width="1320" align="center" background="img/top_bg02.png">
        <tr>
            <td width="1327" height="71" align="left">
                <table cellpadding="0" cellspacing="0" width="1315">
                    <tr>
                        <td width="652" height="71" align="left">
                            <table cellpadding="0" cellspacing="0" width="638">
                                <tr>
                                    <td width="299" height="71"><img src="img/cam_menutitle.png" width="224" height="71" border="0"></td>
                                    <td width="339" height="71">&nbsp;</td>
                                </tr>
                            </table>
                        </td>
                        <td width="663" height="71" align="right">
                            <table cellpadding="0" cellspacing="0" width="240">
                                <tr>
                                    <td width="120" height="35">
                                        <input id="btnSave" type="button" value="저장" onclick="OnSave()" class="cls99Button" style="width:110px; height:27px;" />
                                    </td>
                                    <td width="120" height="35">
                                        <input id="btnBack" type="button" value="나가기" class="cls99Button" onclick="OnBack()" style="width:110px; height:27px;" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table cellpadding="0" cellspacing="0" align="center" width="1320" style="border-collapse:collapse;">
        <tr>
            <td width="223" height="506" bgcolor="white" style="border-top-width:1px; border-right-width:2; border-bottom-width:1px; border-left-width:1px; border-top-color:black; border-right-color:rgb(224,226,228); border-bottom-color:black; border-left-color:black; border-top-style:none; border-right-style:solid; border-bottom-style:none; border-left-style:none;" valign="top">
                <table cellpadding="0" cellspacing="0" align="center" width="201">
                    <tr>
                        <td width="35" height="20">&nbsp;</td>
                        <td width="107" height="20">&nbsp;</td>
                        <td width="59" height="20">&nbsp;</td>
                    </tr>
                    <tr id="trMenu1r">
                        <td width="35" height="50"><img src="img/cam_menunum01_r.png" width="26" height="27" border="0"></td>
                        <td width="107" height="50"><span style="font-size:11pt;"><b><font face="돋움" color="#666666">마커 등록</font></b></span></td>
                        <td width="59" height="50">&nbsp;</td>
                    </tr>
                    <tr id="trMenu1">
                        <td width="35" height="50"><img src="img/cam_menunum01.png" class="image-btn" width="26" height="27" border="0"></td>
                        <td width="107" height="50"><span style="font-size:11pt;"><b><font face="돋움" color="#999999">마커 등록</font></b></span></td>
                        <td width="59" height="50" align="right">
                            <input type="button" class="cls99Button" value="확인" style="width:50px;height:23px" onclick="selLeftMenu(0)" />
                        </td>
                    </tr>
                    <tr id="trMenu2r">
                        <td width="35" height="50"><img src="img/cam_menunum02_r.png" width="26" height="27" border="0"></td>
                        <td width="107" height="50"><span style="font-size:11pt;"><b><font face="돋움" color="#666666">오브젝트 등록</font></b></span></td>
                        <td width="59" height="50">&nbsp;</td>
                    </tr>
                    <tr id="trMenu2">
                        <td width="35" height="50"><img src="img/cam_menunum02.png" width="26" height="27" border="0"></td>
                        <td width="107" height="50"><span style="font-size:11pt;"><b><font face="돋움" color="#999999">오브젝트 등록</font></b></span></td>
                        <td width="59" height="50" align="right">
                            <input type="button" class="cls99Button" value="수정" style="width:50px;height:23px" onclick="selLeftMenu(1)" />
                        </td>
                    </tr>
                </table>
                <table id="tblMenu2" cellpadding="0" cellspacing="0" width="200" align="center">
                    <tr id="trLeftmenu1">
                        <td width="200" height="50">
                            <div class="clsImagechange" id="imgEditMenu1">
                                <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" bgcolor="#F7F7F7">
                                    <tr>
                                        <td class="leftmenu" width="190" height="40">
                                            <table cellpadding="0" cellspacing="0" width="175">
                                                <tr>
                                                    <td width="35" height="27" align="right">
                                                        <img src="img/cam_icon01.png" width="19" height="19" border="0"/>
                                                    </td>
                                                    <td width="140" height="27" align="center">
                                                        Video
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <div class='panel'>
                                <a class='delete-btn'>Delete</a>
                                <a class='edit-btn'>Edit</a>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr id="trLeftmenu2">
                        <td width="200" height="50">
                            <div class="clsImagechange"id="imgEditMenu2" >
                                <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" bgcolor="#F7F7F7">
                                    <tr>
                                        <td class="leftmenu" width="190" height="40">
                                            <table cellpadding="0" cellspacing="0" width="175">
                                                <tr>
                                                    <td width="35" height="27" align="right">
                                                        <img src="img/cam_icon02.png" width="19" height="19" border="0"/>
                                                    </td>
                                                    <td width="140" height="27" align="center">
                                                        Image
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <div class='panel'>
                                <a class='delete-btn'>Delete</a>
                                <a class='edit-btn'>Edit</a>
                                </div>
                            </div>
                            
                        </td>
                    </tr>
                    <tr id="trLeftmenu3">
                        <td width="200" height="50">
                            <div class="clsImagechange"id="imgEditMenu3" >
                            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" bgcolor="#F7F7F7">
                                <tr>
                                    <td class="leftmenu" onclick="onSelItem(3)" id="leftmenu3" width="190" height="40">
                                        <table cellpadding="0" cellspacing="0" width="175">
                                            <tr>
                                                <td width="35" height="27" align="right">
                                                    <img src="img/cam_icon03.png" width="19" height="19" border="0"/>
                                                </td>
                                                <td width="140" height="27" align="center">
                                                    Website
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                                <div class='panel'>
                                <a class='delete-btn'>Delete</a>
                                <a class='edit-btn'>Edit</a>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr id="trLeftmenu4">
                        <td width="200" height="50">
                            <div class="clsImagechange"id="imgEditMenu4" >
                            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" bgcolor="#F7F7F7">
                                <tr>
                                    <td class="leftmenu" onclick="onSelItem(4)" id="leftmen4" width="190" height="40">
                                        <table cellpadding="0" cellspacing="0" width="175">
                                            <tr>
                                                <td width="35" height="27" align="right">
                                                    <img src="img/cam_icon04.png" width="19" height="19" border="0"/>
                                                </td>
                                                <td width="140" height="27" align="center">
                                                    Phone number
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                                <div class='panel'>
                                <a class='delete-btn'>Delete</a>
                                <a class='edit-btn'>Edit</a>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr id="trLeftmenu5">
                        <td width="200" height="50">
                            <div class="clsImagechange"id="imgEditMenu5" >
                            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" bgcolor="#F7F7F7">
                                <tr>
                                    <td class="leftmenu" onclick="onSelItem(5)" id="leftmenu5" width="190" height="40">
                                        <table cellpadding="0" cellspacing="0" width="175">
                                            <tr>
                                                <td width="35" height="27" align="right">
                                                    <img src="img/cam_icon05.png" width="19" height="19" border="0"/>
                                                </td>
                                                <td width="140" height="27" align="center">
                                                    Google map
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                                <div class='panel'>
                                <a class='delete-btn'>Delete</a>
                                <a class='edit-btn'>Edit</a>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr id="trLeftmenu6">
                        <td width="200" height="50">
                            <div class="clsImagechange"id="imgEditMenu6" >
                            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" bgcolor="#F7F7F7">
                                <tr>
                                    <td class="leftmenu" onclick="onSelItem(6)" id="leftmenu6" width="190" height="40">
                                        <table cellpadding="0" cellspacing="0" width="175">
                                            <tr>
                                                <td width="35" height="27" align="right">
                                                    <img src="img/cam_icon06.png" width="19" height="19" border="0"/>
                                                </td>
                                                <td width="140" height="27" align="center">
                                                    TEXT
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                                <div class='panel'>
                                <a class='delete-btn'>Delete</a>
                                <a class='edit-btn'>Edit</a>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr id="trLeftmenu7">
                        <td width="200" height="50">
                            <div class="clsImagechange"id="imgEditMenu7" >
                            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" bgcolor="#F7F7F7">
                                <tr>
                                    <td class="leftmenu" onclick="onSelItem(7)" id="leftmenu7" width="190" height="40">
                                        <table cellpadding="0" cellspacing="0" width="175">
                                            <tr>
                                                <td width="35" height="27" align="right">
                                                    <img src="img/cam_icon07.png" width="19" height="19" border="0"/>
                                                </td>
                                                <td width="140" height="27" align="center">
                                                    BGM
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                                <div class='panel'>
                                <a class='delete-btn'>Delete</a>
                                <a class='edit-btn'>Edit</a>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr id="trLeftmenu8">
                        <td width="200" height="50">
                            <div class="clsImagechange"id="imgEditMenu8" >
                            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" bgcolor="#F7F7F7">
                                <tr>
                                    <td class="leftmenu" onclick="onSelItem(8)" id="leftmenu8" width="190" height="40">
                                        <table cellpadding="0" cellspacing="0" width="175">
                                            <tr>
                                                <td width="35" height="27" align="right">
                                                    <img src="img/cam_icon08.png" width="19" height="19" border="0"/>
                                                </td>
                                                <td width="140" height="27" align="center">
                                                    Image slide
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                                <div class='panel'>
                                <a class='delete-btn'>Delete</a>
                                <a class='edit-btn'>Edit</a>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr id="trLeftmenu9">
                        <td width="200" height="50">
                            <div class="clsImagechange"id="imgEditMenu9" >
                            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" bgcolor="#F7F7F7">
                                <tr>
                                    <td class="leftmenu" onclick="onSelItem(9)" id="leftmenu9" width="190" height="40">
                                        <table cellpadding="0" cellspacing="0" width="175">
                                            <tr>
                                                <td width="35" height="27" align="right">
                                                    <img src="img/cam_icon09.png" width="19" height="19" border="0"/>
                                                </td>
                                                <td width="140" height="27" align="center">
                                                    Chroma-key photo
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                                <div class='panel'>
                                <a class='delete-btn'>Delete</a>
                                <a class='edit-btn'>Edit</a>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr id="trLeftmenu10">
                        <td width="200" height="50">
                            <div class="clsImagechange"id="imgEditMenu10" >
                            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" bgcolor="#F7F7F7">
                                <tr>
                                    <td class="leftmenu" onclick="onSelItem(10)" id="leftmenu10" width="190" height="40">
                                        <table cellpadding="0" cellspacing="0" width="175">
                                            <tr>
                                                <td width="35" height="27" align="right">
                                                    <img src="img/cam_icon10.png" width="19" height="19" border="0"/>
                                                </td>
                                                <td width="140" height="27" align="center">
                                                    Chroma-key video
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                                <div class='panel'>
                                <a class='delete-btn'>Delete</a>
                                <a class='edit-btn'>Edit</a>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr id="trLeftmenu11">
                        <td width="200" height="50">
                            <div class="clsImagechange"id="imgEditMenu11" >
                            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" bgcolor="#F7F7F7">
                                <tr>
                                    <td class="leftmenu" onclick="onSelItem(11)" id="leftmenu11" width="190" height="40">
                                        <table cellpadding="0" cellspacing="0" width="175">
                                            <tr>
                                                <td width="35" height="27" align="right">
                                                    <img src="img/cam_icon11.png" width="19" height="19" border="0"/>
                                                </td>
                                                <td width="140" height="27" align="center">
                                                    3D object
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                                <div class='panel'>
                                <a class='delete-btn'>Delete</a>
                                <a class='edit-btn'>Edit</a>
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="1093" height="506" bgcolor="#F7F8F8" style="border-top-width:1px; border-right-width:1px; border-bottom-width:1px; border-left-width:2; border-top-color:black; border-right-color:black; border-bottom-color:black; border-left-color:rgb(224,226,228); border-top-style:none; border-right-style:none; border-bottom-style:none; border-left-style:solid;">
                <table cellpadding="0" cellspacing="0" width="1093" align="center" bgcolor="#F7F8F8" style="border-collapse:collapse;">
                    <tr>
                        <td width="976" height="55" style="border-width:1px; border-top-color:black; border-right-color:black; border-bottom-color:rgb(229,233,235); border-left-color:black; border-top-style:none; border-right-style:none; border-bottom-style:solid; border-left-style:none;" valign="bottom">
                            <table cellpadding="0" cellspacing="0" align="center" width="1068">
                                <tr>
                                    <td width="652" height="47">
                                        <table cellpadding="0" cellspacing="0" width="630">
                                            <tr>
                                                <td width="26" height="37">&nbsp;</td>
                                                <td width="198" height="37"><b><font face="돋움" color="#666666"><span style="font-size:12pt;">캠페인1&nbsp;이름</span></font></b></td>
                                                <td width="172" height="37">&nbsp;</td>
                                                <td width="234" height="37">&nbsp;</td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td width="416" height="47" align="right">
                                        <img src="img/cam_grid_bt.png" class="image-btn" width="75" height="32" border="0" name="image2">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td width="976" height="700" align="center" valign="middle" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-top-style:solid; border-right-style:none; border-bottom-style:none; border-left-style:none;">
                            <div id="editframe" class="markdiv" style="margin-left:auto; margin-right:auto; z-index:1; display:none; position:relative; ">
                                <img id="markImg" class="clsMarkerImg" src="" alt="markerImg" />
                            </div>
                            <div class="req_cover">
                                <table id="tblRegMarker" cellpadding="0" cellspacing="0" width="690" align="center">
                                    <tr>
                                        <td width="690" height="113">
                                            <table cellpadding="0" cellspacing="0" width="411" align="center">
                                                <tr>
                                                    <td width="411" height="41" align="center">
                                                        <b><font face="돋움" color="#666666"><span style="font-size:12pt;">마커를 등록하세요.</span></font></b>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="411" height="50" align="center">
                                                        <input type="button" class="cls99BigButton" style="width:310px;height:35px;" value="마커등록하기" onclick="onRegMarker()" />
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
    <table cellpadding="0" cellspacing="0" width="557" align="center" style="border-collapse:collapse;" bgcolor="white">
        <tr>
            <td width="555" height="148" style="border-width:1px; border-color:lightgrey; border-style:solid;">
                <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="531">
                    <tr>
                        <td width="529" height="38" style="border-width:1px; border-top-color:black; border-right-color:black; border-bottom-color:rgb(229,233,235); border-left-color:black; border-style:none;">
                            <table cellpadding="0" cellspacing="0" align="center" width="512">
                                <tr>
                                    <td width="384" height="36"><b><font face="돋움" color="#4C4C4C"><span style="font-size:12pt;">마커 등록</span></font></b></td>
                                    <td width="128" height="36" align="right"></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td width="529" height="48" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                            <table cellpadding="0" cellspacing="0" align="center" width="514">
                                <tr>
                                    <td width="514" height="41" align="center">
                                        <input type="file" id="fileImg" name="fileImg" accept="image/png, image/jpeg" class="clsBrowser" size="49" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td width="529" height="49" align="right" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                            <table cellpadding="0" cellspacing="0" align="center" width="521">
                                <tr>
                                    <td width="521" height="41" align="center">
                                        <input type="button" style="width:508px;height:30px;" class="cls99BigButton" value="업로드" onclick="onRegMarkerImg()" />
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
<div id="dvRegVideo">
<table cellpadding="0" cellspacing="0" width="522" style="background-color:White">
    <tr>
        <td width="520" height="269" style="border-width:1px; border-color:rgb(255,102,0); border-style:solid;">
            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="502">
                <tr>
                    <td width="500" height="38" style="border-width:1px; border-top-color:black; border-right-color:black; border-bottom-color:rgb(229,233,235); border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="475">
                            <tr>
                                <td width="384" height="31"><b><font face="돋움" color="#4C4C4C"><span style="font-size:12pt;">비디오&nbsp;편집</span></font></b></td>
                                <td width="91" height="31" align="right">
                                    <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16" height="16" border="0" name="image1" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="500" height="137" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="487">
                            <tr>
                                <td width="110" height="61" align="center" class="clsTitleLabel>
                                    업로드
                                </td>
                                <td width="377" height="61" align="center">
                                    <input id="video_file" type="file" name="video_path" accept="video/mp4" class="clsBrowser" size="35" />
                                </td>
                            </tr>
                            <tr>
                                <td width="110" height="76" align="center" class="clsTitleLabel>
                                    실행옵션
                                </td>
                                <td width="377" height="76">
                                    <table cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                <input id="videorun_rd1" type="radio" name="videorun_rd" title="자동실행" value="0" checked /> 동영상이 자동으로 재생됩니다.
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                <input id="videorun_rd2" type="radio" name="videorun_rd" title="터치시 실행" value="1" /> 동영상이 터치 시 재생됩니다.
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="500" height="55" align="right" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="485">
                            <tr>
                                <td width="485" height="41" align="right">
                                    <input type="button" style="width:103px;height:30px; font-weight:bold;" class="clsButton" value="적용하기" onclick="OnVideoApply1()"/>
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
<div id="dvVideo3D">
<table cellpadding="0" cellspacing="0" width="522" style="background-color:White">
    <tr>
        <td width="520" height="251" style="border-width:1px; border-color:rgb(255,102,0); border-style:solid;">
            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="502">
                <tr>
                    <td width="500" height="38" style="border-width:1px; border-top-color:black; border-right-color:black; border-bottom-color:rgb(229,233,235); border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="475">
                            <tr>
                                <td width="384" height="31"><b><font face="돋움" color="#4C4C4C"><span style="font-size:12pt;">비디오 - 3D&nbsp;템플릿</span></font></b></td>
                                <td width="91" height="31" align="right">
                                    <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16" height="16" border="0" name="image1" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="500" height="137" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
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
                                                <input id="video_rd3" type="radio" name="video_rd" value="1" /> 3D 와이드 평면 TV형
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="500" height="45" align="right" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="485">
                            <tr>
                                <td width="485" height="41" align="right">
                                    <input type="button" style="width:103px;height:30px; font-weight:bold;" class="clsButton" value="적용하기" onclick="OnVideoApply2()"/>
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
<table cellpadding="0" cellspacing="0" width="522" style="background-color:White">
    <tr>
        <td width="520" height="195" style="border-width:1px; border-color:rgb(255,102,0); border-style:solid;">
            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="502">
                <tr>
                    <td width="500" height="38" style="border-width:1px; border-top-color:black; border-right-color:black; border-bottom-color:rgb(229,233,235); border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="475">
                            <tr>
                                <td width="384" height="31"><b><font face="돋움" color="#4C4C4C"><span style="font-size:12pt;">이미지&nbsp;편집</span></font></b></td>
                                <td width="91" height="31" align="right">
                                    <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16" height="16" border="0" name="image1" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="500" height="86" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="487">
                            <tr>
                                <td width="110" height="61" align="center" class="clsTitleLabel">clsLabel">업로드</b>
                                </td>
                                <td width="377" height="61" align="center">
                                    <input type="file" name="formfile1" class="clsBrowser" size="35">
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="500" height="45" align="right" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="485">
                            <tr>
                                <td width="485" height="41" align="right">
                                    <input type="button" style="width:103px;height:30px; font-weight:bold;" class="clsButton" value="적용하기" />
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
<table cellpadding="0" cellspacing="0" width="522" style="background-color:White">
    <tr>
        <td width="520" height="210" style="border-width:1px; border-color:rgb(255,102,0); border-style:solid;">
            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="502">
                <tr>
                    <td width="500" height="38" style="border-width:1px; border-top-color:black; border-right-color:black; border-bottom-color:rgb(229,233,235); border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="475">
                            <tr>
                                <td width="384" height="31"><b><font face="돋움" color="#4C4C4C"><span style="font-size:12pt;">이미지 - 3D&nbsp;템플릿</span></font></b></td>
                                <td width="91" height="31" align="right">
                                    <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16" height="16" border="0" name="image1" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="500" height="98" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="469">
                            <tr>
                                <td width="469" height="88">
                                    <table cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                <input type="radio" name="formradio1" checked> 적용 안함
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                <input type="radio" name="formradio1"> 3D 스탠드 액자형
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="500" height="45" align="right" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="485">
                            <tr>
                                <td width="485" height="41" align="right">
                                    <table cellpadding="0" cellspacing="0" width="103" bgcolor="#33B5E5">
                                        <tr>
                                            <td width="103" height="30" align="center">
                                                <font face="돋움" color="white"><span style="font-size:10pt;"><b>적용하기</b></span></font>
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
</table>
</div>
<div id="divWeb" class="clspopup">
<table cellpadding="0" cellspacing="0" width="522" style="background-color:White">
    <tr>
        <td width="520" height="590" style="border-width:1px; border-color:rgb(255,102,0); border-style:solid;">
            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="502">
                <tr>
                    <td width="500" height="38" style="border-width:1px; border-top-color:black; border-right-color:black; border-bottom-color:rgb(229,233,235); border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="475">
                            <tr>
                                <td width="384" height="54"><b><font face="돋움" color="#4C4C4C"><span style="font-size:12pt;">웹사이트&nbsp;편집</span></font></b></td>
                                <td width="91" height="54" align="right">
                                    <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16" height="16" border="0" name="image1" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="500" height="86" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="476">
                            <tr>
                                <td width="115" height="70" align="center" class="clsTitleLabel">
                                    URL
                                </td>
                                <td width="361" height="70" align="left">
                                    <input type="text" name="formtext1" size="49">
                                </td>
                            </tr>
                            <tr>
                                <td width="115" height="88" valign="top">                                    
                                    <table cellpadding="0" cellspacing="0" width="105" align="center">
                                        <tr>
                                            <td width="105" height="32" align="center" class="clsTitleLabel">clsLabel">VIEW 옵션</b>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="361" height="88" valign="top">
                                    <table cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                <input type="radio" name="formradio1" checked> 링크형
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                <input type="radio" name="formradio1"> 자체&nbsp;브라우저형
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td width="115" height="183" valign="top">                                    
                                    <table cellpadding="0" cellspacing="0" width="105" align="center">
                                        <tr>
                                            <td width="105" height="32" align="center" class="clsTitleLabel">
                                                버튼종류
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="361" height="183" valign="top">
                                    <table cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                <input type="radio" name="formradio1" checked> 기본 버튼
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                <input type="radio" name="formradio1"> 커스텀 버튼형
                                            </td>
                                        </tr>
                                    </table>
                                    <table cellpadding="0" cellspacing="0" width="360">
                                        <tr>
                                            <td width="180" height="47">
                                                <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" bgcolor="#F7F7F7" width="169">
                                                    <tr>
                                                        <td width="167" height="35" align="left" style="border-width:1px; border-color:rgb(187,187,187); border-style:solid;">
                                                            <table cellpadding="0" cellspacing="0" width="159">
                                                                <tr>
                                                                    <td width="35" height="27" align="right">
                                                                        <img src="img/cam_icon_setting.png" width="19" height="19" border="0">
                                                                    </td>
                                                                    <td width="124" height="27" align="center">
                                                                        <b><font face="돋움" color="#8C959A"><span style="font-size:10pt;">Website</span></font></b>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="180" height="47">
                                                <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" bgcolor="#F7F7F7" width="169">
                                                    <tr>
                                                        <td width="167" height="35" align="left" style="border-width:1px; border-color:rgb(187,187,187); border-style:solid;">
                                                            <table cellpadding="0" cellspacing="0" width="159">
                                                                <tr>
                                                                    <td width="35" height="27" align="right">
                                                                        <img src="img/cam_icon_setting.png" width="19" height="19" border="0">
                                                                    </td>
                                                                    <td width="124" height="27" align="center">
                                                                        <b><font face="돋움" color="#8C959A"><span style="font-size:10pt;">APP다운로드</span></font></b>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="180" height="46">
                                                <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" bgcolor="#F7F7F7" width="169">
                                                    <tr>
                                                        <td width="167" height="35" align="left" style="border-width:1px; border-color:rgb(187,187,187); border-style:solid;">
                                                            <table cellpadding="0" cellspacing="0" width="159">
                                                                <tr>
                                                                    <td width="35" height="27" align="right">
                                                                        <img src="img/cam_icon_setting.png" width="19" height="19" border="0">
                                                                    </td>
                                                                    <td width="124" height="27" align="center">
                                                                        <b><font face="돋움" color="#8C959A"><span style="font-size:10pt;">바로가기</span></font></b>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="180" height="46">
                                                <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" bgcolor="#F7F7F7" width="169">
                                                    <tr>
                                                        <td width="167" height="35" align="left" style="border-width:1px; border-color:rgb(187,187,187); border-style:solid;">
                                                            <table cellpadding="0" cellspacing="0" width="159">
                                                                <tr>
                                                                    <td width="35" height="27" align="right">
                                                                        <img src="img/cam_icon_setting.png" width="19" height="19" border="0">
                                                                    </td>
                                                                    <td width="124" height="27" align="center">
                                                                        <b><font face="돋움" color="#8C959A"><span style="font-size:10pt;">구매하기</span></font></b>
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
                            <tr>
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
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center">
                                                    <tr>
                                                        <td width="25" height="25" bgcolor="black">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35" style="border-width:1px; border-color:rgb(7,157,236); border-style:solid;">
                                                <table cellpadding="0" cellspacing="0" align="center">
                                                    <tr>
                                                        <td width="25" height="25" bgcolor="#079DEC">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
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
                                    <table cellpadding="0" cellspacing="0" width="316">
                                        <tr>
                                            <td width="180" height="47" valign="top">
                                                <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" bgcolor="#F7F7F7" width="169">
                                                    <tr>
                                                        <td width="167" height="35" align="left" style="border-width:1px; border-color:rgb(187,187,187); border-style:solid;">
                                                            <table cellpadding="0" cellspacing="0" width="159">
                                                                <tr>
                                                                    <td width="35" height="27" align="right">
                                                                        <img src="img/cam_icon_setting.png" width="19" height="19" border="0">
                                                                    </td>
                                                                    <td width="124" height="27" align="center">
                                                                        <b><font face="돋움" color="#8C959A"><span style="font-size:10pt;">Website</span></font></b>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="136" height="47">&nbsp;</td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="500" height="45" align="right" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="466">
                            <tr>
                                <td width="466" height="44" align="right">
                                    <table cellpadding="0" cellspacing="0" width="124" bgcolor="#33B5E5">
                                        <tr>
                                            <td width="124" height="30" align="center">
                                                <font face="돋움" color="white"><span style="font-size:10pt;"><b>적용하기</b></span></font>
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
</table>
</div>
<div id="divWeb3D" class="clspopup">
<table cellpadding="0" cellspacing="0" width="522" style="background-color:White">
    <tr>
        <td width="520" height="452" style="border-width:1px; border-color:rgb(255,102,0); border-style:solid;">
            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="502">
                <tr>
                    <td width="500" height="38" style="border-width:1px; border-top-color:black; border-right-color:black; border-bottom-color:rgb(229,233,235); border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="475">
                            <tr>
                                <td width="384" height="54"><b><font face="돋움" color="#4C4C4C"><span style="font-size:12pt;">웹사이트&nbsp;편집</span></font></b></td>
                                <td width="91" height="54" align="right">
                                    <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16" height="16" border="0" name="image1" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="500" height="86" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="476">
                            <tr>
                                <td width="115" height="70" align="center" class="clsTitleLabel">
                                    URL
                                </td>
                                <td width="361" height="70" align="left">
                                    <input type="text" name="formtext1" size="49">
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
                                <td width="361" height="88" valign="top">
                                    <table cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                <input type="radio" name="formradio1" checked> 링크형
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                <input type="radio" name="formradio1"> 자체 브라우져형
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td width="115" height="89" valign="top">                                    
                                    <table cellpadding="0" cellspacing="0" width="105" align="center">
                                        <tr>
                                            <td width="105" height="32" align="center" class="clsTitleLabel">
                                                버튼종류
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="361" height="89" valign="top">
                                    <table cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                <input type="radio" name="formradio1" checked> 기본버튼
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                <input type="radio" name="formradio1"> 커스텀&nbsp;버튼
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
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
                                                <input type="file" name="formfile1" class="clsBrowser" size="30">
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="500" height="45" align="right" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="466">
                            <tr>
                                <td width="466" height="44" align="right">
                                    <table cellpadding="0" cellspacing="0" width="124" bgcolor="#33B5E5">
                                        <tr>
                                            <td width="124" height="30" align="center">
                                                <font face="돋움" color="white"><span style="font-size:10pt;"><b>적용하기</b></span></font>
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
</table>
</div>
<div id="dvPhone" class="clspopup">
<table cellpadding="0" cellspacing="0" width="522" style="background-color:White">
    <tr>
        <td width="520" height="549" style="border-width:1px; border-color:rgb(255,102,0); border-style:solid;">
            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="502">
                <tr>
                    <td width="500" height="38" style="border-width:1px; border-top-color:black; border-right-color:black; border-bottom-color:rgb(229,233,235); border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="475">
                            <tr>
                                <td width="384" height="38"><b><font face="돋움" color="#4C4C4C"><span style="font-size:12pt;">전화번호&nbsp;편집&nbsp;</span></font></b></td>
                                <td width="91" height="38" align="right">
                                    <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16" height="16" border="0" name="image1" />
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="0" cellspacing="0" align="center" width="475">
                            <tr>
                                <td width="384" height="37" valign="top" class="clsLabel">유선전화의 경우 지역번호도 함께 입력해주세요.</td>
                                <td width="91" height="37" align="right">
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="500" height="86" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="476">
                            <tr>
                                <td width="115" height="70" align="center" class="clsTitleLabel">
                                    전화번호 입력
                                </td>
                                <td width="361" height="70" align="left">
                                    <input type="text" name="formtext1" size="49">
                                </td>
                            </tr>
                            <tr>
                                <td width="115" height="180" valign="top">                                    
                                    <table cellpadding="0" cellspacing="0" width="105" align="center">
                                        <tr>
                                            <td width="105" height="32" align="center" class="clsTitleLabel">
                                                버튼종류
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="361" height="180" valign="top">
                                    <table cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                <input type="radio" name="formradio1" checked> 기본 버튼
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                <input type="radio" name="formradio1"> 커스텀&nbsp;버튼
                                            </td>
                                        </tr>
                                    </table>
                                    <table cellpadding="0" cellspacing="0" width="360">
                                        <tr>
                                            <td width="180" height="47">
                                                <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" bgcolor="#F7F7F7" width="169">
                                                    <tr>
                                                        <td width="167" height="35" align="left" style="border-width:1px; border-color:rgb(187,187,187); border-style:solid;">
                                                            <table cellpadding="0" cellspacing="0" width="159">
                                                                <tr>
                                                                    <td width="35" height="27" align="right">
                                                                        <img src="img/cam_icon_setting.png" width="19" height="19" border="0">
                                                                    </td>
                                                                    <td width="124" height="27" align="center">
                                                                        <b><font face="돋움" color="#8C959A"><span style="font-size:10pt;">Phone Number</span></font></b>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="180" height="47">
                                                <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" bgcolor="#F7F7F7" width="169">
                                                    <tr>
                                                        <td width="167" height="35" align="left" style="border-width:1px; border-color:rgb(187,187,187); border-style:solid;">
                                                            <table cellpadding="0" cellspacing="0" width="159">
                                                                <tr>
                                                                    <td width="35" height="27" align="right">
                                                                        <img src="img/cam_icon_setting.png" width="19" height="19" border="0">
                                                                    </td>
                                                                    <td width="124" height="27" align="center">
                                                                        <b><font face="돋움" color="#8C959A"><span style="font-size:10pt;">Office phone</span></font></b>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="180" height="46">
                                                <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" bgcolor="#F7F7F7" width="169">
                                                    <tr>
                                                        <td width="167" height="35" align="left" style="border-width:1px; border-color:rgb(187,187,187); border-style:solid;">
                                                            <table cellpadding="0" cellspacing="0" width="159">
                                                                <tr>
                                                                    <td width="35" height="27" align="right">
                                                                        <img src="img/cam_icon_setting.png" width="19" height="19" border="0">
                                                                    </td>
                                                                    <td width="124" height="27" align="center">
                                                                        <b><font face="돋움" color="#8C959A"><span style="font-size:10pt;">연락처</span></font></b>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="180" height="46">
                                                <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" bgcolor="#F7F7F7" width="169">
                                                    <tr>
                                                        <td width="167" height="35" align="left" style="border-width:1px; border-color:rgb(187,187,187); border-style:solid;">
                                                            <table cellpadding="0" cellspacing="0" width="159">
                                                                <tr>
                                                                    <td width="35" height="27" align="right">
                                                                        <img src="img/cam_icon_setting.png" width="19" height="19" border="0">
                                                                    </td>
                                                                    <td width="124" height="27" align="center">
                                                                        <b><font face="돋움" color="#8C959A"><span style="font-size:10pt;">주문하기</span></font></b>
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
                            <tr>
                                <td width="115" height="10" valign="top">
                                    <table cellpadding="0" cellspacing="0" width="105" align="center">
                                        <tr>
                                            <td width="105" height="32" align="center" class="clsTitleLabel">
                                                색상
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="361" height="61" valign="top">
                                    <table cellpadding="0" cellspacing="0" width="350">
                                        <tr>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center">
                                                    <tr>
                                                        <td width="25" height="25" bgcolor="black">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35" style="border-width:1px; border-color:rgb(7,157,236); border-style:solid;">
                                                <table cellpadding="0" cellspacing="0" align="center">
                                                    <tr>
                                                        <td width="25" height="25" bgcolor="#079DEC">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
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
                                    <table cellpadding="0" cellspacing="0" width="316">
                                        <tr>
                                            <td width="180" height="47" valign="top">
                                                <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" bgcolor="#F7F7F7" width="169">
                                                    <tr>
                                                        <td width="167" height="35" align="left" style="border-width:1px; border-color:rgb(187,187,187); border-style:solid;">
                                                            <table cellpadding="0" cellspacing="0" width="159">
                                                                <tr>
                                                                    <td width="35" height="27" align="right">
                                                                        <img src="img/cam_icon_setting.png" width="19" height="19" border="0">
                                                                    </td>
                                                                    <td width="124" height="27" align="center">
                                                                        <b><font face="돋움" color="#8C959A"><span style="font-size:10pt;">Phone Number</span></font></b>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="136" height="47">&nbsp;</td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="500" height="45" align="right" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="466">
                            <tr>
                                <td width="466" height="44" align="right">
                                    <table cellpadding="0" cellspacing="0" width="124" bgcolor="#33B5E5">
                                        <tr>
                                            <td width="124" height="30" align="center">
                                                <font face="돋움" color="white"><span style="font-size:10pt;"><b>적용하기</b></span></font>
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
</table>
</div>
<div id="dvPhoneCustom" class="clspopup">
<table cellpadding="0" cellspacing="0" width="522" style="background-color:White">
    <tr>
        <td width="520" height="394" style="border-width:1px; border-color:rgb(255,102,0); border-style:solid;">
            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="502">
                <tr>
                    <td width="500" height="38" style="border-width:1px; border-top-color:black; border-right-color:black; border-bottom-color:rgb(229,233,235); border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="475">
                            <tr>
                                <td width="384" height="38"><b><font face="돋움" color="#4C4C4C"><span style="font-size:12pt;">전화번호&nbsp;편집</span></font></b></td>
                                <td width="91" height="38" align="right">
                                    <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16" height="16" border="0" name="image1" />
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="0" cellspacing="0" align="center" width="475">
                            <tr>
                                <td width="384" height="37" valign="top" class="clsLabel">유선전화의 경우 지역번호도 함께 입력해주세요.</td>
                                <td width="91" height="37" align="right">
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="500" height="86" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="476">
                            <tr>
                                <td width="115" height="72" align="center" class="clsTitleLabel">
                                    전화번호 입력</
                                </td>
                                <td width="361" height="72" align="left">
                                    <input type="text" name="formtext1" size="49">
                                </td>
                            </tr>
                            <tr>
                                <td width="115" height="91" valign="top">                                    
                                    <table cellpadding="0" cellspacing="0" width="105" align="center">
                                        <tr>
                                            <td width="105" height="32" align="center" class="clsTitleLabel">
                                                버튼종류
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="361" height="91" valign="top">
                                    <table cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                <input type="radio" name="formradio1"> 기본 버튼
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                <input type="radio" name="formradio1" checked> 커스텀 버튼
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
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
                                                <input type="file" name="formfile1" class="clsBrowser" size="30">
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="500" height="45" align="right" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="466">
                            <tr>
                                <td width="466" height="44" align="right">
                                    <table cellpadding="0" cellspacing="0" width="124" bgcolor="#33B5E5">
                                        <tr>
                                            <td width="124" height="30" align="center">
                                                <font face="돋움" color="white"><span style="font-size:10pt;"><b>적용하기</b></span></font>
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
</table>
</div>
<div id="dvPhone3D" class="clspopup">
<table cellpadding="0" cellspacing="0" width="522" style="background-color:White">
    <tr>
        <td width="520" height="210" style="border-width:1px; border-color:rgb(255,102,0); border-style:solid;">
            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="502">
                <tr>
                    <td width="500" height="38" style="border-width:1px; border-top-color:black; border-right-color:black; border-bottom-color:rgb(229,233,235); border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="475">
                            <tr>
                                <td width="384" height="31"><b><font face="돋움" color="#4C4C4C"><span style="font-size:12pt;">전화번호 - 3D&nbsp;템플릿</span></font></b></td>
                                <td width="91" height="31" align="right">
                                    <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16" height="16" border="0" name="image1" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="500" height="98" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="469">
                            <tr>
                                <td width="469" height="88">
                                    <table cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                <input type="radio" name="formradio1" checked> 적용 안함
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                <input type="radio" name="formradio1"> 3D 클래식 전화기
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="500" height="45" align="right" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="485">
                            <tr>
                                <td width="485" height="41" align="right">
                                    <table cellpadding="0" cellspacing="0" width="103" bgcolor="#33B5E5">
                                        <tr>
                                            <td width="103" height="30" align="center">
                                                <font face="돋움" color="white"><span style="font-size:10pt;"><b>적용하기</b></span></font>
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
</table>
</div>
<div id="dvGoogleMap" class="clspopup">
<table cellpadding="0" cellspacing="0" width="522" style="background-color:White">
    <tr>
        <td width="520" height="549" style="border-width:1px; border-color:rgb(255,102,0); border-style:solid;">
            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="502">
                <tr>
                    <td width="500" height="38" style="border-width:1px; border-top-color:black; border-right-color:black; border-bottom-color:rgb(229,233,235); border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="475">
                            <tr>
                                <td width="384" height="38"><b><font face="돋움" color="#4C4C4C"><span style="font-size:12pt;">구글맵&nbsp;편집&nbsp;</span></font></b></td>
                                <td width="91" height="38" align="right">
                                    <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16" height="16" border="0" name="image1" />
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="0" cellspacing="0" align="center" width="475">
                            <tr>
                                <td width="413" height="37" valign="top" class="clsLabel">유표시하고자 하는 장소의 구글맵 좌표를 확인하여 입력해주세요.</td>
                                <td width="62" height="37" align="right">
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="500" height="86" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="476">
                            <tr>
                                <td width="115" height="70" align="center" class="clsTitleLabel">
                                    좌표입력
                                </td>
                                <td width="361" height="70" align="left">
                                    <input type="text" name="formtext1" size="49" value="필수입력 항목입니다." style="font-family:돋움; font-size:10pt; color:rgb(153,153,153);">
                                </td>
                            </tr>
                            <tr>
                                <td width="115" height="180" valign="top">                                    
                                    <table cellpadding="0" cellspacing="0" width="105" align="center">
                                        <tr>
                                            <td width="105" height="32" align="center" class="clsTitleLabel">
                                                버튼종류
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="361" height="180" valign="top">
                                    <table cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                <input type="radio" name="formradio1" checked> 기본 버튼
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                <input type="radio" name="formradio1"> 커스텀&nbsp;버튼
                                            </td>
                                        </tr>
                                    </table>
                                    <table cellpadding="0" cellspacing="0" width="360">
                                        <tr>
                                            <td width="180" height="47">
                                                <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" bgcolor="#F7F7F7" width="169">
                                                    <tr>
                                                        <td width="167" height="35" align="left" style="border-width:1px; border-color:rgb(187,187,187); border-style:solid;">
                                                            <table cellpadding="0" cellspacing="0" width="159">
                                                                <tr>
                                                                    <td width="35" height="27" align="right">
                                                                        <img src="img/cam_icon_setting.png" width="19" height="19" border="0">
                                                                    </td>
                                                                    <td width="124" height="27" align="center">
                                                                        <b><font face="돋움" color="#8C959A"><span style="font-size:10pt;">Google Map</span></font></b>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="180" height="47">
                                                <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" bgcolor="#F7F7F7" width="169">
                                                    <tr>
                                                        <td width="167" height="35" align="left" style="border-width:1px; border-color:rgb(187,187,187); border-style:solid;">
                                                            <table cellpadding="0" cellspacing="0" width="159">
                                                                <tr>
                                                                    <td width="35" height="27" align="right">
                                                                        <img src="img/cam_icon_setting.png" width="19" height="19" border="0">
                                                                    </td>
                                                                    <td width="124" height="27" align="center">
                                                                        <b><font face="돋움" color="#8C959A"><span style="font-size:10pt;">지도보기</span></font></b>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="180" height="46">
                                                <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" bgcolor="#F7F7F7" width="169">
                                                    <tr>
                                                        <td width="167" height="35" align="left" style="border-width:1px; border-color:rgb(187,187,187); border-style:solid;">
                                                            <table cellpadding="0" cellspacing="0" width="159">
                                                                <tr>
                                                                    <td width="35" height="27" align="right">
                                                                        <img src="img/cam_icon_setting.png" width="19" height="19" border="0">
                                                                    </td>
                                                                    <td width="124" height="27" align="center">
                                                                        <b><font face="돋움" color="#8C959A"><span style="font-size:10pt;">행사장소</span></font></b>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="180" height="46">
                                                <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" bgcolor="#F7F7F7" width="169">
                                                    <tr>
                                                        <td width="167" height="35" align="left" style="border-width:1px; border-color:rgb(187,187,187); border-style:solid;">
                                                            <table cellpadding="0" cellspacing="0" width="159">
                                                                <tr>
                                                                    <td width="35" height="27" align="right">
                                                                        <img src="img/cam_icon_setting.png" width="19" height="19" border="0">
                                                                    </td>
                                                                    <td width="124" height="27" align="center">
                                                                        <b><font face="돋움" color="#8C959A"><span style="font-size:10pt;">매장위치</span></font></b>
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
                            <tr>
                                <td width="115" height="10" valign="top">
                                    <table cellpadding="0" cellspacing="0" width="105" align="center">
                                        <tr>
                                            <td width="105" height="32" align="center" class="clsTitleLabel">
                                                색상
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="361" height="61" valign="top">
                                    <table cellpadding="0" cellspacing="0" width="350">
                                        <tr>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center">
                                                    <tr>
                                                        <td width="25" height="25" bgcolor="black">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35" style="border-width:1px; border-color:rgb(7,157,236); border-style:solid;">
                                                <table cellpadding="0" cellspacing="0" align="center">
                                                    <tr>
                                                        <td width="25" height="25" bgcolor="#079DEC">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
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
                                    <table cellpadding="0" cellspacing="0" width="316">
                                        <tr>
                                            <td width="180" height="47" valign="top">
                                                <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" bgcolor="#F7F7F7" width="169">
                                                    <tr>
                                                        <td width="167" height="35" align="left" style="border-width:1px; border-color:rgb(187,187,187); border-style:solid;">
                                                            <table cellpadding="0" cellspacing="0" width="159">
                                                                <tr>
                                                                    <td width="35" height="27" align="right">
                                                                        <img src="img/cam_icon_setting.png" width="19" height="19" border="0">
                                                                    </td>
                                                                    <td width="124" height="27" align="center">
                                                                        <b><font face="돋움" color="#8C959A"><span style="font-size:10pt;">Google Map</span></font></b>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="136" height="47">&nbsp;</td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="500" height="45" align="right" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="466">
                            <tr>
                                <td width="466" height="44" align="right">
                                    <table cellpadding="0" cellspacing="0" width="124" bgcolor="#33B5E5">
                                        <tr>
                                            <td width="124" height="30" align="center">
                                                <font face="돋움" color="white"><span style="font-size:10pt;"><b>적용하기</b></span></font>
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
</table>
</div>
<div id="dvGoogleMapCustom" class="clspopup">
<table cellpadding="0" cellspacing="0" width="522" style="background-color:White">
    <tr>
        <td width="520" height="394" style="border-width:1px; border-color:rgb(255,102,0); border-style:solid;">
            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="502">
                <tr>
                    <td width="500" height="38" style="border-width:1px; border-top-color:black; border-right-color:black; border-bottom-color:rgb(229,233,235); border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="475">
                            <tr>
                                <td width="384" height="38"><b><font face="돋움" color="#4C4C4C"><span style="font-size:12pt;">구글맵&nbsp;편집</span></font></b></td>
                                <td width="91" height="38" align="right">
                                    <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16" height="16" border="0" name="image1" />
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="0" cellspacing="0" align="center" width="475">
                            <tr>
                                <td width="384" height="37" valign="top" class="clsLabel">유표시하고자 하는 장소의 구글맵 좌표를 확인하여 입력해주세요.</td>
                                <td width="91" height="37" align="right">
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="500" height="86" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="476">
                            <tr>
                                <td width="115" height="72" align="center" class="clsTitleLabel">
                                    좌표입력
                                </td>
                                <td width="361" height="72" align="left">
                                    <input type="text" name="formtext1" size="49" value="필수입력 항목입니다." style="font-family:돋움; font-size:10pt; color:rgb(153,153,153);">
                                </td>
                            </tr>
                            <tr>
                                <td width="115" height="91" valign="top">                                    
                                    <table cellpadding="0" cellspacing="0" width="105" align="center">
                                        <tr>
                                            <td width="105" height="32" align="center" class="clsTitleLabel">
                                                버튼종류
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="361" height="91" valign="top">
                                    <table cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                <input type="radio" name="formradio1"> 기본 버튼
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                <input type="radio" name="formradio1" checked> 커스텀 버튼
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
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
                                                <input type="file" name="formfile1" class="clsBrowser" size="30">
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="500" height="45" align="right" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="466">
                            <tr>
                                <td width="466" height="44" align="right">
                                    <table cellpadding="0" cellspacing="0" width="124" bgcolor="#33B5E5">
                                        <tr>
                                            <td width="124" height="30" align="center">
                                                <font face="돋움" color="white"><span style="font-size:10pt;"><b>적용하기</b></span></font>
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
</table>
</div>
<div id="dvText" class="clspopup">
<table cellpadding="0" cellspacing="0" width="522" style="background-color:White">
    <tr>
        <td width="520" height="620" style="border-width:1px; border-color:rgb(255,102,0); border-style:solid;">
            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="502">
                <tr>
                    <td width="500" height="38" style="border-width:1px; border-top-color:black; border-right-color:black; border-bottom-color:rgb(229,233,235); border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="475">
                            <tr>
                                <td width="384" height="60"><b><font face="돋움" color="#4C4C4C"><span style="font-size:12pt;">텍스트&nbsp;편집&nbsp;</span></font></b></td>
                                <td width="91" height="60" align="right">
                                    <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16" height="16" border="0" name="image1" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="500" height="86" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="476">
                            <tr>
                                <td width="115" height="105" align="center" class="clsTitleLabel">
                                    텍스트 문구
                                </td>
                                <td width="361" height="105">
                                    <table cellpadding="0" cellspacing="0" width="349" align="center">
                                        <tr>
                                            <td width="327" height="69" align="left">
                                                <textarea name="formtextarea1" rows="4" cols="44"></textarea>
                                            </td>
                                            <td width="22" height="69" align="right" class="clsLabel">
                                                <span style="font-size:10pt;"><font face="돋움" color="#666666">60</font></span><br><br><br>&nbsp;
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
                                <td width="361" height="70" valign="top">
                                    <table cellpadding="0" cellspacing="0" width="350">
                                        <tr>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center">
                                                    <tr>
                                                        <td width="25" height="25" bgcolor="black">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35" style="border-width:1px; border-color:rgb(7,157,236); border-style:solid;">
                                                <table cellpadding="0" cellspacing="0" align="center">
                                                    <tr>
                                                        <td width="25" height="25" bgcolor="#079DEC">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
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
                                            <td width="69" height="47" align="center" class="clsLabel">
                                                없음
                                            </td>
                                            <td width="71" height="47" style="border-width:1px; border-color:rgb(255,119,0); border-style:solid;" align="center">
                                                <img src="img/icon_text01.png" width="38" height="33" border="0">
                                            </td>
                                            <td width="71" height="47" align="center">
                                                <img src="img/icon_text02.png" width="38" height="33" border="0">
                                            </td>
                                            <td width="79" height="47" align="center">
                                                <img src="img/icon_text03.png" width="57" height="33" border="0">
                                            </td>
                                            <td width="70" height="47" align="center">
                                                <img src="img/icon_text04.png" width="38" height="33" border="0">
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
                                                &nbsp;&nbsp;&nbsp;텍스트보드<br> &nbsp;&nbsp;&nbsp;색상
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="361" height="70" valign="top">
                                    <table cellpadding="0" cellspacing="0" width="350">
                                        <tr>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center">
                                                    <tr>
                                                        <td width="25" height="25" bgcolor="black">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35" style="border-width:1px; border-color:rgb(7,157,236); border-style:solid;">
                                                <table cellpadding="0" cellspacing="0" align="center">
                                                    <tr>
                                                        <td width="25" height="25" bgcolor="#079DEC">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                                </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
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
                                                &nbsp;&nbsp;&nbsp;텍스트<br> &nbsp;&nbsp;&nbsp;재생방법
                                            </td>
                                        </tr>
                                    </table>
                                    &nbsp;
                                </td>
                                <td width="361" height="110" valign="top">
                                    <table cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                <input type="radio" name="formradio1"> 없음
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                <input type="radio" name="formradio1" checked> 쓰기효과
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                <input type="radio" name="formradio1" checked> 페이드 인 효과
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td width="115" height="89" valign="top">
                                    <table cellpadding="0" cellspacing="0" width="105" align="center">
                                        <tr>
                                            <td width="105" height="26" align="left" class="clsTitleLabel">
                                                &nbsp;&nbsp;&nbsp;미리보기
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="361" height="89" valign="top">
                                    <table width="323" height="70" cellpadding="0" cellspacing="0" background="img/icon_textbox01.png">
                                        <tr>
                                            <td width="351" class="clsLabel">
                                                &nbsp;&nbsp;텍스트를 입력해주세요.
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="500" height="78" align="right" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="466">
                            <tr>
                                <td width="466" height="44" align="right">
                                    <table cellpadding="0" cellspacing="0" width="124" bgcolor="#33B5E5">
                                        <tr>
                                            <td width="124" height="30" align="center">
                                                <font face="돋움" color="white"><span style="font-size:10pt;"><b>적용하기</b></span></font>
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
</table>
</div>
<div id="dvText3D" class="clspopup">
<table cellpadding="0" cellspacing="0" width="522" style="background-color:White">
    <tr>
        <td width="520" height="210" style="border-width:1px; border-color:rgb(255,102,0); border-style:solid;">
            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="502">
                <tr>
                    <td width="500" height="38" style="border-width:1px; border-top-color:black; border-right-color:black; border-bottom-color:rgb(229,233,235); border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="475">
                            <tr>
                                <td width="384" height="31"><b><font face="돋움" color="#4C4C4C"><span style="font-size:12pt;">TEXT - 3D&nbsp;템플릿</span></font></b></td>
                                <td width="91" height="31" align="right">
                                    <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16" height="16" border="0" name="image1" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="500" height="98" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="469">
                            <tr>
                                <td width="469" height="88">
                                    <table cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                <input type="radio" name="formradio1" checked> 적용 안함
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                <input type="radio" name="formradio1"> 3D 데스크 메모
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="500" height="45" align="right" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="485">
                            <tr>
                                <td width="485" height="41" align="right">
                                    <table cellpadding="0" cellspacing="0" width="103" bgcolor="#33B5E5">
                                        <tr>
                                            <td width="103" height="30" align="center">
                                                <font face="돋움" color="white"><span style="font-size:10pt;"><b>적용하기</b></span></font>
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
</table>
</div>
<div id="dvBGM" class="clspopup">
<table cellpadding="0" cellspacing="0" width="522" style="background-color:White">
    <tr>
        <td width="520" height="300" style="border-width:1px; border-color:rgb(255,102,0); border-style:solid;">
            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="502">
                <tr>
                    <td width="500" height="38" style="border-width:1px; border-top-color:black; border-right-color:black; border-bottom-color:rgb(229,233,235); border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="475">
                            <tr>
                                <td width="384" height="31"><b><font face="돋움" color="#4C4C4C"><span style="font-size:12pt;">BGM&nbsp;편집</span></font></b></td>
                                <td width="91" height="31" align="right">
                                    <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16" height="16" border="0" name="image1" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="500" height="182" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="487">
                            <tr>
                                <td width="110" height="30" align="center" class="clsTitleLabel">
                                    업로드
                                </td>
                                <td width="377" height="61" align="center">
                                    <input type="file" name="formfile1" class="clsBrowser" size="35">
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
                                    <table cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                <input type="radio" name="formradio1" checked> 버튼 표시안함
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                <input type="radio" name="formradio1"> 기본 버튼
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                <input type="radio" name="formradio1"> 커스텀 버튼
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="500" height="44" align="right" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="485">
                            <tr>
                                <td width="485" height="41" align="right">
                                    <table cellpadding="0" cellspacing="0" width="103" bgcolor="#33B5E5">
                                        <tr>
                                            <td width="103" height="30" align="center">
                                                <font face="돋움" color="white"><span style="font-size:10pt;"><b>적용하기</b></span></font>
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
</table>
</div>
<div id="dvBGMCustom" class="clspopup">
<table cellpadding="0" cellspacing="0" width="522" style="background-color:White">
    <tr>
        <td width="520" height="625" style="border-width:1px; border-color:rgb(255,102,0); border-style:solid;">
            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="502">
                <tr>
                    <td width="500" height="38" style="border-width:1px; border-top-color:black; border-right-color:black; border-bottom-color:rgb(229,233,235); border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="475">
                            <tr>
                                <td width="384" height="60">
                                    <b><font face="돋움" color="#4C4C4C"><span style="font-size:12pt;">BGM</span></font></b><b><font face="돋움" color="#4C4C4C"><span style="font-size:12pt;">&nbsp;편집&nbsp;</span></font></b>
                                </td>
                                <td width="91" height="60" align="right">
                                    <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16" height="16" border="0" name="image1" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="500" height="86" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="476">
                            <tr>
                                <td width="115" height="78" align="center" class="clsTitleLabel">
                                    업로드
                                </td>
                                <td width="361" height="78" align="center">
                                    <input type="file" name="formfile1" class="clsBrowser" size="35">
                                </td>
                            </tr>
                            <tr>
                                <td width="115" height="123" valign="top">
                                    <table cellpadding="0" cellspacing="0" width="105" align="center">
                                        <tr>
                                            <td width="105" height="32" align="center" class="clsTitleLabel">
                                                버튼종류
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="361" height="123" valign="top">
                                    <table cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                <input type="radio" name="formradio1" checked> 버튼 표시안함
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                <input type="radio" name="formradio1"> 기본 버튼
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="367" height="32">
                                                <input type="radio" name="formradio1"> 커스텀 버튼
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td width="115" height="143" valign="top">
                                    <table cellpadding="0" cellspacing="0" width="105" align="center">
                                        <tr>
                                            <td width="105" height="46" align="center" class="clsTitleLabel">
                                                버튼모양
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="361" height="143" valign="top">
                                    <table cellpadding="0" cellspacing="0" width="359">
                                        <tr>
                                            <td width="180" height="47">
                                                <table cellpadding="0" cellspacing="0" width="169" align="center" style="border-collapse:collapse;" bgcolor="#F7F7F7">
                                                    <tr>
                                                        <td width="167" height="35" bgcolor="#F7F7F7" style="border-width:1px; border-color:rgb(193,193,193); border-style:solid;">                                                            
                                                            <table cellpadding="0" cellspacing="0" width="161">
                                                                <tr>
                                                                    <td width="35" height="27" align="right">
                                                                        <img src="img/cam_icon_setting.png" width="19" height="19" border="0">
                                                                    </td>
                                                                    <td width="126" height="27" align="center">
                                                                        <b><span style="font-size:10pt;"><font face="돋움" color="#8C959A">BGM</font></span></b>
</td>
                                                    </tr>
                                                </table></td>
                                                    </tr>
                                                </table></td>
                                            <td width="179" height="47">
                                                <table cellpadding="0" cellspacing="0" width="169" align="center" style="border-collapse:collapse;">
                                                    <tr>
                                                        <td width="167" height="35" bgcolor="#F7F7F7" style="border-width:1px; border-color:rgb(193,193,193); border-style:solid;">                                                            
                                                            <table cellpadding="0" cellspacing="0" width="161">
                                                                <tr>
                                                                    <td width="35" height="27" align="right">
                                                                        <img src="img/cam_icon_setting.png" width="19" height="19" border="0">
</td>
                                                                    <td width="126" height="27" align="center">
                                                                        <b><span style="font-size:10pt;"><font face="돋움" color="#8C959A">사운드</font></span></b>
</td>
                                                    </tr>
                                                </table></td>
                                                    </tr>
                                                </table></td>
                                        </tr>
                                    </table>
                                    <table cellpadding="0" cellspacing="0" width="359">
                                        <tr>
                                            <td width="180" height="60" align="center">
                                                <img src="img/icon_bgm01.png" width="50" height="42" border="0">
</td>
                                            <td width="179" height="60" align="center">
                                                <img src="img/icon_bgm02.png" width="33" height="42" border="0">
</td>
                                        </tr>
                                    </table>
</td>
                </tr>
                            <tr>
                                <td width="115" height="70" valign="top">                                                                        
                                    <table cellpadding="0" cellspacing="0" width="105" align="center">
                                        <tr>
                                            <td width="105" height="37" align="center" class="clsTitleLabel">
                                                색상
</td>
                                            </tr>
                                        </table></td>
                                <td width="361" height="70" valign="top">
                                    <table cellpadding="0" cellspacing="0" width="350">
                                        <tr>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
</td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
</td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center">
                                                    <tr>
                                                        <td width="25" height="25" bgcolor="black">&nbsp;</td>
                                                    </tr>
                                                </table>
</td>
                                            <td width="35" height="35" style="border-width:1px; border-color:rgb(7,157,236); border-style:solid;">
                                                <table cellpadding="0" cellspacing="0" align="center">
                                                    <tr>
                                                        <td width="25" height="25" bgcolor="#079DEC">&nbsp;</td>
                                                    </tr>
                                                </table>
</td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
</td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
</td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
</td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
</td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
</td>
                                            <td width="35" height="35">
                                                <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                    <tr>
                                                        <td width="25" height="25">&nbsp;</td>
                                                    </tr>
                                                </table>
</td>
                                        </tr>
                                    </table>
</td>
                </tr>
                            <tr>
                                <td width="115" height="63" valign="top">
                                    <table cellpadding="0" cellspacing="0" width="105" align="center">
                                        <tr>
                                            <td width="105" height="26" align="center" class="clsTitleLabel">
                                                미리보기
</td>
                                            </tr>
                                        </table></td>
                                <td width="361" height="63" valign="top">
                                    <table cellpadding="0" cellspacing="0" width="316">
                                        <tr>
                                            <td width="180" height="47" valign="top">
                                                <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" bgcolor="#F7F7F7" width="169">
                                                    <tr>
                                                        <td width="167" height="35" align="left" style="border-width:1px; border-color:rgb(187,187,187); border-style:solid;">
                                                            <table cellpadding="0" cellspacing="0" width="159">
                                                                <tr>
                                                                    <td width="35" height="27" align="right">
                                                                        <img src="img/cam_icon_setting.png" width="19" height="19" border="0">
                                                                    </td>
                                                                    <td width="124" height="27" align="center">
                                                                        <b><font face="돋움" color="#8C959A"><span style="font-size:10pt;">BGM</span></font></b>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="136" height="47">&nbsp;</td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="500" height="78" align="right" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                           <table cellpadding="0" cellspacing="0" align="center" width="466">
                                <tr>
                                    <td width="466" height="44" align="right">
                                        <table cellpadding="0" cellspacing="0" width="124" bgcolor="#33B5E5">
                                            <tr>
                                                <td width="124" height="30" align="center">
                                                    <font face="돋움" color="white"><span style="font-size:10pt;"><b>적용하기</b></span></font>
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
    </table>
</div>
<div id="dvBGM3D" class="clspopup">
<table cellpadding="0" cellspacing="0" width="522" style="background-color:White">
    <tr>
        <td width="520" height="232" style="border-width:1px; border-color:rgb(255,102,0); border-style:solid;">
            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="502">
                <tr>
                    <td width="500" height="38" style="border-width:1px; border-top-color:black; border-right-color:black; border-bottom-color:rgb(229,233,235); border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="475">
                            <tr>
                                <td width="384" height="31"><b><font face="돋움" color="#4C4C4C"><span style="font-size:12pt;">BGM&nbsp;편집 </span></font></b></td>
                                <td width="91" height="31" align="right">
                                    <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16" height="16" border="0" name="image1" />
</td>
                </tr>
            </table></td>
                </tr>
                <tr>
                    <td width="500" height="98" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="469">
                            <tr>
                                <td width="469" height="111">
                                    <table cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                <input type="radio" name="formradio1" checked> 적용 안함
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                <input type="radio" name="formradio1"> 3D 사운드 플레이어 형
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                <input type="radio" name="formradio1"> 3D 클래식 사운드 플레이어 형
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="500" height="54" align="right" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                            <table cellpadding="0" cellspacing="0" align="center" width="485">
                                <tr>
                                    <td width="485" height="41" align="right">
                                        <table cellpadding="0" cellspacing="0" width="103" bgcolor="#33B5E5">
                                            <tr>
                                                <td width="103" height="30" align="center">
                                                    <font face="돋움" color="white"><span style="font-size:10pt;"><b>적용하기</b></span></font>
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
</table>
</div>
<div id="dvSlide" class="clspopup">
<table cellpadding="0" cellspacing="0" width="522" style="background-color:White">
    <tr>
        <td width="520" height="635" style="border-width:1px; border-color:rgb(255,102,0); border-style:solid;">
            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="502">
                <tr>
                    <td width="500" height="96" style="border-width:1px; border-top-color:black; border-right-color:black; border-bottom-color:rgb(229,233,235); border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="475">
                            <tr>
                                <td width="384" height="31"><b><font face="돋움" color="#4C4C4C"><span style="font-size:12pt;">이미지슬라이드&nbsp;편집</span></font></b></td>
                                <td width="91" height="31" align="right">
                                    <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16" height="16" border="0" name="image1" />
</td>
                </tr>
            </table>
                        <table cellpadding="0" cellspacing="0" align="center" width="475">
                            <tr>
                                <td width="384" height="43" class="clsLabel">+버튼으로 표시될 이미지를 선택해주세요.(최대 10매)<br>이미지의 사이지가 같으면 더욱 효과적입니다.</td>
                                <td width="91" height="43" align="right">&nbsp;</td>
                </tr>
            </table></td>
                </tr>
                <tr>
                    <td width="500" height="264" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
<table cellpadding="0" cellspacing="0" bordercolordark="black" bordercolorlight="black" align="center" width="475">
                            <tr>
                                <td width="95" height="100">
                                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;">
                                        <tr>
                                            <td width="85" height="69" style="border-width:1px; border-top-color:rgb(153,153,153); border-right-color:rgb(153,153,153); border-bottom-color:black; border-left-color:rgb(153,153,153); border-top-style:solid; border-right-style:solid; border-bottom-style:none; border-left-style:solid;" align="center">
                                                <img src="img/imgslide_img01.png" width="80" height="57" border="0">
</td>
                                        </tr>
                                        <tr>
                                            <td width="85" height="24" style="border-width:1px; border-top-color:black; border-right-color:rgb(153,153,153); border-bottom-color:rgb(153,153,153); border-left-color:rgb(153,153,153); border-top-style:none; border-right-style:solid; border-bottom-style:solid; border-left-style:solid;" bgcolor="#CCCCCC" align="center">
                                                <a href="#" OnMouseOut="na_restore_img_src('image3', 'document')" OnMouseOver="na_change_img_src('image3', 'document', 'img/cam_icon_trash_r.png', true);"><img src="img/cam_icon_trash.png" width="18" height="21" border="0" name="image3"></a>
</td>
                                        </tr>
                                    </table>
</td>
                                <td width="95" height="100">
                                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;">
                                        <tr>
                                            <td width="85" height="93" style="border-width:1px; border-color:rgb(153,153,153); border-style:solid;" align="center">
                                                <span style="font-size:24pt;"><font color="#999999">+</font></span>
</td>
                                        </tr>
                                    </table>
</td>
                                <td width="95" height="100">
                                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;">
                                        <tr>
                                            <td width="85" height="93" style="border-width:1px; border-color:rgb(153,153,153); border-style:solid;" align="center">
                                                &nbsp;
</td>
                                        </tr>
                                    </table>
</td>
                                <td width="95" height="100">
                                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;">
                                        <tr>
                                            <td width="85" height="93" style="border-width:1px; border-color:rgb(153,153,153); border-style:solid;" align="center">
                                                &nbsp;
</td>
                                        </tr>
                                    </table>
</td>
                                <td width="95" height="100">
                                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;">
                                        <tr>
                                            <td width="85" height="93" style="border-width:1px; border-color:rgb(153,153,153); border-style:solid;" align="center">
                                                &nbsp;
</td>
                                        </tr>
                                    </table>
</td>
                            </tr>
                            <tr>
                                <td width="95" height="100">
                                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;">
                                        <tr>
                                            <td width="85" height="93" style="border-width:1px; border-color:rgb(153,153,153); border-style:solid;" align="center">
                                                &nbsp;
</td>
                                        </tr>
                                    </table>
</td>
                                <td width="95" height="100">
                                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;">
                                        <tr>
                                            <td width="85" height="93" style="border-width:1px; border-color:rgb(153,153,153); border-style:solid;" align="center">
                                                &nbsp;
</td>
                                        </tr>
                                    </table>
</td>
                                <td width="95" height="100">
                                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;">
                                        <tr>
                                            <td width="85" height="93" style="border-width:1px; border-color:rgb(153,153,153); border-style:solid;" align="center">
                                                &nbsp;
</td>
                                        </tr>
                                    </table>
</td>
                                <td width="95" height="100">
                                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;">
                                        <tr>
                                            <td width="85" height="93" style="border-width:1px; border-color:rgb(153,153,153); border-style:solid;" align="center">
                                                &nbsp;
</td>
                                        </tr>
                                    </table>
</td>
                                <td width="95" height="100">
                                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;">
                                        <tr>
                                            <td width="85" height="93" style="border-width:1px; border-color:rgb(153,153,153); border-style:solid;" align="center">
                                                &nbsp;
</td>
                                        </tr>
                                    </table>
</td>
                            </tr>
                        </table>
                        <table cellpadding="0" cellspacing="0" align="center" width="475">
                            <tr>
                                <td width="384" height="25">&nbsp;</td>
                                <td width="91" height="25" align="right">
                                    &nbsp;
</td>
                </tr>
            </table>                        <table cellpadding="0" cellspacing="0" align="center" width="476">
                            <tr>
                                <td width="115" height="61" valign="top">
                                    <table cellpadding="0" cellspacing="0" width="105" align="center">
                                        <tr>
                                            <td width="105" height="38" align="left" class="clsTitleLabel">
                                                이미지<br> 전환 연출
</td>
                                            </tr>
                                        </table></td>
                                <td width="361" height="123" valign="top">
                                    <table cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                    <input type="radio" name="formradio1" checked> 없음
</td>
                                            </tr>
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                    <input type="radio" name="formradio1"> 페이드&nbsp;인/아웃
</td>
                                            </tr>
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                    <input type="radio" name="formradio1"> 슬라이드
</td>
                                            </tr>
                                        </table>
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
                                        </table></td>
                                <td width="361" height="88" valign="top">
                                    <table cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                    <input type="radio" name="formradio1" checked> 이미지가 3초간격으로 자동으로 전환됩니다.
</td>
                                            </tr>
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                    <input type="radio" name="formradio1"> 이미지가 터치 시 전환됩니다.
</td>
                                            </tr>
                                        </table></td>
                </tr>
            </table></td>
                </tr>
                <tr>
                    <td width="500" height="79" align="right" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="485">
                            <tr>
                                <td width="485" height="41" align="right">
                                    <table cellpadding="0" cellspacing="0" width="103" bgcolor="#33B5E5">
                                        <tr>
                                            <td width="103" height="30" align="center">
                                                <font face="돋움" color="white"><span style="font-size:10pt;"><b>적용하기</b></span></font>
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
</table>
</div>
<div id="dvSlide3D" class="clspopup">
<table cellpadding="0" cellspacing="0" width="522" style="background-color:White">
    <tr>
        <td width="520" height="208" style="border-width:1px; border-color:rgb(255,102,0); border-style:solid;">
            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="502">
                <tr>
                    <td width="500" height="38" style="border-width:1px; border-top-color:black; border-right-color:black; border-bottom-color:rgb(229,233,235); border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="475">
                            <tr>
                                <td width="384" height="31"><b><font face="돋움" color="#4C4C4C"><span style="font-size:12pt;">이미지&nbsp;-&nbsp;3D템플릿 </span></font></b></td>
                                <td width="91" height="31" align="right">
                                    <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16" height="16" border="0" name="image1" />
</td>
                </tr>
            </table></td>
                </tr>
                <tr>
                    <td width="500" height="98" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="469">
                            <tr>
                                <td width="469" height="87">
                                    <table cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                    <input type="radio" name="formradio1" checked> 적용 안함
</td>
                                            </tr>
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                    <input type="radio" name="formradio1"> 3D 스탠드 액자형
</td>
                                            </tr>
                                        </table></td>
                </tr>
            </table></td>
                </tr>
                <tr>
                    <td width="500" height="54" align="right" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="485">
                            <tr>
                                <td width="485" height="41" align="right">
                                    <table cellpadding="0" cellspacing="0" width="103" bgcolor="#33B5E5">
                                        <tr>
                                            <td width="103" height="30" align="center">
                                                <font face="돋움" color="white"><span style="font-size:10pt;"><b>적용하기</b></span></font>
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
</table>
</div>
<div id="dvCapture" class="clspopup">
</div>
<div id="dvChromeKey" class="clspopup">
<table cellpadding="0" cellspacing="0" width="522" style="background-color:White">
    <tr>
        <td width="520" height="363" style="border-width:1px; border-color:rgb(255,102,0); border-style:solid;">
            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="502">
                <tr>
                    <td width="500" height="38" style="border-width:1px; border-top-color:black; border-right-color:black; border-bottom-color:rgb(229,233,235); border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="475">
                            <tr>
                                <td width="384" height="31"><b><font face="돋움" color="#4C4C4C"><span style="font-size:12pt;">크로마키&nbsp;비디오&nbsp;편집</span></font></b></td>
                                <td width="91" height="31" align="right">
                                    <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16" height="16" border="0" name="image1" />
</td>
                </tr>
            </table></td>
                </tr>
                <tr>
                    <td width="500" height="161" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="487">
                            <tr>
                                <td width="110" height="65" align="center" class="clsTitleLabel">
                                    업로드
</td>
                                <td width="377" height="65" align="center">
                                        <input type="file" name="formfile1" class="clsBrowser" size="35">
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
                                        </table></td>
                                <td width="377" height="89" valign="top">
                                    <table cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                    <input type="radio" name="formradio1"> 동영상이 자동으로 재생됩니다.
</td>
                                            </tr>
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                    <input type="radio" name="formradio1" checked> 동영상이 수동으로 재생됩니다.
</td>
                                            </tr>
                                        </table></td>
                </tr>
                            <tr>
                                <td width="110" height="88" valign="top">                                    
                                    <table cellpadding="0" cellspacing="0" width="105" align="center">
                                        <tr>
                                            <td width="105" height="34" align="center" class="clsTitleLabel">
                                                재생방향
</td>
                                            </tr>
                                        </table></td>
                                <td width="377" height="88" valign="top">
                                    <table cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                    <input type="radio" name="formradio1"> 마커와 평행
</td>
                                            </tr>
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                    <input type="radio" name="formradio1" checked> 마커와 90도
</td>
                                            </tr>
                                        </table></td>
                </tr>
            </table></td>
                </tr>
                <tr>
                    <td width="500" height="55" align="right" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="485">
                            <tr>
                                <td width="485" height="41" align="right">
                                    <table cellpadding="0" cellspacing="0" width="103" bgcolor="#33B5E5">
                                        <tr>
                                            <td width="103" height="30" align="center">
                                                <font face="돋움" color="white"><span style="font-size:10pt;"><b>적용하기</b></span></font>
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
</table>
</div>
<div id="dv3DObj" class="clspopup">
<table cellpadding="0" cellspacing="0" width="522" style="background-color:White">
    <tr>
        <td width="520" height="559" style="border-width:1px; border-color:rgb(255,102,0); border-style:solid;">
            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="502">
                <tr>
                    <td width="500" height="38" style="border-width:1px; border-top-color:black; border-right-color:black; border-bottom-color:rgb(229,233,235); border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="475">
                            <tr>
                                <td width="384" height="48"><b><font face="돋움" color="#4C4C4C"><span style="font-size:12pt;">3D 오브젝트&nbsp;편집</span></font></b></td>
                                <td width="91" height="48" align="right">
                                    <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16" height="16" border="0" name="image1" />
</td>
                </tr>
            </table></td>
                </tr>
                <tr>
                    <td width="500" height="161" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="487">
                            <tr>
                                <td width="110" height="65" align="center" class="clsTitleLabel">
                                    업로드
</td>
                                <td width="377" height="65" align="center">
                                    <input type="file" name="formfile1" class="clsBrowser" size="31">
</td>
                </tr>
                            <tr>
                                <td width="110" height="65" align="center" class="clsTitleLabel">
                                    자동재생
</td>
                                <td width="377" height="65" align="center">
                                    <input type="file" name="formfile1" class="clsBrowser" size="31">
</td>
                </tr>
                            <tr>
                                <td width="110" height="65" align="center" class="clsTitleLabel">
                                    객체 정면방향
</td>
                                <td width="377" height="65">
                                    <table cellpadding="0" cellspacing="0" width="366">
                                        <tr>
                                            <td width="223" height="39" align="center">
                                                <input type="text" name="formtext1" size="28">
</td>
                                            <td width="143" height="39" class="clsLabel">
                                                도<font color="#727272">(1~360)</font>
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
                                            <td width="45" height="24" align="right" class="clsLabel">
                                                어두움
</td>
                                            <td width="279" height="24" background="img/3D_scrollbar.png">
                                                <table cellpadding="0" cellspacing="0" width="24" align="center">
                                                    <tr>
                                                        <td width="24" align="center">
                                                            <img src="img/3D_scrollbarhandle.png" width="24" height="25" border="0">
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
                                <td width="110" height="60" align="center" class="clsTitleLabel>
                                    실행횟수
</td>
                                <td width="377" height="60">
                                    <table cellpadding="0" cellspacing="0" width="366">
                                        <tr>
                                            <td width="223" height="39" align="center">
                                                    <input type="text" name="formtext1" size="28">
</td>
                                            <td width="143" height="39" class="clsLabel">
                                                회<font color="#727272">(0의 경우 무제한)</font>
</td>
                                        </tr>
                                    </table></td>
                </tr>
                            <tr>
                                <td width="110" height="113" valign="top">                                    
                                    <table cellpadding="0" cellspacing="0" width="105" align="center">
                                        <tr>
                                            <td width="105" height="34" align="center" class="clsTitleLabel">
                                                재생방향
</td>
                                            </tr>
                                        </table></td>
                                <td width="377" height="113" valign="top">
                                    <table cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="367" height="32" class="clsLabel">
                                                <input type="radio" name="formradio1"> 일반형
</td>
                                            </tr>
                                        <tr>
                                            <td width="367" height="29" class="clsLabel">
                                                <input type="radio" name="formradio1" checked> 상하형
</td>
                                            </tr>
                                        <tr>
                                            <td width="367" height="29" class="clsLabel">
                                                    <input type="radio" name="formradio1" checked> 페이드인&nbsp;형
</td>
                                            </tr>
                                        </table></td>
                </tr>
            </table></td>
                </tr>
                <tr>
                    <td width="500" height="55" align="right" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                        <table cellpadding="0" cellspacing="0" align="center" width="485">
                            <tr>
                                <td width="485" height="41" align="right">
                                    <table cellpadding="0" cellspacing="0" width="103" bgcolor="#33B5E5">
                                        <tr>
                                            <td width="103" height="30" align="center">
                                                <font face="돋움" color="white"><span style="font-size:10pt;"><b>편집적용</b></span></font>
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
</table>
</div>
</asp:Content>
