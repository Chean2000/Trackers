<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<jsp:include page="/WEB-INF/views/common/header.jsp" />

  
<!-- Wrapper -->
<div id="wrapper container" class="co">
	<main id="co-post" class="row" style="margin-top: 200px">
	
		<!-- Sidebar -->
		<jsp:include page="/WEB-INF/views/common/co-sidebar.jsp" />
		
		<!-- Main -->
		<div id="main" class="col-lg-7 ml-auto mr-auto" > <!-- style="float: right;" -->
		
			<!-- Post -->
			<section class="post"> 
				<div class="header">
					<a href="/profiles/${post.url}" class="author">
					    <img src="${post.profile_img}" alt="프로필 이미지"/>
			    		<span class="name author">${post.name}</span>
					</a>
					<div class="d-flex">
						<c:if test="${post.id eq sessionScope.id}">
							<form action="/community/posts/${post.postId}" method="post" id="deletePost" name="postId_${post.postId}">
							 	<input type="hidden" name="_method" value="DELETE"/>
								<div class="delete-post" onclick="javascript:checkDeletePost(${post.postId})">삭제</div>
							</form>
						</c:if>
						<span class="published">${fn:substring(post.creDate, 0, 19)}</span>
					</div>
				</div>


		    	
		    	<div class="post-content-container row justify-content-center">
			    	<c:if test="${!empty imgList}">
				    	<div class="img-container 
				    		<c:choose>
				    			<c:when test="${fn:length(imgList) == 1 }">one</c:when>
				    			<c:when test="${fn:length(imgList) == 2 }">two</c:when>
				    			<c:when test="${fn:length(imgList) == 3 }">three</c:when>
				    			<c:when test="${fn:length(imgList) == 4 }">four</c:when>
				    		</c:choose> col-12"> <!-- 이미지 개수에 따라 class 부여 필요 -->
				    		<c:forEach var="img" items="${imgList}">
								<div class="img-card">
				    				<img src="${img.img}" alt="포스트 이미지" data-toggle="modal" data-target="#image-modal" onclick="showImageModal(event, '${img.img}')">
				    			</div>
			   	   			</c:forEach>
		   	   			</div>
			    	</c:if>
				
					<div id="post-content" class="collapse-content">
						<div class="post-content-inner collapsed">
							${post.content}
						</div>
			    	</div>

				</div>


	
				<div class="footer">
					<ul class="stats commment_stats">
						<c:choose>
							<c:when test="${p.c_count > 3 }">
								<li class="comment-count" onclick="location.href='/community/posts/${p.postId}'"><span class="comment-icon"><i class="fa fa-comment"></i></span><span class="comment-count-number">${post.c_count}</span></li>
							</c:when>
							<c:otherwise>
								<li class="comment-count" onclick="showCommentInput(this)"><span class="comment-icon"><i class="fa fa-comment"></i></span><span class="comment-count-number">${post.c_count}</span></li>
							</c:otherwise>
						</c:choose>
						<li class="like-count"><span class="like-icon"><i class="fa fa-thumbs-up"></i></span><span class="like-count-number">${post.t_count}</span></li>
						<c:if test="${!empty post.pid }">
							<li class="tag"><a href="/store/products/${post.pid }"><span class="tag-icon"><i class="fa fa-tag"></i></span><span class="tag-product">${post.p_name}</span></a></li>
						</c:if>
					</ul>
					<div class="comment-section">
						<c:if test="${!empty commentList}">	
							<ul id="comment-list" class="comment-list">
					    		<c:forEach var="c" items="${commentList}">
					   	   			<li>
					   	   				<div class="comment-top d-flex justify-content-between align-items-center">
											<div class="comment-name">${c.name }</div>
											<div class="d-flex">
												<c:if test="${c.id eq sessionScope.id}">
													<form id="deleteComment" action="/community/posts/${post.postId}/comments/${c.comment_id}" method="post" name="commentid_${c.comment_id }">
													 	<input type="hidden" name="_method" value="DELETE"/>
														<div class="delete-comment" onclick="checkDeleteComment(${c.comment_id })">삭제</div>
													</form>
												</c:if>
												<div class="comment-date">${c.creDate }</div>
											</div>
					   	   				</div>
										<div class="comment-content">${c.content}</div>
									</li>
				   	   			</c:forEach>
							</ul>
							<!-- <div class="comment-button" type="button" onclick="showCommentInput(this)"><span class="comment-plus">+</span> 댓글쓰기</div> -->
				    	</c:if>	
					    	
						<div class="button-row">

							<%-- <c:if test="${p.c_count > 3 }">
	                           <div onclick="location.href='/community/posts/${p.postId}'">댓글 더보기</div>
	                        </c:if> --%>
							<div class="comment-input">
								<form action="/community/posts/${post.postId}/comments" method="post" name="comment" id="insertcomment">
									<input type="hidden" name="postId" value="${post.postId }"/>
									<c:choose>
								    	<c:when test="${!empty sessionScope.id}">	<!-- 로그인 o --> 
								    		<input type="hidden" name="id" value="${sessionScope.id}">
											<input type="text" id="comment-text" name="content" class="form-control" placeholder="댓글을 입력하세요">
								            <button class="submit-button" id="comment-submit-button" type="submit" ><i class="fa fa-paper-plane"></i></button> <!-- onclick="addComment()" -->
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
		</div>
		<input type="hidden" id="sessionId" name="id" value="${sessionScope.id}">
	</main>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/resources/js/community-toggle.js"></script>
<script>
	
	

	$(() => {
    	// body 컬러 임시
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
	
	
	
	
    
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
