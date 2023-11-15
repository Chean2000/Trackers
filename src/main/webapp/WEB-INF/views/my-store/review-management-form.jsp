<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

  <!-- 
  =========================================
		dash-board template  
  =========================================
   -->     
    
  <!-- Fonts and icons -->
  <!-- <link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" rel="stylesheet"> -->
  
  <!-- Nucleo Icons -->
  <link href="/resources/css/nucleo-icons.css" rel="stylesheet" />
  
  <!-- CSS Files -->
  <link href="/resources/css/black-dashboard.css" rel="stylesheet" />
  
    

<jsp:include page="/WEB-INF/views/common/header.jsp" />



  <main id="review-management-form" class="my-store wrapper broad management-form narrow"><!-- 추후 좁은헤더로 class명 변경 필요 -->
    <jsp:include page="/WEB-INF/views/common/sidebar.jsp" />  
    <div class="main-panel">     
      <div class="content">
        <div class="row">
          <div class="col-xl-10 col-lg-12">
            <div class="col-lg-12 card">
              <div class="card-header">
                <h2 class="card-title text-center management-title">후기 답변</h2>
              </div>
              <div class="card-body">
                <div class="row">
                	<div class="col-lg-12 d-flex p-info scroll-custom">
                		<img src="${p_info.thumbnail}" alt="상품 썸네일">
                		<div class="d-flex flex-column justify-content-center p-text-info">
                			<div>
		                		<h6>상품명</h6>
		                		<p>${p_info.p_name}</p>
		                	</div>
		                	<div>
		                		<h6>작성자</h6>
		                		<p>${review.name}</p>
		                	</div>
		                	<div>
		                		<h6>작성 일자</h6>
		                		<p>${review.creDate}</p>
		                	</div>
                		</div>
                	</div>
                	<div class="col-lg-12">
	                	<div class="management-data">
	                		<h6>별점</h6>
	                		<span class="star">
								★★★★★
								<span style="width: ${review.rating}%;">★★★★★</span>
							</span>
	                	</div>
                		<h6>후기</h6>
                		<p>${review.content}</p>
                	</div>
                	<form class="col-lg-12" action="/store/reviews/${review.pid}/${review.id}/comments" method="post" onsubmit="enter('answer');">		
                		<h6>답변</h6>
                		<c:choose>	
						    <c:when test="${!empty review.answer}">	<!-- 답변 존재 --> 
					    		<p class="answer-p">${review.answer}</p>
					    	</c:when>		
					    	<c:otherwise>		<!-- 답변 존재 x -->
					    		<textarea id="answer" name="answer" maxlength="300" placeholder="답변 내용 작성" required></textarea>
       	         				<input class="management-btn insert-btn" type="submit" value="답변">
					    	</c:otherwise>
				    	</c:choose>
                	</form>
                </div>
              </div>
            </div>
          </div>
        </div>

      </div>
      
      

    </div>
  </main>
  <script src="/resources/js/my-store.js"></script>
  
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

   

<!--
=========================================================
* * Black Dashboard - v1.0.1
=========================================================

* Product Page: https://www.creative-tim.com/product/black-dashboard
* Copyright 2019 Creative Tim (https://www.creative-tim.com)


* Coded by Creative Tim

=========================================================

* The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
-->


