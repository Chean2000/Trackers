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



  <main id="subscribe-management" class="my-store wrapper narrow">
    <jsp:include page="/WEB-INF/views/common/sidebar.jsp" />  
    <div class="main-panel">     
      <div class="content">
        <div class="row">
          <div class="col-xl-10 col-lg-12">
            <div class="col-lg-12 card">
              <div class="card-header">
                <h2 class="card-title text-center management-title">구독 상품 관리</h2>
              </div>
              <div class="card-body">
				<div>
					<div class="store-form subscribe-form">
			           	<label for="subscribe"><h5>구독 활성화 여부</h5></label>
			           	<div class="do-subscribe">
			           		<label for="yes-subscribe">활성화</label>
			           		<input type="radio" name="subscribe" id="yes-subscribe" value="true" <c:if test="${!empty subscribe}">checked</c:if>>
			           		<label for="no-subscribe">비활성화</label>
			           		<input type="radio" name="subscribe" id="no-subscribe" value="false" <c:if test="${empty subscribe}">checked</c:if>>
			           	</div>	 
			           	
			           	<form id="subscribe-form" action="/store/subscribes" method="post" enctype="multipart/form-data">
			           		<div class="subscribe-info">
				           		<div class="row flex-column">
					           		<label for="subscribe-content"><h5>구독 내용</h5></label>
					           		<div class="form-control-container d-flex subscribe">
					           			<textarea name="content" id="subscribe-content" class="form-control store-input" maxlength="300" placeholder="구독 내용 작성" required>${subscribe.content}</textarea>
						           	</div>
					           	</div>
					           	<div class="row flex-column">
					           		<label for="subscribe-price"><h5>구독 가격</h5></label>
					           		<div class="form-control-container d-flex subscribe">
						           		<span>&#8361;</span>
						           		<input type="text" name="price" id="subscribe-price" class="form-control store-input" value="${price}" placeholder="구독 가격을 입력하세요." oninput="remove(4, this); comma(this);" required>
						           	</div>
					           	</div>
					           	<div class="row flex-column">
					           		<label><h5>구독 상품</h5></label>
						           	<p class="desc">∙ 구독한 구매자들이 다운로드 받을 <b>압축 파일(.zip)</b>을 등록해주세요</p>
						           	<p class="desc">∙ 파일 용량이 너무 크면 구매자가 다운로드를 하기 어려울 수 있으니 유의해주세요</p>
						           	<p class="desc">∙ 등록하는 콘텐츠가 타인의 저작권 또는 초상권을 침해하지 않도록 유의해주세요</p>
		           					<div class="d-flex align-content-center file-input-container">
										<input type="file" accept=".zip" name="mfile" required>
					           		</div>
					           	</div>
							</div>
							<input type="button" class="main-btn management-btn" value="수정" onclick="subscribe();">
			            </form>
			            <form id="delete-form" action="/store/subscribes" method="post">
			           		<input type='hidden' name='_method' value='delete'>
			            </form>
					</div>
				</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </main>

  <script>
	$(() => {

		//구독정보 슬라이드업다운		
		if($('#yes-subscribe').attr('checked') == 'checked'){
			$('.subscribe-info').show();
			$('input[name=mfile]').attr('required', 'required');
		}else{
			$('.subscribe-info').hide();
			$('input[name=mfile]').removeAttr("required");
		}
		
		$('#no-subscribe').on('click', function() {
			$('.subscribe-info').slideUp('300');
			$('input[name=mfile]').removeAttr("required");
			$("#subscribe-form").prepend("<input type='hidden' name='_method' value='delete'>"); 
		});
		$('#yes-subscribe').on('click', function() {
			$('.subscribe-info').slideDown('300');
			$('input[name=mfile]').attr('required', 'required');
		});
	});
	
	function comma(event){
		$('#subscribe-price').val(numberWithCommas($(event).val()));
	}
	
	function remove_comma(){
		let price = $('#subscribe-price').val();
		$('#subscribe-price').val(price.replaceAll(',', ''));
	}
	
	function subscribe(){
		if($('.subscribe-info').css('display') == 'block'){
			remove_comma();
			$("#subscribe-form").submit();
		}
		else if($('.subscribe-info').css('display') == 'none'){		// 만약 비활성화 누르고 수정 시 삭제되는걸로
			if(confirm('정말 구독 상품을 삭제 하시겠습니까?')){
				$("#delete-form").submit();
			}
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


