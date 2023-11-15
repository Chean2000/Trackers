<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />



<!-- ***** Page Content Starts ***** -->
<main id="inquiry-history" class="my-info broad">
    <section class="section" id="page">
    	<div class="page-title">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-heading">
                        <h2>나의 문의 내역</h2>
                    </div>
                </div>
            </div>
        </div>
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-lg-12 table-responsive scroll-custom">
					<form action="" class="inquiry-type">
						<select name="inquiry_type">
							<option value="" selected>상품문의</option>
							<option value="">고객센터</option>
						</select>
					</form>
		            <table class="text-center table table-bordered table-hover">
						<thead>
							<tr>
								<th>No.</th>
								<th>제목</th>
								<th>작성일자</th>
								<th>답변 여부</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${empty inquiries.content}">
		                    	<tr class="empty-data">
		                     	  	<td colspan="4" rowspan="5">작성한 문의가 없습니다.</td>
		                     	</tr>
		                    </c:if>	
							<c:forEach var="inquiry" items="${inquiries.content}" varStatus="status">
								<tr onclick="location.href='/store/inquiries/${inquiry.inquiryId}'">
									<td>${inquiries.totalElements-((inquiries.number*10)+status.index)} </td>
									<td>${inquiry.title}</td>
									<td>${fn:substring(inquiry.creDate, 0, 10)}</td>
									<td>
										<c:choose>
											<c:when test="${!empty inquiry.answer}">
												답변 완료
											</c:when>
											<c:otherwise>
												답변 대기
											</c:otherwise>			
										</c:choose>
									</td>
								</tr>
							</c:forEach>
						</tbody> 
					</table>
				</div>
				
                <!-- 페이지 번호 -->
                <div class="col-lg-12">
	                 <div class="pagination">
	                     <ul>
	                     	<c:if test="${inquiries.number-1 >= 0}" >
					    		<li>
						            <a href="/store/inquiries?page=${inquiries.number-1}">&lt;</a>
						        </li>
					    	</c:if>
					    	<c:forEach var="p" begin="${startPage}" end="${endPage}">
				    			<li <c:if test="${p == nowPage}">class='active'</c:if>>
						            <a href="/store/inquiries?page=${p-1}">${p}</a>
						        </li>	
							</c:forEach>
							<c:if test="${inquiries.number+1 < inquiries.totalPages }" >
					    		<li>
					           		<a href="/store/inquiries?page=${inquiries.number+1}">&gt;</a>
					        	</li>
					    	</c:if>
	                     </ul>
	                 </div>
                </div>
			</div>
		</div>
    </section>
</main>
    <!-- ***** Page Content Ends ***** -->
    


 
<jsp:include page="/WEB-INF/views/common/footer.jsp" />



