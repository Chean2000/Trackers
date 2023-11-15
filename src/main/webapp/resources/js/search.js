	// 모바일 검색창
/*
function mobileSearch() {
	let width = window.innerWidth;
	let icon = document.getElementsByClassName('fa-search')[0];
	let container = $('.header-area .search-container');
	
	if(width <= 767) {
		$(container).removeClass('active');
		showSearchInput();
		icon.removeEventListener('click', showSearchInput);
		
	}else if(width > 767){
		$(container).addClass('active');
		showSearchInput();
		icon.addEventListener('click', showSearchInput);
	}
}
*/

	
	// 헤더 검색버튼 클릭 시 검색창 토글
function showSearchInput() {
	let icon = $('.header-area .search-icon-container');
	let input = $('.header-area .search-input-container');
	let color = $('body').css('background-color');
	
	if(!$(icon).hasClass('active')) {
		$(input).css({'background-color':color});
		$(input).animate({'padding':'10px', 'width': '220px'});
		icon.addClass('active');
	} else {
		$(input).animate({'padding':'0', 'width': '0'});
		icon.removeClass('active');
	}
	
}





