<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

  
<jsp:include page="/WEB-INF/views/common/header.jsp" />

  <main id="insert-review" class="my-info broad my-info-form">
  	
    <section class="section" id="page">
    	<div class="page-title">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-heading">
                        <h2>후기 작성</h2>
                    </div>
                </div>
            </div>
        </div>
		<div class="container">
			<div class="row justify-content-center">
				<a href="/store/purchases?page=0" class="back"><span class="fa fa-angle-double-left"></span> 구매 내역</a>
				<div class="col-lg-12 d-flex p-info scroll-custom">
               		<img src="${p_info.thumbnail}" alt="상품 썸네일">
               		<div class="d-flex flex-column justify-content-center p-text-info">
               			<div>
	                		<h6>상품명</h6>
	                		<p>${p_info.p_name}</p>
	                	</div>
	                	<div>
	                		<h6>크리에이터</h6>
	                		<p>${p_info.store_name}</p>
	                	</div>
	                	<div>
	                		<h6>구매 일자</h6>
	                		<p>${p_info.creDate}</p>
	                	</div>
               		</div>
               	</div>
               	<form class="col-lg-12 form-data" action="/store/reviews/${p_info.bak_p_id}" method="post" onsubmit="enter('review-content');">
               		<c:choose>
				    	<c:when test="${!empty review.content}">	<!-- 리뷰 존재 --> 
				    		<div class="sub-title">
		                		<h6>별점</h6>
		                		<span class="star">
									★★★★★
									<span style="width:${review.rating}%">★★★★★</span>
								</span>
		                	</div>
		                	<div>
		               			<h6>후기</h6>
		               			<p class="my-info-p">${review.content}</p>
		               		</div>
				    	</c:when>		
				    	<c:otherwise>		<!-- 리뷰 존재 x -->
				    		<div class="sub-title">
		                		<h6>별점</h6>
		                		<span class="star">
									★★★★★
									<span>★★★★★</span>
									<input type="range" name="rating" oninput="score(this);" value="0" step="1" min="0" max="10">
								</span>
		                	</div>
		                	<div>
		               			<h6>후기</h6>
		               			<textarea id="review-content" name="content" maxlength="300" placeholder="후기 내용을 입력하세요." required></textarea>
			               		<input class="form-btn" type="submit" value="작성">
		               		</div>
				    	</c:otherwise>
			    	</c:choose>
               	</form>
               	<c:if test="${!empty review.content}">
	               	<div class="col-lg-12">
	               		<h6 class="answer">크리에이터 답변</h6>
	               		<c:choose>
					    	<c:when test="${!empty review.answer}">
	               				<p class="my-info-p">${review.answer}</p>
					    	</c:when>		
					    	<c:otherwise>
	               				<p class="my-info-p">크리에이터가 답변을 작성하지 않았습니다.</p>
					    	</c:otherwise>
				    	</c:choose>
	               	</div>
               	</c:if>
			</div>
		</div>
    </section>
  </main>

  <script>
		// score
		function score(event){
		    $('.star span').css('width', $(event).val() * 10+'%');
		}
  </script>
  <script src="/resources/js/my-store.js"></script>
  
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
