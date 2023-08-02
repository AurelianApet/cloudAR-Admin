function init_objects() {
    
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

    $.ajax({
        url: "getXML.aspx?isscan=0&content_id=" + SERVER_ID,
        type: 'POST',
        datatype: "xml",
        async: false,
        success: function (data) {
            //xml을 받아서 파싱해야 한다.
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
            var pdfs = $(xmlDoc).find("pdf");
            var linkvideos = $(xmlDoc).find("linkvideo");

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
            pdf_counter = pdfs.length;
            linkvideo_counter = linkvideos.length;

            //총 갯수 초기화
            counter = slide_counter + img_counter + video_counter + web_counter + capture_counter + three_counter + tel_counter + googlemap_counter + notepad_counter + audio_counter + chromakey_counter + pdf_counter + linkvideo_counter;

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
                var run_opt = $(this).find("run_opt").text();
                var posX = $(this).find("posX").text();
                var posY = $(this).find("posY").text();
                var width = $(this).find("width").text();
                var height = $(this).find("height").text();
                var depth = $(this).find("depth").text();
                var objsize = $(this).find("objsize").text();

                if (run_opt == 0) {
                    imgList[i] = { url: url, type: type, run_opt: run_opt, objsize: objsize };
                } else if (run_opt == 1) {
                    var btn_title = $(this).find("btn_title").text();
                    var btn_mode_index = $(this).find("btn_mode_index").text();
                    var btn_color = $(this).find("btn_color").text();
                    if (btn_color == '#0') {
                        btn_color = "black";
                    }
                    var btn_color_index = $(this).find("btn_color_index").text();
                    var btn_textcolor = $(this).find("btn_textcolor").text();
                    if (btn_textcolor == '#0') {
                        btn_textcolor = "black";
                    }
                    var btn_textcolor_index = $(this).find("btn_textcolor_index").text();
                    var btn_width = $(this).find("btn_width").text();
                    var btn_height = $(this).find("btn_height").text();
                    var btn_posX = $(this).find("btn_posX").text();
                    var btn_posY = $(this).find("btn_posY").text();

                    var btn_obj = "<div class='tempclass' style='width:190px; height:40px; position:absolute;'>";
                    btn_obj += "<div class='tempcontent' >";
                    btn_obj += "<table cellpadding='0' cellspacing='0' align='center' style='border-collapse:collapse;' bgcolor='#F7F7F7'>";
                    btn_obj += "	<tr>";
                    btn_obj += "		<td width='190' height='40' style='border-width:1px; border-color:rgb(187,187,187); border-style:solid;' align='left'>";
                    btn_obj += "			<table cellpadding='0' cellspacing='0' width='175'>";
                    btn_obj += "				<tr>";
                    btn_obj += "					<td width='35' height='27' align='right'>";
                    btn_obj += "						<img src='img/cam_icon02.png' width='19' height='19' border='0'>";
                    btn_obj += "					</td>";
                    btn_obj += "					<td width='140' height='27' align='center'>";
                    btn_obj += "						<b><font face='돋움' color='#8C959A'><span style='font-size:10pt;' ></span></font></b>";
                    btn_obj += "					</td>";
                    btn_obj += "				</tr>";
                    btn_obj += "			</table>";
                    btn_obj += "		</td>";
                    btn_obj += "	</tr>";
                    btn_obj += "</table>";
                    btn_obj += "</div>";

                    jQuery(btn_obj).appendTo("#editframe");
                    $(".tempcontent" + " img").attr("src", "img/cam_icon02.png");
                    $(".tempcontent" + " span").css("color", btn_textcolor);
                    $(".tempcontent" + " span").html(btn_title);

                    $(".tempcontent > table").css("background-color", btn_color);

                    $(".tempclass").attr("id", "img_" + i + "_btn");
                    $("#img_" + i + "_btn").removeClass("tempclass").addClass("dragged_object");

                    $(".tempclass").removeClass("tempclass");
                    $(".tempcontent").removeClass("tempcontent");

                    $("#img_" + i + "_btn").css({ "left": btn_posX * unitX, "top": btn_posY * unitY, "width": btn_width * unitX, "height": btn_height * unitY, "z-index": i });
                    $("#img_" + i + "_btn").draggable({
                        containment: "parent"
                    });

                    imgList[i] = { url: url, type: type, run_opt: run_opt, objsize: objsize, btn_mode_index: btn_mode_index, btn_color_index: btn_color_index, btn_textcolor_index: btn_textcolor_index };

                } else if (run_opt == 2) {
                    var imgbtn_url = $(this).find("imgbtn_url").text();
                    var imgbtn_width = $(this).find("imgbtn_width").text();
                    var imgbtn_height = $(this).find("imgbtn_height").text();
                    var imgbtn_posX = $(this).find("imgbtn_posX").text();
                    var imgbtn_posY = $(this).find("imgbtn_posY").text();

                    var imgbtn_obj = '<div id="temp" style="width: 100px; height:auto; position:absolute">';
                    imgbtn_obj += '<img style="width:100%; height:100%" src="' + imgbtn_url + '"></img>';
                    imgbtn_obj += "</div>";
                    jQuery(imgbtn_obj).appendTo("#editframe");

                    $("#temp").attr("id", "img_" + i + "_imgbtn");
                    $("#img_" + i + "_imgbtn").css({ "left": imgbtn_posX * unitX, "top": imgbtn_posY * unitY, "width": imgbtn_width * unitX, "height": imgbtn_height * unitY, "z-index": i });
                    $("#img_" + i + "_imgbtn").addClass("dragged_object");
                    //크기조종
                    $("#img_" + i + "_imgbtn").draggable({
                        containment: "parent"
                    });

                    $("#img_" + i + "_imgbtn").resizable({
                        aspectRatio: true,
                        containment: "parent"
                    });

                    imgList[i] = { url: url, type: type, run_opt: run_opt, objsize: objsize };

                }

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

            /*PDF 오브젝트 구현*/
            i = 0;
            $(pdfs).each(function () {
                i++;
                var backurl = encodeURI($(this).find("backurl").text());
                var name = encodeURI($(this).find("name").text());
                var pagecount = $(this).find("pagecount").text();
                var run_opt = $(this).find("run_opt").text();
                var objsize = $(this).find("objsize").text();
                var depth = $(this).find("depth").text();
                var posX = $(this).find("posX").text();
                var posY = $(this).find("posY").text();
                var width = $(this).find("width").text();
                var height = $(this).find("height").text();

                var empty_obj2 = "<div id='temp' class='tempclass' style='width:190px; height:40px; position:absolute;'>";
                empty_obj2 += "<div class='tempcontent' >";
                empty_obj2 += "<table cellpadding='0' cellspacing='0' align='center' style='border-collapse:collapse;' bgcolor='#F7F7F7'>";
                empty_obj2 += "	<tr>";
                empty_obj2 += "		<td width='190' height='40' style='border-width:1px; border-color:rgb(187,187,187); border-style:solid;' align='left'>";
                empty_obj2 += "			<table cellpadding='0' cellspacing='0' width='175'>";
                empty_obj2 += "				<tr>";
                empty_obj2 += "					<td width='35' height='27' align='right'>";
                empty_obj2 += "						<img src='img/cam_icon11.png' width='19' height='19' border='0'>";
                empty_obj2 += "					</td>";
                empty_obj2 += "					<td width='140' height='27' align='center'>";
                empty_obj2 += "						<b><font face='돋움' color='#8C959A'><span style='font-size:10pt;' >PDF viewer</span></font></b>";
                empty_obj2 += "					</td>";
                empty_obj2 += "				</tr>";
                empty_obj2 += "			</table>";
                empty_obj2 += "		</td>";
                empty_obj2 += "	</tr>";
                empty_obj2 += "</table>";
                empty_obj2 += "</div>";

                if (run_opt == 0) {
                    element = empty_obj2 + panel_obj;
                    jQuery(element).appendTo("#editframe");
                    $(".tempcontent" + " img").attr("src", "img/cam_icon11.png");
                    $(".tempcontent" + " span").css("color", "#999999");
                    $(".tempcontent" + " span").html("PDF viewer");
                    $(".tempcontent > table").css("background-color", "#FFFFFF");
                    $(".tempclass").removeClass("tempclass");
                    $(".tempcontent").removeClass("tempcontent");

                    $("#temp").css({ "left": posX * unitX, "top": posY * unitY });
                    $("#temp").css({ "z-index": depth });

                    $("#temp").addClass("dragged_object");
                    $("#temp").attr("id", "pdf_" + i);
                    //드래깅가능 설정

                    pdfList[i] = { backurl: "none", name: name, pagecount: pagecount, run_opt: run_opt, objsize: objsize };

                } else if (run_opt == 1) {
                    var title = $(this).find("title").text();
                    var color = $(this).find("color").text();
                    if (color == '#0') {
                        color = "black";
                    }
                    var textcolor = $(this).find("textcolor").text();
                    if (textcolor == '#0') {
                        textcolor = "black";
                    }
                    var mode_index = $(this).find("mode_index").text();
                    var color_index = $(this).find("color_index").text();
                    var textcolor_index = $(this).find("textcolor_index").text();

                    element = empty_obj2 + panel_obj;
                    jQuery(element).appendTo("#editframe");
                    $(".tempcontent" + " img").attr("src", "img/cam_icon11.png");
                    $(".tempcontent" + " span").css("color", textcolor);
                    $(".tempcontent" + " span").html(title);
                    $(".tempcontent > table").css("background-color", color);
                    $(".tempclass").removeClass("tempclass");
                    $(".tempcontent").removeClass("tempcontent");


                    $("#temp").css({ "left": posX * unitX, "top": posY * unitY, "width": width * unitX, "height": height * unitY });
                    $("#temp").css({ "z-index": depth });

                    $("#temp").addClass("dragged_object");
                    $("#temp").attr("id", "pdf_" + i);
                    //드래깅가능 설정
                    $("#pdf_" + i).draggable({
                        containment: "parent"
                    });

                    pdfList[i] = { backurl: "none", name: name, pagecount: pagecount, run_opt: run_opt, objsize: objsize, title: title, mode_index: mode_index, color: color, color_index: color_index, textcolor: textcolor, textcolor_index: textcolor_index };

                } else if (run_opt == 2) {

                    var element = '<div id="temp" style="min-width:98px; width: 100px; height:auto; position:absolute">';
                    element += '<img style="width:100%; height:100%" src="' + backurl + '"></img>';
                    //패널 추가
                    element += panel_obj;

                    jQuery(element).appendTo("#editframe");
                    if (pdfList[i] != null) {
                        $("#temp").css({ "width": width * unitX, "height": height * unitY });
                    }
                    $("#temp").css({ "left": posX * unitX, "top": posY * unitY });
                    $("#temp").css({ "z-index": depth });
                    $("#temp").addClass("dragged_object");
                    $("#temp").attr("id", "pdf_" + i);
                    //크기조종
                    $("#pdf_" + i).draggable({
                        containment: "parent"
                    });
                    $("#pdf_" + i).resizable({
                        aspectRatio: true,
                        containment: "parent"
                    });

                    //디비에 등록
                    pdfList[i] = { backurl: backurl, name: name, pagecount: pagecount, run_opt: run_opt, objsize: objsize };

                }
            });
            /***PDF 오브젝트 구현***/

            /*슬라이드 오브젝트 구현*/
            i = 0;
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

                var run_opt = $(this).find("run_opt").text();       // 실행옵션
                var type = $(this).find("type").text();             // 일반, 3D
                var showtype = $(this).find("showtype").text();     // 전환모드
                var playtype = $(this).find("playtype").text();     // 재생모드
                var timediff = $(this).find("timediff").text();

                var prev_count = $(this).find("prev_count").text();
                var posX = $(this).find("posX").text();
                var posY = $(this).find("posY").text();
                var width = $(this).find("width").text();
                var height = $(this).find("height").text();
                var depth = $(this).find("depth").text();
                var width = $(this).find("width").text();
                var objsize = $(this).find("objsize").text();

                if (run_opt == 0) {
                    slideList[i] = { url1: url1, url2: url2, url3: url3, url4: url4, url5: url5, url6: url6, url7: url7, url8: url8, url9: url9, url10: url10, run_opt: run_opt, type: type, showtype: showtype, playtype: playtype, timediff: timediff, prev_count: prev_count, objsize: objsize };
                } else if (run_opt == 1) {
                    var btn_title = $(this).find("btn_title").text();
                    var btn_mode_index = $(this).find("btn_mode_index").text();
                    var btn_color = $(this).find("btn_color").text();
                    if (btn_color == '#0') {
                        btn_color = "black";
                    }
                    var btn_color_index = $(this).find("btn_color_index").text();
                    var btn_textcolor = $(this).find("btn_textcolor").text();
                    if (btn_textcolor == '#0') {
                        btn_textcolor = "black";
                    }
                    var btn_textcolor_index = $(this).find("btn_textcolor_index").text();
                    var btn_width = $(this).find("btn_width").text();
                    var btn_height = $(this).find("btn_height").text();
                    var btn_posX = $(this).find("btn_posX").text();
                    var btn_posY = $(this).find("btn_posY").text();

                    var btn_obj = "<div class='tempclass' style='width:190px; height:40px; position:absolute;'>";
                    btn_obj += "<div class='tempcontent' >";
                    btn_obj += "<table cellpadding='0' cellspacing='0' align='center' style='border-collapse:collapse;' bgcolor='#F7F7F7'>";
                    btn_obj += "	<tr>";
                    btn_obj += "		<td width='190' height='40' style='border-width:1px; border-color:rgb(187,187,187); border-style:solid;' align='left'>";
                    btn_obj += "			<table cellpadding='0' cellspacing='0' width='175'>";
                    btn_obj += "				<tr>";
                    btn_obj += "					<td width='35' height='27' align='right'>";
                    btn_obj += "						<img src='img/cam_icon08.png' width='19' height='19' border='0'>";
                    btn_obj += "					</td>";
                    btn_obj += "					<td width='140' height='27' align='center'>";
                    btn_obj += "						<b><font face='돋움' color='#8C959A'><span style='font-size:10pt;' ></span></font></b>";
                    btn_obj += "					</td>";
                    btn_obj += "				</tr>";
                    btn_obj += "			</table>";
                    btn_obj += "		</td>";
                    btn_obj += "	</tr>";
                    btn_obj += "</table>";
                    btn_obj += "</div>";

                    jQuery(btn_obj).appendTo("#editframe");
                    $(".tempcontent" + " img").attr("src", "img/cam_icon08.png");
                    $(".tempcontent" + " span").css("color", btn_textcolor);
                    $(".tempcontent" + " span").html(btn_title);

                    $(".tempcontent > table").css("background-color", btn_color);

                    $(".tempclass").attr("id", "slide_" + i + "_btn");
                    $("#slide_" + i + "_btn").removeClass("tempclass").addClass("dragged_object");

                    $(".tempclass").removeClass("tempclass");
                    $(".tempcontent").removeClass("tempcontent");

                    $("#slide_" + i + "_btn").css({ "left": btn_posX * unitX, "top": btn_posY * unitY, "width": btn_width * unitX, "height": btn_height * unitY, "z-index": i });
                    $("#slide_" + i + "_btn").draggable({
                        containment: "parent"
                    });

                    slideList[i] = { url1: url1, url2: url2, url3: url3, url4: url4, url5: url5, url6: url6, url7: url7, url8: url8, url9: url9, url10: url10, run_opt: run_opt, type: type, showtype: showtype, playtype: playtype, timediff: timediff, prev_count: prev_count, objsize: objsize, btn_mode_index: btn_mode_index, btn_color_index: btn_color_index, btn_textcolor_index: btn_textcolor_index };

                } else if (run_opt == 2) {
                    var imgbtn_url = $(this).find("imgbtn_url").text();
                    var imgbtn_width = $(this).find("imgbtn_width").text();
                    var imgbtn_height = $(this).find("imgbtn_height").text();
                    var imgbtn_posX = $(this).find("imgbtn_posX").text();
                    var imgbtn_posY = $(this).find("imgbtn_posY").text();

                    var imgbtn_obj = '<div id="temp" style="width: 100px; height:auto; position:absolute">';
                    imgbtn_obj += '<img style="width:100%; height:100%" src="' + imgbtn_url + '"></img>';
                    imgbtn_obj += "</div>";
                    jQuery(imgbtn_obj).appendTo("#editframe");

                    $("#temp").attr("id", "slide_" + i + "_imgbtn");
                    $("#slide_" + i + "_imgbtn").css({ "left": imgbtn_posX * unitX, "top": imgbtn_posY * unitY, "width": imgbtn_width * unitX, "height": imgbtn_height * unitY, "z-index": i });
                    $("#slide_" + i + "_imgbtn").addClass("dragged_object");
                    //크기조종
                    $("#slide_" + i + "_imgbtn").draggable({
                        containment: "parent"
                    });

                    $("#slide_" + i + "_imgbtn").resizable({
                        aspectRatio: true,
                        containment: "parent"
                    });

                    slideList[i] = { url1: url1, url2: url2, url3: url3, url4: url4, url5: url5, url6: url6, url7: url7, url8: url8, url9: url9, url10: url10, run_opt: run_opt, type: type, showtype: showtype, playtype: playtype, timediff: timediff, prev_count: prev_count, objsize: objsize };

                }

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
            /***슬라이드 오브젝트 구현***/

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

                if (run_opt == 0 || run_opt == 1) {
                    videoList[i] = { url: url, type: type, run_opt: run_opt, objsize: objsize };
                } else if (run_opt == 2) {
                    var btn_title = $(this).find("btn_title").text();
                    var btn_mode_index = $(this).find("btn_mode_index").text();
                    var btn_color = $(this).find("btn_color").text();
                    if (btn_color == '#0') {
                        btn_color = "black";
                    }
                    var btn_color_index = $(this).find("btn_color_index").text();
                    var btn_textcolor = $(this).find("btn_textcolor").text();
                    if (btn_textcolor == '#0') {
                        btn_textcolor = "black";
                    }
                    var btn_textcolor_index = $(this).find("btn_textcolor_index").text();
                    var btn_width = $(this).find("btn_width").text();
                    var btn_height = $(this).find("btn_height").text();
                    var btn_posX = $(this).find("btn_posX").text();
                    var btn_posY = $(this).find("btn_posY").text();

                    var btn_obj = "<div class='tempclass' style='width:190px; height:40px; position:absolute;'>";
                    btn_obj += "<div class='tempcontent' >";
                    btn_obj += "<table cellpadding='0' cellspacing='0' align='center' style='border-collapse:collapse;' bgcolor='#F7F7F7'>";
                    btn_obj += "	<tr>";
                    btn_obj += "		<td width='190' height='40' style='border-width:1px; border-color:rgb(187,187,187); border-style:solid;' align='left'>";
                    btn_obj += "			<table cellpadding='0' cellspacing='0' width='175'>";
                    btn_obj += "				<tr>";
                    btn_obj += "					<td width='35' height='27' align='right'>";
                    btn_obj += "						<img src='img/cam_icon09.png' width='19' height='19' border='0'>";
                    btn_obj += "					</td>";
                    btn_obj += "					<td width='140' height='27' align='center'>";
                    btn_obj += "						<b><font face='돋움' color='#8C959A'><span style='font-size:10pt;' ></span></font></b>";
                    btn_obj += "					</td>";
                    btn_obj += "				</tr>";
                    btn_obj += "			</table>";
                    btn_obj += "		</td>";
                    btn_obj += "	</tr>";
                    btn_obj += "</table>";
                    btn_obj += "</div>";

                    jQuery(btn_obj).appendTo("#editframe");
                    $(".tempcontent" + " img").attr("src", "img/cam_icon01.png");
                    $(".tempcontent" + " span").css("color", btn_textcolor);
                    $(".tempcontent" + " span").html(btn_title);

                    $(".tempcontent > table").css("background-color", btn_color);

                    $(".tempclass").attr("id", "video_" + i + "_btn");
                    $("#video_" + i + "_btn").removeClass("tempclass").addClass("dragged_object");

                    $(".tempclass").removeClass("tempclass");
                    $(".tempcontent").removeClass("tempcontent");

                    $("#video_" + i + "_btn").css({ "left": btn_posX * unitX, "top": btn_posY * unitY, "width": btn_width * unitX, "height": btn_height * unitY, "z-index": i });
                    $("#video_" + i + "_btn").draggable({
                        containment: "parent"
                    });

                    videoList[i] = { url: url, type: type, run_opt: run_opt, objsize: objsize, btn_mode_index: btn_mode_index, btn_color_index: btn_color_index, btn_textcolor_index: btn_textcolor_index };

                } else if (run_opt == 3) {
                    var imgbtn_url = $(this).find("imgbtn_url").text();
                    var imgbtn_width = $(this).find("imgbtn_width").text();
                    var imgbtn_height = $(this).find("imgbtn_height").text();
                    var imgbtn_posX = $(this).find("imgbtn_posX").text();
                    var imgbtn_posY = $(this).find("imgbtn_posY").text();

                    var imgbtn_obj = '<div id="temp" style="width: 100px; height:auto; position:absolute">';
                    imgbtn_obj += '<img style="width:100%; height:100%" src="' + imgbtn_url + '"></img>';
                    imgbtn_obj += "</div>";
                    jQuery(imgbtn_obj).appendTo("#editframe");

                    $("#temp").attr("id", "video_" + i + "_imgbtn");
                    $("#video_" + i + "_imgbtn").css({ "left": imgbtn_posX * unitX, "top": imgbtn_posY * unitY, "width": imgbtn_width * unitX, "height": imgbtn_height * unitY, "z-index": i });
                    $("#video_" + i + "_imgbtn").addClass("dragged_object");
                    //크기조종
                    $("#video_" + i + "_imgbtn").draggable({
                        containment: "parent"
                    });

                    $("#video_" + i + "_imgbtn").resizable({
                        aspectRatio: true,
                        containment: "parent"
                    });

                    videoList[i] = { url: url, type: type, run_opt: run_opt, objsize: objsize };

                }


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

                $("#video_" + i).draggable({
                    containment: "parent"
                });
                $("#video_" + i).resizable({
                    aspectRatio: true,
                    containment: "parent"
                });

            });
            /***비디오 오브젝트 구현***/

            /*링크비디오 오브젝트 구현*/
            i = 0;
            $(linkvideos).each(function () {
                i++;
                var link_url = encodeURI($(this).find("link_url").text());
                var data_url = encodeURI($(this).find("data_url").text());
                var type = $(this).find("type").text();
                var run_opt = $(this).find("run_opt").text();
                var posX = $(this).find("posX").text();
                var posY = $(this).find("posY").text();
                var width = $(this).find("width").text();
                var height = $(this).find("height").text();
                var depth = $(this).find("depth").text();
                var objsize = $(this).find("objsize").text();

                var element = "<div id='temp' style='position:absolute'>";
                element += "<video width='100%' height='100%' controls>";
                element += "<source src=" + data_url + ">";
                element += "</video>";
                //패널 추가
                element += panel_obj;
                jQuery(element).appendTo("#editframe");
                $("#temp").css({ "width": width * unitX, "height": height * unitY });
                $("#temp").css({ "left": oX + posX * unitX - width * unitX / 2, "top": oY - posY * unitY - height * unitY / 2 });
                $("#temp").css({ "z-index": depth });
                $("#temp").addClass("dragged_object");
                $("#temp").attr("id", "linkvideo_" + i);

                $("#linkvideo_" + i).draggable({
                    containment: "parent"
                });
                $("#linkvideo_" + i).resizable({
                    aspectRatio: true,
                    containment: "parent"
                });

                linkvideoList[i] = { link_url: link_url, data_url: data_url, type: type, run_opt: run_opt, objsize: objsize };
            });
            /***링크비디오 오브젝트 구현***/



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
                if (color == '#0') {
                    color = "black";
                }
                var title = $(this).find("title").text();
                var color_index = $(this).find("color_index").text();
                var mode_index = $(this).find("mode_index").text();
                var view = $(this).find("view").text();
                var backurl = encodeURI($(this).find("backurl").text());
                var objsize = $(this).find("objsize").text();
                var textcolor = $(this).find("textcolor").text();
                if (textcolor == '#0') {
                    textcolor = "black";
                }
                var textcolor_index = $(this).find("textcolor_index").text();
                var element = "<div id='temp' style='min-width:98px; width:100px; height:auto; position:absolute'>";
                if (type == 1)
                    element += "<img style='width:100%; height;100%' src=" + backurl + ">";
                else {
                    element = empty_obj2;
                }
                //패널 추가
                element += panel_obj;
                jQuery(element).appendTo("#editframe");
                if (type == 1)
                    $("#temp").css({ "width": width * unitX, "height": height * unitY });
                else {
                    $(".tempcontent" + " img").attr("src", "img/cam_icon03.png");
                    $(".tempcontent" + " span").css("color", textcolor);
                    $(".tempcontent" + " span").html(title);
                    $(".tempcontent > table").css("background-color", color);
                    $(".tempclass").removeClass("tempclass");
                    $(".tempcontent").removeClass("tempcontent");
                }

                $("#temp").css({ "left": oX + posX * unitX - width * unitX / 2, "top": oY - posY * unitY - (type == 0 ? 0 : height * unitY / 2) });
                $("#temp").css({ "z-index": depth });
                $("#temp").addClass("dragged_object");
                $("#temp").attr("id", "web_" + i);

                webList[i] = { backurl: backurl, url: url, view: view, type: type, objsize: objsize, color: color, title: title, color_index: color_index, mode_index: mode_index, textcolor: textcolor, textcolor_index: textcolor_index };
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
                if (color == '#0') {
                    color = "black";
                }
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

                var angle = front_angle;
                element = '<div id="temp" style="min-width:61px; min-height:55px;width:122px; height:110px; position:absolute">';

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
                } else {
                    element += '<img style="width:100%; height:100%" src="img/3Dobject.png"></img>';
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
                if (color == '#0') {
                    color = "black";
                }
                var title = $(this).find("title").text();
                var color_index = $(this).find("color_index").text();
                var mode_index = $(this).find("mode_index").text();
                var threemode = $(this).find("threemode").text();

                var textcolor = $(this).find("textcolor").text();
                if (textcolor == '#0') {
                    textcolor = "black";
                }
                var textcolor_index = $(this).find("textcolor_index").text();

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
                    $(".tempcontent" + " span").css("color", textcolor);
                    $(".tempcontent" + " span").html(title);
                    $(".tempcontent > table").css("background-color", color);
                    $(".tempclass").removeClass("tempclass");
                    $(".tempcontent").removeClass("tempcontent");
                }
                $("#temp").css({ "left": oX + posX * unitX - width * unitX / 2, "top": oY - posY * unitY - height * unitY / 2 });
                $("#temp").css({ "z-index": depth });
                $("#temp").addClass("dragged_object");
                $("#temp").attr("id", "tel_" + i);

                telList[i] = { tel_no: tel_no, type: type, color: color, title: title, color_index: color_index, mode_index: mode_index, threemode: threemode, backurl: backurl, objsize: objsize, textcolor: textcolor, textcolor_index: textcolor_index };
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
                if (color == '#0') {
                    color = "black";
                }
                var color_index = $(this).find("color_index").text();
                var mode_index = $(this).find("mode_index").text();
                var title = $(this).find("title").text();

                var textcolor = $(this).find("textcolor").text();
                if (textcolor == '#0') {
                    textcolor = "black";
                }
                var textcolor_index = $(this).find("textcolor_index").text();

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
                    $(".tempcontent" + " span").css("color", textcolor);
                    $(".tempcontent" + " span").html(title);
                    $(".tempcontent > table").css("background-color", color);
                    $(".tempclass").removeClass("tempclass");
                    $(".tempcontent").removeClass("tempcontent");
                }
                $("#temp").css({ "left": oX + posX * unitX - width * unitX / 2, "top": oY - posY * unitY - height * unitY / 2 });
                $("#temp").css({ "z-index": depth });
                $("#temp").addClass("dragged_object");
                $("#temp").attr("id", "googlemap_" + i);

                googlemapList[i] = { coordinate: coordinate, type: type, title: title, color: color, color_index: color_index, mode_index: mode_index, backurl: backurl, objsize: objsize, textcolor: textcolor, textcolor_index: textcolor_index };
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
                if (boardcolor == '#0') {
                    boardcolor = "black";
                }
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

                $(".tempcontent > table").css("background-color", boardcolor);
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
                else if (boardtype == 4) {
                    $(".tempcontent > table").css("background-color", "transparent");
                    $(".tempcontent > table").removeClass("clsTableRightRadius").removeClass("clsTableRadius");
                    $(".tempcontent > table").attr("background", "img/icon_textbox03_" + board_color_index + ".png");
                }

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
                if (color == '#0') {
                    color = "black";
                }
                var posX = $(this).find("posX").text();
                var posY = $(this).find("posY").text();
                var width = $(this).find("width").text();
                var height = $(this).find("height").text();
                var depth = $(this).find("depth").text();
                var width = $(this).find("width").text();
                var objsize = $(this).find("objsize").text();

                var color_index = $(this).find("color_index").text();
                var mode_index = $(this).find("mode_index").text();

                var textcolor = $(this).find("textcolor").text();
                if (textcolor == '#0') {
                    textcolor = "black";
                }
                var textcolor_index = $(this).find("textcolor_index").text();

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
                        $(".tempcontent" + " span").css("color", textcolor);
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

                audioList[i] = { url: url, btn_url: btn_url, type: type, run_opt: run_opt, btnkind: btnkind, color: color, objsize: objsize, color_index: color_index, mode_index: mode_index, textcolor: textcolor, textcolor_index: textcolor_index };
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

                if (run_opt == 0 || run_opt == 1) {
                    chromakeyList[i] = { url: url, type: type, run_opt: run_opt, objsize: objsize };
                } else if (run_opt == 2) {
                    var btn_title = $(this).find("btn_title").text();
                    var btn_mode_index = $(this).find("btn_mode_index").text();
                    var btn_color = $(this).find("btn_color").text();
                    if (btn_color == '#0') {
                        btn_color = "black";
                    }
                    var btn_color_index = $(this).find("btn_color_index").text();
                    var btn_textcolor = $(this).find("btn_textcolor").text();
                    if (btn_textcolor == '#0') {
                        btn_textcolor = "black";
                    }
                    var btn_textcolor_index = $(this).find("btn_textcolor_index").text();
                    var btn_width = $(this).find("btn_width").text();
                    var btn_height = $(this).find("btn_height").text();
                    var btn_posX = $(this).find("btn_posX").text();
                    var btn_posY = $(this).find("btn_posY").text();

                    var btn_obj = "<div class='tempclass' style='width:190px; height:40px; position:absolute;'>";
                    btn_obj += "<div class='tempcontent' >";
                    btn_obj += "<table cellpadding='0' cellspacing='0' align='center' style='border-collapse:collapse;' bgcolor='#F7F7F7'>";
                    btn_obj += "	<tr>";
                    btn_obj += "		<td width='190' height='40' style='border-width:1px; border-color:rgb(187,187,187); border-style:solid;' align='left'>";
                    btn_obj += "			<table cellpadding='0' cellspacing='0' width='175'>";
                    btn_obj += "				<tr>";
                    btn_obj += "					<td width='35' height='27' align='right'>";
                    btn_obj += "						<img src='img/cam_icon10.png' width='19' height='19' border='0'>";
                    btn_obj += "					</td>";
                    btn_obj += "					<td width='140' height='27' align='center'>";
                    btn_obj += "						<b><font face='돋움' color='#8C959A'><span style='font-size:10pt;' ></span></font></b>";
                    btn_obj += "					</td>";
                    btn_obj += "				</tr>";
                    btn_obj += "			</table>";
                    btn_obj += "		</td>";
                    btn_obj += "	</tr>";
                    btn_obj += "</table>";
                    btn_obj += "</div>";

                    jQuery(btn_obj).appendTo("#editframe");
                    $(".tempcontent" + " img").attr("src", "img/cam_icon10.png");
                    $(".tempcontent" + " span").css("color", btn_textcolor);
                    $(".tempcontent" + " span").html(btn_title);

                    $(".tempcontent > table").css("background-color", btn_color);

                    $(".tempclass").attr("id", "chromakey_" + i + "_btn");
                    $("#chromakey_" + i + "_btn").removeClass("tempclass").addClass("dragged_object");

                    $(".tempclass").removeClass("tempclass");
                    $(".tempcontent").removeClass("tempcontent");

                    $("#chromakey_" + i + "_btn").css({ "left": btn_posX * unitX, "top": btn_posY * unitY, "width": btn_width * unitX, "height": btn_height * unitY, "z-index": i });
                    $("#chromakey_" + i + "_btn").draggable({
                        containment: "parent"
                    });

                    chromakeyList[i] = { url: url, type: type, run_opt: run_opt, objsize: objsize, btn_mode_index: btn_mode_index, btn_color_index: btn_color_index, btn_textcolor_index: btn_textcolor_index };

                } else if (run_opt == 3) {
                    var imgbtn_url = $(this).find("imgbtn_url").text();
                    var imgbtn_width = $(this).find("imgbtn_width").text();
                    var imgbtn_height = $(this).find("imgbtn_height").text();
                    var imgbtn_posX = $(this).find("imgbtn_posX").text();
                    var imgbtn_posY = $(this).find("imgbtn_posY").text();

                    var imgbtn_obj = '<div id="temp" style="width: 100px; height:auto; position:absolute">';
                    imgbtn_obj += '<img style="width:100%; height:100%" src="' + imgbtn_url + '"></img>';
                    imgbtn_obj += "</div>";
                    jQuery(imgbtn_obj).appendTo("#editframe");

                    $("#temp").attr("id", "chromakey_" + i + "_imgbtn");
                    $("#chromakey_" + i + "_imgbtn").css({ "left": imgbtn_posX * unitX, "top": imgbtn_posY * unitY, "width": imgbtn_width * unitX, "height": imgbtn_height * unitY, "z-index": i });
                    $("#chromakey_" + i + "_imgbtn").addClass("dragged_object");
                    //크기조종
                    $("#chromakey_" + i + "_imgbtn").draggable({
                        containment: "parent"
                    });

                    $("#chromakey_" + i + "_imgbtn").resizable({
                        aspectRatio: true,
                        containment: "parent"
                    });

                    chromakeyList[i] = { url: url, type: type, run_opt: run_opt, objsize: objsize };

                }


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

        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
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
            var description = data.description;
            var is_board = parseInt(data.is_board);

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

                if (is_board == 1)
                    $("#cbxBoardStatus").attr("checked", true);
                else
                    $("#cbxBoardStatus").attr("checked", false);


                if (description == "") {
                    $("#img_cam_description").attr("src", "img/cam_description1.png");
                } else {
                    $("#img_cam_description").attr("src", "img/cam_description2.png");
                }

                $("#campain_description").val(description);


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