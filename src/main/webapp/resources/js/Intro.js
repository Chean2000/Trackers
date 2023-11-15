window.addEventListener("wheel", function(e){
    e.preventDefault();
},{passive : false});

var mHtml = $("html");
var page = 1;

mHtml.animate({scrollTop : 0},10);

$(window).on("wheel", function(e) {
    if(mHtml.is(":animated")) return;
    if(e.originalEvent.deltaY > 0) {
        if(page == 4) return;
        page++;
    } else if(e.originalEvent.deltaY < 0) {
        if(page == 1) return;
        page--;
    }
    var posTop =(page-1) * $(window).height();
    mHtml.animate({scrollTop : posTop});
})

$(document).ready(function() {
	  $(".taga").hover(
	    function() {
	      $("body").css("background-color", "#f2f2f6");
	      $("#section1").css("background-color", "#f2f2f6");
	    },
	    function() {
	      $("body").css("background-color", ""); // hover가 끝날 때 기본 배경색으로 되돌립니다.
	      $("#section1").css("background-color", "");
	    }
	  );
	});



