<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<!-- 아임포트 (결제 API) -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>


<script>

/* 체크박스에 따라 가격, 개수 합산 */	
function getTotal(){
	let total_price = 0;
	
	$('span.number').each(function() {        
        let price = $(this).text();
        total_price += Number(price);		
        console.log(total_price);
    });
	
	return total_price;
}
function putTotal() {
	$('#total-price').text(numberWithCommas(getTotal()));
}



$(()=> {		
	
	putTotal();
	
	/* 가격 세자리마다 콤마 넣어주기 */
	let numbers = document.getElementsByClassName('number');	
	for(num of numbers) {
		let text = num.innerText;
		num.innerText = numberWithCommas(text);
	}	

})



/***** purchase 구매하기 필수값 체크*****/
function purchase_chk() {

	if($('#buyer-name').val() == '' || $('#buyer-name').val() == null){ 
		alert("이름을 입력해주세요.");
		$('#buyer-name').focus();
		return false;
	} 
	else if($('#buyer-email').val() == '' || $('#buyer-email').val() == null){ 
		alert("이메일을 입력해주세요.");
		$('#buyer-email').focus();
		return false;
	} 
	else if($('#buyer-tel').val() == '' || $('#buyer-tel').val() == null){ 
		alert("연락처를 입력해주세요.");
		$('#buyer-tel').focus();
		return false;
	} 
	else if(($("input:checkbox[name=accept-terms]").prop('checked')) === false){ 
		alert("취소 및 환불 규정에 대한 동의가 필요합니다");
		$('#accept-terms').focus();
		return false;
	} 
	else {
		
		// 결제함수 실행
		requestPay();				
	}

}




/***** 결제 함수 *****/
function requestPay() {


	//let pathname = window.location.pathname;
	//let p_id = pathname.substring(pathname.indexOf("products")+9)
	//console.log(p_id);
	//let p_id = '${product.pid}';
	
	let queryString = window.location.search;
	queryString = queryString.substring(queryString.indexOf('=')+1);
	
	let idlist = queryString.split('%2C');

	let merchant_uid = '';
	for(id of idlist) {
		merchant_uid += id+'-';
	}
	merchant_uid = merchant_uid.substring(0, merchant_uid.length-1);
	console.log(merchant_uid);	
	
	merchant_uid += "_"+'${user.id}'+"-"+new Date().getTime()+Math.random().toString(36).substring(2, 12);
	console.log(merchant_uid);
	
	let amount = $('#total-price').text().replaceAll(',','');
	console.log(amount);
	
	let b_name = document.getElementById('buyer-name').value;
	let b_email = document.getElementById('buyer-email').value;
	let b_tel = document.getElementById('buyer-tel').value;
	
	var IMP = window.IMP;
    IMP.init('imp41250534'); //iamport 대신 자신의 "가맹점 식별코드"를 사용
    IMP.request_pay({
    pg: "html5_inicis.INIpayTest",
    pay_method: "card",
    merchant_uid : merchant_uid,
    name : 'Trackers',	
    amount : amount,
    buyer_email : b_email,	// 인풋값 받아서 사용하는 것으로 변경
    buyer_name : b_name,
    buyer_tel : b_tel,
  }, function (rsp) { // callback
      if (rsp.success) {
      	alert("상품을 구매하셨습니다!");
      	location.href="/store/purchases?page=0";
      } else {
        alert(rsp.error_msg);
      }
  });
    
}





/*
function monthlyPay() {
	
	var IMP = window.IMP;
	  IMP.init('imp41250534');
	  
	IMP.request_pay({
		pg: 'kakaopay',
		pay_method : 'card', // 기능 없음.
		merchant_uid: new Date().getTime(), // 상점에서 관리하는 주문 번호
		name : '정기결제1',
		amount : 0, // 빌링키 발급과 함께 1,004원 결제승인을 시도합니다.
		customer_uid : '4', // 필수 입력
 		buyer_email : 'iamport@siot.do',
		buyer_name : '아임포트',
		buyer_tel : '02-1234-1234' 
	}, function(rsp) {
		if ( rsp.success ) {
			alert('빌링키 발급 성공');
			
			$.ajax({
				url:'/purchaseAgain', //결제 상태를 확인하고 스케줄러를 호출하는 부분
				type : 'POST',
				data:{
					"customer_uid" : '3',
					"price" : 120, 
					"merchant_uid" : new Date().getTime()
				},
				success:function(result) {
					alert('다음 결제 예약');
				}
			});
			
		} else {
			alert('빌링키 발급 실패');
		}
	});

}
*/



function kakaopay(){
	var IMP = window.IMP; // 생략가능
	let customer_uid = '3';
	IMP.init('imp41751598'); 
	IMP.request_pay({
		pay_method : 'card', // 결제창 호출단계에서의 pay_method는 아무런 역할을 하지 못하며, 구매자가 카카오페이 앱 내에서 신용카드 vs 카카오머니 중 실제 선택한 값으로 추후 정정됩니다.
		merchant_uid : new Date().getTime(),
		name : '구독1',
		amount : 130, 
		customer_uid :customer_uid, //customer_uid 파라메터가 있어야 빌링키 발급이 정상적으로 이뤄집니다.
		buyer_email : 'first@mail.com',
		buyer_name : '첫번째',
		buyer_tel : '010-1111-2222'
	}, function(rsp) {
		if ( rsp.success ) {
			
			alert('구독을 시작합니다.');
			/*
			$.ajax({
				url:'/subscribe/1', //DB에 구독정보 등록하는 부분..
				type: 'POST',
				data:{
					//package_id : $('#package_id').val(),
					//customer_id : $('#customer_id').val()
				},
				success:function(result) {
					alert('정기결제 등록'+result);
				}
			});
			*/
			
			/*
		    //alert($('#customer_id').val());
			$.ajax({
				url:'/payment1', //결제 상태를 확인하고 스케줄러를 호출하는 부분
				type : 'POST',
				data:{
					"customer_uid" : customer_uid,
					"price" :120, 
					"merchant_uid" : new Date().getTime()
				},
				success:function(result) {
					alert('다음 결제 예약');
				}
			});
			*/
		} else {
			alert('빌링키 발급 실패');
			}
		});
}	


