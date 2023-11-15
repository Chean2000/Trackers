
// 대표상품 최대 5개 초과시 등록 불가
function signatureLimit(btn) {
	
	let sigs = document.getElementsByClassName('signature-del-btn');
	console.log(sigs.length);
	
	let sig_form = btn.parentElement;
	
	if(sigs.length < 5) {
		// 5개 미만이면 등록 가능
		sig_form.submit();
	} else {
		alert('대표 상품은 최대 5개까지 등록 가능합니다');
		return;
	}
	
}