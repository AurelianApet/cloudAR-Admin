<%@ Page Title="" Language="C#" MasterPageFile="~/Account/UserPage.Master" AutoEventWireup="true" CodeBehind="EditContent1.aspx.cs" Inherits="nocutAR.Account.EditContent1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="/Scripts/detail_opt.js" type="text/javascript"></script>
    <script src="/Scripts/save_obj.js" type="text/javascript"></script>
    <script src="/Scripts/jquery-ui.js" type="text/javascript"></script>
    <script src="/scripts/jquery-1.11.2.js" type="text/javascript"></script>
    
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
    <script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
<asp:Literal ID="ltlScript" runat="server" Text=""></asp:Literal>
<script type="text/javascript" language="javascript">

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

    var addIndex=0;
    var prevIndex=0;
    var capCount = 0;
    var capprevIndex = 0;

    $(document).ready(function () {
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
                var iCapture_obj = data.capture_obj;
                var iThree_model_obj = data.three_model_obj;
                var iTel_obj = data.tel_obj;
                var iGooglemap_obj = data.googlemap_obj;
                var iNotepad_obj = data.notepad_obj;
                var iBgm_obj = data.bgm_obj;
                var iChromakey = data.chromakey_obj;
                var iThreeTemplate = data.three_template;

                if (iVideo_obj == 1)
                    $("#imgEditMenu1").css("display", "block");
                if (iWeb_obj == 1)
                    $("#imgEditMenu2").css("display", "block");
                if (iImage_obj == 1)
                    $("#imgEditMenu3").css("display", "block");
                if (iCapture_obj == 1)
                    $("#imgEditMenu4").css("display", "block");
                if (iThree_model_obj == 1)
                    $("#imgEditMenu5").css("display", "block");
                if (iTel_obj == 1)
                    $("#imgEditMenu6").css("display", "block");
                if (iGooglemap_obj == 1)
                    $("#imgEditMenu7").css("display", "block");
                if (iNotepad_obj == 1)
                    $("#imgEditMenu8").css("display", "block");
                if (iBgm_obj == 1)
                    $("#imgEditMenu9").css("display", "block");
                if (iChromakey == 1)
                    $("#imgEditMenu10").css("display", "block");
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
        $(".clsImagechange").mouseover(function () {
            if ($(this).hasClass("btn-over")) return;
            //$(this).children("img").attr("src")
            $(this).children("img").attr("src", $(this).children("img").attr("src").replace(".gif", "_r.gif").replace("0.png", "1.png").replace(".jpg", "_r.jpg"));
        });
        $(".clsImagechange").mouseout(function () {
            if ($(this).hasClass("btn-over")) return;
            $(this).children("img").attr("src", $(this).children("img").attr("src").replace("_r.gif", ".gif").replace("1.png", "0.png").replace("_r.jpg", ".jpg"));
        });

        $("#btnRegMarker").unbind("click").bind("click", function () {
            $("#fileImg").click();
        });
        //마크이미지를 업로드하는 함수
        $('#fileImg').bind("change", function () {
            var file = this.files[0];
            if (file) {
                /*확장자체크*/
                var imgExtension = ($("#fileImg").val().substr($("#fileImg").val().length - 3)).toLowerCase();
                if (imgExtension != 'jpg' && imgExtension != 'png') {
                    alert("파일형식이 바르지 않습니다.");
                    return;
                }
                /***확장자체크***/

                var file = document.getElementById("fileImg");
                if (file.files[0] != null) {
                    /*용량제한*/
                    if ((file.files[0].size / 1053317.6) > 5) {
                        alert("5MB 이상의 이미지는 등록하실수 없습니다.");
                        return;
                    }
                    /***용량제한***/

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
                                $(".markdiv").css("display", "block");
                                $(".req_cover").css("display", "none");
                                document.getElementById("markImg").src = data;
                                OnSave();
                                init_mark();
                            }, 3000);

                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            HideProgress();
                            alert("마커이미지 등록과정에 오류가 발생하였습니다.");
                        }
                    });
                }
            } else {

            }
        });

        init_mark();
        init_objects();
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
                        objsize: objsize };

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

                        threeList[i] = { url1: url1, url2: url2, front_angle: front_angle, brightness: brightness,  run_times: run_times, type: type, objsize: objsize };
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
                    $(".markdiv").css("display", "block");
                    $(".req_cover").css("display", "none");
                    document.getElementById("markImg").src = "/markers/" + marker_url;
                    setTimeout(function () {
                        $(".markdiv").css({ "width": document.getElementById("markImg").width });
                    }, 500);

                }
                else {
                    $(".markdiv").css("display", "none");
                    $(".req_cover").css("display", "block");
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                HideProgress();
                alert("마커이미지를 불러오는동안 오류가 발생하였습니다.");
            }
        });
    }
    function showPanel(objectid) {
        $(".dragged_object .panel").css("display", "none");
        $("#" + objectid + " .panel").css("display", "block");
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

    function OnBack() {
        document.location = "ProjectList.aspx";
    }


    $(function () {

        dropflag = 0;
        $(".clsImagechange").draggable({
            containment: ".page",
            helper: "clone",
            revert: "invalid",
            start: function (ui) { // 드래그 시작했을 때 한 번 호출
                //$(this).addClass("dragging");
                dropflag = 0;
                if (ui.currentTarget.id == "imgEditMenu1") {
                    select_option(0);
                }
                else if (ui.currentTarget.id == "imgEditMenu2") {
                    select_option(1);
                }
                else if (ui.currentTarget.id == "imgEditMenu3") {
                    select_option(2);
                }
                else if (ui.currentTarget.id == "imgEditMenu4") {
                    select_option(3);
                }
                else if (ui.currentTarget.id == "imgEditMenu5") {
                    select_option(4);
                }
                else if (ui.currentTarget.id == "imgEditMenu6") {
                    select_option(5);
                }
                else if (ui.currentTarget.id == "imgEditMenu7") {
                    select_option(6);
                }
                else if (ui.currentTarget.id == "imgEditMenu8") {
                    select_option(7);
                }
                else if (ui.currentTarget.id == "imgEditMenu9") {
                    select_option(8);
                }
                else if (ui.currentTarget.id == "imgEditMenu10") {
                    select_option(9);
                }
                disable_applybtn();

            },
            stop: function (ev, ui) { // 드래그 끝났을 때 한 번 호출
                //$(this).removeClass("dragging");
                if (dropflag != 1)
                    return;
                var pos = $(ui.helper).position();
                //objName = "#clonediv" + counter

                $(objName).css({ "left": ui.position.left - $("#editframe").offset().left, "top": ui.position.top - $("#editframe").offset().top });
                $(objName).removeClass("clsImagechange").addClass("dragged_object");   //클론되지 않게 해주는 코드이다.

                $(objName).draggable({
                    containment: "parent"
                });
                //패널사건추가
                add_DoubleClickEvent();
            }

        });
        $(".markdiv").droppable({
            accept: ".clsImagechange",
            activeClass: "ui-state-default",
            hoverClass: "ui-state-hover",
            drop: function (event, ui) {						// event : drop, , ui.draggable : 지금 .drop-box 에 drop된 .drag-box를 가리킨다
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
                //$(".tempclass").attr("id", "clonediv" + counter);
                //$("#clonediv" + counter).removeClass("tempclass").addClass("dragged_object");

                //$(this).append($(ui.draggable).clone());

                //$(this).removeClass("over").addClass("drop");

                //ui.draggable.clone().addClass("drop"); // drop된 .drag-box에 클래스 지정
            }
        });

        capprevdrop();

    });

</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderSearch" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="padding-left:25px; padding-right:25px;">
        <div style="background-color:#fff; height:80px;" >
            <div style="float:left; margin-top:25px ">
                <div class="clsImagechange"id="imgEditMenu1">
                    <img src="img/video_0.png" alt="" border="0" width="100%"/>
                    <div class='panel'>
                    <a class='delete-btn'>Delete</a>
                    <a class='edit-btn'>Edit</a>
                    </div>
                </div>
                <div class="clsImagechange"id="imgEditMenu2" >
                    <img src="img/web_0.png" alt="" border="0" width="100%"/>
                    <div class='panel'>
                    <a class='delete-btn'>Delete</a>
                    <a class='edit-btn'>Edit</a>
                    </div>
                </div>
                <div class="clsImagechange"id="imgEditMenu3" >
                    <img src="img/image_0.png" alt="" border="0" width="100%"/>
                    <div class='panel'>
                    <a class='delete-btn'>Delete</a>
                    <a class='edit-btn'>Edit</a>
                    </div>
                </div>
                <div class="clsImagechange"id="imgEditMenu4" >
                    <img src="img/capture_0.png" alt="" border="0" width="100%"/>
                    <div class='panel'>
                    <a class='delete-btn'>Delete</a>
                    <a class='edit-btn'>Edit</a>
                    </div>
                </div>
                <div class="clsImagechange"id="imgEditMenu5" >
                    <img src="img/3dmodel_0.png" alt="" border="0" width="100%"/>
                    <div class='panel'>
                    <a class='delete-btn'>Delete</a>
                    <a class='edit-btn'>Edit</a>
                    </div>
                </div>
                <div class="clsImagechange"id="imgEditMenu6" >
                    <img src="img/tel_0.png" alt="" border="0" width="100%"/>
                    <div class='panel'>
                    <a class='delete-btn'>Delete</a>
                    <a class='edit-btn'>Edit</a>
                    </div>
                </div>
                <div class="clsImagechange"id="imgEditMenu7" >
                    <img src="img/google_0.png" alt="" border="0" width="100%" />
                    <div class='panel'>
                    <a class='delete-btn'>Delete</a>
                    <a class='edit-btn'>Edit</a>
                    </div>
                </div>
                <div class="clsImagechange"id="imgEditMenu8" >
                    <img src="img/notepad_0.png" alt="" border="0" width="100%"/>
                    <div class='panel'>
                    <a class='delete-btn'>Delete</a>
                    <a class='edit-btn'>Edit</a>
                    </div>
                </div>
                <div class="clsImagechange"id="imgEditMenu9" >
                    <img src="img/sound_0.png" alt="" border="0" width="100%"/>
                    <div class='panel'>
                    <a class='delete-btn'>Delete</a>
                    <a class='edit-btn'>Edit</a>
                    </div>
                </div>
                <div class="clsImagechange"id="imgEditMenu10" >
                    <img src="img/chromakey_0.png" alt="" border="0" width="100%"/>
                    <div class='panel'>
                    <a class='delete-btn'>Delete</a>
                    <a class='edit-btn'>Edit</a>
                    </div>
                </div>
            </div>
            <div style="float:right; margin-top:20px">
                <input id="btnSave" type="button" value="저장" onclick="OnSave()" style="height:47px; width:85px; font-family:맑은 고딕; font-size:13pt; color:#D64F26; font-weight:bold" />
                            &nbsp;&nbsp;&nbsp;&nbsp;
                <input id="btnBack" type="button" value="나가기" onclick="OnBack()" style="height:47px; width:85px; font-family:맑은 고딕; font-size:13pt; color:#D64F26; font-weight:bold" />
            </div>
        </div>
        <hr style="height:1px" />
        <div>
            <div id="detail_opt" style="float:left; ">
                <div class=".mask" ></div>
                <div style="width:260px; height:62px; font-family:맑은 고딕; font-size:13pt; border-bottom:1px solid"><br />세부옵션</div>
                <br />
                <div id="video_opt" style="float:left; width:260px; display:block;"  >
                    <div >
                        <input id="video_file" type="file" name="video_path" accept="video/mp4" style="position:absolute; height:46px; width:260px;display:none;" onchange="document.getElementById('video_path').value=this.value"/>
                        <input type="text" name="video_path" id="video_path" value="비디오파일" style="width: 61%; height: 41px; " />
                        <input type="button" id="btnVideoBrowse" value="찾아보기" onclick="OnAddVideo()" style="width: 35%; height: 46px; "/>
                    </div>
                    <br />
                    <div class="optdiv">
                        VIEW 옵션
                        <hr />
                        <Label style="line-height:25px;"><input id="video_rd1" type="radio" name="video_rd" value="0" checked />일반형</Label><br />
                        <Label id="template1" style="line-height:25px;"><input id="video_rd2" type="radio" name="video_rd" value="1" />3D클래식 TV형</Label><br />
                        <Label id="template2" style="line-height:25px;"><input id="video_rd3" type="radio" name="video_rd" value="1" />3D와이드 평면TV형</Label><br />
                    </div>
                    <br/>
                    <div class="optdiv">
                        실행옵션
                        <hr />
                        <label style="line-height:25px;"><input id="videorun_rd1" type="radio" name="videorun_rd" title="자동실행" value="0" checked />자동실행</label> <br/>
                        <label style="line-height:25px;"><input id="videorun_rd2" type="radio" name="videorun_rd" title="터치시 실행" value="1" />터치시 실행</label>
                    </div>
                    <br />
                    <div>
                        <input id="btnVideoApply" type="button" value="적용하기" onclick="OnVideoApply()" style="height:50px; width:260px; font-family:맑은 고딕; font-size:13pt; color:#D64F26; font-weight:bold" />
                    </div>
                </div>
                <div id="web_opt" style="float:left; width:260px; display:none;">
                    <div style="height:48px; border:solid 1px #000; margin-bottom:10px;">
                        <input type="text" id="web_url" name="web_url" maxlength="100" style=" width:98%; height:44px; padding:2px; border:none" />
                    </div>
                    <div class="optdiv">
                        버튼 이미지 옵션
                        <hr />
                        <asp:RadioButtonList CssClass="rdbWeb1" runat="server" BackColor="#FBFBFB">
                            <asp:ListItem Value="0" Selected>기본형</asp:ListItem>
                            <asp:ListItem Value="1">제작형</asp:ListItem>
                        </asp:RadioButtonList>
                        <input id="webbtn_path" type="file" name="webbtn_path" accept="image/png"  style="position:absolute; height:46px; width:260px;display:none;" onchange="document.getElementById('webbtn_path_text').value=this.value"/>
                        <input type="text" name="webbtn_path_text" id="webbtn_path_text" value="이미지파일" style="width: 61%; height: 41px; " readonly="readonly" />
                        <input type="button" id="btnWebbtnBrowse" value="찾아보기" onclick="OnAddWebbtnImage()" style="width: 35%; height: 46px; "/>
                    </div>
                    <br/>
                    <div class="optdiv">
                        VIEW 옵션
                        <hr />
                        <asp:RadioButtonList CssClass="rdbWeb2" runat="server" BackColor="#FBFBFB">
                            <asp:ListItem Value="0" Selected>링크형</asp:ListItem>
                            <asp:ListItem Value="1">자체브라우저형</asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                    <div style="padding-top:20px;">
                        <input id="btnWebApply" disabled type="button" value="적용하기" onclick="OnWebApply()" style="height:50px; width:260px; font-family:맑은 고딕; font-size:13pt; color:#D64F26; font-weight:bold" />
                    </div>
                </div>
                <div id="tel_opt" style="float:left; width:260px; display:none;">
                    <div style="height:48px; border:solid 1px #000; margin-bottom:10px;">
                        <input type="text" onkeypress="num_only()" id="tel_no" name="tel_no" maxlength="20" style="width:90%; height:40px; padding:2px; border-style:none;ime-mode:disabled" />
                    </div>
                    <div class="optdiv">
                        VIEW 옵션
                        <hr />
                            <Label ><input id="rdTel1" type="radio" name="rdTel" title="2D이미지형기본형" value="twoD" checked />2D 이미지형</Label> <br/>
                                <Label style="padding-left:20px"><input id="rdCommon" type="radio" name="twoD" title="기본형" value="common" checked />기본형</Label> <br/>
                                <Label style="padding-left:20px"><input id="rdCustom" type="radio" name="twoD" title="제작형" value="custom" />제작형</Label><br />
                                <input id="telbtn_path" type="file" name="telbtn_path" accept="image/jpeg, image/png" style="position:absolute; height:46px; width:260px;display:none;" disabled onchange="document.getElementById('telbtn_path_text').value=this.value"/>
                                <input type="text" name="telbtn_path_text" id="telbtn_path_text" value="이미지파일" style="width: 61%; height: 41px; " readonly="readonly" />
                                <input type="button" id="btnTelbtnBrowse" value="찾아보기" onclick="OnAddTelbtn()" style="width: 35%; height: 46px; "/>
                            <Label id="template3"><input id="rdTel2" type="radio" name="rdTel" title="3D 모델형" value="threeD" />3D 모델형</Label> <br/>

                    </div>
                    <br/>
                    <div style="padding-top:20px;">
                        <input id="btnTelApply" disabled type="button" value="적용하기" onclick="OnTelApply()" style="height:50px; width:260px; font-family:맑은 고딕; font-size:13pt; color:#D64F26; font-weight:bold" />
                    </div>
                </div>

                <div id="capture_opt" style="float:left; width:260px; display:none;">
                    <div >
                        <input id="capture_file" type="file" name="capture_file" accept="image/png" style="position:absolute; height:46px; width:260px;display:none;" onchange="document.getElementById('imgPath').value=this.value"/>
                        <input type="text" name="capimgPath" id="capimgPath" value="이미지파일" style="width: 61%; height: 41px; " readonly="readonly"/>
                        <input type="button" id="btnCapBrowse" value="찾아보기" onclick="OnAddCapPrevImg()" style="width: 35%; height: 46px; "/>
                    </div>
                    <br />
                    <div class="optdiv" style="height:115px; overflow-x:scroll; overflow-y:hidden;" >
                        <div id="capcontainer_div" style="width:400px">
                        </div>
                    </div>
                    <span >여러장 등록할 경우, 같은 사이즈의 이미지를 등록하시면 더욱 효과적입니다.</span>
                    <div id="capture_detail_div" style="position:relative; height:115px; z-index:1" >
                    </div>

                    <div class="optdiv">
                        버튼 이미지 옵션
                        <hr />
                        <asp:RadioButtonList CssClass="rdbCapture" runat="server" BackColor="#FBFBFB">
                            <asp:ListItem Value="0" Selected>기본형</asp:ListItem>
                            <asp:ListItem Value="1">제작형</asp:ListItem>
                        </asp:RadioButtonList>

                        <input id="capturebtn_path" type="file" name="capturebtn_path" accept="image/jpeg, image/png" style="position:absolute; height:46px; width:260px;display:none;" onchange="document.getElementById('capturebtn_path_text').value=this.value"/>
                        <input type="text" name="capturebtn_path_text" id="capturebtn_path_text" value="이미지파일" style="width: 61%; height: 41px; " readonly="readonly" />
                        <input type="button" id="btnCaptureBrowse" value="찾아보기" onclick="OnAddCaptureBtn()" style="width: 35%; height: 46px; "/>
                    </div>
                    <br/>
                    <div style="padding-top:20px;">
                        <input id="btnCaptureApply" disabled="disabled" type="button" value="적용하기" onclick="OnCaptureApply()" style="height:50px; width:260px; font-family:맑은 고딕; font-size:13pt; color:#D64F26; font-weight:bold" />
                    </div>
                </div>
                <div id="three_opt" style="float:left; width:260px; display:none;">
                    <div >
                        <input id="three_file1" type="file" name="three_file1" accept="application/unity3d" style="position:absolute; height:46px; width:260px;display:none;" onchange="document.getElementById('three_file1_path').value=this.value"/>
                        <input type="text" name="three_file1" id="three_file1_path" value="unity3d파일" style="width: 61%; height: 41px; " readonly="readonly"/>
                        <input type="button" id="Button3" value="찾아보기" onclick="OnAddThree1()" style="width: 35%; height: 46px; "/>
                    </div>
                    <br />
                    <div >
                        <input id="three_file2" type="file" name="three_file2" accept="application/assetbundle" style="position:absolute; height:46px; width:260px;display:none;" onchange="document.getElementById('three_file2_path').value=this.value"/>
                        <input type="text" name="three_file1" id="three_file2_path" value="assetbundle파일" style="width: 61%; height: 41px; " readonly="readonly"/>
                        <input type="button" id="Button4" value="찾아보기" onclick="OnAddThree2()" style="width: 35%; height: 46px; "/>
                    </div>
                    <br />
                    <div style="height:48px; border:solid 1px #000; margin-bottom:10px;">
                        <input type="text" id="front_angle" name="front_angle" onkeypress="num_only()" size="38" style="width:220px; height:44px; padding:2px; border-style:none; float:left" />
                        <p style="float:left">도</p>
                    </div>
                    <br />
                    <div style="height:48px; border:solid 1px #000; margin-bottom:10px;">
                        <input type="text" id="brightness" name="brightness" onkeypress="num_only()" size="38" style="width:98%; height:44px; padding:2px; border-style:none; float:left" />
                    </div>
                    <div class="optdiv">
                        등장 옵션
                        <hr />
                        <asp:RadioButtonList CssClass="rdbThree" runat="server" BackColor="#FBFBFB">
                            <asp:ListItem Value="0" Selected>일반형</asp:ListItem>
                            <asp:ListItem Value="1">상하형</asp:ListItem>
                            <asp:ListItem Value="2">페이드인형</asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                    <br />
                    <div style="height:48px; border:solid 1px #000; margin-bottom:10px;">
                        <input type="text" id="run_times" name="run_times" size="38" onkeypress="num_only()" style="width:220px; height:44px; padding:2px; border-style:none; float:left" />
                        <p style="float:left">회</p>
                    </div>
                    <br/>
                    <div >
                        <input id="btnThreeApply" disabled type="button" value="적용하기" onclick="OnThreeApply()" style="height:50px; width:260px; font-family:맑은 고딕; font-size:13pt; color:#D64F26; font-weight:bold" />
                    </div>
                </div>
                <div id="img_opt" style="float:left; width:260px; display:none">
                    <div >
                        <input id="image_file" type="file" name="img_path" accept="image/png, image/jpeg" style="position:absolute; height:46px; width:260px;display:none;" onchange="document.getElementById('imgPath').value=this.value"/>
                        <input type="text" name="imgPath" id="imgPath" value="이미지파일" style="width: 61%; height: 41px; " readonly="readonly"/>
                        <input type="button" id="btn_ImageBrowse" value="찾아보기" onclick="OnAddPrevImg()" style="width: 35%; height: 46px; "/>
                    </div>
                    <br />
                    <div class="optdiv" style="height:115px; overflow-x:scroll; overflow-y:hidden;" >
                        <div id="prevcontainer_div" style="width:730px">
                        </div>
                    </div>
                    <br />
                    <div class="optdiv">
                        VIEW 옵션
                        <hr />
                            <Label style="line-height:25px;"><input id="imgview_rd1" type="radio" name="imgview_rd" title="일반형" value="0" checked />일반형</Label> <br/>
                            <Label id="template4" style="line-height:25px;"><input id="imgview_rd2" type="radio" name="imgview_rd" title="3D스탠드 액자형" value="1" />3D스탠드 액자형</Label>
                    </div>
                    <br/>
                    <div>
                        <input id="btnImageApply" type="button" value="적용하기" onclick="OnImageApply()" style="height:50px; width:260px; font-family:맑은 고딕; font-size:13pt; color:#D64F26; font-weight:bold; " />
                    </div>
                </div>
                <div id="googlemap_opt" style="float:left; width:260px; display:none;">
                    <div style="height:48px; border:solid 1px #000; margin-bottom:10px;">
                        <input type="text"  id="coordinate" name="coordinate" onkeypress="googlepos_only()" style="width:98%; height:44px; padding:2px; border-style:none; ime-mode:disabled" />
                    </div>
                    <div class="optdiv">
                        VIEW 옵션
                        <hr />
                            <Label style="line-height:25px;" ><input id="googlebtn_rd1" type="radio" name="googlebtn_rd" title="기본형" value="common" checked />기본형</Label> <br/>
                            <Label style="line-height:25px;"><input id="googlebtn_rd2" type="radio" name="googlebtn_rd" title="제작형" value="custom" />제작형</Label>
                            <br />
                            <input id="googlebtn_path" type="file" name="googlebtn_path" accept="image/jpeg, image/png" style="position:absolute; height:46px; width:260px;display:none;" onchange="document.getElementById('googlebtn_path_text').value=this.value"/>
                            <input type="text" name="googlebtn_path_text" id="googlebtn_path_text" value="이미지파일" style="width: 61%; height: 41px; " readonly="readonly" />
                            <input type="button" id="btnGoogleBrowse" value="찾아보기" onclick="OnAddGoogleBtn()" style="width: 35%; height: 46px; "/>
                    </div>
                    <br/>
                    <div style="padding-top:20px;">
                        <input id="btnGoogleMapApply" disabled type="button" value="적용하기" onclick="OnGoogleMapApply()" style="height:50px; width:260px; font-family:맑은 고딕; font-size:13pt; color:#D64F26; font-weight:bold" />
                    </div>
                </div>
                <div id="notepad_opt" style="float:left; width:260px; display:none; ">
                    <div style="height:auto; margin-bottom:10px;">
                        <textarea id="notepad_content" cols="20" rows="5" maxlength="20" style="width:255px;"></textarea>
                    </div>
                    <div class="optdiv">
                        VIEW 옵션
                        <hr />
                            <Label style="line-height:25px;" ><input id="notepad_rd1" type="radio" name="notepad_rd" title="일반형" value="common" checked />일반형</Label> <br/>
                            <Label id="template5" style="line-height:25px;"><input id="notepad_rd2" type="radio" name="notepad_rd" title="3D모델형" value="3dmodel" />3D모델형</Label>
                    </div>
                    <br/>
                    <div style="padding-top:20px;">
                        <input id="btnNotepadApply" disabled type="button" value="적용하기" onclick="OnNotepadApply()" style="height:50px; width:260px; font-family:맑은 고딕; font-size:13pt; color:#D64F26; font-weight:bold" />
                    </div>
                </div>
                <div id="audio_opt" style="float:left; width:260px; display:none;" >
                    <div style="height:72px">
                        <input id="audio_file" type="file" name="audio_file" accept="audio/mp3" style="position:absolute; height:46px; width:260px;display:none;" onchange="document.getElementById('audio_file_text').value=this.value"/>
                        <input type="text" name="audio_file_text" id="audio_file_text" value="사운드파일" style="width: 61%; height: 41px; " readonly="readonly" />
                        <input type="button" id="btnAudioBrowse" value="찾아보기" onclick="OnAddAudioFile()" style="width: 35%; height: 46px; "/>
                    </div>
                    <div class="optdiv">
                        VIEW 옵션
                        <hr />
                        <Label style="line-height:25px;"><input id="audiobtn_rd1" type="radio" name="audiobtn_rd" title="일반형" value="0" checked />일반형</Label> <br/>
                        <Label id="template6" style="line-height:25px;"><input id="audiobtn_rd2" type="radio" name="audiobtn_rd" title="3D 사운드 플레이어형" value="1" />3D 사운드 플레이어형</Label><br />
                        <Label id="template7" style="line-height:25px;"><input id="audiobtn_rd3" type="radio" name="audiobtn_rd" title="3D 클래식 사운드 플레이어형" value="2" />3D 클래식 사운드 플레이어형</Label>
                    </div>
                    <br/>
                    <div class="optdiv">
                        실행옵션
                        <hr />
                        <Label style="line-height:25px;"><input id="audiorun_rd1" type="radio" name="audiorun_rd" title="자동실행" value="0" checked />자동실행</Label> <br/>
                        <Label style="line-height:25px;"><input id="audiorun_rd2" type="radio" name="audiorun_rd" title="터치시 실행" value="1" />터치시 실행</Label>
                    </div>
                    <br />
                    <div>
                        <input id="btnAudioApply" disabled type="button" value="적용하기" onclick="OnAudioApply()" style="height:50px; width:260px; font-family:맑은 고딕; font-size:13pt; color:#D64F26; font-weight:bold" />
                    </div>
                </div>
                <div id="chromakey_opt" style="float:left; width:260px; display:none;" >
                    <div style="height:72px">
                        <input id="chromakey_file" type="file" name="chromakey_file" style="position:absolute; height:46px; width:260px;display:none;" onchange="document.getElementById('chromakey_file_text').value=this.value"/>
                        <input type="text" name="chromakey_file_text" id="chromakey_file_text" value="MOV" style="width: 61%; height: 41px; " readonly="readonly" />
                        <input type="button" id="btnChromakeyBrowse" value="찾아보기" onclick="OnAddChromakeyFile()" style="width: 35%; height: 46px; "/>
                    </div>
                    <div class="optdiv">
                        VIEW 옵션
                        <hr />
                        <Label style="line-height:25px;"><input id="chromakeyview_rd1" type="radio" name="chromakeyview_rd" title="마커와 평행" value="0" checked />마커와 평행</Label> <br/>
                        <Label style="line-height:25px;"><input id="chromakeyview_rd2" type="radio" name="chromakeyview_rd" title="마커와 90도" value="1" />마커와 90도</Label>
                    </div>
                    <br/>
                    <div class="optdiv">
                        실행옵션
                        <hr />
                        <label style="line-height:25px;"><input id="chromakeyrun_rd1" type="radio" name="chromakeyrun_rd" title="자동실행" value="0" checked />자동실행</label> <br/>
                        <Label style="line-height:25px;"><input id="chromakeyrun_rd2" type="radio" name="chromakeyrun_rd" title="터치시 실행" value="1" />터치시 실행</Label>
                    </div>
                    <br />
                    <div>
                        <input id="btnChromakeyApply" disabled type="button" value="적용하기" onclick="OnChromakeyApply()" style="height:50px; width:260px; font-family:맑은 고딕; font-size:13pt; color:#D64F26; font-weight:bold" />
                    </div>
                </div>
            </div>

            <div style="float:right; width:700px; background-color:#F6F6F6; max-height:550px; ">
                <div class="req_cover">
                    <asp:Label ID="Label1" runat="server" Text="커버이미지를 넣으세요." Font-Size="X-Large"
                        Font-Bold="False"></asp:Label>
                    <br /><br />
                    <input id="btnRegMarker" type="button" value="이미지 넣기" style="height:50px; width:260px; font-family:맑은 고딕; font-size:13pt; color:#D64F26; font-weight:bold" />
                    <input type="file" id="fileImg" name="markImg" style="visibility:hidden" />
                </div>
                <div id="editframe" class="markdiv" style="margin-left:auto; margin-right:auto; z-index:1; display:none; position:relative; " >
                     <img id="markImg" class="clsMarkerImg" src="" alt="markerImg" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
