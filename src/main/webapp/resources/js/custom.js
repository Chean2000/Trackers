(function ($) {
	
	"use strict";
	$('.owl-best-item').owlCarousel({
		items:5,
		loop:true,
		dots: true,
		nav: true,
		margin:30,
		  responsive:{
			  0:{
				  items:1
			  },
			  600:{
				  items:2
			  },
			  1000:{
				  items:3
			  }
		 }
	})

	$('.owl-recent-item').owlCarousel({
		items:5,
		loop:true,
		dots: true,
		nav: true,
		margin:30,
		  responsive:{
			  0:{
				  items:1
			  },
			  600:{
				  items:2
			  },
			  1000:{
				  items:3
			  }
		 }
	 })

	$('.owl-creator-item').owlCarousel({
		items:5,
		loop:true,
		dots: true,
		nav: true,
		margin:30,
		  responsive:{
			  0:{
				  items:1
			  },
			  600:{
				  items:2
			  },
			  1000:{
				  items:3
			  }
		 }
	 })

	$(window).scroll(function() {
	  var scroll = $(window).scrollTop();
	  var box = $('#top').height();
	  var tab = $('#tab').height();
	  var header = $('header').height();

	 
	  
	  if (scroll > 0) {
		  $("header").addClass("background-header");
		  $("header").css("top", "0px");
		} else {
			// scroll == 0 이면 
			$("header").removeClass("background-header");
			$("header").css("top", tab);

		}	  
	  setTimeout(function() {
			$("main").css("margin-top", $('header').height());
		}, 100);

	});
	

	// Window Resize Mobile Menu Fix
	mobileNav();
	

	// Window Resize Mobile Menu MyMenu
	let menu_flag = false;		// myMenu flag
	myMenu();


	// Scroll animation init
	window.sr = new scrollReveal();
	
	
	// 검색창
	//showSearchInput();
	//mobileSearch();
	

	// Menu Dropdown Toggle
	if($('.menu-trigger').length){
		$(".menu-trigger").on('click', function() {	
			$(this).toggleClass('active');
			$('.header-area .nav').slideToggle(200);
			$('.header-area .nav').css('display','flex');
		});
	}


	// Menu elevator animation
	$('.scroll-to-section a[href*=\\#]:not([href=\\#])').on('click', function() {
		if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
			var target = $(this.hash);
			target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
			if (target.length) {
				var width = $(window).width();
				if(width < 991) {
					$('.menu-trigger').removeClass('active');
					$('.header-area .nav').slideUp(200);	
				}				
				$('html,body').animate({
					scrollTop: (target.offset().top) - 80
				}, 700);
				return false;
			}
		}
	});

//	$(document).ready(function () {
//	    $(document).on("scroll", onScroll);
	    
	    //smoothscroll
//	    $('.scroll-to-section a[href^="#"]').on('click', function (e) {
//	        e.preventDefault();
//	        $(document).off("scroll");
	        
//	        $('.scroll-to-section a').each(function () {
//	            $(this).removeClass('active');
//	        })
//	        $(this).addClass('active');
	      
//	        var target = this.hash,
//	        menu = target;
//	       	var target = $(this.hash);
//	        $('html, body').stop().animate({
//	            scrollTop: (target.offset().top) - 79
//	        }, 500, 'swing', function () {
//	            window.location.hash = target;
//	            $(document).on("scroll", onScroll);
//	        });
//	    });
//	});

	function onScroll(event){
	    var scrollPos = $(document).scrollTop();
	    $('.nav a').each(function () {
	        var currLink = $(this);
	        var refElement = $(currLink.attr("href"));
	        if (refElement.position().top <= scrollPos && refElement.position().top + refElement.height() > scrollPos) {
	            $('.nav ul li a').removeClass("active");
	            currLink.addClass("active");
	        }
	        else{
	            currLink.removeClass("active");
	        }
	    });
	}


	// Page loading animation
	$(window).on('load', function() {
		if($('.cover').length){
			$('.cover').parallax({
				imageSrc: $('.cover').data('image'),
				zIndex: '1'
			});
		}

		$("#preloader").animate({
			'opacity': '0'
		}, 600, function(){
			setTimeout(function(){
				$("#preloader").css("visibility", "hidden").fadeOut();
			}, 300);
		});
		 
		// 헤더 로고 path 지정 함수
		let href = $(location).attr('href');
    	let path;
    	if(href.includes('/community/posts') || href.includes('users?path') || href.includes("/profiles/")){
    		path = "/community/posts?page=0&type=all";
    	}else{
    		path = "/store/main";
    	}
    	$("#logo_container .logo").attr('href', path);
	});
	
	// Window Resize Mobile Menu Fix
	$(window).on('resize', function() {
		myMenu();
		mobileNav();
		//mobileSearch();
		setTimeout(function() {
			$('main').css("margin-top", $('header').height());
		}, 300);
	});


	// Window Resize Mobile Menu Fix
	function mobileNav() {
		var width = $(window).width();
		$('.submenu').on('click', function() {
			if(width < 768) {
				if($(this).find('ul').attr('class') == 'active'){
					$(this).find('ul').removeClass('active');
				}else{
					$(this).find('ul').addClass('active');
				}
			}
		});
	}
	
	// Window Resize Mobile Menu - MyMenu
	function myMenu() {
		let width = window.innerWidth;
		
		if(width <= 767 && !menu_flag) {
			$('#user-menu').children('img').css('display', 'none');
			$('#user-menu').prepend("<a class='submenu'>마이 메뉴</a>");
			menu_flag = true;
		}else if(width > 767 && menu_flag){
			$('#user-menu').children('a').remove();
			$('#user-menu').children('img').css('display', 'block');
			menu_flag = false;
		}
	}
	
	
	
	
	// 커뮤니티 소속 페이지에 있을 때 헤더 상품/크리에이터 메뉴 안보이게 하기
	function modifyHeaderMenu(){
		let path = $(location).attr('pathname');				
		let st_menu = $('.header-area .store-menu');
		
		// 일단 임시 URI로 시험 적용
		if(path.includes('community') || path.includes('profiles') || path.includes('users')) {
			$(st_menu).css('visibility', 'hidden');
			$(st_menu).addClass('hidden');
			return;
		} else {
			$(st_menu).css('visibility', 'visible');
			$(st_menu).removeClass('hidden');
			return;
		}
	}

	modifyHeaderMenu();

	
	// 커뮤니티 소속 페이지에 있을 때 헤더 / active탭 배경색 바꾸기 
	/*function addHeaderBackground(){
		let path = $(location).attr('pathname');				
		let header = $('.header-area');
		let co_tab = $('#co_tab');
		
		// 일단 임시 URI로 시험 적용
		if(path.includes('co-')) {
			$(header).css('background-color', '#f2f2f6');
			// 탭 active 구현되고 나서 탭 배경색도 추가
			return;
		} else {
			$(header).css('background-color', '#fff');
			return;
		}
	}
	
	addHeaderBackground();
	*/
	/* 나중에 여기 애니메이션도 넣어야되나 */
	
	
	
	// 좁은헤더 페이지일때 헤더 클래스값 변경 (마이스토어, 프로필)
	function modifyHeaderType(){
		let path = $(location).attr('pathname');				
		let header = $('.header-area');
		
		// 일단 프로필에만 적용
		// 마이스토어는 공통 URI 정한 뒤 적용 예정
		if(path.includes('profile') || path.includes('store/my')) {
			$(header).addClass('narrow-header');
			return;
		} else {
			$(header).removeClass('narrow-header');
			return;
		}
		
	}
	
	modifyHeaderType();
	
	

	
	// 탭 active / 헤더 배경색 적용
	tabActive();
	
	


	
	
	
	
})(window.jQuery);


