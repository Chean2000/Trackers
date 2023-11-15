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



  <main id="notice-management" class="my-store wrapper narrow">
    <jsp:include page="/WEB-INF/views/common/sidebar.jsp" />  
    <div class="main-panel">
      <div class="content">      
        <div class="row justify-content-center">
          <div class="col-xl-10 col-lg-12">
            <div class="card">
              <h2 class="card-title text-center management-title">공지 관리</h2>
              <form class="card-body" action="">
                <div class="row notice-box">
	                <div class="notice col-lg-12">
	                	<textarea name="notice" maxlength="300" placeholder="공지 작성" required></textarea>
	                </div>
	             </div>
               	 <div class="col-lg-12 btn-box">
               	 	 <input name="notice_img" type="file" accept="image/*" multiple>
               		 <input class="management-btn insert-btn" type="submit" value="작성">
               	 </div>
              </form>
            </div>

            <div class="card">
              <form class="card-body" action='#' method='post'>
                <div class="row notice-box">
	                <div class="notice col-lg-12">
	                	<h6>
	                		안녕하세요. ooo몰입니다!<br>
	                		~~~<br>
	                		~~~~~~~<br>
	                		~~~~~~~~~~~~~~~~~~<br>
	                		~~~~~~~~~~~~~~~~~~~~~~~~~~
	                	</h6>
	                	<div class="d-flex justify-content-start img-box scroll-custom">
		                	<img src="/resources/images/men-01.jpg" alt="">
		                	<img src="/resources/images/men-01.jpg" alt="">
		                	<img src="/resources/images/men-01.jpg" alt="">
	                	</div>
	                </div>
	             </div>
               	 <div class="col-lg-12 btn-box">
               		 <input class="management-btn" type="submit" value="삭제">
               		 <input class="management-btn" type="button" onclick="notice_modify(this);" value="수정">
               	 </div>
              </form>
            </div>
            <div class="card">
              <form class="card-body" action='#' method='post'>
                <div class="row notice-box">
	                <div class="notice col-lg-12">
	                	<h6>
	                		안녕하세요. ooo몰입니다!<br>
	                		~~~<br>
	                		~~~~~~~<br>
	                		~~~~~~~~~~~~~~~~~~<br>
	                		~~~~~~~~~~~~~~~~~~~~~~~~~~
	                	</h6>
	                	<div class="d-flex justify-content-start img-box scroll-custom">
		                	<img src="/resources/images/men-01.jpg" alt="">
		                	<img src="/resources/images/men-01.jpg" alt="">
		                	<img src="/resources/images/men-01.jpg" alt="">
	                	</div>
	                </div>
	             </div>
               	 <div class="col-lg-12 btn-box">
               		 <input class="management-btn" type="submit" value="삭제">
               		 <input class="management-btn" type="button" onclick="notice_modify(this);" value="수정">
               	 </div>
              </form>
            </div>
            <div class="card">
              <form class="card-body" action='#' method='post'>
                <div class="row notice-box">
	                <div class="notice col-lg-12">
	                	<h6>
	                		안녕하세요. ooo몰입니다!<br>
	                		~~~<br>
	                		~~~~~~~<br>
	                		~~~~~~~~~~~~~~~~~~<br>
	                		~~~~~~~~~~~~~~~~~~~~~~~~~~
	                	</h6>
	                	<div class="d-flex justify-content-start img-box scroll-custom">
		                	<img src="/resources/images/men-01.jpg" alt="">
		                	<img src="/resources/images/men-01.jpg" alt="">
		                	<img src="/resources/images/men-01.jpg" alt="">
	                	</div>
	                </div>
	             </div>
               	 <div class="col-lg-12 btn-box">
               		 <input class="management-btn" type="submit" value="삭제">
               		 <input class="management-btn" type="button" onclick="notice_modify(this);" value="수정">
               	 </div>
              </form>
            </div>
            <div class="card">
              <form class="card-body" action='#' method='post'>
                <div class="row notice-box">
	                <div class="notice col-lg-12">
	                	<h6>
	                		안녕하세요. ooo몰입니다!<br>
	                		~~~<br>
	                		~~~~~~~<br>
	                		~~~~~~~~~~~~~~~~~~<br>
	                		~~~~~~~~~~~~~~~~~~~~~~~~~~
	                	</h6>
	                	<div class="d-flex justify-content-start img-box scroll-custom">
		                	<img src="/resources/images/men-01.jpg" alt="">
		                	<img src="/resources/images/men-01.jpg" alt="">
		                	<img src="/resources/images/men-01.jpg" alt="">
	                	</div>
	                </div>
	             </div>
               	 <div class="col-lg-12 btn-box">
               		 <input class="management-btn" type="submit" value="삭제">
               		 <input class="management-btn" type="button" onclick="notice_modify(this);" value="수정">
               	 </div>
              </form>
            </div>
          </div>
          
          <!-- 페이지 번호 -->
          <div class="col-lg-12">
	          <div class="pagination">
	              <ul>
	                  <li>
	                      <a href="#"><</a>
	                  </li>
	                  <li>
	                      <a href="#">1</a>
	                  </li>
	                  <li class="active">
	                      <a href="#">2</a>
	                  </li>
	                  <li>
	                      <a href="#">3</a>
	                  </li>
	                  <li>
	                      <a href="#">4</a>
	                  </li>
	                  <li>
	                      <a href="#">></a>
	                  </li>
	              </ul>
	          </div>
	        </div>
        </div>
      </div>
    </div>
  </main>

  

  <script src="/resources/js/my-store.js"></script>
  <script>
  	function notice_modify(event){
  		let notice = $(event).parent().prev().children();
  		let content = $(event).parent().prev().children().children().eq(0);
  		
  		let btn = "<input class='management-btn' type='submit' value='완료'>";
  		let form = "<textarea name='notice_edit' maxlength='300' placeholder='공지 작성' required>"+content.html().replace(/\s/gi, '').replace(/(<br>|<br\/>|<br \/>)/gi, '\r\n')+"</textarea>";
  		
  		$(notice).children('h6').remove();
  		$(notice).prepend(form);
  		$(event).after(btn);
  		$(event).remove();
  	}
  </script>
  
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


