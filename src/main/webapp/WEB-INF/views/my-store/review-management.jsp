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



  <main id="review-management" class="my-store wrapper broad"><!-- 추후 좁은헤더로 class명 변경 필요 -->
    <jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
    <div class="main-panel">     
      <div class="content">
        <div class="row">
          <div class="col-lg-12">
            <div class="col-lg-12 card">
              <div class="card-header">
                <h2 class="card-title text-center management-title">후기 관리</h2>
              </div>
              <div class="card-body">
                <div class="table-responsive scroll-custom">
                  <table class="table tablesorter table-hover table-custom table-management">
                    <thead>
                      <tr>
                      	<th>
                          	No.
                        </th>
                        <th>
                          	상품명
                        </th>
                        <th>
                          	작성자
                        </th>
                        <th>
                          	작성일자
                        </th>
                        <th>
                          	별점
                        </th>
                      </tr>
                    </thead>
                    <tbody>
                    	<c:forEach var="review" items="${reviews.content}" varStatus="status">
	                      <tr onclick="location.href='/profiles/${url}/reviews/${review.id}'">
	                      	<td>
	                          	${reviews.totalPages-((reviews.number*10)+status.index)+1} 
	                        </td>
	                        <td>
	                          	${review.p_name}
	                        </td>
	                        <td>
	                          	${review.name}
	                        </td>
	                        <td>
	                            ${review.creDate}
	                        </td>
	                        <td>
	                          	<span class="star">
									★★★★★
									<span style="width: ${review.rating}%;">★★★★★</span>
								</span>
	                        </td>
	                      </tr>
                      </c:forEach>
                    </tbody>
                  </table>
                  <div>
                  	<c:set var="url" value="${sessionScope.user.url}"/>
	                 <div class="pagination">
	                     <ul>
	                     	<c:if test="${reviews.number-1 >= 0}" >
					    		<li>
						            <a href="/profiles/${url}/reviews?page=${reviews.number-1}">&lt;</a>
						        </li>
					    	</c:if>
					    	<c:forEach var="p" begin="${startPage}" end="${endPage}">
				    			<li <c:if test="${p == nowPage}">class='active'</c:if>>
						            <a href="/profiles/${url}/reviews?page=${p-1}">${p}</a>
						        </li>	
							</c:forEach>
							<c:if test="${reviews.number+1 < reviews.totalPages }" >
					    		<li>
					           		<a href="/profiles/${url}/reviews?page=${reviews.number+1}">&gt;</a>
					        	</li>
					    	</c:if>
	                     </ul>
	                 </div>
                </div>
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


