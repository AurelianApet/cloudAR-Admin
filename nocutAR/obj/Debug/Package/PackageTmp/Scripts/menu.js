$(document).ready(function () {
    $(".addcontent_menu").mouseover(function () {
        if ($(this).hasClass("btn-over")) return;
        $(this).css("color", "#ED4512");
    });
    $(".addcontent_menu").mouseout(function () {
        if ($(this).hasClass("btn-over")) return;
        $(this).css("color", "#000");
    });

    $(".clsaccheader").mouseover(function () {
        if ($(this).hasClass("btn-over")) return;
        $(this).css("background-color", "#BDFBCD");
    });
    $(".clsaccheader").mouseout(function () {
        if ($(this).hasClass("btn-over")) return;
        $(this).css("background-color", "#fff");
    });
    $(".contentbox").mouseover(function () {
        if ($(this).hasClass("btn-over")) return;
        $(this).css("background-color", "#BDFBCD");
    });
    $(".contentbox").mouseout(function () {
        if ($(this).hasClass("btn-over")) return;
        $(this).css("background-color", "#fff");
    });

    $(".clseditbtn").mouseover(function () {
        if ($(this).hasClass("btn-over")) return;
        $(this).attr("src", $(this).attr("src").replace(".png", "_1.png"));
    });
    $(".clseditbtn").mouseout(function () {
        if ($(this).hasClass("btn-over")) return;
        $(this).attr("src", $(this).attr("src").replace("_1.png", ".png"));
    });

    $(".clsMarkerPreview").mouseover(function () {
        if ($(this).hasClass("btn-over")) return;
        $(this).css("border-style", "solid");
    });
    $(".clsMarkerPreview").mouseout(function () {
        if ($(this).hasClass("btn-over")) return;
        $(this).css("border-style", "none");
    });

});