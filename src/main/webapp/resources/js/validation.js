/**
 * signin-modal
 * signup-modal
 * store-create-modal
 * user-modify
 * store-management
 */

function onSigninModal() { $('.modal-content').load("/signin-modal"); }
function onSignupModal() { $('.modal-content').load("/signup-modal"); }
function onStoreModal() { $('#store-modal .modal-content').load("/store-create-modal"); }
function changeSignupModal(){ $('.scroll-to-section').eq(1).click(); } 		// signin-modal.jsp에서 사용


let email_flag = -1;
let pwd_flag = false;
let store_flag = -1;
let url_flag = -1;
let name_flag = false;
let inputs, parents;
let pwd_chk_str = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,15}$/;

/*****common*****/
// 중복확인 초기화
function chk_reset(flag){
	if(flag == "email"){ email_flag = -1; }
	else if(flag == "store"){ store_flag = -1; }
	else if(flag == "url"){ url_flag = -1; }
	else if(flag == "pwd"){ pwd_flag = false; }
	else if(flag == "name"){ name_flag = false; }
	else{
		email_flag = -1;
		store_flag = -1;
		url_flag = -1;
		pwd_flag = false;
		name_flag = false;
	}
}

//공백, 특수문자 제거 + 숫자입력
function remove(type, target){
	let reg;
	
	if(type==1){	// 공백 제거
		reg = /[ ]/gim;
	}else if(type==2){	// 공백 및 특수문자 제거(@,.제외)
		reg = /[`~!#$%^&*()_|+\-=?;:'",<>\{\}\[\]\\\/ ]/gim;
	}else if(type==3){	// 공백 및 특수문자 제거
		reg = /[`~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\\/ ]/gim;
	}
	else if(type==4){	// 숫자만 입력 가능
		reg = /[^0-9]/gim;
	}
	target.value = target.value.replace(reg, '');
}

// 전화번호 하이픈 추가
function tel_hyphen(target){
	target.value = target.value.replace(/[^0-9]/g, '')
						.replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, '');
}

// textarea 줄바꿈 db에 저장
function enter(id){
	$('#'+id).val($('#'+id).val().replace(/\n/g, "<br>"));
}

// 인스타그램, 유튜브 insert시 맨 앞 @ 추가
function at(target){
	target.value = target.value.replace(/^([0-9a-zA-Z._])/g, "@$1");
}

// 닉네임 길이 체크
function name_len(){
	let len = $("input[name=name]").val().length;
	let p = $(".form-group.name").children().last();
	console.log(len);
	if(len > 1 && len < 9){
		p.text("");
		name_flag = true;
	}
	else{
		p.text("닉네임은 최소 2글자 ~ 최대 8글자까지 작성 가능합니다.").css('color','#e97d7d');
		name_flag = false;
	}
	
}


/*****signin-modal*****/
// 로그인
function login(){
	
	let email = $('#email').val();
	let password = $('#password').val();
	let flag;
	
	if(email == '') {
		alert("아이디를 작성입력해주세요.");
		$('#email').focus();
		return false;
	}else if(password == '') {
		alert("비밀번호를 작성입력해주세요.");
		$('#password').focus()
		return false;
	}
	
	$.ajax({
		url: "/validation/signin", 			//통신할 url
		type: "POST",						//통신할 메소드 타입
		data: {email : email, password : password},	//전송할 데이터
		dataType: "json",
		async: false,						// 실행 결과 기다리지 않고 다음 코드 읽을 것인지
		success : function(result) { 		// 매개변수에 통신성공시 데이터 저장
			if(result) {					// 로그인 성공
				flag = true;
			} else {						// 로그인 실패
				flag = false;
			}	
		},
		error : function (status, error) {	//통신 실패
			console.log('통신실패');
			console.log(status, error);
		}
	});
	
	if(flag){
		$('#path').val($(location).attr('pathname')+$(location).attr('search'));
		return true;
	}else{
		alert('이메일 또는 비밀번호가 일치하지 않습니다. 다시 시도해 주세요.');
		$('#email').val("");
		$('#password').val("");
		$('#email').focus();
		return false;	
	} 
}

