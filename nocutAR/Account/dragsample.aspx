<%@ Page Title="" Language="C#" MasterPageFile="~/Account/UserPage2.Master" AutoEventWireup="true" CodeBehind="dragsample.aspx.cs" Inherits="nocutAR.Account.dragsample" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>jQuery UI Droppable - Revert draggable position</title>

  <link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">

  <script src="//code.jquery.com/jquery-1.10.2.js"></script>

  <script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>

  <link rel="stylesheet" href="/resources/demos/style.css">

  <style>
  body{font-family:NanumGothic, "나눔고딕", "맑은 고딕", 'Malgun Gothic', Dotum, "돋움", gulim, "굴림", verdana, sans-serif;text-align:center;}
	.drop-box{background-position: 0 0; width:500px;height:500px;background-color:#ddd;margin:30px auto 0;text-align:center;border-radius:30px;}
	

	.drag-box{padding:10px;background-color:#9dcbff;border-radius:5px;cursor:pointer; width:50px;height:30px}

	
	.dragged-box{position:absolute; padding:10px;background-color:#9dcbff;border-radius:5px;cursor:pointer;width:50px;height:30px}

  #draggable, #draggable2 { width: 100px; height: 100px; padding: 0.5em; float: left; margin: 10px 10px 10px 0; cursor: move; }

  #droppable { width: 550px; height: 550px; padding: 0.5em; float: left; margin: 10px; }
  
  h1 { padding: .2em; margin: 0; }

  #products { float:left; width: 500px; margin-right: 2em; }

  #cart { width: 200px; float: left; margin-top: 1em; }

  /* style the list to maximize the droppable hitarea */

  #cart ol { margin: 0; padding: 1em 0 1em 3em; }
  </style>
  <script>

      $(function () {

          $("#draggable").draggable({ 
            revert: "invalid",
            appendTo: "body",
            helper: "clone"
        });
        $("#draggable2").draggable({
            helper:"clone",
            revert: "invalid"            
        });
        $("#droppable").droppable({
              
              activeClass: "ui-state-default",              
              hoverClass: "ui-state-hover",
              drop: function (event, ui) {                   
                  $(this).append($(ui.draggable).clone());
                  $("#droppable .product").addClass("item");                  
                  $(".item").removeClass("ui-draggable product");
                  $(".item").draggable({                        
                      containment: 'parent'
                      //grid: [150, 150]
                  });

                  //$(this).append(ui.draggable);      
                  //$(this).addClass("ui-state-highlight").find("p").html("Dropped!");
              }
          });
          $(".product").draggable({
              helper: 'clone',
              revert:"invalid"
          });

      });
      $(function () {

          $("#catalog").accordion();

          $("#catalog li").draggable({
              appendTo: "body",
              helper: "clone"
          });

          $("#cart ol").droppable({
              activeClass: "ui-state-default",
              hoverClass: "ui-state-hover",
              accept: ":not(.ui-sortable-helper)",
              drop: function (event, ui) {
                  $(this).find(".placeholder").remove();
                  $("<li></li>").text(ui.draggable.text()).appendTo(this);
              }
          }).sortable({
              items: "li:not(.placeholder)",
              sort: function () {
                  // gets added unintentionally by droppable interacting with sortable
                  // using connectWithSortable fixes this, but doesn't allow you to customize active/hoverClass options
                  $(this).removeClass("ui-state-default");
              }
          });
      });

      $(function () {
          counter = 0;
          flag = 0;
          $(".drag-box").draggable({
              containment: "frame",  // 드래그가 가능한 영역 지정, 문서 전체를 영역으로 지정하고 싶으면 "document", 특정 클래스나 id를 영역으로 지정하고 싶으면  ".drag-area", "#drag-area"

              revert: "invalid", // 지정한 DROP영역의 밖에 DROP 했을 때 원래 위치로 돌아가게 하는 속성

              helper: "clone",
              //axis : "x", // x축으로만 드래그 가능

              //axis : "y", // y축으로만 드래그 가능

              start: function () { // 드래그 시작했을 때 한 번 호출
                  //$(this).addClass("dragging");
                  flag = 0;
                  //오브젝트아이콘크기같은것을 드래그 시작때 한번 줄수 있다. 끝날때 즉 stop에서 다시 없애주면 된다.
              },

              stop: function (ev, ui) { // 드래그 끝났을 때 한 번 호출
                  //$(this).removeClass("dragging");
                  if (flag != 1)
                      return;
                  var pos = $(ui.helper).offset();
                  objName = "#clonediv" + counter
                  $(objName).css({ "left": pos.left, "top": pos.top });
                  $(objName).removeClass("drag-box");
                  //$(objName).removeClass("drag-box");

                  $(objName).draggable({
                      containment: "parent"
                  });
              }

              // 그외에도 여러가지 속성, snap, cursor 위치 조정, delay 
          });


          // DROP 객체
          $(".drop-box").droppable({

              accept: ".drag-box", // DROP 할 수 있는 DRAG 객체 지정

              over: function (event, ui) {						// event : dropover, ui.draggable : 지금 .drop-box 위로 올라온 .drag-box를 가리킨다 
                  //$(this).addClass("over");
              },

              out: function (event, ui) {							// event : dropout, ui.draggable : 지금 .drop-box 를 벗어난 .drag-box를 가리킨다 
                  //$(this).removeClass("over");
              },

              drop: function (event, ui) {						// event : drop, , ui.draggable : 지금 .drop-box 에 drop된 .drag-box를 가리킨다 
                  counter++;
                  flag = 1;
                  var element = $(ui.draggable).clone();
                  element.addClass("tempclass");
                  $(this).append(element);
                  $(".tempclass").attr("id", "clonediv" + counter);
                  $("#clonediv" + counter).removeClass("tempclass").addClass("dragged-box");

                  //$(this).append($(ui.draggable).clone());

                  //$(this).removeClass("over").addClass("drop");

                  //ui.draggable.clone().addClass("drop"); // drop된 .drag-box에 클래스 지정
              }

          });
      });

  </script>



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="drop-box" id="frame">
		<asp:Image ID="Image1" runat="server" ImageUrl="~/markers/1-2.jpg" Width="100%"></asp:Image>        
	</div>

	<!-- drag-box DRAG 가능한 객체-->
	<div id="drag-area">
		<span class="drag-box">.drag-box</span>
		<span class="drag-box">.drag-box</span>
		<span class="drag-box">.drag-box</span>
		<span class="drag-box">.drag-box</span>
	</div>
<br/>
<br/>



    <div id="draggable" class="ui-widget-content" style="display:none">
        <img src="/markers/1-2.jpg" class="product" alt="" />
      <p>I revert when I'm dropped</p>
    </div>
    <div id="draggable2" class="ui-widget-content" style="display:none">
      <p>I revert when I'm not dropped</p>
    </div>
    <div id="droppable" class="ui-widget-header" style="display:none">
      <p>Drop me here</p>
    </div>


<div id="products" style="display:none">
  <h1 class="ui-widget-header">Products</h1>
  <div id="catalog">
    <h2><a href="#">T-Shirts</a></h2>
    <div>
      <ul>
        <li>Lolcat Shirt</li>
        <li>Cheezeburger Shirt</li>
        <li>Buckit Shirt</li>
      </ul>
     </div>
    <h2><a href="#">Bags</a></h2>
    <div>
      <ul>
        <li>Zebra Striped</li>
        <li>Black Leather</li>
        <li>Alligator Leather</li>
      </ul>
    </div>
    <h2><a href="#">Gadgets</a></h2>
    <div>
      <ul>
        <li>iPhone</li>
        <li>iPod</li>
        <li>iPad</li>
      </ul>
    </div>
  </div>
</div>
<div id="cart" style="display:none">
  <h1 class="ui-widget-header">Shopping Cart</h1>
  <div class="ui-widget-content">
    <ol>
      <li class="placeholder">Add your items here</li>
    </ol>
  </div>
</div>
</asp:Content>
