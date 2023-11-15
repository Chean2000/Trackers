<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<section id="sidebar" class="col-lg-3">
	<nav class="navbar navbar-expand-md navbar-absolute navbar-transparent">
		 <div class="navbar-wrapper">
			<div class="navbar-toggle d-inline">
				<button type="button" class="navbar-toggler">
					<i class="fa fa-quote-left"></i>
				</button>
			</div>
		</div>
	</nav>
	
	<div class="sidebar-wrapper scroll-y-custom">
		<section class="sidebar-post-list">
			<nav class="sidebar-nav">
				<ul>
					<li class="menu<c:if test="${type eq 'all'}"> active</c:if>">
						<a href="/community/posts?page=0&type=all">통합 피드</a>
					</li>
					<li class="menu<c:if test="${type eq 'creator'}"> active</c:if>">
								<a href="/community/posts?page=0&type=creator">크리에이터 피드</a>
							</li>
					<c:choose>
				    	<c:when test="${!empty sessionScope.id}">	<!-- 로그인 o --> 
				    		<li class="menu<c:if test="${type eq 'follow'}"> active</c:if>">
								<a href="/community/posts?page=0&type=follow">팔로잉 피드</a>
							</li>
							<li class="menu<c:if test="${type eq 'comment'}"> active</c:if>">
								<a href="/community/posts?page=0&type=comment">내가 댓글 남긴 포스트</a>
							</li>
							<li class="menu<c:if test="${type eq 'like'}"> active</c:if>">
								<a href="/community/posts?page=0&type=like">내가 좋아요한 포스트</a>
							</li>
				    	</c:when>		
				    	<c:otherwise>		<!-- 로그인 x -->
				    		<li class="menu" onclick="sidebarSignin();">
								<a href="">팔로잉 피드</a>
							</li>
							<li class="menu" onclick="sidebarSignin();">
								<a href="">내가 댓글 남긴 포스트</a>
							</li>
							<li class="menu" onclick="sidebarSignin();">
								<a href="">내가 좋아요한 포스트</a>
							</li>
				    	</c:otherwise>
			    	</c:choose>
				</ul>
			</nav> 
		</section>

		<!-- Posts List -->
		<section>
			<ul class="posts">
				<c:forEach var="f" items="${followList}">
					<li class="d-flex justify-content-start">
						<div class="divlist d-flex justify-content-between" onclick="location.href='/profiles/${f[0]}'">
							<div class="divimg" id="article_img1"><img src="${f[1]}"></div>
							<div class="d-flex flex-column justify-content-center">
                  				<p class="lidiv">${f[2]}</p>
                  			</div>
						</div>
					</li>
				</c:forEach>
			</ul>
		</section>
	</div>
</section>