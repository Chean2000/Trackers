<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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


<!-- product-management JS -->
<script src="/resources/js/product-management.js"></script>
	
	
	

  <main id="product-management" class="my-store wrapper narrow">
    <jsp:include page="/WEB-INF/views/common/sidebar.jsp" />  
    <div class="main-panel">     
      <div class="content">
      	<div class="row justify-content-center listtop">
      		<div class="col-xl-10 col-lg-12 d-flex justify-content-between align-items-center">
				<div>
					<h5>총 ${totalProducts} 개 상품</h5>
				</div>
				<!-- 상품 등록 버튼 -->
				<button type="button" onclick="location.href='/store/my/products/new'">신규 상품 등록</button>
			</div>
      	</div>
      	       
        
        
        <!-- 상품 목록 -->
        <c:choose>
            <c:when test="${fn:length(productList) > 0 }">
                <c:forEach var="product" items="${productList}">
                    <div class="row justify-content-center">
                    	<!-- 상품 정보 표시 -->
                        <div class="col-xl-10 col-lg-12 info" data-product-id="${product.pid}">
                            <div class="card">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-lg-3 col-md-4 col-sm-5 sm_info">
                                            <div class="thumb">
                                                <a href="/store/products/${product.pid}"><img src="${product.thumbnail}" alt="thumbnail"></a>
                                            </div>
                                        </div>
                                        <div class="col-lg-7 col-md-5 col-sm-4 sm_info">
                                            <div class="down-content d-flex flex-column justify-content-around product-info">
                                                <h5>${product.p_name}</h5>
                                                <div class="d-flex align-items-center">
	                                                <h4 class="<c:if test="${product.sale > 0}">discount</c:if>">${product.price}원</h4>
	                                                <c:if test="${product.sale > 0}">
	                                                	<h4>${product.price - product.sale}원</h4>
	                                                </c:if>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-3 col-sm-3 d-flex flex-column justify-content-center btn-container">
                                            <div class="d-flex flex-column justify-content-center align-items-center">
                                                <div class="up-del-btn-container d-flex flex-row justify-content-between">
                                                    <button type="button" class="update-btn" onclick="goToUpdatePage(${product.pid})">수정</button>
                                                    <form method="post" action="/store/products/${product.pid}">
                                                        <input type="hidden" name="_method" value="delete" />
                                                        <button type="button" class="delete-btn" onclick="confirmDelete(this)">삭제</button>
                                                    </form>
                                                </div>
                                                <c:choose>
                                                	<c:when test="${product.signature }">	<!-- 대표상품일 경우 해제버튼 출력 -->
		                                                <form action="/store/products/signature/${product.pid}" method="post">
		                                                	<input type="hidden" name="_method" value="DELETE">
			                                                <button type="submit" class="signature-del-btn button">대표 상품 해제</button>
		                                                </form>
                                                	</c:when>
                                                	<c:otherwise>		<!-- 대표상품 아닐 경우 등록버튼 출력 -->
		                                                <form action="/store/products/signature/${product.pid}" method="post">
		                                                	<input type="hidden" name="_method" value="PUT">
			                                                <button type="button" onclick="signatureLimit(this)" class="signature-btn button">대표 상품 등록</button>
		                                                </form>
                                                	</c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="row justify-content-center">
                    <div class="col-xl-10 col-lg-12">
                        <p>등록된 상품이 없습니다.</p>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
        
        
        
<!-- 페이지 번호 -->
<div class="col-lg-12">
  <div class="pagination">
    <ul>
      <c:choose>
        <c:when test="${totalPages > 1 }"> <!-- 페이지가 1개 이상일 때에만 페이징 처리 -->
          <c:if test="${currentPage > 1}" >
            <li>
              <a href="/store/my/products?page=${currentPage - 1}" >&lt;</a>
            </li>
          </c:if>
          <c:forEach var="p" begin="1" end="${totalPages}">
            <li <c:if test="${currentPage == p}">class='active'</c:if>>
              <a href="/store/my/products?page=${p}">${p}</a>
            </li>
          </c:forEach>
          <c:if test="${currentPage < totalPages }" >
            <li>
              <a href="/store/my/products?page=${currentPage + 1}">&gt;</a>
            </li>
          </c:if>
        </c:when>
        <c:otherwise>
          <!-- 페이지가 없을 때 처리할 내용 (예를 들어, "등록된 상품이 없습니다." 메시지 출력 등) -->
        </c:otherwise>
      </c:choose>
    </ul>
  </div>
</div>

      

      </div>
    </div>
  </main>

<script src="/resources/js/my-store.js"></script>
  
<!-- 정희 -->

<script>
  // 삭제된 상품 ID 목록을 저장할 배열
  let deletedProducts = [];

  // 서버로부터 삭제된 상품 ID를 받아와서 deletedProducts 배열에 추가하는 함수
  function setDeletedProducts(deletedIds) {
    deletedProducts = deletedIds;
  }

  function confirmDelete(obj) {	
		let delFrm = obj.parentElement;
		console.log(delFrm.getAttribute('action'));
		
		if(confirm("상품을 목록에서 삭제하시겠습니까?")) {		
			//let delFrm = document.getElementsByName('delete')[0];
			delFrm.submit();	
		}
	}

  document.addEventListener('DOMContentLoaded', function() {
    // 서버로부터 받은 삭제된 상품 ID 목록을 사용하여 숨겨야 할 상품 div를 찾아 숨김 처리
    const productDivs = document.querySelectorAll('.info');
    productDivs.forEach(productDiv => {
      const productId = parseInt(productDiv.getAttribute('data-product-id'));
      if (deletedProducts.includes(productId)) {
        productDiv.style.display = 'none';
      }
    });
  });
  
  
  function goToUpdatePage(productId) {
    // 상품 정보 수정 페이지로 이동하는 코드
    location.href = '/store/my/products/update/' + productId;
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