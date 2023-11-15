// 장바구니에 담고 이동할 것인지 확인하는 confirm
function goCart(p_id) {

	$.ajax({
		type: "post",
		url: "/store/carts/"+p_id,
		datatype: 'text',
		success: function() {
			if(confirm("상품이 장바구니에 추가되었습니다.\n장바구니로 이동하시겠습니까?")) {
				location.href="/store/carts";
				// 장바구니로 이동
			} 
		},
		error: function() {
			alert('오류 발생');
			//alert('로그인이 필요한 메뉴입니다');
		}

	})
}


// 리스트화면에서 장바구니 담기
function preventDefaultGoCart(e, p_id) {

	e.stopPropagation();
	goCart(p_id);
}



// 로그인 alert
function loginAlert(e) {

	alert('로그인이 필요한 메뉴입니다');
	e.stopImmediatePropagation();
	return false;

}





