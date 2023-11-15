/*!

=========================================================
* Black Dashboard - v1.0.1
=========================================================

* Product Page: https://www.creative-tim.com/product/black-dashboard
* Copyright 2019 Creative Tim (https://www.creative-tim.com)


* Coded by Creative Tim

=========================================================

* The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
*/

/* my-store 관련 js */


// 작은화면 인경우 사이드 바
var $html = $('html');
var $body = $('body');
var navbar_initialized = false;
var backgroundOrange = false;
var sidebar_mini_active = false;
var toggle_initialized = false;
var $admin = $('main').attr('id');

$(document).on('click', '.navbar-toggle', function() {
	var $toggle = $(this);

	if (blackDashboard.misc.navbar_menu_visible == 1) {
		$html.removeClass('nav-open');
		blackDashboard.misc.navbar_menu_visible = 0;
	    setTimeout(function() {
			$toggle.removeClass('toggled');
			$('.bodyClick').remove();
	    }, 550);

	} else {
		setTimeout(function() {
			$toggle.addClass('toggled');
	    }, 580);

		var div = '<div class="bodyClick"></div>';
		$(div).appendTo('body').click(function() {
			$html.removeClass('nav-open');
			blackDashboard.misc.navbar_menu_visible = 0;
			setTimeout(function() {
				$toggle.removeClass('toggled');
		        $('.bodyClick').remove();
			}, 550);
		});
	
		$html.addClass('nav-open');
		blackDashboard.misc.navbar_menu_visible = 1;
	}
});

blackDashboard = {
	misc: {
		navbar_menu_visible: 0
	},

	initMinimizeSidebar: function() {
		if ($('.sidebar-mini').length != 0) {
			sidebar_mini_active = true;
	    }

	    $('#minimizeSidebar').click(function() {
			var $btn = $(this);

			if (sidebar_mini_active == true) {
				$('body').removeClass('sidebar-mini');
				sidebar_mini_active = false;
				blackDashboard.showSidebarMessage('Sidebar mini deactivated...');
	      	} else {
	        	$('body').addClass('sidebar-mini');
	        	sidebar_mini_active = true;
	        	blackDashboard.showSidebarMessage('Sidebar mini activated...');
	      	}

	      	// we simulate the window Resize so the charts will get updated in realtime.
	      	var simulateWindowResize = setInterval(function() {
	        	window.dispatchEvent(new Event('resize'));
	      	}, 180);

	      	// we stop the simulation of Window Resize after the animations are completed
	      	setTimeout(function() {
	        	clearInterval(simulateWindowResize);
	      	}, 1000);
		});
	}
};


$(document).ready(function() {
	$().ready(function() {
		$sidebar = $('.sidebar');
        $navbar = $('.navbar');
        $main_panel = $('.main-panel');

        $full_page = $('.full-page');

        $sidebar_responsive = $('body > .navbar-collapse');
        sidebar_mini_active = true;
        white_color = false;

        window_width = $(window).width();

        fixed_plugin_open = $('.sidebar .sidebar-wrapper .nav li.active a p').html();
        
        // sidebar height 지정
        if($admin.includes('popup') ||  $admin.includes('center')){
    	    $('.sidebar').css("height", ($('.admin').innerHeight())+"px");    
        }else{
        	$('.sidebar').css("height", ($('.my-store').innerHeight())+"px");
		}

        $('.fixed-plugin a').click(function(event) {
          if ($(this).hasClass('switch-trigger')) {
            if (event.stopPropagation) {
              event.stopPropagation();
            } else if (window.event) {
              window.event.cancelBubble = true;
            }
          }
        });


        $('.switch-sidebar-mini input').on("switchChange.bootstrapSwitch", function() {
          var $btn = $(this);

          if (sidebar_mini_active == true) {
            $('body').removeClass('sidebar-mini');
            sidebar_mini_active = false;
            blackDashboard.showSidebarMessage('Sidebar mini deactivated...');
          } else {
            $('body').addClass('sidebar-mini');
            sidebar_mini_active = true;
            blackDashboard.showSidebarMessage('Sidebar mini activated...');
          }

          // we simulate the window Resize so the charts will get updated in realtime.
          var simulateWindowResize = setInterval(function() {
            window.dispatchEvent(new Event('resize'));
          }, 180);

          // we stop the simulation of Window Resize after the animations are completed
          setTimeout(function() {
            clearInterval(simulateWindowResize);
          }, 1000);
        });
        
		// 사이드바  크기 조절
	  	$(window).on('resize', function() {
	  		setTimeout(function() {
	  			if($admin.includes('popup') ||  $admin.includes('center')){
		  			$('.sidebar').css("height", ($('.admin').innerHeight())+"px"); 
		        }else{
		        	$('.sidebar').css("height", ($('.my-store').innerHeight())+"px");
				}
	  		}, 10);
	  	});
	  	
	  	addActive();		// 사이드바 위치 표시
	});
});

// 사이드바 현재 위치 표시 함수
function addActive(){
	let path = $(location).attr('pathname');				
	let href = $('.sidebar .sidebar-wrapper .nav li a');
	console.log(path);
	// 상품등록 페이지 수동으로 current값 주기
	if(path.includes('products/new')) {
		$(href).filter("[href='/store/products/management']").parent().addClass('active');
		return;
	}
	else if(path.includes('table')) {
		$(href).filter("[href='/store/sales/table']").parent().addClass('active');
		return;
	}
	
	for(let i=0; i<href.length; i++){
		let url = $(href[i]).attr('href');
		if(path.includes(url)) {
			console.log(url)
			$(href[i]).parent().addClass('active');
			break;
		}
	}
}

 
// 숫자 카운팅 함수	  
function countingUp(target, count){
	$({ val : 0 }).animate({ val : count }, {
		duration: 1500,
		step: function() {
			var num = numberWithCommas(Math.floor(this.val));
			target.text(num);
		},
		complete: function() {
			var num = numberWithCommas(Math.floor(this.val));
			target.text(num);
		}
	});
}
      
// 세자리 마다 콤마(,) 넣는 함수
function numberWithCommas(x) {
	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}