//이메일 중복 체크
function email_chk(){
	inputs = $('#modal .form-control');
	parents = $('.form-group');
	
	let p = $(parents[0]).children().last();
	let email = $(inputs[0]).val();
	let email_chk;
	let email_chk_str = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

	if(email == ""){
		p.text("이메일이 입력되지 않았습니다.").css('color','#e97d7d');
		email_flag = 0;
		return;
	}else if(!email_chk_str.test(email)){
		console.log($(inputs[1]));
		p.text("이메일 형식에 맞지 않습니다.").css('color','#e97d7d');
		email_flag = 0;
		return;
	}
	
	$.ajax({
		url: "/validation/email", 			//통신할 url
		type: "GET",						//통신할 메소드 타입
		data: {email : email},	//전송할 데이터
		dataType: "json",
		async: false,						// 실행 결과 기다리지 않고 다음 코드 읽을 것인지
		success : function(result) { 		// 매개변수에 통신성공시 데이터 저장
			if(result) email_chk = true;	// 이메일 존재
			else email_chk = false;			// 이메일 존재 x (사용 가능)
		},
		error : function (status, error) {	//통신 실패
			console.log('통신실패');
			console.log(status, error);
		}
	});	 
	
 	if(email_chk){
		p.text("중복된 이메일입니다.").css('color','#e97d7d');
		email_flag = 0;
	}else if(email != "" && !email_chk){
		p.text("사용 가능한 이메일입니다.").css('color','#586579');
		email_flag = 1;
	}
}


/*****signup-modal, store-create-modal, user-modify, store-management*****/
//url 체크
function url_chk(old_url, idx, path){			// 기존 url(수정 시 사용), 중복된 url인지(후에 db로, true가 중복), input 위치, 함수 사용 페이지
	
	// 함수 부른 페이지 구별해 요소 가져옴
	if(path == 'store'){
		inputs = $('#store-management .validation-input');
		parents = $('.store-form');
	}else if(path == 'modify'){
		inputs = $('#modify-input-container .form-control');
		parents = $('.form-group');
	}else{
		inputs = $('.modal .form-control');
		parents = $('.form-group');
	}
	
	let url = $(inputs[idx]).val();
	let url_chk;
	let p = $(parents[idx]).children().last();
	
	if(url == ""){
		p.text("URL이 입력되지 않았습니다.").css('color','#e97d7d');
		url_flag = 0;
		return;
	}else if((old_url.length > 0) && (url == old_url)){
		p.text("기존 URL을 사용합니다.").css('color','#586579');
		url_flag = 1;
		return;
	}
	
	$.ajax({
		url: "/validation/url", 			//통신할 url
		type: "GET",						//통신할 메소드 타입
		data: {url : url},	//전송할 데이터
		dataType: "json",
		async: false,						// 실행 결과 기다리지 않고 다음 코드 읽을 것인지
		success : function(result) { 		// 매개변수에 통신성공시 데이터 저장
			if(result) url_chk = true;		// url 존재
			else url_chk = false;			// url 존재 x (사용 가능)
		},
		error : function (status, error) {	//통신 실패
			console.log('통신실패');
			console.log(status, error);
		}
	});	

	if(url_chk){
		p.text("중복된 URL입니다.").css('color','#e97d7d');
		url_flag = 0;
	}else if(url != "" && !url_chk){
		p.text("사용 가능한 URL입니다.").css('color','#586579');
		url_flag = 1;
	} 
}


/*****signup-modal, user-pwd-modify*****/
//비밀번호 유효성 검사
function pwd_validation(id, target){
	inputs = $('#'+id+' .form-control');
	parents = $('.form-group');
	
	let p = $(parents[1]).children().last();
	let pwd = $(inputs[1]).val();
	
	target.value = target.value.replace(/[ ]/gim, '');
	
	if(!pwd_chk_str.test(pwd)){
		p.text("비밀번호는 8~15자리이고 문자/숫자/특수문자를 포함해야 합니다.").css('color','#e97d7d');
	}else{
		p.text("");		
	}	
}


