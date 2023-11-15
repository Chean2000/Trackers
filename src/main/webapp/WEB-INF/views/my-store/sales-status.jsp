<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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



  <main id="sales-status" class="my-store wrapper narrow">
   	<jsp:include page="/WEB-INF/views/common/sidebar.jsp" /> 
    <div class="main-panel">     
      <div class="content">
        <div class="row">
          <div class="col-lg-8">
            <div class="card card-chart">
              <div class="card-header ">
                <div class="row">
                  <div class="col-sm-12 text-left">
                    <h5 class="card-category">월별 판매 수익</h5>
                    <h2 class="card-title">
	                  	<input id="total" type="hidden" value="${m_sum}">
                    	Total. ￦<span id="revenue">0</span>
                    </h2>
                  </div>
                </div>
              </div>
              <div class="card-body">
                <div class="chart-area">
                  <canvas id="chartBig1"></canvas>
                  <input id="month" type="hidden" value="${months}">
                </div>
              </div>
            </div>
          </div>
          <div class="col-lg-4">
            <div class="card card-chart m-revenue">
              <div class="card-header">
                <h5 class="card-category"><fmt:formatDate value="${now}" pattern="yyyy년 MM월" /></h5>
                <h3 class="card-title">이번달 수익</h3>
              </div>
              <div class="card-body">
                <div class="chart-area d-flex flex-column justify-content-center revenue scroll-custom">
               		<p class="card-content" style="width: max-content;">
               			<input id="oneMonth" type="hidden" value="${oneMonth}">
               			￦<span id="m-revenue">0</span>
               		</p>
                </div>
                <button type="button" class="cal-history" onclick="javascript:location.href='/store/my/sales/table';">정산 내역 보러가기<i class="tim-icons icon-double-right"></i></button>
              </div>
            </div>
          </div>
        </div>
        
        <div class="row">
          <div class="col-lg-6 col-md-12">
            <div class="card card-chart bar-chart">
              <div class="card-header">
                <h5 class="card-category">Best5 상품 수익</h5>
                <h2 class="card-title">
                	<input id="p-total" type="hidden" value="${p_sum}">
                	Total. ￦<span id="p-revenue">0</span>
                </h2>
              </div>
              <div class="card-body">
                <div class="chart-area">
                  <canvas id="ProductChart"></canvas>
                  <input id="products" type="hidden" value="${p_cnt}">
                </div>
              </div>
            </div>
          </div>
          <div class="col-lg-6 col-md-12">
            <div class="card">
              <div class="card-header">
                <h4 class="card-title">Best5 상품</h4>
              </div>
              <div class="card-body">
                <div class="table-responsive">
                  <table class="table tablesorter table-custom">
                    <thead>
                      <tr>
                      	<th>
                          	No.
                        </th>
                        <th>
                          	상품명
                        </th>
                        <th>
                        	 판매수량
                        </th>
                        <th>
                          	판매금액
                        </th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:if test="${empty products}">
                    	  <tr>
                     	  	<td colspan="4" rowspan="5">등록한 상품이 없습니다.</td>
                     	  </tr>
                      </c:if>	
                      <c:forEach var="p" items="${products}" varStatus="status">
	                      <tr>
	                      	<td>
	                          ${status.count}
	                        </td>
	                        <td>
	                          	${p[0]}
	                        </td>
	                        <td>
	                          ${p[1]}건
	                        </td>
	                        <td>
	                        	<input type="hidden" value="${p[2]}">
	                          	￦<fmt:formatNumber value="${p[2]}" pattern="#,###" /> 
	                        </td>
	                      </tr>
                      </c:forEach>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          </div>
        </div>

      </div>
      
      

    </div>
  </main>

  

  <script src="/resources/js/my-store.js"></script>
  
  
  <!-- Chart JS -->
  <script src="/resources/js/chartjs.min.js"></script>
  <script src="/resources/js/demo.js"></script>
  <script>
    $(document).ready(function() {
      $().ready(function() {
		countingUp($('#m-revenue'), $('#oneMonth').val());
		countingUp($('#revenue'), $('#total').val());
		countingUp($('#p-revenue'), $('#p-total').val());
	  });
  	});
  </script>
  
  
  
  
  

 
<script>
  $(document).ready(function() {
    // Javascript method's body can be found in assets/js/demos.js
    demo.initDashboardPageCharts();

  });
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


