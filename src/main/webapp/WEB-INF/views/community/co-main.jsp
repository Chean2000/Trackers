<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<!-- tag js -->
<script src="/resources/js/tag-modal.js"></script>


<script>

// 태그 모달 표시
function showTagModal() {
	$('.modal-content').load("/community/tag-modal");
}

// 이미지 아이콘 클릭시 input 대신 클릭됨
function clickImageInput() {
	$('#thumbnail').trigger('click');
}

</script>

  
<!-- Wrapper -->
<div id="wrapper container" class="co">
	<main id="co-main" class="row">
	
		<c:set var="user_id" value="${sessionScope.id }"/>	
		
		<!-- Sidebar -->
		<jsp:include page="/WEB-INF/views/common/co-sidebar.jsp" />
		
		<!-- Main -->
		<div id="main" class="col-lg-7 m-auto" > 

			<c:if test="${!empty sessionScope.user}">
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
							<div class="icons-container d-flex justify-content-between">
								<div class="d-flex flex-row align-items-center">
									<div onclick="clickImageInput()"><i class="fa fa-image"></i></div>
									<!-- 파일 input 대신 클릭 -->
									<div onclick="showTagModal()" data-toggle="modal" data-target="#modal"><i class="fa fa-tag"></i></div>
									<input type="hidden" name="pid" id="tag" value="">
									<div class="tag-preview"></div>
									<div class="tag-delete" onclick="deleteTag()"><i class="fa fa-close"></i></div>
								</div>
								<!-- <button class="submiticon" type="button" onclick="checkPhotoCount()"><img alt="" src="/resources/images/icon-submit.png"></button> -->
								<button class="submiticon" type="submit" onclick="return checkPhotoCount()"><i class="fa fa-paper-plane"></i></button>
							</div>
							
							<input type="file" accept="image/*" name="post-img" id="thumbnail" 
									onchange="imgPreview(event);" multiple="multiple" >
							<div class="d-flex align-items-center thumb-title inputphoto">
								<small>사진 최대 4개까지 업로드 가능</small>
								<p></p>
							</div>
							<div id="thumb-preview" class="thumb-preview"></div>
								
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
									<input type="text" name="pid" id="pid" placeholder="태그 입력">
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
				<%-- <form id="post-form" action="/community/posts" method="post" name="post" onclick="location.href='/community/posts/${p.postId}'"> --%>
				<div>
					<div class="header">
						<a href="/profiles/${p.url}" class="author">
						    <img src="${p.profile_img}" alt="프로필 이미지" />
				    		<%-- <span class="name"><input type="text" name="id" value="${p.name}" readonly="readonly" class="author"></span> --%>
				    		<span class="name author">${p.name}</span>
						</a>
						<%-- <input type="text" readonly="readonly" name="cre_date" class="published" value="${p.creDate}"> --%>
						<div class="d-flex">
							<c:if test="${p.id eq user_id}">
								<form action="/community/posts/${p.postId}" method="post" id="deletePost" name="postId_${p.postId }">
								 	<input type="hidden" name="_method" value="DELETE"/>
									<div class="delete-post" onclick="javascript:checkDeletePost(${p.postId })">삭제</div>
								</form>
							</c:if>
							<span class="published">${fn:substring(p.creDate, 0, 19)}</span>
						</div>
					</div>

			    	
			    	<div>			    		
		    			<div class="post-content-container row justify-content-center" onclick="location.href='/community/posts/${p.postId}'"> 
					    	<c:if test="${!empty imgs[p.postId]}">
						    	<div class="img-container 
						    		<c:choose>
						    			<c:when test="${fn:length(imgs[p.postId]) == 1 }">one</c:when>
						    			<c:when test="${fn:length(imgs[p.postId]) == 2 }">two</c:when>
						    			<c:when test="${fn:length(imgs[p.postId]) == 3 }">three</c:when>
						    			<c:when test="${fn:length(imgs[p.postId]) == 4 }">four</c:when>
						    		</c:choose> col-12"> <!-- 이미지 개수에 따라 class 부여 필요 -->
						    		<c:forEach var="img" items="${imgs[p.postId]}">
										<div class="img-card">
						    				<img src="${img.img}" alt="포스트 이미지" data-toggle="modal" data-target="#image-modal" onclick="showImageModal(event, '${img.img}')">
						    			</div>
					   	   			</c:forEach>
				   	   			</div>
					    	</c:if>
						
							<div id="post-content" class="collapse-content">
								<div class="post-content-inner collapsed">
									${p.content}
								</div>
					    	</div>
						</div>
					</div>
				</div>
				<!-- </form> -->

					

				
			
					
				<div class="footer">
					<ul class="stats commment_stats">
						<c:choose>
							<c:when test="${p.c_count > 3 }">
								<li class="comment-count" onclick="location.href='/community/posts/${p.postId}'"><span class="comment-icon"><i class="fa fa-comment"></i></span><span class="comment-count-number">${p.c_count}</span></li>
							</c:when>
							<c:otherwise>
								<li class="comment-count" onclick="showCommentInput(this)"><span class="comment-icon"><i class="fa fa-comment"></i></span><span class="comment-count-number">${p.c_count}</span></li>
							</c:otherwise>
						</c:choose>
						<li class="like-count"><span class="like-icon"><i class="fa fa-thumbs-up"></i></span><span class="like-count-number">${p.t_count}</span></li>
						<c:if test="${!empty p.pid }">
							<li class="tag"><a href="/store/products/${p.pid }"><span class="tag-icon"><i class="fa fa-tag"></i></span><span class="tag-product">${p.p_name}</span></a></li>
						</c:if>
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
													<form id="deleteComment" action="/community/posts/${p.postId}/comments/${c.comment_id}" method="post" name="commentid_${c.comment_id }">
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
								<form action="/community/posts/${p.postId}/comments" method="post" name="comment" id="insertcomment">
									<input type="hidden" name="postId" value="${p.postId }"/>
									<c:choose>
								    	<c:when test="${!empty user_id}">	<!-- 로그인 o --> 
								    		<input type="hidden" name="id" value="${user_id}">
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
		
		<input type="hidden" id="sessionId" name="id" value="${user_id}">
	</main>
</div>

<!-- ***** Modal Start ***** -->
<div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-container" role="document" >
     <div class="modal-content">
		</div>
    </div>
</div>
<!-- ***** Modal End ***** -->





<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/resources/js/community-toggle.js"></script>
<script>

	$(() => {
 		$('body').css('background', '#f2f2f6');
    	
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