/*****user-pwd-modify*****/
//비밀번호 변경 전 확인
function change_pwd_chk(){
	old_res = false;
	new_res = false;
	
	inputs = $('#modify-input-container input:password');
	
	
	// 기존 비밀번호 체크
	var password = $(inputs[0]).val();
	console.log("입력:"+password);
	$.ajax({
		url: "/validation/pwd", 			//통신할 url
		type: "POST",						//통신할 메소드 타입
		data: {old_password : password},	//전송할 데이터
		dataType: "json",
		async: false,						// 실행 결과 기다리지 않고 다음 코드 읽을 것인지
		success : function(result) { 		// 매개변수에 통신성공시 데이터 저장
		 	if(result){
		 		$(inputs[0]).parent().next().text("");
		 		old_res = true;		 		
		 	}else{
		 		$(inputs[0]).parent().next().text("비밀번호가 틀렸습니다.").css('color','#e97d7d');
		 	}
		},
		error : function (status, error) {	//통신 실패
			console.log('통신실패');
			console.log(status, error);
		}
	});	 
	
	// 신규 비밀번호 체크
	if(pwd_chk_str.test($(inputs[1]).val())){	// 비밀번호 형식에 맞아야함
		if($(inputs[1]).val() == $(inputs[2]).val()){
			$(inputs[2]).parent().next().text("");
			new_res = true;
		}else{
			$(inputs[2]).parent().next().text("비밀번호가 일치하지않습니다.").css('color','#e97d7d');
		}
	}
	
	return (old_res && new_res);
}


/*****signup-modal*****/
function sign_chk(){    	
	inputs = $('#modal .form-control');
	parents = $('.form-group');
	
	if(email_flag == -1 || url_flag == -1){
		let p;
		if(email_flag == -1){ p = $(parents[0]).children().last(); }
		else if(url_flag == -1){ p = $(parents[5]).children().last(); }

		p.text("중복 확인이 되지않았습니다.").css('color','#e97d7d');
		return false;
	}else if(email_flag == 0 || !pwd_flag || url_flag == 0 || !name_flag){
		return false;
	}
	
	
	$('#path').val($(location).attr('pathname')+$(location).attr('search'));
	
	
	return true;
}

// 비밀번호 체크 실시간 확인
function pwd_chk(){
	inputs = $('#modal .form-control');
	parents = $('.form-group');
	
	let p = $(parents[2]).children().last();
	let pwd = $(inputs[1]).val();
	let pwd_chk = $(inputs[2]).val();

	if(pwd_chk == ""){
		p.text("");
		pwd_flag = false;
	}
	else if(!pwd_chk_str.test(pwd)){
		p.text("비밀번호 형식에 맞지 않습니다.").css('color','#e97d7d');
		pwd_flag = false;
	}else{
		if(pwd != pwd_chk){
			p.text("비밀번호가 일치하지 않습니다.").css('color','#e97d7d');
			pwd_flag = false;
		}else if(pwd == pwd_chk){
			p.text("비밀번호가 일치합니다.").css('color','#586579');
			pwd_flag = true;
		}
	}
}


/*****store-create-modal*****/
function store_create_chk(){
	parents = $('.form-group');
	
	if(store_flag == -1 || url_flag == -1){
		let p;
		if(store_flag == -1){ p = $(parents[0]).children().last(); }
		else if(url_flag == -1){ p = $(parents[1]).children().last(); }
		
		p.text("중복 확인이 되지않았습니다.").css('color','#e97d7d');
		return false;
	}else if(store_flag == 0 || url_flag == 0){
		return false;
	}
	
	return true;
}

