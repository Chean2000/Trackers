function getParameterValueFromUrl() {
  var url = window.location.href; // 현재 페이지의 URL을 가져옴
  var parts = url.split('/'); // URL을 "/"로 나눔

  // parts 배열에서 마지막 요소(즉, "test6" 부분)를 추출하여 반환
  return parts[parts.length - 1];
}



/*  구독 결제창 띄우기 (실제 결제 X)  */
function testpay(subscribe_id, id, payment, pay_date){
	var IMP = window.IMP; 
	let customer_uid = 'sub'+'-'+subscribe_id+'-'+id;
	IMP.init('imp41751598'); 
	IMP.request_pay({
		pay_method : 'card', 
		merchant_uid : new Date().getTime(),
		name : '구독',
		amount : 100, 
		customer_uid :customer_uid, //customer_uid 파라메터가 있어야 빌링키 발급이 정상적으로 이뤄집니다.
		buyer_email : 'first@mail.com',
		buyer_name : '첫번째',
		buyer_tel : '010-1111-2222'
	}, function(rsp) {
		if ( rsp.success ) {
		 
		 
		 
			var value = getParameterValueFromUrl();
			
			const params = {
				subscribeId:subscribe_id, 
				id:id, 
				payment: customer_uid
				//payDate:pay_date
			}
		
			$.ajax({
				url : "/profile/"+value,
				type : "POST",
				contentType: "application/json;charset=UTF-8",
				dataType : "json",
				data : JSON.stringify(params),
    			async : false,
				success : function(result) {
			
					
					alert("error");
					$('#subModal').modal('hide');	
			     },
				error : function(result) {
					alert('구독을 시작합니다.');
					
					//console.log(status, error);
					$('#subModal').modal('hide');
					 window.location.href = "/profiles/" + value;
					
				}
			});	
								
		} else {
			alert('빌링키 발급 실패');
			$('#subModal').modal('hide');
			}
		});
}




/*  이니시스 정기결제창   */

function sub_pay(subscribe_id, id) {

	let merchant_uid = 'test_m_uid';
	let amount = 100;

	var IMP = window.IMP;
    IMP.init('imp41250534'); 
    IMP.request_pay({
    //pg: "TC0ONETIME",
    customer_uid: "test_0001_1234",	// 카드(빌링키)와 1:1로 대응하는 값
    pay_method: "card",
    merchant_uid : merchant_uid,
    name : 'Trackers',	
    amount : amount,
    buyer_email : 'test@mail.com',
    buyer_name : '구독자',
    buyer_tel : '010-9988-7766',
    }, function (rsp) { // callback
        if (rsp.success) {
        	
        	alert('빌링키 발급');
        	
        	let value = getParameterValueFromUrl();
        	
        	$.ajax({
				url : "/profile/"+value,
				type : "POST",
				headers: { "Content-Type": "application/json" },
				dataType : "json",
				data : {
					subscribeId:subscribe_id, 
					id:id, 
					payment: "test_0001_1234"	// 카드(빌링키)와 1:1로 대응하는 값 
					//, payDate:pay_date
				},
    			async : false,
				success : function(result) {		
					
					alert('구독을 시작합니다.');
					$('#subModal').modal('hide');	
			     },
				error : function(result) {
					
					alert("error");
					//console.log(status, error);
					$('#subModal').modal('hide');
					 window.location.href = "/profiles/" + value;
					
				}
			});	
        	       	
        	
        } else {
            alert(rsp.error_msg);
        }
    });

}









