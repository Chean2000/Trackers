<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

  
<!-- Wrapper -->
<div id="wrapper container" class="co">
	<main id="co-main" class="row">
	
		<c:set var="user_id" value="${sessionScope.id }"/>	
		
		<!-- Sidebar -->
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
						    	<c:when test="${!empty user_id}">	<!-- 로그인 o --> 
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
		
		<!-- Main -->
		<div id="main" class="col-lg-7 m-auto" > 

			<c:if test="${!empty user_id}">
				<section class="post">
					<form action="/community/posts" method="post" name="post" enctype="multipart/form-data">
						<input type="hidden" id="sessionId" name="id" value="${user_id}">
						<div class="header meta">
							<a href="/profiles/${sessionScope.user.url }" class="author">
								<img src="${sessionScope.user.profile_img}" alt="프로필 사진" />
								<span class="name author">${sessionScope.user.name}</span>
							</a>
							<div class="insertpost inserticon" id="inserticon" type="button"><i class="fa fa-plus"></i></div>
						</div>
						 

						<div class="submitpost">
							<textarea id="co-textarea" name="content" rows="2"></textarea>
							<input type="text" name="p_id" id="p_id" placeholder="태그 입력">
							<div class="row flex-column">
								<div class="d-flex align-items-center thumb-title inputphoto">
									<h6>사진&nbsp;<small>최대 4개까지 업로드 가능</small></h6>
									<p></p>
								</div>
								<div id="thumb-preview" class="thumb-preview"></div>
								<input type="file" accept="image/*" name="post-img" id="thumbnail" 
										onchange="imgPreview(event);" multiple="multiple" >
							</div>
							<button class="submiticon" type="button" onclick="checkPhotoCount()"><img alt="" src="/resources/images/icon-submit.png"></button>
						</div>
					</form>
				</section>
					
<%-- 				<article class="post">
					<form action="/community/posts" method="post" name="post" enctype="multipart/form-data">
						<!-- <input type="hidden" name="_method" value="post"> -->
						<input type="hidden" id="sessionId" name="id" value="${user_id}">
						<div>
							<div class="header">
								<div class="meta">
									<a href="/profiles/${sessionScope.user.url }" class="author"><img src="${sessionScope.user.profile_img}" alt="프로필 사진" />&nbsp;&nbsp;
										<span class="name"><div class="author">${sessionScope.user.name}</div></span>
									</a>
									<button class="insertpost inserticon" type="button"><img alt="" src="/resources/images/icon-insertpost.png"></button>
								</div>
							</div>
						</div>
		
					 
					   		<div class="col-12">
								<div class="submitpost col-12">
									<textarea id="co-textarea" name="content" class="col-11" rows="2"></textarea>
									<input type="text" name="p_id" id="p_id" placeholder="태그 입력">
									<div class="row flex-column">
										<div class="d-flex align-items-center thumb-title inputphoto">
											<h6>사진&nbsp;<small>최대 4개까지 업로드 가능</small></h6>
											<p></p>
										</div>
										<div id="thumb-preview" class="thumb-preview"></div>
										<input type="file" accept="image/*" name="post-img" id="thumbnail" 
												onchange="imgPreview(event);" multiple="multiple" >
									</div>
									<button class="submiticon" type="button" onclick="checkPhotoCount()"><img alt="" src="/resources/images/icon-submit.png"></button>
								</div>
							</div>
						</form>
					</article> --%>
			</c:if>	
			
			