// 스토어 이름 체크
function store_chk(old_store, path){				// 기존 store 이름, 페이지 path
	if(path == 'store'){
		inputs = $('#store-management .form-control');
		parents = $('.store-form');
	}else{
		inputs = $('#store-modal .form-control');
		parents = $('.form-group');
	}
	
	let p = $(parents[0]).children().last();
	let store = $(inputs[0]).val();
	let store_chk;
	let len = store.length;
	
	if(len < 2 || len > 8){
		p.text("스토어 이름은 최소 2글자 ~ 최대 8글자까지 작성 가능합니다.").css('color','#e97d7d');
		store_flag = 0;
		return;
	}else if(len > 1 && store == old_store){
		p.text("기존 스토어 이름을 사용합니다.").css('color','#586579');
		store_flag = 1;
		return;
	}
	
	$.ajax({
		url: "/validation/creator", 			//통신할 url
		type: "GET",						//통신할 메소드 타입
		data: {storeName : store},	//전송할 데이터
		dataType: "json",
		async: false,						// 실행 결과 기다리지 않고 다음 코드 읽을 것인지
		success : function(result) { 		// 매개변수에 통신성공시 데이터 저장
			if(result) store_chk = true;		// url 존재
			else store_chk = false;			// url 존재 x (사용 가능)
		},
		error : function (status, error) {	//통신 실패
			console.log('통신실패');
			console.log(status, error);
		}
	});	
	
	if(store_chk){
		p.text("중복된 스토어 이름입니다.").css('color','#e97d7d');
		store_flag = 0;
	}else if(store != "" && !store_chk){
		p.text("사용 가능한 스토어 이름입니다.").css('color','#586579');
		store_flag = 1;
	}
}


/*****user-modify, store-management*****/
function modify_chk(path, idx){    		// 함수 사용 페이지, input 위치
	if(path == 'store'){
		parents = $('.store-form');
		
		if(store_flag == -1){
			let p = $(parents[idx-1]).children().last();
	
			p.text("중복 확인이 되지않았습니다.").css('color','#e97d7d');
			
			return false;
		}
	}else{
		parents = $('.form-group');
	}
	
	
	if(url_flag == -1){
		let p = $(parents[idx]).children().last();

		p.text("중복 확인이 되지않았습니다.").css('color','#e97d7d');
		return false;
	}else if(url_flag == 0 || store_flag == 0){
		return false;
	}
	
	return true;
}



/*****insert-product 상품등록 필수값 체크*****/
function insert_p_chk(frm) {

	if($('#product-name').val() == '' || $('#product-name').val() == null){ 
		alert("상품명을 입력해주세요.");
		$('#product-name').focus();
		return false;
	} 
	else if($('#file').val() == '' || $('#file').val() == null){ 
		alert("상품 파일을 등록해주세요.");
		$('#file').focus();
		return false;
	} 
	else if($('#product-price').val() == '' || $('#product-price').val() == null){ 
		alert("금액을 입력해주세요.");
		$('#product-price').focus();
		return false;
	} 
	else if($("input[name='do-sale']:checked").val() == 'yes' && ($('#product-sale').val() == '' || $('#product-sale').val() == null)){ 
		alert("할인 금액을 입력해주세요.");
		$('#product-sale').focus();
		return false;
	} 
	else if($('#thumbnail').val() == '' || $('#thumbnail').val() == null){ 
		alert("썸네일을 등록해주세요.");
		$('#thumbnail').focus();
		return false;
	} 
	/*
	else if($('#content').val() == '' || $('#content').val() == null){ 
		alert("상세 정보를 등록해주세요.");
		$('#content').focus();
		return false;
	} 
	*/
	
	
	
	// 할인 미적용일 경우 sale 을 0으로 넘기기	
	if($("input:radio[name='do-sale'][value='no']").prop('checked')) {
		let sale = document.getElementById('product-sale');
		sale.value = '0';
	}
	
	

	// 금액에서 콤마 제거
	let pp = $('#product-price').val();
	$('#product-price').val(pp.replaceAll(',', ''));
		
	let ps = $('#product-sale').val();
	$('#product-sale').val(ps.replaceAll(',', ''));
	
	
	
	// 카테고리 체크박스 체크된 항목만 배열로 넘기기 - 디자인
	let category_design = new Array();

    $('input:checkbox[name=category_design_c]:checked').each(function() {
        category_design.push(this.value);
    });
    
	$('input#category_design').val(category_design);
	
	
	// 카테고리 체크박스 체크된 항목만 배열로 넘기기 - 페이지
	let category_page = new Array();

    $('input:checkbox[name=category_page_c]:checked').each(function() {
   		console.log("page");
        category_page.push(this.value);
    });
    
	$('input#category_page').val(category_page);
	
	
	frm.submit();
	
}










