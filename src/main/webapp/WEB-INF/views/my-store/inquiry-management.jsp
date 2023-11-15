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



  <main id="inquiry-management" class="my-store wrapper narrow">
    <jsp:include page="/WEB-INF/views/common/sidebar.jsp" />  
    <div class="main-panel">     
      <div class="content">
        <div class="row">
          <div class="col-lg-12">
            <div class="col-lg-12 card">
              <div class="card-header">
                <h2 class="card-title text-center management-title">문의 관리</h2>
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
                          	제목
                        </th>
                        <th>
                          	작성자
                        </th>
                        <th>
                          	작성일자
                        </th>
                        <th>
                          	답변여부
                        </th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:if test="${empty inquiries.content}">
                    	  <tr class="empty-data">
                     	  	<td colspan="5" rowspan="5">작성된 문의가 없습니다.</td>
                     	  </tr>
                      </c:if>	
                      <c:forEach var="inquiry" items="${inquiries.content}" varStatus="status">
	                      <tr <c:if test="${!empty inquiry.answer}">class="answer"</c:if> onclick="location.href='/store/my/inquiries/${inquiry.inquiryId}'">
	                      	<td>
	                          	${inquiries.totalElements-((inquiries.number*10)+status.index)} 
	                        </td>
	                        <td>
	                          	${inquiry.title}
	                        </td>
	                        <td>
	                          	${inquiry.name}
	                        </td>
	                        <td>
	                            ${fn:substring(inquiry.creDate, 0, 10)}
	                        </td>
	                        <td>
	                        	<c:choose>
									<c:when test="${!empty inquiry.answer}">
										답변
									</c:when>
									<c:otherwise>
	                          			미답변
									</c:otherwise>			
								</c:choose>
	                        </td>
	                      </tr>
                      </c:forEach>
                    </tbody>
                  </table>
                  <div>
	                 <div class="pagination">
	                     <ul>
	                     	<c:if test="${inquiries.number-1 >= 0}" >
					    		<li>
						            <a href="/store/my/inquiries?page=${inquiries.number-1}">&lt;</a>
						        </li>
					    	</c:if>
					    	<c:forEach var="p" begin="${startPage}" end="${endPage}">
				    			<li <c:if test="${p == nowPage}">class='active'</c:if>>
						            <a href="/store/my/inquiries?page=${p-1}">${p}</a>
						        </li>	
							</c:forEach>
							<c:if test="${inquiries.number+1 < inquiries.totalPages }" >
					    		<li>
					           		<a href="/store/my/inquiries?page=${inquiries.number+1}">&gt;</a>
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


