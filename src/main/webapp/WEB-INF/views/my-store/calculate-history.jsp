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



  <main id="calculate-history" class="my-store wrapper narrow">
    <jsp:include page="/WEB-INF/views/common/sidebar.jsp" />     
    <div class="main-panel">     
      <div class="content">
        <div class="row">
          <div class="col-lg-12">
            <div class="card">
              <div class="card-header">
                <h4 class="card-title font-weight-bold">정산 내역</h4>
                <h5 class="card-title">Total. ￦<span id="t-revenue">0</span></h5>
                
              	<form class="sort">
              		<select name="year">
              			<option selected>2023년</option>
              			<option>2022년</option>
              			<option>2021년</option>
              			<option>2020년</option>
              			<option>2019년</option>
              		</select>
              	</form>
              </div>
              <div class="card-body">
                <div class="table-responsive">
                  <table class="table tablesorter">
                    <thead>
                      <tr>
           	            <th>
                          	정산 일자
                        </th>
                        <th>
                          	총 금액 
                        </th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr>
                        <td>
                          2023.06.30
                        </td>
                        <td>
                          	￦<span class="price">50000</span>
                        </td>
                      </tr>
                      <tr>
                        <td>
                          2023.05.31
                        </td>
                        <td>
                          	￦<span class="price">35000</span>
                        </td>
                      </tr>
                      <tr>
                        <td>
                          2023.04.30
                        </td>
                        <td>
                          	￦<span class="price">30000</span>
                        </td>
                      </tr>
                      <tr>
                        <td>
                          2023.03.31
                        </td>
                        <td>
                          	￦<span class="price">9000</span>
                        </td>
                      </tr>
                      <tr>
                        <td>
                          2023.02.28
                        </td>
                        <td>
                          	￦<span class="price">14000</span>
                        </td>
                      </tr>
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
  <script>
    $(document).ready(function() {
      $().ready(function() {
        // total 금액
        let sum = 0
        let price = $('.price');
        for(let i=0; i<price.length; i++){
        	sum +=parseInt($(price[i]).text());
        	$(price[i]).text(numberWithCommas(Math.floor($(price[i]).text())));
        }
		countingUp($('#t-revenue'), sum);   
	  });
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


