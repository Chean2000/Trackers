<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

  <main id="st-inquiry" class="my-info broad my-info-form">
  	
    <section class="section" id="page">
    	<div class="page-title">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-heading">
                        <h2>상품 문의하기</h2>
                    </div>
                </div>
            </div>
        </div>
		<div class="container">
			<div class="row justify-content-center">
				<a class="back" onclick="javascript:history.go(-1);"><span class="fa fa-angle-double-left"></span> 상품 상세보기</a>
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
               		</div>
               	</div>
               	<form class="col-lg-12 form-data" action="/store/products/${p_info.pid}/inquiries" method="post" onsubmit="enter('inquiry-content');">
               		<div class="sub-title">
	               		<h6>문의 제목</h6>
	               		<input type="text" name="title" placeholder="문의 제목 작성" required>
	               	</div>
	               	<div>
	               		<h6>문의 내용</h6>
	               		<textarea id="inquiry-content" name="content" maxlength="300" placeholder="문의 내용 작성" required></textarea>	
               		</div>
               		<input class="management-btn insert-btn" type="submit" value="문의">
               	</form>
			</div>
		</div>
    </section>
  </main>
  
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

