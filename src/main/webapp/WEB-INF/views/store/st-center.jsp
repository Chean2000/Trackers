<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

  
<jsp:include page="/WEB-INF/views/common/header.jsp" />

  <main id="st-center" class="my-info broad my-info-form">
  	
    <section class="section" id="page">
    	<div class="page-title">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-heading">
                        <h2>고객센터 문의</h2>
                    </div>
                </div>
            </div>
        </div>
		<div class="container">
			<div class="row justify-content-center">
				<a class="back" href="/store/main">&lt; 스토어 메인으로 돌아가기</a>
               	<form class="col-lg-12 form-data">
               		<div class="sub-title">
	               		<h6>문의 제목</h6>
	               		<input type="text" name="title" placeholder="문의 제목 작성">
	               	</div>
	               	<div>
	               		<h6>문의 내용</h6>
	               		<textarea name="inquiry_answer" maxlength="300" placeholder="문의 내용 작성" required></textarea>	
               		</div>
               		<input class="management-btn insert-btn" type="submit" value="문의">
               	</form>
			</div>
		</div>
    </section>
  </main>
  
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