<%-- 			<c:if test="${empty user_id}">
				<article class="post">
					<form action="" method="post" name="post">
						<div>
							<div class="header">
								<div class="meta">
									<div class="author">
										<p name="id"class="author">포스트 작성은 로그인이 필요합니다</p>
									</div>
									<button class="insertpost inserticon" type="button"><img alt="" src="/resources/images/icon-insertpost.png"></button>
								</div>
							</div>
						</div>
	
					</form>
				</article>
			</c:if> --%>
			
			
			
		<c:forEach var="p" items="${posts.content }">
			<!-- Post -->
			<section class="post"> 
				<form id="post-form" action="/community/posts" method="post" name="post" onclick="location.href='/community/posts/${p.postId}'">
					<div class="header">
						<a href="/profiles/${p.url}" class="author">
						    <img src="${p.profile_img}" alt="프로필 이미지" />
				    		<%-- <span class="name"><input type="text" name="id" value="${p.name}" readonly="readonly" class="author"></span> --%>
				    		<span class="name author">${p.name}</span>
						</a>
						<%-- <input type="text" readonly="readonly" name="cre_date" class="published" value="${p.creDate}"> --%>
						<div class="d-flex">
							<c:if test="${p.id eq user_id}">
								<form action="/community/posts/${p.postId}" method="post">
								 	<input type="hidden" name="_method" value="DELETE"/>
									<div class="delete-post" onclick="checkDeletePost(event)">삭제</div>
								</form>
							</c:if>
							<span class="published">${p.creDate}</span>
						</div>
					</div>
					
					<c:if test="${!empty imgs[p.postId]}">	<!-- 첨부 이미지 있는 경우 --> 
						<div class="post_img-outer">
				    		<c:forEach var="img" items="${imgs[p.postId]}">
				   	   			<div class="post_img">
									<img src="${img.postimg}" alt="포스트 첨부 이미지" />
								</div>
			   	   			</c:forEach>
						</div>
			    	</c:if>	
					
					<div id="post-content" class="collapse-content">
						<div class="post-content-inner collapsed">
							${p.content}
						</div>
					</div>
				</form>
					

				
			
					
				<div class="footer">
					<ul class="stats commment_stats">
						<li class="comment-count"><span class="comment-icon"><i class="fa fa-comment"></i></span><span class="comment-count-number">${p.c_count}</span></li>
						<li class="like-count"><span class="like-icon"><i class="fa fa-thumbs-up"></i></span><span class="like-count-number">${p.t_count}</span></li>
					</ul>
					<div class="comment-section">
						<c:if test="${!empty comments[p.postId]}">	
							<ul id="comment-list" class="comment-list">
					    		<c:forEach var="c" items="${comments[p.postId]}">
					   	   			<li>
					   	   				<div class="comment-top d-flex justify-content-between align-items-center">
											<div class="comment-name">${c.name }</div>
											<div class="d-flex">
												<c:if test="${c.id eq user_id}">
													<form id="deleteComment" action="" method="post">
													 	<input type="hidden" name="_method" value="DELETE"/>
														<div class="delete-comment" onclick="checkDeleteComment(event)">삭제</div>
													</form>
												</c:if>
												<div class="comment-date">${c.creDate }</div>
											</div>
					   	   				</div>
										<div class="comment-content">${c.content}</div>
									</li>
				   	   			</c:forEach>
							</ul>
							<div class="comment-button" type="button" onclick="showCommentInput(this)"><span class="comment-plus">+</span> 댓글쓰기</div>
				    	</c:if>	
					    	
						<div class="button-row">

							<%-- <c:if test="${p.c_count > 3 }">
	                           <div onclick="location.href='/community/posts/${p.postId}'">댓글 더보기</div>
	                        </c:if> --%>
							<div class="comment-input">
								<form action="/community/posts/${p.postId}/comments" method="post" name="comment" id="insertcomment">
									<input type="hidden" name="postId" value="${p.postId }"/>
									<c:choose>
								    	<c:when test="${!empty user_id}">	<!-- 로그인 o --> 
								    		<input type="hidden" name="id" value="${user_id}">
											<input type="text" id="comment-text" name="content" class="form-control" placeholder="댓글을 입력하세요">
								            <button class="submit-button" type="submit" >입력</button> <!-- onclick="addComment()" -->
								    	</c:when>		
								    	<c:otherwise>		<!-- 로그인 x -->
								    		<div id="comment-text" >로그인이 필요합니다.</div>
								    	</c:otherwise>
							    	</c:choose>
								</form>
							</div>	
						</div>
					</div>
				</div>
			</section>
		</c:forEach>	
		
		<!-- 페이지 번호 -->
		<div class="col-lg-12">
			<div class="pagination">
			    <ul>
			   		<c:choose>
						<c:when test="${!empty keyword || keyword ne '' }"> <!-- 검색 o -->
					    	<c:if test="${posts.number-1 >= 0}" >
					    		<li>
						            <a href="/community/posts?page=${posts.number-1}&type=${type}&keyword=${keyword}" >&lt;</a>
						        </li>
					    	</c:if>
					    	<c:forEach var="p" begin="${startPage}" end="${endPage}">
				    			<li <c:if test="${p == nowPage}">class='active'</c:if>>
						            <a href="/community/posts?page=${p-1}&type=${type}&keyword=${keyword}">${p}</a>
						        </li>	
							</c:forEach>
							<c:if test="${posts.number+1 < posts.totalPages }" >
					    		<li>
					           		<a href="/community/posts?page=${posts.number+1}&type=${type}&keyword=${keyword}">&gt;</a>
					        	</li>
					    	</c:if>
					    </c:when>
						<c:otherwise> <!-- 검색 x -->
							<c:if test="${posts.number-1 >= 0}" >
					    		<li>
						            <a href="/community/posts?page=${posts.number-1}&type=${type}" >&lt;</a>
						        </li>
					    	</c:if>
					    	<c:forEach var="p" begin="${startPage}" end="${endPage}">
				    			<li <c:if test="${p == nowPage}">class='active'</c:if>>
						            <a href="/community/posts?page=${p-1}&type=${type}">${p}</a>
						        </li>	
							</c:forEach>
							<c:if test="${posts.number+1 < posts.totalPages }" >
					    		<li>
					           		<a href="/community/posts?page=${posts.number+1}&type=${type}">&gt;</a>
					        	</li>
					    	</c:if>
					    </c:otherwise> 
					</c:choose>
			    </ul>
			</div>
		</div>

	</div>
		
		
	</main>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/resources/js/community-toggle.js"></script>
<script>

	$(() => {
 		$('body').css('background-color', '#f2f2f6');
    	
    	// 모바일 화면 사이드 바
    	$("#sidebar .navbar button").on('click', function(){
    		let clazz = $('.sidebar-wrapper').attr('class');
    		if(!clazz.includes('open')) {
    			$('.sidebar-wrapper').addClass('open');
    			$('#sidebar').addClass('open');
    		}
    		else {
    			$('.sidebar-wrapper').removeClass('open');
    			$('#sidebar').removeClass('open');
    		}
    	});
	});
	
	function sidebarSignin(){
		alert("로그인 후 이용 가능합니다.");
	}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
