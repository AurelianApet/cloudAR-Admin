function init_objects() {
    //ShowProgress();


    var empty_obj2 = "<div id='temp' class='tempclass' style='width:190px; height:40px; position:absolute;'>";
    empty_obj2 += "<div class='tempcontent' style='width:100%;height:100%'>";
    empty_obj2 += "<table cellpadding='0' cellspacing='0' align='center' style='border-collapse:collapse;' bgcolor='#F7F7F7'>";
    empty_obj2 += "	<tr>";
    empty_obj2 += "		<td width='190' height='40' style='border-width:1px; border-color:rgb(187,187,187); border-style:solid;' align='left'>";
    empty_obj2 += "			<table cellpadding='0' cellspacing='0' width='175'>";
    empty_obj2 += "				<tr>";
    empty_obj2 += "					<td width='35' height='27' align='right'>";
    empty_obj2 += "						<img src='img/cam_icon09.png' width='19' height='19' border='0'>";
    empty_obj2 += "					</td>";
    empty_obj2 += "					<td width='140' height='27' align='center'>";
    empty_obj2 += "						<b><font face='돋움' color='#8C959A'><span style='font-size:10pt;' >Chroma-key photo</span></font></b>";
    empty_obj2 += "					</td>";
    empty_obj2 += "				</tr>";
    empty_obj2 += "			</table>";
    empty_obj2 += "		</td>";
    empty_obj2 += "	</tr>";
    empty_obj2 += "</table>";
    empty_obj2 += "</div>";

    /*var panel_obj = "<div class='panel'>";
    panel_obj += "		<table cellpadding='0' cellspacing='0' align='center' width='100%'>";
    panel_obj += "			<tr>";
    panel_obj += "				<td width='30%' height='26' align='left'>";
    panel_obj += "					<img class='delete-btn' src='img/cam_icon_trash.png' width='18' height='21' border='0' name='image3'>";
    panel_obj += "				</td>";
    panel_obj += "				<td width='30%' height='26' align='center'>";
    panel_obj += "					<img class='3d-btn' src='img/cam_icon12_3d.png' width='25' height='21' border='0'>";
    panel_obj += "				</td>";
    panel_obj += "				<td width='30%' height='26' align='right'>";
    panel_obj += "					<img class='edit-btn' src='img/cam_icon_pen.png' width='18' height='21' border='0' name='image4'>";
    panel_obj += "				</td>";
    panel_obj += "			</tr>";
    panel_obj += "		</table>";
    panel_obj += "</div>";
    panel_obj += "</div>";*/

    $.ajax({
        url: "getXML.aspx?isscan=0&content_id=" + SERVER_ID,
        type: 'POST',
        datatype: "xml",
        async: false,
        success: function (data) {
            //xml을 받아서 파싱해야 한다.
            //setTimeout(function () {
            var unitX = $("#markImg").width() / 100;
            var unitY = $("#markImg").height() / 100;
            var oX = $("#markImg").position().left;
            var oY = $("#markImg").position().top + $("#markImg").height();

            xmlDoc = data;
            xmlDoc = xmlDoc.replace(/<image /g, '<picture ');
            xmlDoc = xmlDoc.replace(/image>/g, 'picture>');
            var marker = $(xmlDoc).find("marker");
            var images = $(xmlDoc).find("picture");
            var slides = $(xmlDoc).find("slide");
            var videos = $(xmlDoc).find("video");
            var webs = $(xmlDoc).find("web");
            var captures = $(xmlDoc).find("capture");
            var threes = $(xmlDoc).find("three");
            var tels = $(xmlDoc).find("tel");
            var googlemaps = $(xmlDoc).find("googlemap");
            var notepads = $(xmlDoc).find("notepad");
            var audios = $(xmlDoc).find("audio");
            var chromakeys = $(xmlDoc).find("chromakey");

            //초기 이미지,비디오 및 오브젝트들의 갯수를 설정한다. 새로 만드는 오브젝트들을 그 다음번호부터 가진다.
            slide_counter = slides.length;
            img_counter = images.length;
            video_counter = videos.length;
            web_counter = webs.length;
            capture_counter = captures.length;
            three_counter = threes.length;
            tel_counter = tels.length;
            googlemap_counter = googlemaps.length;
            notepad_counter = notepads.length;
            audio_counter = audios.length;
            chromakey_counter = chromakeys.length;

            //총 갯수 초기화
            counter = slide_counter + img_counter + video_counter + web_counter + capture_counter + three_counter + tel_counter + googlemap_counter + notepad_counter + audio_counter + chromakey_counter;

            /*마커이미지 구현*/
            $(marker).each(function () {
                imgList[0] = { url: encodeURI($(this).find("url").text()) }
            });
            /***마커이미지 구현***/

            /*이미지 오브젝트 구현*/
            i = 0;
            $(images).each(function () {
                i++;
                var url = encodeURI($(this).find("url").text());
                var type = $(this).find("type").text();
                var posX = $(this).find("posX").text();
                var posY = $(this).find("posY").text();
                var width = $(this).find("width").text();
                var height = $(this).find("height").text();
                var depth = $(this).find("depth").text();
                var width = $(this).find("width").text();
                var objsize = $(this).find("objsize").text();
                //var rate = $images.find("rate");
                var element = "<div id='temp' style='position:absolute'>";
                element += "<img width='100%' height='100%' src='" + url + "'>";
                //패널 추가
                element += panel_obj;
                jQuery(element).appendTo("#editframe");
                $("#temp").css({ "width": width * unitX, "height": height * unitY });
                $("#temp").css({ "left": oX + posX * unitX - width * unitX / 2, "top": oY - posY * unitY - height * unitY / 2 });
                $("#temp").css({ "z-index": depth });
                $("#temp").addClass("dragged_object");
                $("#temp").attr("id", "img_" + i);
                imgList[i] = { url: url, type: type, objsize: objsize };

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

            /*슬라이드 오브젝트 구현*/
            $(slides).each(function () {
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
                var url10 = encodeURI($(this).find("url10").text());

                var type = $(this).find("type").text();     // 일반, 3D
                var showtype = $(this).find("showtype").text();     // 전환모드
                var playtype = $(this).find("playtype").text();     // 재생모드

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
                element += panel_obj;
                jQuery(element).appendTo("#editframe");
                $("#temp").css({ "width": width * unitX, "height": height * unitY });
                $("#temp").css({ "left": oX + posX * unitX - width * unitX / 2, "top": oY - posY * unitY - height * unitY / 2 });
                $("#temp").css({ "z-index": depth });
                $("#temp").addClass("dragged_object");
                $("#temp").attr("id", "slide_" + i);
                slideList[i] = { url1: url1, url2: url2, url3: url3, url4: url4, url5: url5, url6: url6, url7: url7, url8: url8, url9: url9, url10: url10, type: type, showtype: showtype, playtype: playtype, prev_count: prev_count, objsize: objsize };

                addIndex = prev_count;
                prevIndex = prev_count;
                //크기조종
                $("#slide_" + i).draggable({
                    containment: "parent"

                });
                $("#slide_" + i).resizable({
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
                element += panel_obj;
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
                var title = $(this).find("title").text();
                var color_index = $(this).find("color_index").text();
                var mode_index = $(this).find("mode_index").text();
                var view = $(this).find("view").text();
                var backurl = encodeURI($(this).find("backurl").text());
                var objsize = $(this).find("objsize").text();
                //var rate = $images.find("rate");

                var element = "<div id='temp' style='min-width:98px; width:100px; height:auto; position:absolute'>";
                //element += "<p style='background-color:#0099FF; margin-bottom:0px;margin-top: 0px; text-align:center'>웹사이트";
                if (type == 1)
                    element += "<img style='width:100%; height;100%' src=" + backurl + ">";
                else {
                    element = empty_obj2;
                }
                //element += "" + string + "";
                //패널 추가
                element += panel_obj;
                jQuery(element).appendTo("#editframe");
                if (type == 1)
                    $("#temp").css({ "width": width * unitX, "height": height * unitY });
                else {
                    $(".tempcontent" + " img").attr("src", "img/cam_icon03.png");
                    $(".tempcontent" + " span").html(title);
                    $(".tempcontent > table").css("background-color", color);
                    $(".tempclass").removeClass("tempclass");
                    $(".tempcontent").removeClass("tempcontent");
                }

                $("#temp").css({ "left": oX + posX * unitX - width * unitX / 2, "top": oY - posY * unitY - (type == 0 ? 0 : height * unitY / 2) });
                $("#temp").css({ "z-index": depth });
                $("#temp").addClass("dragged_object");
                $("#temp").attr("id", "web_" + i);

                webList[i] = { backurl: backurl, url: url, view: view, type: type, objsize: objsize, color: color, title: title, color_index: color_index, mode_index: mode_index };
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

                var slide1 = encodeURI($(this).find("slide1").text());
                var posX1 = $(this).find("posX1").text();
                var posY1 = $(this).find("posY1").text();
                var width1 = $(this).find("width1").text();
                var height1 = $(this).find("height1").text();

                var slide2 = encodeURI($(this).find("slide2").text());
                var posX2 = $(this).find("posX2").text();
                var posY2 = $(this).find("posY2").text();
                var width2 = $(this).find("width2").text();
                var height2 = $(this).find("height2").text();

                var slide3 = encodeURI($(this).find("slide3").text());
                var posX3 = $(this).find("posX3").text();
                var posY3 = $(this).find("posY3").text();
                var width3 = $(this).find("width3").text();
                var height3 = $(this).find("height3").text();

                var slide4 = encodeURI($(this).find("slide4").text());
                var posX4 = $(this).find("posX4").text();
                var posY4 = $(this).find("posY4").text();
                var width4 = $(this).find("width4").text();
                var height4 = $(this).find("height4").text();

                var slide5 = encodeURI($(this).find("slide5").text());
                var posX5 = $(this).find("posX5").text();
                var posY5 = $(this).find("posY5").text();
                var width5 = $(this).find("width5").text();
                var height5 = $(this).find("height5").text();

                var depth = $(this).find("depth").text();
                var backurl = encodeURI($(this).find("backurl").text());
                var objsize = $(this).find("objsize").text();

                var buttontype = $(this).find("buttontype").text();
                var title = $(this).find("title").text();
                var color = $(this).find("color").text();
                //var mode_index = $(this).find("mode_index").text();
                var color_index = $(this).find("color_index").text();

                var element = "<div id='temp' style='position:absolute'>";
                if (type != 0)
                    element += "<img width='100%' height='100%' src=" + backurl + ">";
                else
                    element = empty_obj2;
                //패널 추가
                element += panel_obj;
                jQuery(element).appendTo("#editframe");
                if (type == 1)
                    $("#temp").css({ "width": width * unitX, "height": height * unitY });
                else {
                    $(".tempcontent" + " img").attr("src", "img/cam_icon09.png");
                    $(".tempcontent" + " span").html(title);
                    $(".tempcontent > table").css("background-color", color);
                    $(".tempclass").removeClass("tempclass");
                    $(".tempcontent").removeClass("tempcontent");
                }

                $("#temp").css({ "width": width * unitX, "height": height * unitY });
                $("#temp").css({ "left": oX + posX * unitX - width * unitX / 2, "top": oY - posY * unitY - height * unitY / 2 });
                $("#temp").css({ "z-index": depth });
                $("#temp").addClass("dragged_object");
                $("#temp").attr("id", "capture_" + i);

                captureList[i] = { backurl: backurl, type: type, prev_count: prev_count,
                    slide1: slide1, width1: width1, height1: height1, posX1: posX1, posY1: posY1,
                    slide2: slide2, width2: width2, height2: height2, posX2: posX2, posY2: posY2,
                    slide3: slide3, width3: width3, height3: height3, posX3: posX3, posY3: posY3,
                    slide4: slide4, width4: width4, height4: height4, posX4: posX4, posY4: posY4,
                    slide5: slide5, width5: width5, height5: height5, posX5: posX5, posY5: posY5,
                    buttontype: buttontype, title: title, color: color,
                    color_index: color_index,
                    objsize: objsize
                };

                capCount = prev_count;
                capprevIndex = prev_count;
                //크기조종

                $("#capture_" + i).draggable({
                    containment: "parent"
                });
                if (type == 1) {
                    $("#capture_" + i).resizable({
                        aspectRatio: true,
                        containment: "parent"
                    });
                }

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

                var angle = front_angle;
                element = '<div id="temp" style="min-width:61px; min-height:55px;width:122px; height:110px; position:absolute">';
                //element += '<img style="width:100%; height:100%" src="img/3Dobject.png"></img>';

                if ((1 <= front_angle && front_angle <= 22) || (338 <= front_angle && front_angle <= 360)) {
                    element += '<img style="width:100%; height:100%" src="img/3Dobject_360.png"></img>';
                } else if (23 <= front_angle && front_angle <= 67) {
                    element += '<img style="width:100%; height:100%" src="img/3Dobject_45.png"></img>';
                } else if (68 <= front_angle && front_angle <= 112) {
                    element += '<img style="width:100%; height:100%" src="img/3Dobject_90.png"></img>';
                } else if (113 <= front_angle && front_angle <= 157) {
                    element += '<img style="width:100%; height:100%" src="img/3Dobject_135.png"></img>';
                } else if (158 <= front_angle && front_angle <= 202) {
                    element += '<img style="width:100%; height:100%" src="img/3Dobject_180.png"></img>';
                } else if (203 <= front_angle && front_angle <= 247) {
                    element += '<img style="width:100%; height:100%" src="img/3Dobject_225.png"></img>';
                } else if (248 <= front_angle && front_angle <= 292) {
                    element += '<img style="width:100%; height:100%" src="img/3Dobject_270.png"></img>';
                } else if (293 <= front_angle && front_angle <= 337) {
                    element += '<img style="width:100%; height:100%" src="img/3Dobject_315.png"></img>';
                }
                //패널 추가
                element += panel_obj;
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
                var color = $(this).find("color").text();
                var title = $(this).find("title").text();
                var color_index = $(this).find("color_index").text();
                var mode_index = $(this).find("mode_index").text();
                var threemode = $(this).find("threemode").text();
                //var rate = $(this).find("rate").text();

                var element = '<div id="temp" style=" position:absolute">';
                if (type != 1) {
                    element = empty_obj2;
                }
                else
                    element += '<img width="100%" height="100%" src=' + backurl + '>';

                //패널 추가
                element += panel_obj;
                jQuery(element).appendTo("#editframe");

                if (type == 1)
                    $("#temp").css({ "width": width * unitX, "height": height * unitY });
                else {
                    $(".tempcontent" + " img").attr("src", "img/cam_icon04.png");
                    $(".tempcontent" + " span").html(title);
                    $(".tempcontent > table").css("background-color", color);
                    $(".tempclass").removeClass("tempclass");
                    $(".tempcontent").removeClass("tempcontent");
                }
                $("#temp").css({ "left": oX + posX * unitX - width * unitX / 2, "top": oY - posY * unitY - height * unitY / 2 });
                $("#temp").css({ "z-index": depth });
                $("#temp").addClass("dragged_object");
                $("#temp").attr("id", "tel_" + i);

                telList[i] = { tel_no: tel_no, type: type, color: color, title: title, color_index: color_index, mode_index: mode_index, threemode: threemode, backurl: backurl, objsize: objsize };
                //크기조종
                $("#tel_" + i).draggable({
                    containment: "parent"
                });
                if (type == 1) {
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
                var color = $(this).find("color").text();
                var color_index = $(this).find("color_index").text();
                var mode_index = $(this).find("mode_index").text();
                var title = $(this).find("title").text();

                var element = '<div id="temp" style="min-width:98px; position:absolute">';
                if (type == 0) {
                    element = empty_obj2;
                }
                if (type == 1)
                    element += '<img width="100%" height="100%" src=' + backurl + '>';

                //패널 추가
                element += panel_obj;
                jQuery(element).appendTo("#editframe");

                if (type == 1) {
                    $("#temp").css({ "width": width * unitX, "height": height * unitY });
                }
                else {
                    $(".tempcontent" + " img").attr("src", "img/cam_icon05.png");
                    $(".tempcontent" + " span").html(title);
                    $(".tempcontent > table").css("background-color", color);
                    $(".tempclass").removeClass("tempclass");
                    $(".tempcontent").removeClass("tempcontent");
                }
                $("#temp").css({ "left": oX + posX * unitX - width * unitX / 2, "top": oY - posY * unitY - height * unitY / 2 });
                $("#temp").css({ "z-index": depth });
                $("#temp").addClass("dragged_object");
                $("#temp").attr("id", "googlemap_" + i);

                googlemapList[i] = { coordinate: coordinate, type: type, title: title, color: color, color_index: color_index, mode_index: mode_index, backurl: backurl, objsize: objsize };
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
                var color = $(this).find("color").text();
                var text_color_index = $(this).find("text_color_index").text();
                var board_color_index = $(this).find("board_color_index").text();
                var boardtype = $(this).find("boardtype").text();
                var boardcolor = $(this).find("boardcolor").text();
                var textplaymode = $(this).find("textplaymode").text();
                var view = $(this).find("view").text();

                var element = "<div id='temp' style='position:absolute; min-height:60px;min-width:98px'>";
                element += "<div class='tempcontent' style='width:100%; height:100%'>";
                element += "<table cellpadding='0' cellspacing='0' width='100%' height='100%' align='center' style='border-collapse:collapse;background-repeat:no-repeat;background-size:cover;'>";
                element += "	<tr>";
                element += "		<td width='100%' height='100%' align='center' valign='middle' style='border-style:none;color:" + color + ";'>";
                element += "			" + decodeURIComponent(content);
                element += "		</td>";
                element += "	</tr>";
                element += "</table>";
                element += "</div>"
                //패널 추가
                element += panel_obj;
                jQuery(element).appendTo("#editframe");
                $("#temp").css({ "width": width * unitX, "height": height * unitY });
                $("#temp").css({ "left": oX + posX * unitX - width * unitX / 2, "top": oY - posY * unitY - height * unitY / 2 });

                if (boardtype == 1) {
                    $(".tempcontent > table").removeClass("clsTableRightRadius").removeClass("clsTableRadius");
                    $(".tempcontent > table").attr("background", "");
                }
                else if (boardtype == 2) {
                    $(".tempcontent > table").removeClass("clsTableRadius").addClass("clsTableRightRadius");
                    $(".tempcontent > table").attr("background", "img/icon_textbox01.png");
                }
                else if (boardtype == 3) {
                    $(".tempcontent > table").removeClass("clsTableRightRadius").addClass("clsTableRadius");
                    $(".tempcontent > table").attr("background", "");
                }
                else if (boardtype == 5) {
                    $(".tempcontent > table").removeClass("clsTableRightRadius").removeClass("clsTableRadius");
                    $(".tempcontent > table").attr("background", "img/icon_textbox04_" + board_color_index + ".png");
                }
                $(".tempcontent > table").css("background-color", boardcolor);
                $(".tempcontent").removeClass("tempcontent");
                $("#temp").css({ "z-index": depth });
                $("#temp").addClass("dragged_object");
                $("#temp").attr("id", "notepad_" + i);

                notepadList[i] = { content: decodeURIComponent(content), view: view, color: color, boardcolor: boardcolor, boardtype: boardtype, text_color_index: text_color_index, board_color_index: board_color_index, textplaymode: textplaymode };
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
            empty_obj2 = "";
            i = 0;
            $(audios).each(function () {
                i++;
                var url = encodeURI($(this).find("url").text());
                var btn_url = encodeURI($(this).find("btn_url").text());
                var type = $(this).find("type").text();
                var run_opt = $(this).find("run_opt").text();
                var btnkind = $(this).find("btnkind").text();   // 표시안함, 기본버튼, 커스텀버튼                
                var color = $(this).find("color").text();       // 기본버튼 색상
                var posX = $(this).find("posX").text();
                var posY = $(this).find("posY").text();
                var width = $(this).find("width").text();
                var height = $(this).find("height").text();
                var depth = $(this).find("depth").text();
                var width = $(this).find("width").text();
                var objsize = $(this).find("objsize").text();

                var color_index = $(this).find("color_index").text();
                var mode_index = $(this).find("mode_index").text();

                var audiotag = "<audio style='width:100%; height:100%;' controls>";
                audiotag += "<source src=" + url + ">";
                audiotag += "</audio>";

                empty_obj2 = "<div id='temp' class='tempclass' style='width:190px; height:40px; position:absolute;'>";
                if (mode_index == 1 || mode_index == 2) {
                    empty_obj2 += "<div class='tempcontent' style='width:100%; height:100%'>";
                    empty_obj2 += "<table cellpadding='0' cellspacing='0' align='center' style='border-collapse:collapse;' bgcolor='#F7F7F7'>";
                    empty_obj2 += "	<tr>";
                    empty_obj2 += "		<td width='190' height='40' style='border-width:1px; border-color:rgb(187,187,187); border-style:solid;' align='left'>";
                    empty_obj2 += "			<table cellpadding='0' cellspacing='0' width='175'>";
                    empty_obj2 += "				<tr>";
                    empty_obj2 += "					<td width='35' height='27' align='right'>";
                    empty_obj2 += "						<img src='img/cam_icon09.png' width='19' height='19' border='0' />";
                    empty_obj2 += "					</td>";
                    empty_obj2 += "					<td width='140' height='27' align='center'>";
                    empty_obj2 += "						<b><font face='돋움' color='#8C959A'><span style='font-size:10pt;' ></span></font></b>";
                    empty_obj2 += "					</td>";
                    empty_obj2 += "				</tr>";
                    empty_obj2 += "			</table>";
                    empty_obj2 += "		</td>";
                    empty_obj2 += "	</tr>";
                    empty_obj2 += "</table>";
                    empty_obj2 += "</div>";
                }
                else if (mode_index == 3 || mode_index == 4) {
                    empty_obj2 += "<div class='tempcontent' style='width:100%; height:100%'>";
                    empty_obj2 += "<img src='img/cam_icon09.png' width='50' height='50' border='0' />";
                    empty_obj2 += "</div>";
                }

                var element = "<div id='temp' style='position:absolute'>";

                if (btnkind == 2) {
                    // 커스텀버튼
                    element = "<div id='temp' style='position:absolute; min-height:42px;min-width:" + (mode_index == 1 ? "50" : "33") + "px'>";
                    element += '<img width="100%" height="100%" src="' + btn_url + '">';
                }
                else if (btnkind == 1) {
                    // 기본버튼
                    element = empty_obj2;
                }
                else {
                    element += audiotag;
                }
                //패널 추가
                element += panel_obj;
                jQuery(element).appendTo("#editframe");

                if (btnkind == 1) {
                    if (mode_index == 1 || mode_index == 2) {
                        $(".tempcontent" + " img").attr("src", "img/cam_icon07.png");
                        $(".tempcontent" + " span").html((mode_index == 1 || btnkind == 0) ? "BGM" : "사운드");
                        $(".tempcontent > table").css("background-color", color);
                        $(".tempclass").removeClass("tempclass");
                        $(".tempcontent").removeClass("tempcontent");
                    }
                    if (mode_index == 3) {
                        $(".tempcontent" + " img").attr("src", "img/icon_bgm01.png");
                        $(".tempclass").removeClass("tempclass");
                        $(".tempcontent").removeClass("tempcontent");
                    }
                    if (mode_index == 4) {
                        $(".tempcontent" + " img").attr("src", "img/icon_bgm02.png");
                        $(".tempclass").removeClass("tempclass");
                        $(".tempcontent").removeClass("tempcontent");
                    }
                }
                else {
                    $("#temp").css({ "width": width * unitX, "height": height * unitY });
                }
                if (btnkind != 0) {
                    $("#temp" + " audio").css("display:none");
                }

                $("#temp").css({ "left": oX + posX * unitX - width * unitX / 2, "top": oY - posY * unitY - height * unitY / 2 });
                $("#temp").css({ "z-index": depth });
                $("#temp").addClass("dragged_object");
                $("#temp").attr("id", "audio_" + i);

                audioList[i] = { url: url, btn_url: btn_url, type: type, run_opt: run_opt, btnkind: btnkind, color: color, objsize: objsize, color_index: color_index, mode_index: mode_index };
                //크기조종

                $("#audio_" + i).draggable({
                    containment: "parent"
                });
                if (btnkind != 1) {
                    $("#audio_" + i).resizable({
                        aspectRatio: true,
                        containment: "parent"
                    });
                }
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
                element += panel_obj;
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

            //}, 1000);
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
            var flag = parseInt(data.flag);
            if (marker_url != "") {
                $("#editframe").css("display", "");
                $("#req_cover").css("display", "none");
                $("#markImg").attr("src", "/markers/" + marker_url);

                $("#markImg").one("load", function () {
                    if ($("#markImg").width() >= 1080) {
                        $("#markImg").css("width", "1080px");
                        $("#markImg").css("height", "auto");
                    }

                    $(".markdiv").css("width", $("#markImg").width() + "px");
                    init_objects();
                }).each(function () {
                    if (this.complete) $(this).load();
                });

                //                $("#markImg").load(function () {
                //                    $(".markdiv").css({ "width": document.getElementById("markImg").width });
                //                    init_objects();
                //                });

                /*setTimeout(function () {
                $(".markdiv").css({ "width": document.getElementById("markImg").width });
                }, 500);*/
            }
            else {
                $("#editframe").css("display", "none");
                $("#req_cover").css("display", ""); 
                if (flag != 0) {
                    showPopup("dvCopyCampaignAlert");
                }
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            HideProgress();
            alert("마커이미지를 불러오는동안 오류가 발생하였습니다.");
        }
    });
}

function add_DoubleClickEvent() {
    //double click event 구현
    var dataToPass = { objid: "This is what I wanted to say" };
    var objectid;
    $(".dragged_object").click(dataToPass, function (event) {
        //해당 오브젝트밑의 패널만 보이게 한다.
        objectid = event.currentTarget.id;

        if ($("#" + objectid + " .panel").css("display") == "none") {
            showPanel(event.currentTarget.id);
            // 3d방식의 초기값을 설정한다.
            if (objectid.indexOf("video_") == 0) {
                var index = objectid.substr(6);
                $("#video_rd1")[0].checked = true;
                if (videoList[index] != null) {
                    if (videoList[index].type == 0)
                        $("#video_rd1")[0].checked = true;
                    else if (videoList[index].type == 1)
                        $("#video_rd2")[0].checked = true;
                    else if (videoList[index].type == 2)
                        $("#video_rd3")[0].checked = true;
                }
            }
            else if (objectid.indexOf("tel_") == 0) {
                var index = objectid.substr(4);
                $("#rdTel1")[0].checked = true;
                if (telList[index] != null) {
                    if (telList[index].threemode == 0)
                        $("#rdTel1")[0].checked = true;
                    else
                        $("#rdTel2")[0].checked = true;
                }
            }
            else if (objectid.indexOf("web_") == 0) {
            }
            else if (objectid.indexOf("img_") == 0) {
                var index = objectid.substr(4);
                $("#imgview_rd1")[0].checked = true;
                if (imgList[index] != null) {
                    if (imgList[index].type == 0)
                        $("#imgview_rd1")[0].checked = true;
                    else
                        $("#imgview_rd2")[0].checked = true;
                }
            }
            else if (objectid.indexOf("slide_") == 0) {
                var index = objectid.substr(6);
                $('.rdoSlideViewType').find('input')[0].checked = true;
                if (slideList[index] != null) {
                    $('.rdoSlideViewType').find('input')[slideList[index].type].checked = true;
                }

                onSetDVSlideItem(1, "");
                onSetDVSlideItem(2, "");
                onSetDVSlideItem(3, "");
                onSetDVSlideItem(4, "");
                onSetDVSlideItem(5, "");
                onSetDVSlideItem(6, "");
                onSetDVSlideItem(7, "");
                onSetDVSlideItem(8, "");
                onSetDVSlideItem(9, "");
                onSetDVSlideItem(10, "");

            }
            else if (objectid.indexOf("capture_") == 0) {
                var index = objectid.substr(8);
                $('.rdbCapture').find('input')[0].checked = true;
                $('.clsCustomCaptureMode').css("display", "none");
                $('.clsNorCaptureMode').css("display", "");

                onSetDVCaptureItem(1, ""); $("#controlcapprev1").remove();
                onSetDVCaptureItem(2, ""); $("#controlcapprev2").remove();
                onSetDVCaptureItem(3, ""); $("#controlcapprev3").remove();
                onSetDVCaptureItem(4, ""); $("#controlcapprev4").remove();
                onSetDVCaptureItem(5, ""); $("#controlcapprev5").remove();

            }
            else if (objectid.indexOf("three_") == 0) {
            }
            else if (objectid.indexOf("googlemap_") == 0) {
            }
            else if (objectid.indexOf("notepad_") == 0) {
                var index = objectid.substr(8);
                $("#notepad_rd1")[0].checked = true;
                if (notepadList[index] != null) {
                    if (notepadList[index].view == 0)
                        $("#notepad_rd1")[0].checked = true;
                    else
                        $("#notepad_rd2")[0].checked = true;
                }
            }
            else if (objectid.indexOf("audio_") == 0) {
                var index = objectid.substr(6);
                $("#audiobtn_rd1")[0].checked = true;
                if (audioList[index] != null) {
                    if (audioList[index].type == 0) {
                        $("#audiobtn_rd1")[0].checked = true;
                    }
                    else if (audioList[index].type == 1) {
                        $("#audiobtn_rd2")[0].checked = true;
                    }
                    else if (audioList[index].type == 2) {
                        $("#audiobtn_rd3")[0].checked = true;
                    }
                }
            }
            else if (objectid.indexOf("chromakey_") == 0) {
            }
        }
    });
    $(".delete-btn").click(objectid, function (event) {
        //alert("deleted");

        $("#del_objectid").val(objectid);
        showPopup("delpopup");
    });
    $(".3d-btn").click(objectid, function (event) {
        objName = "#" + objectid;
        if (objectid.indexOf("video_") == 0) {
            showPopup("dvVideo3D");
        }
        else if (objectid.indexOf("tel_") == 0) {
            showPopup("dvPhone3D");
        }
        else if (objectid.indexOf("web_") == 0) {
        }
        else if (objectid.indexOf("img_") == 0) {
            showPopup("dvImage3D");
        }
        else if (objectid.indexOf("slide_") == 0) {
            showPopup("dvSlide3D");
        }
        else if (objectid.indexOf("capture_") == 0) {
        }
        else if (objectid.indexOf("three_") == 0) {
        }
        else if (objectid.indexOf("googlemap_") == 0) {
        }
        else if (objectid.indexOf("notepad_") == 0) {
            showPopup("dvText3D");
        }
        else if (objectid.indexOf("audio_") == 0) {
            showPopup("dvBGM3D");
        }
        else if (objectid.indexOf("chromakey_") == 0) {
        }
    });
    $(".edit-btn").click(objectid, function (event) {
        //alert("edited");
        //세부옵션이 활성화되어야 한다. objectid를 문자열처리하여 video_ img_ web_와 같은 문자열에 따라 처리가 되어야 한다.
        objName = "#" + objectid;

        if (objectid.indexOf("video_") == 0) {
            var index = objectid.substr(6);
            if (videoList[index] == null) {
                $("#videorun_rd1")[0].checked = true;
            }
            else {
                if (videoList[index].run_opt == 0)
                    $("#videorun_rd1")[0].checked = true;
                else if (videoList[index].run_opt == 1)
                    $("#videorun_rd2")[0].checked = true;
            }
            showPopup("dvRegVideo");
        }
        else if (objectid.indexOf("web_") == 0) {
            var index = objectid.substr(4);
            if (webList[index] == null) {
                $('.rdbWeb1').find('input')[0].checked = true;
                $('.rdbWeb2').find('input')[0].checked = true;
                $("#web_url").val("");
                $('.trNorWebMode').css("display", "");
                $('.trCustomWebMode').css("display", "none");
                $("#tblWebPreviewBtn").css("background-color", "#F7F7F7");
                $(".clsColorBtnSel").removeClass("clsColorBtnSel");
                $("#tdWebModeBtn1").addClass("clsColorBtnSel");
                $("#tdWebColorBtn1").addClass("clsColorBtnSel");
            }
            else {
                if (webList[index].type == 0) {
                    // 웹 디폴트
                    $('.rdbWeb1').find('input')[0].checked = true;
                    $('.trNorWebMode').css("display", "");
                    $('.trCustomWebMode').css("display", "none");
                    /*$("#webbtn_path").attr("disabled", "disabled");
                    $("#btnWebbtnBrowse").attr("disabled", "disabled");*/
                    var title = webList[index].title;
                    var color = webList[index].color;
                    var mode_index = webList[index].mode_index;
                    var color_index = webList[index].color_index;
                    $("#tblWebPreviewBtn").css("background-color", color);
                    $("#spWebPreviewText").html = (title == "" ? "Website" : title);
                    $(".clsColorBtnSel").removeClass("clsColorBtnSel");
                    $("#tdWebModeBtn" + mode_index).addClass("clsColorBtnSel");
                    $("#tdWebColorBtn" + color_index).addClass("clsColorBtnSel");
                }
                else {
                    // 커스텀형
                    $('.rdbWeb1').find('input')[1].checked = true;
                    $('.trNorWebMode').css("display", "none");
                    $('.trCustomWebMode').css("display", "");
                    /*$("#webbtn_path").removeAttr("disabled");
                    $("#btnWebbtnBrowse").removeAttr("disabled");*/
                }

                if (webList[index].view == 0) // 링크형
                    $('.rdbWeb2').find('input')[0].checked = true;
                else { //자체브라우저형
                    $('.rdbWeb2').find('input')[1].checked = true;
                }

                $("#web_url").val(decodeURIComponent(webList[index].url));
            }
            showPopup("dvWeb");
        }
        else if (objectid.indexOf("tel_") == 0) {
            var index = objectid.substr(4);
            if (telList[index] == null) {
                $("#tel_no").val("");
                $('.rdbTel1').find('input')[0].checked = true;
                $('.trNorTelMode').css("display", "");
                $('.trCustomTelMode').css("display", "none");
                $("#tblTelPreviewBtn").css("background-color", "#F7F7F7");
                $(".clsColorBtnSel").removeClass("clsColorBtnSel");
                $("#tdTelModeBtn1").addClass("clsColorBtnSel");
                $("#tdTelColorBtn1").addClass("clsColorBtnSel");
            }
            else {
                if (telList[index].type == 0) {
                    $('.rdbTel1').find('input')[0].checked = true;
                    $('.trNorTelMode').css("display", "");
                    $('.trCustomTelMode').css("display", "none");
                    var title = telList[index].title;
                    var color = telList[index].color;
                    var mode_index = telList[index].mode_index;
                    var color_index = telList[index].color_index;
                    $("#tblTelPreviewBtn").css("background-color", color);
                    $("#spTelPreviewText").html = (title == "" ? "Phone number" : title);
                    $(".clsColorBtnSel").removeClass("clsColorBtnSel");
                    $("#tdTelModeBtn" + mode_index).addClass("clsColorBtnSel");
                    $("#tdTelColorBtn" + color_index).addClass("clsColorBtnSel");
                }
                else if (telList[index].type == 1) {
                    $('.rdbTel1').find('input')[1].checked = true;
                    $('.trNorTelMode').css("display", "none");
                    $('.trCustomTelMode').css("display", "");
                }
                $("#tel_no").val(telList[index].tel_no);
            }
            showPopup("dvPhone");
        }
        else if (objectid.indexOf("googlemap_") == 0) {
            var index = objectid.substr(10);
            if (googlemapList[index] == null) {
                $("#coordinate").val("");
                $('.rdbGoogle1').find('input')[0].checked = true;
                $('.trNorGoogleMode').css("display", "");
                $('.trCustomGoogleMode').css("display", "none");
                $("#tblGooglePreviewBtn").css("background-color", "#F7F7F7");
                $(".clsColorBtnSel").removeClass("clsColorBtnSel");
                $("#tdGoogleModeBtn1").addClass("clsColorBtnSel");
                $("#tdGoogleColorBtn1").addClass("clsColorBtnSel");
            }
            else {
                if (googlemapList[index].type == 0) {
                    $('.rdbGoogle1').find('input')[0].checked = true;
                    $('.trNorGoogleMode').css("display", "");
                    $('.trCustomGoogleMode').css("display", "none");
                    var title = googlemapList[index].title;
                    var color = googlemapList[index].color;
                    var mode_index = googlemapList[index].mode_index;
                    var color_index = googlemapList[index].color_index;
                    $("#tblGooglePreviewBtn").css("background-color", color);
                    $(".clsColorBtnSel").removeClass("clsColorBtnSel");
                    $("#tdGoogleModeBtn" + mode_index).addClass("clsColorBtnSel");
                    $("#tdGoogleColorBtn" + color_index).addClass("clsColorBtnSel");
                    $("#spGooglePreviewText").html = (title == "" ? "Google Map" : title);
                }
                else if (googlemapList[index].type == 1) {
                    $('.rdbGoogle1').find('input')[1].checked = true;
                    $('.trNorGoogleMode').css("display", "none");
                    $('.trCustomGoogleMode').css("display", "");

                }
                $("#coordinate").val(googlemapList[index].coordinate);
            }
            showPopup("dvGoogleMap");
        }
        else if (objectid.indexOf("slide_") == 0) {
            var index = objectid.substr(6);

            $('.rdoSlideShowType').find('input')[0].checked = true;
            $('.rdoSlidePlayType').find('input')[0].checked = true;
            if (slideList[index] != null) {
                var type = slideList[index].type;     // 일반, 3D
                var showtype = slideList[index].showtype;     // 전환모드
                var playtype = slideList[index].playtype;     // 재생모드

                $('.rdoSlideShowType').find('input')[showtype].checked = true;
                $('.rdoSlidePlayType').find('input')[playtype].checked = true;
                onSetDVSlideItem(1, slideList[index].url1);
                onSetDVSlideItem(2, slideList[index].url2);
                onSetDVSlideItem(3, slideList[index].url3);
                onSetDVSlideItem(4, slideList[index].url4);
                onSetDVSlideItem(5, slideList[index].url5);
                onSetDVSlideItem(6, slideList[index].url6);
                onSetDVSlideItem(7, slideList[index].url7);
                onSetDVSlideItem(8, slideList[index].url8);
                onSetDVSlideItem(9, slideList[index].url9);
                onSetDVSlideItem(10, slideList[index].url10);
            }
            showPopup("dvSlide");
        }
        else if (objectid.indexOf("img_") == 0) {
            var index = objectid.substr(4);
            showPopup("dvImage");
        }
        else if (objectid.indexOf("capture_") == 0) {
            var index = objectid.substr(8);
            if (captureList[index] == null) {
                capCount = 0;
                $('.rdbCapture').find('input')[0].checked = true;
                $('.clsCustomCaptureMode').css("display", "none");
                $('.clsNorCaptureMode').css("display", "");
                capdropflag = 0;
                no_drop = false;
                //n_setteddprevs = 0;
            }
            else {
                var type = captureList[index].type; //기본버튼, 커스텀버튼
                if (captureList[index].type == 0) {
                    $('.rdbCapture').find('input')[0].checked = true;
                    $('.clsCustomCaptureMode').css("display", "none");
                    $('.clsNorCaptureMode').css("display", "");
                }
                else {
                    $('.rdbCapture').find('input')[1].checked = true;
                    $('.clsCustomCaptureMode').css("display", "");
                    $('.clsNorCaptureMode').css("display", "none");
                }
                var unitX2 = $("#capture_detail_div").width() / 100;
                var unitY2 = $("#capture_detail_div").height() / 100;
                var oX2 = $("#capture_detail_div").position().left;
                var oY2 = $("#capture_detail_div").position().top + $("#capture_detail_div").height();

                onAddDVCaptureItem(1, captureList[index].slide1, captureList[index].width1, captureList[index].height1, captureList[index].posX1, captureList[index].posY1, unitX2, unitY2);
                onAddDVCaptureItem(2, captureList[index].slide2, captureList[index].width2, captureList[index].height2, captureList[index].posX2, captureList[index].posY2, unitX2, unitY2);
                onAddDVCaptureItem(3, captureList[index].slide3, captureList[index].width3, captureList[index].height3, captureList[index].posX3, captureList[index].posY3, unitX2, unitY2);
                onAddDVCaptureItem(4, captureList[index].slide4, captureList[index].width4, captureList[index].height4, captureList[index].posX4, captureList[index].posY4, unitX2, unitY2);
                onAddDVCaptureItem(5, captureList[index].slide5, captureList[index].width5, captureList[index].height5, captureList[index].posX5, captureList[index].posY5, unitX2, unitY2);

                //n_setteddprevs = captureList[index].prev_count;

                //capprevdrag();
                dragdrop2();
                capdropflag = 1;

                capCount = captureList[index].prev_count;
            }
            showPopup("dvCapture");
        }
        else if (objectid.indexOf("three_") == 0) {
            var index = objectid.substr(6);
            if (threeList[index] == null) {
                $('#front_angle').val("객체 정면 방향");
                $('#brightness').val("밝기");
                onSelBrightLess(1);
                $('.rdbThree').find('input')[0].checked = true;
            }
            else {
                if (threeList[index].type == 0) {
                    $('.rdbThree').find('input')[0].checked = true;
                }
                else if (threeList[index].type == 1) {
                    $('.rdbThree').find('input')[1].checked = true;
                }
                else if (threeList[index].type == 2) {
                    $('.rdbThree').find('input')[2].checked = true;
                }
                $("#front_angle").val(threeList[index].front_angle);
                onSelBrightLess(threeList[index].brightness);
                $("#run_times").val(threeList[index].run_times);
            }
            showPopup("dv3DObj");
        }
        else if (objectid.indexOf("notepad_") == 0) {
            var index = objectid.substr(8);
            if (notepadList[index] != null) {
                if (notepadList[index].view == 0) {
                    $("#notepad_rd1")[0].checked = true;
                }
                else if (notepadList[index].view == 1) {
                    $("#notepad_rd2")[0].checked = true;
                }
                var board_color = notepadList[index].boardcolor;
                var boardtype = notepadList[index].boardtype;
                var board_color_index = notepadList[index].board_color_index;
                var text_color_index = notepadList[index].text_color_index;

                $("#notepad_content").val(notepadList[index].content);
                $("#spNotepadPreview").html(notepadList[index].content);
                $("#spNotepadPreview").css("color", notepadList[index].color);

                $("#spBorderPreview").css("color", notepadList[index].boardcolor);
                $("#spBorderPreview").html(notepadList[index].boardtype);
                $('.rdoTextPlayMode').find('input')[notepadList[index].textplaymode].checked = true;

                $("#tblNotepadPreviewBtn").css("background-color", board_color);
                if (boardtype == 1) {
                    $("#tblNotepadPreviewBtn").removeClass("clsTableRightRadius").removeClass("clsTableRadius");
                    $("#tblNotepadPreviewBtn").attr("background", "");
                }
                else if (boardtype == 2) {
                    $("#tblNotepadPreviewBtn").removeClass("clsTableRadius").addClass("clsTableRightRadius");
                    $("#tblNotepadPreviewBtn").attr("background", "img/icon_textbox0" + type + ".png");
                }
                else if (boardtype == 3) {
                    $("#tblNotepadPreviewBtn").removeClass("clsTableRightRadius").addClass("clsTableRadius");
                    $("#tblNotepadPreviewBtn").attr("background", "");
                }
                else if (boardtype == 5) {
                    $("#tblNotepadPreviewBtn").css("background-color", "transparent");
                    $("#tblNotepadPreviewBtn").removeClass("clsTableRightRadius").removeClass("clsTableRadius");
                    $("#tblNotepadPreviewBtn").attr("background", "img/icon_textbox0" + boardtype + "_" + board_color_index + ".png");
                }


                $(".clsColorBtnSel").removeClass("clsColorBtnSel");
                $("#tdBoardTypeBtn" + boardtype).addClass("clsBoardTypeSel");
                $("#tdBoardColorBtn" + board_color_index).addClass("clsColorBtnSel");
                $("#tdNotepadColorBtn" + text_color_index).addClass("clsColorBtnSel");
            }
            else {
                $('.rdoTextPlayMode').find('input')[0].checked = true;
                $("#spNotepadPreview").html("텍스트를 입력해주세요.");
                $("#spNotepadPreview").css("color", "#999999");
                //                        $("#spBorderPreview").css("color", "#999999");
                $("#spBorderPreview").html("0");
                $("#notepad_rd1")[0].checked = true;

                $("#tblNotepadPreviewBtn").css("background-color", "#FFFFFF");

                $(".clsColorBtnSel").removeClass("clsColorBtnSel");
                $("#tdBoardTypeBtn1").addClass("clsBoardTypeSel");
                $("#tdBoardColorBtn1").addClass("clsColorBtnSel");
                $("#tdNotepadColorBtn1").addClass("clsColorBtnSel");
            }
            showPopup("dvText");
        }
        else if (objectid.indexOf("audio_") == 0) {
            var index = objectid.substr(6);
            if (audioList[index] == null) {
                //$("#audio_file_text").val("사운드파일");
                $('.rdbBGM1').find('input')[0].checked = true;
                $('.trShowBGMMode').css("display", "none");
                $('.trCustomBGMMode').css("display", "none");
                //$('.tblNorBGMMode').css("display", "none");                        
            }
            else {
                // 일반형/3D사운드플레이형/....
                if (audioList[index].type == 0)
                    $("#audiobtn_rd1")[0].checked = true;
                else if (audioList[index].type == 1)
                    $("#audiobtn_rd2")[0].checked = true;
                else if (audioList[index].type == 2)
                    $("#audiobtn_rd3")[0].checked = true;
                // 실행옵션
                /*if (audioList[index].run_opt == 0) {
                $("#audiorun_rd1")[0].checked = true;
                }
                else if (audioList[index].run_opt == 1) {
                $("#audiorun_rd2")[0].checked = true;
                }*/
                var color_index = audioList[index].color_index;   // 
                var mode_index = audioList[index].mode_index;   // 

                var btnkind = audioList[index].btnkind;   // 표시안함, 기본버튼, 커스텀버튼
                var btntype = audioList[index].btntype;   // BGM, SOUND
                var color = audioList[index].color;       // 기본버튼 색상
                $('.rdbBGM1').find('input')[btnkind].checked = true;
                // 표시안함/기본버튼/커스텀버튼
                if (btnkind == 0) {
                    $('.trShowBGMMode').css("display", "none");
                    $('.trCustomBGMMode').css("display", "none");
                }
                else if (btnkind == 1) {
                    $('.trShowBGMMode').css("display", "");
                    $('.trCustomBGMMode').css("display", "none");
                }
                else {
                    $('.trShowBGMMode').css("display", "none");
                    $('.trCustomBGMMode').css("display", "");
                }
                $("#spNorBGMLabel").html(btntype == 1 ? "BGM" : "사운드");
                $("#spNorBGMLabel").css("color", color);
                $("#imgCustomBGM").attr("src", "img/icon_bgm0" + (btntype == 0 ? 1 : 2) + ".png");

                //$("#audio_file_text").val(audioList[index].url);
            }
            showPopup("dvBGM");
        }
        else if (objectid.indexOf("chromakey_") == 0) {
            var index = objectid.substr(10);
            if (chromakeyList[index] == null) {
                $("#chromakeyview_rd1")[0].checked = true;
                $("#chromakeyrun_rd1")[0].checked = true;
            }
            else {
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
            }
            showPopup("dvChromaKey");
        }
    });
}