</script>


<!-- ***** Page Content Starts ***** -->
<main id="purchase" class="broad">

    <section class="section" id="page">
    	<div class="page-title">
            <div class="row justify-content-center">
                <div class="col-lg-12">
                    <div class="section-heading">
                        <h2>구매하기</h2>
                    </div>
                </div>
            </div>
        </div>
		
		
		
		<div class="container">
			
			<div class="notice-content row justify-content-center">
           		<p class="notice col-lg-10 col-md-12"><i class="fa fa-exclamation-circle"></i>본 상품은 실물 상품이 아닌 디지털 상품으로, 주문 및 결제 후 즉시 다운로드가 가능한 콘텐츠입니다.</p>
           	</div>
			
			<div class="row justify-content-center total-items">
				<div class="col-lg-10 col-md-12">
					<h5> 총 ${fn:length(infolist) } 개 상품</h5>
				</div>
			</div>
		
			<div class="row justify-content-center">
            <!-- Product Start -->
            	
	            <c:forEach var="item" items="${infolist}">
					<div class="col-lg-10 col-md-12 info item${item.pid }">
						<div class="row justify-content-center">
			                <div class="col-lg-3 col-md-4 col-sm-5 sm_info">
			                   <div class="thumb">
			                       <a href="/store/products/${item.pid}">
			                           <img src="${item.thumbnail }" alt="${item.p_name } 썸네일">
			                       </a>
			                   </div>
			                </div>
			                <div class="col-lg-8 col-md-7 col-sm-6 sm_info">
			                    <div class="down-content d-flex flex-column justify-content-center product-info">
			                   	    <h6>
			                   	    	<a href="/profiles/${item.url }">${item.store_name }</a>
			                   	    </h6>
			                        <h4>
			                       		<a href="/store/products/${item.pid}">${item.p_name }</a>
			                        </h4>
			                        <h4><span class="number">${item.price-item.sale}</span>원</h4>
			                    </div>
			                </div>
		                </div>
					</div>
				</c:forEach>
			<!-- Product End -->
			
			
			
			<!-- Buyer Info Start -->

				<div class="col-lg-10 col-md-12 buyer-info-title">
					<h5>주문자 정보</h5>
				</div>
				<div class="col-lg-9 col-md-12 buyer-info">
		           	<label for="buyer-name"><p class="must">이름</p></label>
		           	<input type="text" name="name" id="buyer-name" class="form-control" value="${user.name }">
	            </div>
				<div class="col-lg-9 col-md-12 buyer-info">
		           	<label for="buyer-email"><p class="must">이메일</p></label>
		           	<input type="text" name="email" id="buyer-email" class="form-control" value="${user.email }">
	           	</div>
				<div class="col-lg-9 col-md-12 buyer-info">
		           	<label for="buyer-tel"><p class="must">연락처</p></label>
		           	<input type="text" name="tel" id="buyer-tel" class="form-control" value="${user.tel }">
            	</div>
			
			<!-- Buyer Info End -->
			
			
			<!-- 규정 Start -->
				<div class="row col-lg-10 col-md-12 terms">
					<div>
						<h6>디지털 콘텐츠 취소/환불 규정</h6>
						<ul>
							<li>• 디지털콘텐츠의 특성상 구매 후 취소/환불이 불가능합니다.</li>
							<li>• 구매완료 시점부터 횟수 제한 없이 콘텐츠를 다운받아 사용할 수 있습니다.</li>
							<li>• 제공받은 콘텐츠는 별도로 명시되어 있지 않는 이상 상업적으로 이용할 수 없습니다.</li>
							<li>• 트래커스는 통신판매중개업자로서 제공되는 콘텐츠의 소유권을 비롯한 모든 권한과 책임은 모두 제작하는 크리에이터에게 있습니다.</li>
						</ul>
					</div>
				</div>
				<div class="row col-lg-10 col-md-12 justify-content-center accept-terms-container">
					<input type="checkbox" name="accept-terms" id="accept-terms" class="form-check" value="accept">
					<label for="accept-terms"><p class="must">트래커스의 취소 및 환불 규정에 동의합니다.</p></label>
				</div>
			<!-- 규정 End -->
                
                
                <!-- 구매창 -->
                <div class="row col-lg-12 payment">
                	<div class="col-lg-8 down-content d-flex flex-column justify-content-center">
                        <h4><span class="total-price-span">총 <span id="total-price" class="number"></span>원</span> (<span id="total-amount">${fn:length(infolist) }</span>개 상품)</h4>
                    </div>
                    <div class="col-lg-4 d-flex flex-column justify-content-center">
                    	<button class="purchase" type="button" onclick="purchase_chk()">결제하기</button>
                    	<!-- 임시로 링크 걸어둠 (나중에는 체크박스 데이터 넘겨서 가야함) -->
                    </div>
                </div>
                
			</div>
		</div>
    </section>
</main>
<!-- ***** Page Content Ends ***** -->


  
<jsp:include page="/WEB-INF/views/common/footer.jsp" />


