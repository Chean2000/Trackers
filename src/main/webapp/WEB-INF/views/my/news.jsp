<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />



<!-- ***** Page Content Starts ***** -->
<main id="news" class="my-info broad">

    <section class="section" id="page">
    	<div class="page-title">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-heading">
                        <h2>내 소식</h2>
                    </div>
                </div>
            </div>
        </div>
		<div class="container">
			<div class="row justify-content-center">
				<c:if test="${empty news}">
                	<div class="empty-data">
                 	  	<h6>최근 30일 이내 확인하지 않은 소식이 없습니다.</h6>
                 	</div>
                </c:if>
				<c:forEach var="n" items="${news}">
					<div class="col-lg-12 news-container" onclick="location.href='${n.url}'">
						<div class="news d-flex justify-content-start" >
							<div class="d-flex justify-content-center">
	                  			<img src="${n.img}" alt="소식 관련 이미지" class="profile-img">
	                  			<div class="d-flex flex-column justify-content-center">
	                  				<h6>${n.content}</h6>
	                  			</div>
	                  		</div>
		           		</div>
					</div>
				</c:forEach>
			</div>
		</div>
    </section>
</main>

<!-- ***** Page Content Ends ***** -->


<jsp:include page="/WEB-INF/views/common/footer.jsp" />

   
