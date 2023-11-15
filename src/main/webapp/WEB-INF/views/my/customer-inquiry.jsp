<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

  
<jsp:include page="/WEB-INF/views/common/header.jsp" />

  <main id="customer-inquiry" class="my-info broad my-info-form">
  	
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
				<a href="/store/center/inquires" class="back">&lt; 문의 내역</a>
               	<div class="col-lg-12 form-data">
	               	<div class="sub-title">
	               		<h6>작성 일자</h6>
	               		<p>2023.07.02</p>
	               	</div>
               		<div class="sub-title">
	               		<h6>문의 제목</h6>
	               		<p>영구 다운로드 가능한가요?</p>
	               	</div>
	               	<div>
	               		<h6>문의 내용</h6>
	               		<p class="sub-content">구매하면 영구 다운로드인가요</p>
               		</div>
               	</div>
               	<div class="col-lg-12 form-data">
               		<h6 class="answer">문의 답변</h6>
               		<p>답변 일자: <span>2023.07.02</span></p>
               		<p class="sub-content">그렇습니다! 크리에이터가 상품을 삭제해도 삭제 전 구매 시 다운로드 가능합니다!</p>
               	</div>
			</div>
		</div>
    </section>
  </main>
  
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

