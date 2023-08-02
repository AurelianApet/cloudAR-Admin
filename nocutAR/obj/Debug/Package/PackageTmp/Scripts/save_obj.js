function z(n) { return (n.length == 5 ? '0' : '') + n; }

function colorToHex(color) {
    if (color.substr(0, 1) === '#') {
        return color;
    }
    if (color.substr(0, 4) == 'rgba')
        return "#0";
    var digits = /(.*?)rgb\((\d+), (\d+), (\d+)\)/.exec(color);

    var red = parseInt(digits[2]);
    var green = parseInt(digits[3]);
    var blue = parseInt(digits[4]);

    var rgb = blue | (green << 8) | (red << 16);    
    return digits[1] + '#' + z(rgb.toString(16));
}
function OnSave() {
    var title = $("#txtTitle").val();
    if (title == "") {
        alert("컴페인명을 등록해주세요.");
        return false;
    }
    if ($("#markImg").attr("src") == "") {
        alert("마커이미지를 등록해주세요.");
        return false;
    }

    /*
    contents디비에서 해당 캠페인의 marker_url값을 얻어와서 값이 비였다면 마커만 등록하는걸로 인식하도록 하는 모듈을 구성한다.
    */
    ShowProgress();
    $.ajax({
        url: "getContentData.aspx?id=" + CONTENT_ID,
        dataType: 'json',
        type: 'POST',
        success: function (data) {
            var marker_url = "";
            marker_url = data.marker_url;

            if (marker_url == "") {
                if (imgList[0] == null) {
                    /*마크이미지 세팅정보 디비에 보관*/
                    setMarkerImg($("#markImg").attr("src"));
                    $.ajax({
                        url: "VUpload.aspx?content_id=" + CONTENT_ID + "&imgPath=" + encodeURI($("#markImg").attr("src")) + "&type=add" + "&width=" + $("#markImg").width(),
                        type: "post",
                        async: false,
                        success: function (data, textStatus, jqXHR) {
                            var url = server_url + $("#markImg").attr("src");
                            var rate = $("#markImg").width() / $("#markImg").height();
                            $.ajax({
                                url: "setMarkerUpdateData.aspx?marker_url=" + encodeURI(url) + "&rate=" + rate + "&id=" + CONTENT_ID,
                                type: 'POST',
                                success: function (data) {
                                    //document.location = "EditContent.aspx?id=" + CONTENT_ID;
                                    //alert("마커이미지가 등록되었 습니다. 관리자의 승인이 있을때까지 기다려주십시오.");
                                },
                                error: function (XMLHttpRequest, textStatus, errorThrown) {
                                    alert("마커이미지 등록과정에 오류가 발생하였습니다.");
                                }
                            });

                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert("마커이미지 등록과정에 오류가 발생하였습니다.");
                        }
                    });
                }
                HideProgress();
                document.location = "detailContent.aspx?id=" + CONTENT_ID;
                return true;
            }

            var arrResult = new Array();
            var unitX = $("#markImg").width() / 100;
            var unitY = $("#markImg").height() / 100;
            var oX = $("#markImg").position().left;
            var oY = $("#markImg").position().top + $("#markImg").height();
            var unitX2 = $("#capture_detail_div").width() / 100;
            var unitY2 = $("#capture_detail_div").height() / 100;
            if (imgList[0] == null) {
                /*마크이미지 세팅정보 디비에 보관*/
                setMarkerImg($("#markImg").attr("src"));
                $.ajax({
                    url: "VUpload.aspx?content_id=" + CONTENT_ID + "&imgPath=" + encodeURI($("#markImg").attr("src")) + "&type=add" + "&width=" + $("#markImg").width(),
                    type: "post",
                    async: false,
                    success: function (data, textStatus, jqXHR) {
                        //document.location = "EditContent.aspx?id=" + CONTENT_ID;
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        //alert("마커이미지 등록과정에 오류가 발생하였습니다.");
                    }
                });
            }

            /***마크이미지 세팅정보 디비에 보관***/
            arrResult.push({
                obj: "marker",
                url: server_url + $("#markImg").attr("src"),
                depth: 1,
                width: 100,
                height: 100,
                rate: $("#markImg").width() / $("#markImg").height(),
                posX: 50,
                posY: 50
            });

            /*이미지보관부분*/
            for (i = 1; i < img_counter + 1; i++) {
                if (imgList[i] == null)
                    continue;
                if ($("#img_" + i).length == 0)
                    continue;
                arrResult.push({
                    obj: "image",
                    objsize: imgList[i].objsize,
                    url: imgList[i].url,
                    type: imgList[i].type,
                    depth: $("#img_" + i).css("z-index"),
                    width: $("#img_" + i).width() / unitX,
                    height: $("#img_" + i).height() / unitY,
                    posX: (($("#img_" + i).position().left + $("#img_" + i).width() / 2) - oX) / unitX,
                    posY: (oY - ($("#img_" + i).position().top + $("#img_" + i).height() / 2)) / unitY
                });
            }
            /***이미지보관부분***/

            /*슬라이드보관부분*/
            for (i = 1; i < slide_counter + 1; i++) {
                if (slideList[i] == null)
                    continue;
                if ($("#slide_" + i).length == 0)
                    continue;
                arrResult.push({
                    obj: "slide",
                    objsize: slideList[i].objsize,
                    btnsize: slideList[i].btnsize,
                    url1: slideList[i].url1,
                    url2: slideList[i].url2,
                    url3: slideList[i].url3,
                    url4: slideList[i].url4,
                    url5: slideList[i].url5,
                    url6: slideList[i].url6,
                    url7: slideList[i].url7,
                    url8: slideList[i].url8,
                    url9: slideList[i].url9,
                    url10: slideList[i].url10,

                    type: slideList[i].type,
                    playtype: slideList[i].playtype,
                    showtype: slideList[i].showtype,
                    prev_count: slideList[i].prev_count,
                    depth: $("#slide_" + i).css("z-index"),
                    width: $("#slide_" + i).width() / unitX,
                    height: $("#slide_" + i).height() / unitY,
                    posX: (($("#slide_" + i).position().left + $("#slide_" + i).width() / 2) - oX) / unitX,
                    posY: (oY - ($("#slide_" + i).position().top + $("#slide_" + i).height() / 2)) / unitY


                });
            }
            /***슬라이드보관부분***/

            /*비디오보관부분*/
            for (i = 1; i < video_counter + 1; i++) {
                if (videoList[i] == null)
                    continue;
                if ($("#video_" + i).length == 0)
                    continue;
                if (videoList[i].type != 0) {
                    arrResult.push({
                        obj: "video",
                        objsize: videoList[i].objsize,
                        type: videoList[i].type,
                        run_opt: videoList[i].run_opt,
                        url: videoList[i].url,
                        depth: $("#video_" + i).css("z-index"),
                        width: $("#video_" + i + " video").width() / unitX,
                        height: $("#video_" + i + " video").height() / unitY,
                        posX: (($("#video_" + i).position().left + $("#video_" + i + " video").width() / 2) - oX) / unitX,
                        posY: (oY - ($("#video_" + i).position().top + $("#video_" + i + " video").height() / 2)) / unitY
                    });
                }
                else {
                    arrResult.push({
                        obj: "video",
                        objsize: videoList[i].objsize,
                        type: videoList[i].type,
                        run_opt: videoList[i].run_opt,
                        url: videoList[i].url,
                        depth: $("#video_" + i).css("z-index"),
                        width: $("#video_" + i + " video").width() / unitX,
                        height: $("#video_" + i + " video").height() / unitY,
                        posX: (($("#video_" + i).position().left + $("#video_" + i + " video").width() / 2) - oX) / unitX,
                        posY: (oY - ($("#video_" + i).position().top + $("#video_" + i + " video").height() / 2)) / unitY
                    });
                }
            }
            /***비디오보관부분***/

            /*웹 보관부분*/
            for (i = 1; i < web_counter + 1; i++) {
                if (webList[i] == null)
                    continue;
                if ($("#web_" + i).length == 0)
                    continue;
                if (webList[i].type == 0) {
                    arrResult.push({
                        obj: "web",
                        objsize: webList[i].objsize,
                        url: webList[i].url,
                        type: webList[i].type,
                        view: webList[i].view,
                        color: colorToHex(webList[i].color),
                        title: webList[i].title,
                        color_index: webList[i].color_index,
                        mode_index: webList[i].mode_index,
                        backurl: "none",
                        depth: $("#web_" + i).css("z-index"),
                        width: $("#web_" + i).width() / unitX,
                        height: 50 / unitY,
                        posX: (($("#web_" + i).position().left + $("#web_" + i).width() / 2) - oX) / unitX,
                        posY: (oY - ($("#web_" + i).position().top)) / unitY
                        //posY: (oY - ($("#web_" + i).position().top + $("#web_"+ i + " img").height() / 2)) / unitY
                    });
                }
                else {
                    arrResult.push({
                        obj: "web",
                        objsize: webList[i].objsize,
                        url: webList[i].url,
                        type: webList[i].type,
                        view: webList[i].view,
                        color: "0",
                        title: "website",
                        color_index: "1",
                        mode_index: "1",
                        backurl: webList[i].backurl,
                        depth: $("#web_" + i).css("z-index"),
                        width: $("#web_" + i + " img").width() / unitX,
                        height: $("#web_" + i + " img").height() / unitY,
                        posX: (($("#web_" + i).position().left + $("#web_" + i).width() / 2) - oX) / unitX,
                        posY: (oY - ($("#web_" + i).position().top + $("#web_" + i + " img").height() / 2)) / unitY
                    });
                }
            }
            /***웹 보관부분***/

            /*캡쳐버튼 보관부분*/
            for (i = 1; i < capture_counter + 1; i++) {
                if (captureList[i] == null)
                    continue;
                if ($("#capture_" + i).length == 0)
                    continue;
                if (captureList[i].type == 0) {
                    arrResult.push({
                        obj: "capture",
                        objsize: captureList[i].objsize,
                        btnsize: captureList[i].btnsize,
                        backurl: "none",
                        type: captureList[i].type,
                        prev_count: captureList[i].prev_count,
                        slide1: captureList[i].slide1, width1: captureList[i].width1, height1: captureList[i].height1, posX1: captureList[i].posX1, posY1: captureList[i].posY1,
                        slide2: captureList[i].slide2, width2: captureList[i].width2, height2: captureList[i].height2, posX2: captureList[i].posX2, posY2: captureList[i].posY2,
                        slide3: captureList[i].slide3, width3: captureList[i].width3, height3: captureList[i].height3, posX3: captureList[i].posX3, posY3: captureList[i].posY3,
                        slide4: captureList[i].slide4, width4: captureList[i].width4, height4: captureList[i].height4, posX4: captureList[i].posX4, posY4: captureList[i].posY4,
                        slide5: captureList[i].slide5, width5: captureList[i].width5, height5: captureList[i].height5, posX5: captureList[i].posX5, posY5: captureList[i].posY5,
                        depth: $("#capture_" + i).css("z-index"),
                        width: $("#capture_" + i).width() / unitX,
                        height: $("#capture_" + i).height() / unitY,
                        posX: (($("#capture_" + i).position().left + $("#capture_" + i).width() / 2) - oX) / unitX,
                        posY: (oY - ($("#capture_" + i).position().top + $("#capture_" + i).height() / 2)) / unitY,
                        color: colorToHex(captureList[i].color),
                        title: captureList[i].title,
                        color_index: captureList[i].color_index,
                        buttontype: captureList[i].buttontype
                    });
                }
                else {
                    arrResult.push({
                        obj: "capture",
                        objsize: captureList[i].objsize,
                        btnsize: captureList[i].btnsize,
                        backurl: captureList[i].backurl,
                        type: captureList[i].type,
                        prev_count: captureList[i].prev_count,
                        slide1: captureList[i].slide1, width1: captureList[i].width1, height1: captureList[i].height1, posX1: captureList[i].posX1, posY1: captureList[i].posY1,
                        slide2: captureList[i].slide2, width2: captureList[i].width2, height2: captureList[i].height2, posX2: captureList[i].posX2, posY2: captureList[i].posY2,
                        slide3: captureList[i].slide3, width3: captureList[i].width3, height3: captureList[i].height3, posX3: captureList[i].posX3, posY3: captureList[i].posY3,
                        slide4: captureList[i].slide4, width4: captureList[i].width4, height4: captureList[i].height4, posX4: captureList[i].posX4, posY4: captureList[i].posY4,
                        slide5: captureList[i].slide5, width5: captureList[i].width5, height5: captureList[i].height5, posX5: captureList[i].posX5, posY5: captureList[i].posY5,
                        depth: $("#capture_" + i).css("z-index"),
                        width: $("#capture_" + i + " img").width() / unitX,
                        height: $("#capture_" + i + " img").height() / unitY,
                        posX: (($("#capture_" + i).position().left + $("#capture_" + i).width() / 2) - oX) / unitX,
                        posY: (oY - ($("#capture_" + i).position().top + $("#capture_" + i).height() / 2)) / unitY,
                        color: colorToHex(captureList[i].color),
                        title: captureList[i].title,
                        color_index: "1",
                        buttontype: captureList[i].buttontype
                    });
                }
            }
            /***캡쳐버튼 보관부분***/

            /*3D 오브젝트 보관부분*/
            for (i = 1; i < three_counter + 1; i++) {
                if (threeList[i] == null)
                    continue;
                if ($("#three_" + i).length == 0)
                    continue;

                arrResult.push({
                    obj: "three",
                    objsize: threeList[i].objsize,
                    url1: threeList[i].url1,
                    url2: threeList[i].url2,
                    type: threeList[i].type,
                    front_angle: threeList[i].front_angle,
                    brightness: threeList[i].brightness,
                    run_times: threeList[i].run_times,
                    depth: $("#three_" + i).css("z-index"),
                    width: $("#three_" + i + " img").width() / unitX,
                    height: $("#three_" + i + " img").height() / unitY,
                    posX: (($("#three_" + i).position().left + $("#three_" + i).width() / 2) - oX) / unitX,
                    posY: (oY - ($("#three_" + i).position().top + $("#three_" + i).height() / 2)) / unitY
                });
            }
            /***3D 오브젝트 보관부분***/

            /*전화기 보관부분*/
            for (i = 1; i < tel_counter + 1; i++) {
                if (telList[i] == null)
                    continue;
                if ($("#tel_" + i).length == 0)
                    continue;
                if (telList[i].type == 0) {
                    arrResult.push({
                        obj: "tel",
                        objsize: telList[i].objsize,
                        type: telList[i].type,
                        color: colorToHex(telList[i].color),
                        title: telList[i].title,
                        color_index: telList[i].color_index,
                        mode_index: telList[i].mode_index,
                        threemode: telList[i].threemode,
                        backurl: "none",
                        tel_no: telList[i].tel_no,
                        depth: $("#tel_" + i).css("z-index"),
                        width: $("#tel_" + i).width() / unitX,
                        height: $("#tel_" + i).height() / unitY,
                        posX: (($("#tel_" + i).position().left + $("#tel_" + i).width() / 2) - oX) / unitX,
                        posY: (oY - ($("#tel_" + i).position().top + $("#tel_" + i).height() / 2)) / unitY
                    });
                }
                else {
                    arrResult.push({
                        obj: "tel",
                        objsize: telList[i].objsize,
                        type: telList[i].type,
                        tel_no: telList[i].tel_no,
                        color: "#0099ff",
                        title: "",
                        color_index: "1",
                        mode_index: "1",
                        threemode: telList[i].threemode,
                        backurl: telList[i].backurl,
                        depth: $("#tel_" + i).css("z-index"),
                        width: $("#tel_" + i + " img").width() / unitX,
                        height: $("#tel_" + i + " img").height() / unitY,
                        posX: (($("#tel_" + i).position().left + $("#tel_" + i).width() / 2) - oX) / unitX,
                        posY: (oY - ($("#tel_" + i).position().top + $("#tel_" + i).height() / 2)) / unitY
                    });
                }
            }
            /***전화기 보관부분***/

            /*구글맵 보관부분*/
            for (i = 1; i < googlemap_counter + 1; i++) {
                if (googlemapList[i] == null)
                    continue;
                if ($("#googlemap_" + i).length == 0)
                    continue;
                if (googlemapList[i].type == 0) {
                    arrResult.push({
                        obj: "googlemap",
                        objsize: googlemapList[i].objsize,
                        type: googlemapList[i].type,
                        color: colorToHex(googlemapList[i].color),
                        color_index: googlemapList[i].color_index,
                        mode_index: googlemapList[i].mode_index,
                        title: googlemapList[i].title,
                        backurl: "none",
                        coordinate: googlemapList[i].coordinate,
                        depth: $("#googlemap_" + i).css("z-index"),
                        width: $("#googlemap_" + i).width() / unitX,
                        height: $("#googlemap_" + i).height() / unitY,
                        posX: (($("#googlemap_" + i).position().left + $("#googlemap_" + i).width() / 2) - oX) / unitX,
                        posY: (oY - ($("#googlemap_" + i).position().top + $("#googlemap_" + i).height() / 2)) / unitY
                    });
                }
                else if (googlemapList[i].type == 1) {
                    arrResult.push({
                        obj: "googlemap",
                        objsize: googlemapList[i].objsize,
                        type: googlemapList[i].type,
                        coordinate: googlemapList[i].coordinate,
                        color: "#8C959A",
                        title: "",
                        color_index: "1",
                        mode_index: "1",
                        backurl: googlemapList[i].backurl,
                        depth: $("#googlemap_" + i).css("z-index"),
                        width: $("#googlemap_" + i + " img").width() / unitX,
                        height: $("#googlemap_" + i + " img").height() / unitY,
                        posX: (($("#googlemap_" + i).position().left + $("#googlemap_" + i).width() / 2) - oX) / unitX,
                        posY: (oY - ($("#googlemap_" + i).position().top + $("#googlemap_" + i + " img").height() / 2)) / unitY
                    });
                }
            }
            /***구글맵 보관부분***/

            /*문자판 보관부분*/
            for (i = 1; i < notepad_counter + 1; i++) {
                if (notepadList[i] == null)
                    continue;
                if ($("#notepad_" + i).length == 0)
                    continue;
                arrResult.push({
                    obj: "notepad",
                    view: notepadList[i].view,
                    color: colorToHex(notepadList[i].color),
                    boardtype: notepadList[i].boardtype,
                    boardcolor: colorToHex(notepadList[i].boardcolor),
                    board_color_index: notepadList[i].board_color_index,
                    text_color_index: notepadList[i].text_color_index,
                    textplaymode: notepadList[i].textplaymode,
                    content: notepadList[i].content,
                    depth: $("#notepad_" + i).css("z-index"),
                    width: $("#notepad_" + i).width() / unitX,
                    height: $("#notepad_" + i).height() / unitY,
                    posX: (($("#notepad_" + i).position().left + $("#notepad_" + i).width() / 2) - oX) / unitX,
                    posY: (oY - ($("#notepad_" + i).position().top + $("#notepad_" + i).height() / 2)) / unitY
                });
            }
            /***문자판 보관부분***/

            /*사운드보관부분*/
            for (i = 1; i < audio_counter + 1; i++) {
                if (audioList[i] == null)
                    continue;
                if ($("#audio_" + i).length == 0)
                    continue;
                if (audioList[i].type != 2) {
                    arrResult.push({
                        obj: "audio",
                        objsize: audioList[i].objsize,
                        type: audioList[i].type,
                        btnkind: audioList[i].btnkind,
                        color: colorToHex(audioList[i].color),
                        color_index: audioList[i].color_index,
                        mode_index: audioList[i].mode_index,
                        run_opt: audioList[i].run_opt,
                        url: audioList[i].url,
                        btn_url: audioList[i].btn_url,
                        depth: $("#audio_" + i).css("z-index"),
                        width: $("#audio_" + i).width() / unitX,
                        height: $("#audio_" + i).height() / unitY,
                        posX: (($("#audio_" + i).position().left + $("#audio_" + i).width() / 2) - oX) / unitX,
                        posY: (oY - ($("#audio_" + i).position().top + $("#audio_" + i).height() / 2)) / unitY
                    });
                }
                else {
                    arrResult.push({
                        obj: "audio",
                        objsize: audioList[i].objsize,
                        type: audioList[i].type,
                        btnkind: audioList[i].btnkind,
                        color: colorToHex(audioList[i].color),
                        color_index: audioList[i].color_index,
                        mode_index: audioList[i].mode_index,
                        run_opt: audioList[i].run_opt,
                        url: audioList[i].url,
                        btn_url: audioList[i].btn_url,
                        depth: $("#audio_" + i).css("z-index"),
                        width: $("#audio_" + i + " img").width() / unitX,
                        height: $("#audio_" + i + " img").height() / unitY,
                        posX: (($("#audio_" + i).position().left + $("#audio_" + i).width() / 2) - oX) / unitX,
                        posY: (oY - ($("#audio_" + i).position().top + $("#audio_" + i).height() / 2)) / unitY
                    });
                }

            }
            /***사운드보관부분***/

            /*크로마키보관부분*/
            for (i = 1; i < chromakey_counter + 1; i++) {
                if (chromakeyList[i] == null)
                    continue;
                if ($("#chromakey_" + i).length == 0)
                    continue;
                arrResult.push({
                    obj: "chromakey",
                    objsize: chromakeyList[i].objsize,
                    type: chromakeyList[i].type,
                    run_opt: chromakeyList[i].run_opt,
                    url: chromakeyList[i].url,
                    depth: $("#chromakey_" + i).css("z-index"),
                    width: $("#chromakey_" + i + " video").width() / unitX,
                    height: $("#chromakey_" + i + " video").height() / unitY,
                    posX: (($("#chromakey_" + i).position().left + $("#chromakey_" + i + " video").width() / 2) - oX) / unitX,
                    posY: (oY - ($("#chromakey_" + i).position().top + $("#chromakey_" + i + " video").height() / 2)) / unitY
                });
            }
            /***크로마키보관부분***/

            var strResult = JSON.stringify({ data: arrResult });
            $.ajax({
                url: "setXML.aspx?id=" + CONTENT_ID + "&title=" + encodeURI(title),
                type: 'POST',
                data: encodeURIComponent(strResult),
                success: function (data) {
                    alert("켐페인이 성공적으로 갱신되었습니다.");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("켐페인 보관과정에 에러가 발생하였습니다.");
                }
            });
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert("마커정보를 불러오는동안 오류가 발생하였습니다.");
        }
    });
    HideProgress();
}