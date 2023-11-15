<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

  
<jsp:include page="/WEB-INF/views/common/header.jsp" />

  <main id="product-inquiry" class="my-info broad my-info-form">
  	
    <section class="section" id="page">
    	<div class="page-title">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-heading">
                        <h2>나의 문의</h2>
                    </div>
                </div>
            </div>
        </div>
		<div class="container">
			<div class="row justify-content-center">
				<a href="/store/inquiries?page=0" class="back"><span class="fa fa-angle-double-left"></span> 문의 내역</a>
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
	                		<h6>작성 일자</h6>
	                		<p>${fn:substring(inquiry.creDate, 0, 10)}</p>
	                	</div>
               		</div>
               	</div>
               	<div class="col-lg-12 form-data">
               		<div class="sub-title">
	               		<h6>문의 제목</h6>
	               		<p>${inquiry.title}</p>
	               	</div>
	               	<div>
	               		<h6>문의 내용</h6>
	               		<p class="sub-content">${inquiry.content}</p>
               		</div>
               	</div>
               	<div class="col-lg-12 form-data">
               		<h6 class="answer">문의 답변</h6>
               		<c:choose>
				    	<c:when test="${!empty inquiry.answer}">
               				<p>답변 일자: <span>${inquiry.answer_date}</span></p>
               				<p class="sub-content">${inquiry.answer}</p>
				    	</c:when>		
				    	<c:otherwise>
               				<p class="my-info-p">답변 대기 중 입니다</p>
				    	</c:otherwise>
			    	</c:choose>
               	</div>
			</div>
		</div>
    </section>
  </main>
  
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

