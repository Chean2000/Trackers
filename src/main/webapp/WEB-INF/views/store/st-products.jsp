<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 

<jsp:include page="/WEB-INF/views/common/header.jsp" />

   
<!-- ***** Products Area Starts ***** -->
<main id="products" class="broad"> <!-- 넓은헤더 -->    
    <section class="section">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-heading list-heading">
                        <h2>상품</h2>
                        <span>지금 판매 중인 상품들을 만나보세요</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
        <main id="creators">
        	<div class="row justify-content-center">
        	    <!-- 상품정렬 버튼 추가 -->
            	<div class="col-lg-12 d-flex justify-content-between sort">
					<div id="category-path" class="d-flex">
						<h5 class="d-flex flex-column justify-content-center"></h5>
					</div>
					<form action="/store/products" method="get">
						<input type="hidden" name="page" value="0">
						<select name="sort" onchange="this.form.submit();">
							<option value="creDate" <c:if test="${sort eq 'creDate'}">selected</c:if>>최신순</option>
							<option value="popularity" <c:if test="${sort eq 'popularity'}">selected</c:if>>인기순</option>
							<option value="highprice" <c:if test="${sort eq 'highprice'}">selected</c:if>>높은가격순</option>
							<option value="lowprice" <c:if test="${sort eq 'lowprice'}">selected</c:if>>낮은가격순</option>
						</select>
						<input type="hidden" name="category" value="${category}">
						<c:if test="${!empty keyword || keyword ne '' }">
							<input type="hidden" name="keyword" value="${keyword}">
						</c:if>
					</form>
				</div>
        	</div>
         </main>        	
            <div class="row">
       
       			<c:if test="${(!empty keyword || keyword ne '') && products.totalElements == 0}">
					<div class="empty-search">
						<p>'<span>${keyword}</span>' 검색 결과가 없습니다.</p>
					</div>
				</c:if>
 				<!-- Product Card Start -->
            	<c:forEach var="i" items="${products.content}">
            		<div class="col-lg-4">
	                    <div class="item" onclick="location.href='/store/products/${i.pid}'">
	                        <div class="thumb">
	                            <div class="hover-content">
	                                <ul>
		                                <c:choose>
			                        		<c:when test="${user.id == null }">
			                        			<li onclick="loginAlert(event)"><i class="fa fa-shopping-cart"></i></li>
			                        		</c:when>
			                        		<c:otherwise>
		   										<li onclick="preventDefaultGoCart(event, '${i.pid}')"><i class="fa fa-shopping-cart"></i></li>
			                        		</c:otherwise>
			                        	</c:choose>
	                                    
	                                </ul>
	                            </div>
	                            <img src="${i.thumbnail}" alt="상품 썸네일">
	                        </div>
	                        <div class="down-content">
	                            <h4>${i.pname}</h4>
	                            <span class="price"> <fmt:formatNumber value="${i.salePrice}" pattern="#,###" />원</span>
	                            <c:if test="${i.sale != 0}"><span class="cost"> <fmt:formatNumber value="${i.price}" pattern="#,###" />원</span></c:if>
	                            <ul class="stars">
	                                <span class="star">
										★★★★★
										<span style="width: ${i.rating}%;">★★★★★</span>
										<input type="range" value="1" step="1" min="0" max="10">
									</span>
	                            </ul>
	                        </div>
	                    </div>
	                </div>
            	</c:forEach>
                <!-- Product Card End -->
               
                <div class="col-lg-12">
                    <div class="pagination">
                        <ul>
                        	<c:choose>
								<c:when test="${!empty keyword || keyword ne '' }"> <!-- 검색 o -->
									<c:if test="${products.number-1 >= 0}" >
							    		<li>
								            <a href="/store/products?page=${products.number-1}&sort=${sort}&category=${category}&keyword=${keyword}">&lt;</a>
								        </li>
							    	</c:if>
							    	<c:forEach var="p" begin="${startPage}" end="${endPage}">
						    			<li <c:if test="${p == nowPage}">class='active'</c:if>>
								            <a href="/store/products?page=${p-1}&sort=${sort}&category=${category}&keyword=${keyword}">${p}</a>
								        </li>	
									</c:forEach>
									<c:if test="${products.number+1 < products.totalPages }" >
							    		<li>
							           		<a href="/store/products?page=${products.number+1}&sort=${sort}&category=${category}&keyword=${keyword}">&gt;</a>
							        	</li>
							    	</c:if>
								</c:when>
								<c:otherwise> <!-- 검색 x -->
									<c:if test="${products.number-1 >= 0}" >
							    		<li>
								            <a href="/store/products?page=${products.number-1}&sort=${sort}&category=${category}">&lt;</a>
								        </li>
							    	</c:if>
							    	<c:forEach var="p" begin="${startPage}" end="${endPage}">
						    			<li <c:if test="${p == nowPage}">class='active'</c:if>>
								            <a href="/store/products?page=${p-1}&sort=${sort}&category=${category}">${p}</a>
								        </li>	
									</c:forEach>
									<c:if test="${products.number+1 < products.totalPages }" >
							    		<li>
							           		<a href="/store/products?page=${products.number+1}&sort=${sort}&category=${category}">&gt;</a>
							        	</li>
							    	</c:if>
								</c:otherwise> 
							</c:choose>
					    </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ***** Products Area Ends ***** -->
    
</main>  

<script>
	$(() =>{
		
		let params = new URL(location.href).searchParams;
		let category = params.get('category');
		let h5 = $("#category-path h5");
		console.log(h5);
		console.log(category);
		
		if(category == 'whole') h5.text('페이지 별 > 한달 세트');
		else if(category == 'monthly') h5.text('페이지 별 > 먼슬리');
		else if(category == 'weekly') h5.text('페이지 별 > 위클리');
		else if(category == 'habit') h5.text('페이지 별 > 해빗트래커');
		else if(category == 'mood') h5.text('페이지 별 > 무드트래커');
		else if(category == 'reading') h5.text('페이지 별 > 독서트래커');
		else if(category == 'expense') h5.text('페이지 별 > 가계부');
		else if(category == 'study') h5.text('페이지 별 > 스터디');
		else if(category == 'sticker') h5.text('페이지 별 > 스티커');
		else if(category == 'etc') h5.text('페이지 별 > 그 외');
		else if(category == 'minimal') h5.text('디자인 별 > 미니멀');
		else if(category == 'illustration') h5.text('디자인 별 > 일러스트');
		else if(category == 'photo') h5.text('디자인 별 > 포토');
		else h5.text('전체');
		
		imgHeight();		
		
	});

	$(window).on('resize', function() {
		imgHeight();
	});
	
	function imgHeight(){
		let img = $('#products .item .thumb img');
		let w = $(window).width();
		if(w < 576) { 		
			img.css('height', w-30+"px");
		}else if(w < 768){
			img.css('height', "510px");
		}else if(w < 992){
			img.css('height', "690px");
		}else if(w < 1200){
			img.css('height', "289.98px");
		}else{
			img.css('height', "350px");
		}
	}
	
</script>
    
<jsp:include page="/WEB-INF/views/common/footer.jsp" /> 
    