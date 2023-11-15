<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<!-- ***** Page Content Starts ***** -->
<main id="purchase-history" class="my-info broad">

    <section class="section" id="page">
    	<div class="page-title">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-heading">
                        <h2>구매 내역</h2>
                    </div>
                </div>
            </div>
        </div>
		<div class="container">
			<div class="row justify-content-center">
				<c:if test="${empty purchases.content}">
                	<div class="empty-data">
                 	  	<p>구매 내역이 없습니다.</p>
                 	</div>
                </c:if>	
           	 	<!-- Product 구매 내역 Start -->
            	<c:forEach var="p" items="${purchases.content}">
					<div class="col-lg-12 info">
						<div class="row">
			                <div class="col-lg-3 col-md-4 col-sm-5 sm_info">
			                   <div class="thumb">
			                       <a <c:if test="${!empty p.c_id}">href="/store/products/${p.bak_p_id}"</c:if>><img src="${p.thumbnail}" alt="상품 썸네일"></a>
			                   </div>
			                </div>
			                <div class="col-lg-7 col-md-5 col-sm-4 sm_info">
			                    <div class="down-content d-flex flex-column justify-content-center product-info">
			                   	    <h6>${p.store_name}</h6>
			                        <h4>${p.p_name}</h4>
			                        <h4><fmt:formatNumber value="${p.price}" pattern="#,###" />원</h4>
			                        <h6>${p.creDate}</h6>
			                    </div>
			                </div>
			                <div class="col-lg-2 col-md-3 col-sm-3 d-flex flex-column justify-content-center">
			                    <div class="d-flex flex-column justify-content-center">
				                    <button type="button" class="download button" onclick="window.open('about:blank').location.href='https://drive.google.com/file/d/${p.file}'">다운로드</button>
				                    <button type="button" class="review button" onclick="location.href='/store/reviews/${p.bak_p_id}'">후기 작성</button>			                    
			                    </div>
			                </div>
		                </div>
					</div>
				</c:forEach>
				<!-- Product 구매 내역 End -->
                      
                <!-- 페이지 번호 -->
                <div class="col-lg-12">
	                 <div class="pagination">
	                     <ul>
	                     	<c:if test="${purchases.number-1 >= 0}" >
					    		<li>
						            <a href="/store/purchases?page=${purchases.number-1}">&lt;</a>
						        </li>
					    	</c:if>
					    	<c:forEach var="p" begin="${startPage}" end="${endPage}">
				    			<li <c:if test="${p == nowPage}">class='active'</c:if>>
						            <a href="/store/purchases?page=${p-1}">${p}</a>
						        </li>	
							</c:forEach>
							<c:if test="${purchases.number+1 < purchases.totalPages }" >
					    		<li>
					           		<a href="/store/purchases?page=${purchases.number+1}">&gt;</a>
					        	</li>
					    	</c:if>
	                     </ul>
	                 </div>
                </div>
			</div>
		</div>
    </section>
</main>
<!-- ***** Page Content Ends ***** -->


  
<jsp:include page="/WEB-INF/views/common/footer.jsp" />


