<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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



  <main id="customer-center-form" class="admin wrapper broad"><!-- 추후 좁은헤더로 class명 변경 필요 -->
    <jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />  
    <div class="main-panel">     
      <div class="content">
        <div class="row">
          <div class="col-xl-10 col-lg-12">
            <div class="col-lg-12 card">
              <div class="card-header">
                <h2 class="card-title text-center a-title">문의 답변</h2>
              </div>
              <div class="card-body">
                <div class="row">
                	<div class="col-lg-12 d-flex a-info scroll-custom">
                		<div class="d-flex flex-column justify-content-center a-text-info">
		                	<div>
		                		<h6>작성 일자</h6>
		                		<p>2023.06.28</p>
		                	</div>
		                	<div>
		                		<h6>작성자</h6>
		                		<p>이고객</p>
		                	</div>
		                	<div>
		                		<h6>문의 제목</h6>
		                		<p>영구 다운로드 가능한가요?</p>
		                	</div>
                		</div>
                	</div>
                	<div class="col-lg-12">
                		<h6>문의 내용</h6>
                		<p>구매하면 영구 다운로드인가요</p>
                	</div>
                	<form class="col-lg-12" action="">
                		<textarea name="customer_inquiry" maxlength="300" placeholder="답변 내용 작성" required></textarea>
                		<input class="a-btn" type="submit" value="답변">
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


