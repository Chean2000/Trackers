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



  <main id="notice-popup-form" class="admin wrapper broad"><!-- 추후 좁은헤더로 class명 변경 필요 -->
    <jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />  
    <div class="main-panel">     
      <div class="content">
        <div class="row">
          <div class="col-xl-10 col-lg-12">
            <div class="col-lg-12 card">
              <div class="card-header">
                <h2 class="card-title text-center a-title">팝업 등록</h2>
              </div>
              <div class="card-body">
                <form class="row"  action="" method="post">
                	<div class="col-lg-12">
                		<div class="d-flex flex-column justify-content-center popup-info">
		                	<div>
		                		<h6>제목</h6>
		                		<input class="form-control" type="text" name="popup_title" placeholder="팝업 제목을 입력하세요." required>
		                	</div>
		                	<div>
		                		<h6>시작 일자</h6>
		                		<input id="start-date" class="form-control" type="date" name="popup_start_date" >
		                	</div>
		                	<div>
		                		<h6>종료 일자</h6>
		                		<input id="end-date" class="form-control" type="date" name="popup_end_date">
		                	</div>
		                	<div>
		                		<h6>팝업 이미지</h6>
		                		<input type="file" accept="image/*"  name="popup_img"  onchange="imgPreview(this);" required>
		                		<div id="popup-preview" class="popup-preview">
									<img id="img-modify-white" src="/resources/images/img-modify-white.svg" alt="썸네일 업로드 버튼">
								</div>
		                	</div>
                		</div>
                	</div>
                	<input class="a-btn" type="submit" value="등록">
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </main>
  <script>
	  $(() => {
		  // 시작, 종료 일자 현재로 디폴트 값
		  let date = new Date();
		  let now = date.getFullYear() + "-" +
		  			(date.getMonth() + 1).toString().padStart(2, '0') + "-" +
		  			date.getDate().toString().padStart(2, '0');
		  $('#start-date').val(now);
		  $('#end-date').val(now);
	  });
  
	  /* 썸네일 미리보기 */
	  function imgPreview(input) {
		  if (input.files && input.files[0]) {
		    var reader = new FileReader();
		    reader.onload = function(e) {
		      document.getElementById('popup-preview').style.backgroundImage = "url("+e.target.result+")";
		      document.getElementById('popup-preview').style.backgroundSize = "cover";
		      document.getElementById('popup-preview').style.backgroundColor = "transparent";
		      document.getElementById('img-modify-white').style.display = "none";
		    };
		    reader.readAsDataURL(input.files[0]);
		  } else {
			  document.getElementById('popup-preview').style.backgroundImage = "none";
		      document.getElementById('popup-preview').style.backgroundColor = "#e4e4eb";
		      document.getElementById('img-modify-white').style.display = "block";
		  }
		}
  </script>
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


