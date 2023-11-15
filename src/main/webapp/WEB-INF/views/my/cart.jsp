<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
      
      
      
<script>

/* 상품 삭제 */
function confirmDelete(obj) {	
	let delFrm = obj.parentElement;
	console.log(delFrm.getAttribute('action'));
	
	if(confirm("상품을 장바구니에서 삭제하시겠습니까?")) {		
		//let delFrm = document.getElementsByName('delete')[0];
		
		
		delFrm.submit();
		
	}
}



	/* 체크박스에 따라 가격, 개수 합산 */							
	function getTotal(){
		let total_price = 0;
		let total_amount = 0;
		
		$('input:checkbox[name=pick]:checked').each(function() {

	        total_amount += 1;
	        
	        let p_id = $(this).val();
	        
				$.ajax({
					type: "get",
					url: "/store/products/price/"+p_id,
					datatype: 'json',
					success: function(data) {						
						let price = Number(data.price)-Number(data.sale);;						
				        total_price += price;
				        
						$('#total-price').text(numberWithCommas(total_price));
					},
					error: function(message) { }
				})
	        
	    });
		$('#total-price').text(numberWithCommas(total_price));
		$('#total-amount').text(total_amount);
	}
	
	$(()=> {		
		getTotal();
	})
	
	
	// 체크박스 p_id 모아서 컨트롤러로 넘겨주기
	function goPurchase() {

		let pidList = new Array();

	    $('input:checkbox[name=pick]:checked').each(function() {
	    	pidList.push(this.value);
	    });
	    
	    let newFrm = document.createElement('form');
	    newFrm.setAttribute('action', '/store/purchases/new');
	    
	    let hidden = document.createElement('input');
	    hidden.setAttribute('type', 'hidden');
	    hidden.setAttribute('name', 'pidList');
	    hidden.setAttribute('value', pidList);
	    newFrm.appendChild(hidden);
	    
	    let main = document.getElementsByTagName('main')[0];
	    main.appendChild(newFrm);

	    newFrm.submit();
		
	}

</script>


<!-- ***** Page Content Starts ***** -->
<main id="cart" class="my-info broad">
    <section class="section" id="page">
    	<div class="page-title">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-heading">
                        <h2>장바구니</h2>
                    </div>
                </div>
            </div>
        </div>
		<div class="container">
			<div class="row justify-content-center total-items">
				<h5> 총 ${fn:length(cartlist) } 개 상품</h5>
			</div>
		
			<div class="row justify-content-center">
            <!-- Product Start -->
            	<c:choose>
	            	<c:when test="${fn:length(cartlist) > 0 }">
		            	<c:forEach var="item" items="${cartlist}">
							<div class="col-lg-12 info item${item.pid }">
								<div class="row justify-content-center">
									<div class="form-check d-flex flex-column justify-content-center">
										<div>
											<label class="form-check-label">
												<input class="form-check-input" type="checkbox" value="${item.pid}" name="pick" onclick="getTotal()" checked>
												<span class="form-check-sign">
													<span class="check"></span>
												</span>
											</label>
										</div>
					                </div>
					                <div class="col-lg-3 col-md-4 col-sm-5 sm_info">
					                   <div class="thumb">
					                       <a href="/store/products/${item.pid}">
					                           <img src="${item.thumbnail}" alt="${item.p_name } 썸네일">
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
					                        <h4><span class="number">${item.price-item.sale }</span>원</h4>
					                    </div>
					                </div>
					                <form name="delete" action="/store/carts/${item.pid }" method="post" class="d-flex flex-column justify-content-center">
					                	<input type="hidden" name = "_method" value = "delete"/>
					                    <i class="fa fa-times" onclick="confirmDelete(this)"></i>
					                </form>
				                </div>
							</div>
		            	</c:forEach>
	            	</c:when>
	            	<c:otherwise>
	            		<h5 class="cart-empty">장바구니에 등록된 상품이 없습니다</h5>
	            	</c:otherwise>
            	</c:choose>
			<!-- Product End -->
                
                
                <!-- 구매창 -->
                <div class="row col-lg-12 payment">
                	<div class="col-lg-8 down-content d-flex flex-column justify-content-center">
                        <h4><span class="total-price-span">총 <span id="total-price" class="number"></span>원</span> (<span id="total-amount"></span>개 상품)</h4>
                    </div>
                    <div class="col-lg-4 d-flex flex-column justify-content-center">
                    	<button class="purchase" type="button" onclick="goPurchase()">구매하기</button>
                    </div>
                </div>
                
			</div>
		</div>
    </section>
</main>
<!-- ***** Page Content Ends ***** -->
 
	<script>	
	
		$(() => {
		
			/* 가격 세자리마다 콤마 넣어주기 */
			let numbers = document.getElementsByClassName('number');
			
			for(num of numbers) {
				let text = num.innerText;
				num.innerText = numberWithCommas(text);
			}
		
		});
	
	</script>

  
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
