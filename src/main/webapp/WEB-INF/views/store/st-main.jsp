<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<jsp:include page="/WEB-INF/views/common/header.jsp" />
   

<main class="broad" id="st-main"> <!-- 넓은헤더 -->

    <!-- ***** Main Banner Area Start ***** -->
    <div class="main-banner" id="top">
        <div class="container-lg">
            <div class="row"> 
                <div class="col-lg-12">
                    <div class="left-content">
                        <div class="thumb">
                            <div class="inner-content">
                            </div>
                            <img src="/resources/images/banner-logo.png" alt="">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- ***** Main Banner Area End ***** -->

    <!-- ***** 베스트 상품 Area Starts ***** -->
    <section class="section">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <div class="section-heading">
                        <h2>베스트 상품</h2>
                        <span>지금 가장 인기있는 상품들을 만나보세요!</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="best-item-carousel">
                        <div class="owl-best-item owl-carousel">
                        	<c:forEach var="bp" items="${b_products}">
	                            <div class="item" onclick="location.href='/store/products/${bp.pid}'">
	                                <div class="thumb">
	                                    <div class="hover-content">
	                                        <ul>
	                                            <li onclick="preventDefaultGoCart(event, ${bp.pid})"><i class="fa fa-shopping-cart"></i></li>
	                                        </ul>
	                                    </div>
	                                    <img src="${bp.thumbnail}" alt="상품 썸네일">
	                                </div>
	                                <div class="down-content">
	                                    <h4>${bp.pname}</h4>
	                                    <span class="price"> <fmt:formatNumber value="${bp.salePrice}" pattern="#,###" />원</span>
	                                    <c:if test="${bp.sale != 0}"><span class="cost"> <fmt:formatNumber value="${bp.price}" pattern="#,###" />원</span></c:if>
			                            <ul class="stars">
			                                <span class="star">
												★★★★★
												<span style="width: ${bp.rating}%;">★★★★★</span>
											</span>
			                            </ul>
	                                </div>
	                            </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ***** 베스트 상품 Area Ends ***** -->

    <!-- ***** 신상품 Area Starts ***** -->
    <section class="section">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <div class="section-heading">
                        <h2>신상품</h2>
                        <span>새롭게 올라온 상품들을 만나보세요!</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="recent-item-carousel">
                        <div class="owl-recent-item owl-carousel">
                            <c:forEach var="rp" items="${r_products}">
	                            <div class="item" onclick="location.href='/store/products/${rp.pid}'">
	                                <div class="thumb">
	                                    <div class="hover-content">
	                                        <ul>
	                                            <li onclick="preventDefaultGoCart(event, ${rp.pid})"><i class="fa fa-shopping-cart"></i></li>
	                                        </ul>
	                                    </div>
	                                    <img src="${rp.thumbnail}" alt="상품 썸네일">
	                                </div>
	                                <div class="down-content">
	                                    <h4>${rp.pname}</h4>
			                            <span class="price"> <fmt:formatNumber value="${rp.salePrice}" pattern="#,###" />원</span>
			                            <c:if test="${rp.sale != 0}"><span class="cost"> <fmt:formatNumber value="${rp.price}" pattern="#,###" />원</span></c:if>
			                            <ul class="stars">
			                                <span class="star">
												★★★★★
												<span style="width: ${rp.rating}%;">★★★★★</span>
											</span>
			                            </ul>
	                                </div>
	                            </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ***** 신상품 Area Ends ***** -->

    <!-- ***** 인기 크리에이터 Area Starts ***** -->
    <section class="section">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <div class="section-heading">
                        <h2>인기 크리에이터</h2>
                        <span>지금 가장 주목받는 크리에이터들을 만나보세요!</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="creator-item-carousel">
                        <div class="owl-creator-item owl-carousel">
                        	<c:forEach var="bc" items="${b_creators}" varStatus="status">
	                            <div class="item">
                                    <c:choose>
						    			<c:when test="${!empty b_signatures[status.index].thumbnail}">
						    				<div class="thumb creator" onclick="location.href='/store/products/${b_signatures[status.index].pid}'">
						    					<img src="${b_signatures[status.index].thumbnail}" alt="대표 상품 썸네일">
						    				</div>
						    			</c:when>
						    			<c:otherwise>
						    				<div class="thumb creator">
												<img src="/resources/productfile/thumbnail/basic-thumbnail.png" alt="대표 상품 썸네일">
												<p>지정한 대표 상품이 없습니다.</p>
											</div>
										</c:otherwise>
						    		</c:choose>
	                                <div class="down-content d-flex" onclick="location.href='/profiles/${bc.url}'">
	                                	<img src="${bc.profile_img}">
	                                    <h4 class="d-flex flex-column justify-content-center">${bc.storeName}</h4>
	                                </div>
	                            </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ***** 인기 판매자 Area Ends ***** -->
</main>

<script>
	$(() =>{
		imgHeight();		
	});

	$(window).on('resize', function() {
		imgHeight();
	});
	
	function imgHeight(){
		let img = $('.owl-carousel .owl-item .thumb img');
		let w = $(window).width();
		if(w < 576) { 		
			img.css('height', w-30+"px");
		}else if(w < 768){
			img.css('height', "240px");
		}else if(w < 992){
			img.css('height', "330px");
		}else if(w < 1200){
			img.css('height', "290px");
		}else{
			img.css('height', "350px");
		}
	}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	    
	    