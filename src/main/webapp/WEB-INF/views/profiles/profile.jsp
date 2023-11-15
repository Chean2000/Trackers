<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />


<!-- 아임포트 (결제 API) -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>


<script src="/resources/js/community-toggle.js"></script>
<script src="/resources/js/profile-tab.js"></script>
<script src="/resources/js/profile-sub-purchase.js"></script>




<main id="myprofile" class="narrow">
	<div  class="container firstcontainer">
	<!-- 
	<c:if test="${!empty sessionScope.id}">
	</c:if>
	 -->
		<!--상단 이미지-->
		<div class="row img">
			<div class="col-md-12 topimgdiv" <c:if test="${sessionScope.user.id == profile.id}">id="my-topimgdiv"</c:if>>
				<img src="${profile.bg_img}">
	        </div> 
	    </div>

		<div class="row  seconddiv">
			<div class="col-md-2 col-lg-1 profilediv">
				<div class="profile" id="profile">
					<img <c:if test="${sessionScope.user.id == profile.id}">id="my-profileimg"</c:if> class="profileimgmodify" src="${profile.profile_img}" >
				</div>
			</div> 
			
			<div class="col-md-4 offset-md-1 col-lg-4">
				<c:choose>
					<c:when test="${getCreator != null }">
						<div class="nickname">${getCreator.getStoreName() } (${profile.getName()})</div>
					</c:when>
					<c:otherwise>
						<div class="nickname">${profile.getName()} </div>
					</c:otherwise>
				</c:choose>
				<div class="count">
					팔로워  &nbsp;${count}명&nbsp;&nbsp;|&nbsp;&nbsp;구독 &nbsp;${subcount}명
				</div>
				<br>
			<!-- SNS 주소 -->
			<c:choose>
			    <c:when test="${empty profile.youtube && empty profile.instagram }">
			        <!-- No YouTube and Instagram, no images -->
			        <div class="addressdiv"><a href="https://youtube.com/@${profile.youtube}">&nbsp;${profile.youtube}</a></div>
			        <div class="addressdiv"><a href="https://www.instagram.com/${profile.instagram}">&nbsp;${profile.instagram}</a></div>
			    </c:when>
			    <c:otherwise>
			        <c:choose>
			            <c:when test="${empty profile.youtube}">
			                <!-- Instagram has value, display Instagram image -->
			                <c:choose>
			                	<c:when test="${empty profile.instagram}">
			                		<div class="addressdiv"><a class="icons" href="https://youtube.com/@${profile.youtube}">&nbsp;${profile.youtube}</a></div>
			                		<div class="addressdiv"><a href="https://www.instagram.com/${profile.instagram}">&nbsp;${profile.instagram}</a></div>
			                	</c:when>
			                	<c:otherwise>
			                		<div class="addressdiv"><img class="icons" src="/resources/images/instagram.svg"><a href="https://www.instagram.com/${profile.instagram}">&nbsp;${profile.instagram}</a></div>
			                		<div class="addressdiv"><a href="https://youtube.com/@${profile.youtube}">&nbsp;${profile.youtube}</a></div>
			                	</c:otherwise>
			                </c:choose>
			            </c:when>
			            <c:otherwise>
			            	<c:choose>
			            		<c:when test="${!empty profile.instagram}">
			            			<div class="addressdiv"><img class="icons"  src="/resources/images/youtube.svg"><a href="https://youtube.com/@${profile.youtube}">&nbsp;${profile.youtube}</a></div>
			                		<div class="addressdiv"><img class="icons"  src="/resources/images/instagram.svg"><a href="https://www.instagram.com/${profile.instagram}">&nbsp;${profile.instagram}</a></div>
			            		</c:when>
			            		<c:otherwise>
			            			<div class="addressdiv"><img class="icons"  src="/resources/images/youtube.svg"><a href="https://youtube.com/@${profile.youtube}">&nbsp;${profile.youtube}</a></div>
			                		<div class="addressdiv"><a href="https://www.instagram.com/${profile.instagram}">&nbsp;${profile.instagram}</a></div>	
			            		</c:otherwise>
			            	</c:choose>
			            </c:otherwise>
			        </c:choose>
			    </c:otherwise>
			</c:choose>
	

			</div>
			

			<c:choose>
			    <c:when test="${!empty sessionScope.user.id}">
			        <div class="offset-md-1 col-md-4 offset-lg-2 col-lg-4 thriddiv">
			            <c:choose>
			                <c:when test="${sessionScope.user.url != profile.url}"> <!-- 로그인해서 남의 프로필에 들어왔을 때 -->
			                	<c:choose>
			                		<c:when test="${checks.getId() eq sessionScope.user.id && checkf.getFrom_id() eq sessionScope.user.id && checkf.getTo_id() eq profile.id}">
	                						<button class="btn offbtn"  data-toggle="modal" data-target="#ExampleModalCenter" >팔로우 중</button>
	                						<button class="btn offbtn" data-toggle="modal" data-target="#exampleModalCenter" >구독 중</button>
				                	</c:when>
				                	
				                	<c:when test="${checkf.getFrom_id() eq sessionScope.user.id && checkf.getTo_id() eq profile.id && checks.getId() ne sessionScope.user.id}">
								
				                		<button class="btn offbtn"  data-toggle="modal" data-target="#ExampleModalCenter">팔로우 중</button>

				                		<c:if test="${!empty getMembership }">
			                				<button id="buttonright" class="btn sbutton" data-toggle="modal" data-target="#subModal" onclick="starts"><i class="fa fa-money"></i>구독</button>
				                		</c:if>
				                		

				                	</c:when>
				                	
				                	<c:when test="${checkf.getFrom_id() ne sessionScope.user.id && checkf.getTo_id() ne profile.id && checks.getId() eq sessionScope.user.id}">
				                		<form action="/profiles/${profile.url}" method="post">
				                			<button id="buttonright" class="btn" onclick="startf()">팔로우</button>
				                		</form>
				                		<button class="btn offbtn"  data-toggle="modal" data-target="#ExampleModalCenter"  style=" display: none;">팔로우 중</button>
				                		<button class="btn offbtn" data-toggle="modal" data-target="#exampleModalCenter" >구독 중</button>
				                	</c:when>
				                	
				                	<c:otherwise>
				                		<form action="/profiles/${profile.url}" method="post">
				                			<button id="buttonright" class="btn" onclick="startf()">팔로우</button>
				                		</form>
				                		<button class="btn offbtn" id="changef" data-toggle="modal" data-target="#ExampleModalCenter"  style=" display: none;">팔로우 중</button>
				                		<c:if test="${!empty getMembership }">
				           					<button id="buttonright" class="btn sbutton" data-toggle="modal" data-target="#subModal" onclick="starts"><i class="fa fa-money"></i>구독</button>
			           					</c:if>
			           					

							 		</c:otherwise>
						 		</c:choose>
				                		
			                </c:when>
			                <c:otherwise>
			                	<c:if test="${getCreator.getId() eq sessionScope.user.id}">
			                		<div id="buttonright" class="longtext"><a href="/store/my/sales">마이스토어 관리</a></div>
			                	</c:if>
			                	<c:if test="${getCreator.getId() ne sessionScope.user.id}">
			                		<div id="buttonright" onclick="onStoreModal()" class="longtext"><a href="#" data-toggle="modal" data-target="#store-modal">마이스토어 개설</a></div>
			                	</c:if>	
			                </c:otherwise>
			            </c:choose>
			        </div>
			    </c:when>
		    	
			    <c:otherwise>
			        <div class="offset-md-1 col-md-4 offset-lg-2 col-lg-4 thriddiv">
			            <button id="buttonright" class="btn" onclick="showLoginAlert()">팔로우</button>

			            <c:if test="${!empty getMembership }">
			            	<button id="buttonright" class="btn" data-toggle="modal" data-target=".bd-example-modal-lg" ><i class="fa fa-money"></i>구독</button>
			            </c:if>


			        </div>
			    </c:otherwise>
			 </c:choose>   

			

		</div>	
		<script>
		    function showLoginAlert() {
		        alert("로그인이 필요합니다");
		        /* var link = 'store/main';		        
		        location.href=link; */

		    }
		    
		</script>
	<br>

	<!-- 탭 -->
	<div class="container tabcontainer shadow-sm p-3 mb-5 ">

		<div style="margin:10px;">
			
			<ul class="nav nav-tabs" >
			 	<li class="nav-item navli" id="li" >
			 		<a class="nav-link active" onclick="getUserPostList(0)" data-toggle="tab" id="feedtabbgcolor" >피드</a>
			 	</li>
			 	<c:if test="${getCreator != null }">
				 	<li class="nav-item navli" id="li">
				 		<div class="nav-link" onclick="getCreatorProductList(0, 'creDate')" data-toggle="tab" id="storenamediv">스토어</div>
				 	</li>
				 	<li class="nav-item navli" id="li">
				 		<a class="nav-link" href="#notice" data-toggle="tab">공지</a>
				 	</li>
			 	</c:if>
			</ul>

				<!-- post 탭 -->
 				<div class="tab-pane fade show active co" id="feed">
					<br>

					<div class="feed-listtop">
						<c:if test="${sessionScope.user.url == profile.url}">
							<div id="feed-insert-btn" class="writenew1">
								<a href="/community/posts?page=0&type=all">새 글 작성</a>
							</div>
						</c:if>

					</div>				
					<div id="co-main" >

						<div id="main" class="col-sm-12 col-md-12 col-lg-12">
						<!-- post -->
							<section class="post" id="post-box"> 
								<div class="post-onclick">
									<div class="header">
										<a class="author">
										    <img alt="프로필 이미지" />
								    		<span class="name author"></span>
										</a>
										<div class="d-flex">
											<form class="delFrm" method="post">
											 	<input type="hidden" name="_method" value="DELETE"/>
												<div class="delete-post" onclick="checkDeletePost(event)">삭제</div>
											</form>
											<span class="published"></span>

										</div>
									</div>
							    	
							    	<div class="post-content-container row justify-content-center">

									    	<div class="img-container col-12">
												<div class="img-card" id="card">
									    			<img alt="포스트 이미지" data-toggle="modal" data-target="#image-modal">
									    		</div>
							   	   			</div>

									
										<div id="post-content" class="collapse-content">
											<div class="post-content-inner collapsed">
												${p.content}
											</div>
										</div>
							    	</div>
							    </div>

								<div class="footer">
									<ul class="stats commment_stats">
										<li class="comment-count"><span class="comment-icon"><i class="fa fa-comment"></i></span><span class="comment-count-number"></span></li>
										<li class="like-count"><span class="like-icon"><i class="fa fa-thumbs-up"></i></span><span class="like-count-number"></span></li>
										<li class="tag"><a><span class="tag-icon"><i class="fa fa-tag"></i></span><span class="tag-product"></span></a></li>
									</ul>
 									<div class="comment-section">
										<ul id="comment-list" class="comment-list">
							   	   			<li id="li">
							   	   				<div class="comment-top d-flex justify-content-between align-items-center">
													<div class="comment-name"></div>
													<div class="d-flex">
														<form id="deleteComment" class="deleteComment" action="" method="post">
														 	<input type="hidden" name="_method" value="DELETE"/>
															<div class="delete-comment" onclick="checkDeleteComment(event)">삭제</div>
														</form>
														<div class="comment-date"></div>
													</div>
							   	   				</div>
												<div class="comment-content"></div>
											</li>
										</ul>
										<div class="comment-button" type="button" onclick="showCommentInput(this)"><span class="comment-plus">+</span> 댓글쓰기</div>
									    	
    									<div class="button-row">
											<div class="comment-input">
												<form method="post" name="comment" id="insertcomment">
													<input type="hidden" name="postId" class="comment-postId"/>
													<div class="comment-login">		<!-- 로그인 o --> 
												    		<input type="hidden" name="id">
															<input type="text" id="comment-text" name="content" class="form-control" placeholder="댓글을 입력하세요">
												            <button class="submit-button" id="submit-button" type="submit" ><i class="fa fa-paper-plane"></i></button>
												    </div>		
											    	<div class="comment-logout">	<!-- 로그인 x -->
											    		<div id="comment-text" >로그인이 필요합니다.</div>
											    	</div>
												</form>
											</div>	
										</div> 
									</div> 
								</div>
							</section>
							
						
							<div class="col-lg-12" id="feed-pagination-container" class="pagination-container">
			                    <div class="feed-pagination pagination">
			                        <ul>
							    		<li>
								            <a id="prev">&lt;</a>
								        </li>
							    		<li>
							           		<a id="next">&gt;</a>
							        	</li>
								    </ul>
			                    </div>
			                </div>			
						
						</div> 
					
					</div> 
					<div class="no-post d-flex justify-content-center"></div>	
					
				</div>
					 
				
				<!-- 스토어 탭 -->
				
				<div class="tab-pane fade" id="store"><br>
				
					<div class="row col-lg-12 justify-content-between">
						<select name="sortSelect" onchange="getCreatorProductList(0, 'creDate');" class="form-control-sm">
							<option value="creDate">최신순</option>
							<option value="popularity">인기순</option>
							<option value="highprice">높은가격순</option>
							<option value="lowprice">낮은가격순</option>
						</select>

						<c:if test="${sessionScope.user.url == profile.url}">
							<div class="writenew line">
								<a href="/store/products/management">상품 관리</a>
							</div>	
						</c:if>				

					
					</div>
					<br>
					
					<div id="products">
					
						<div class="row">	               
						 
							<!-- Product Card Start -->	
		            		<div class="col-lg-4" id="product-box">
			                    <div class="item">
			                        <div class="thumb">
			                            <div class="hover-content">
			                                <ul>
				                                <c:choose>
					                        		<c:when test="${user.id == null }">
					                        			<li onclick="loginAlert(event)"><i class="fa fa-shopping-cart"></i></li>
					                        		</c:when>
					                        		<c:otherwise>
				   										<li class="has-id"><i class="fa fa-shopping-cart"></i></li>
					                        		</c:otherwise>
					                        	</c:choose>
			                                </ul>
			                            </div>
			                            <img alt="상품 썸네일">
			                        </div>
			                        <div class="down-content">
			                            <h4 class="p_name"></h4>
			                            <c:if test="${i.sale != 0}"><span class="cost">원</span></c:if>
			                            <span class="price">원</span>
			                            <ul class="stars">
			                                <span class="star">
												★★★★★
												<span>★★★★★</span>
												<input type="range" value="1" step="1" min="0" max="10">
											</span>
			                            </ul>
			                        </div>
			                    </div>
			                </div>
			                <!-- Product Card End -->
			                
			                <div class="col-lg-12" id="store-pagination-container" class="pagination-container">
			                    <div class="store-pagination pagination">
			                        <ul>
							    		<li>
								            <a id="prev">&lt;</a>
								        </li>
							    		<li>
							           		<a id="next">&gt;</a>
							        	</li>
								    </ul>
			                    </div>
			                </div>
						</div>
					</div>
						
					<div class="no-item d-flex justify-content-center"></div>
				</div>
		
			<!-- 공지 탭 -->
			<div class="tab-pane fade" id="notice">

				<div class="container">
								<br>

				<!-- 	<div class="row">
						<div class="col-offset-sm-9 col-sm-3 col-offset-md-10 col-md-2 col-offset-lg-10 col-lg-2" id="noticemanage"><a href="notice-management.do">공지 관리</a></div>
					</div>	 -->
					<div class="row">
						<div class="col-12" style="margin-bottom:15px;">
							<c:if test="${sessionScope.user.url == profile.url}">
								<div class="writenew1">
									<a href="/profiles/url/notice">공지 관리</a>
								</div>
							</c:if>
						</div>	
						<br>
						<div class="col-sm-12 col-md-12 col-xl-12 col-lg-12">
				            <div class="card carddiv">
				              <form class="card-body" action='#' method='post'>
				                <div class="row notice-box">
					                <div class="notice col-lg-12">
					                	<div>
					                		<p class="card-description">
												안녕하세요,기쁘게도 8월 초에 새로운 온라인 상품 판매 서비스를  출시할 예정입니다! <br>
												이를 앞두고 여러분과 소중한 정보를 공유하고자 합니다.<br>
												새로운 캐릭터 템플릿과 넓은 범위의 다양한 디자인 템플릿 pdf 상품을 공개합니다.<br> 
												풍부한 제품 선택지를 제공하여 다양한 관심사와 요구에 부응할 수 있도록 노력하겠습니다. <br>
												안녕하세요,기쁘게도 8월 초에 새로운 온라인 상품 판매 서비스를  출시할 예정입니다! <br>
												이를 앞두고 여러분과 소중한 정보를 공유하고자 합니다.<br>
												새로운 캐릭터 템플릿과 넓은 범위의 다양한 디자인 템플릿 pdf 상품을 공개합니다.<br> 
												풍부한 제품 선택지를 제공하여 다양한 관심사와 요구에 부응할 수 있도록 노력하겠습니다. <br>
												안녕하세요,기쁘게도 8월 초에 새로운 온라인 상품 판매 서비스를  출시할 예정입니다! <br>
												이를 앞두고 여러분과 소중한 정보를 공유하고자 합니다.<br>
												새로운 캐릭터 템플릿과 넓은 범위의 다양한 디자인 템플릿 pdf 상품을 공개합니다.<br> 
												풍부한 제품 선택지를 제공하여 다양한 관심사와 요구에 부응할 수 있도록 노력하겠습니다. <br>
												안녕하세요,기쁘게도 8월 초에 새로운 온라인 상품 판매 서비스를  출시할 예정입니다! <br>
												이를 앞두고 여러분과 소중한 정보를 공유하고자 합니다.<br>
												새로운 캐릭터 템플릿과 넓은 범위의 다양한 디자인 템플릿 pdf 상품을 공개합니다.<br> 
												풍부한 제품 선택지를 제공하여 다양한 관심사와 요구에 부응할 수 있도록 노력하겠습니다. <br>
											</p>
						                	<input type="checkbox" class="card-content__more-btn">				                	
					                	</div>
										<br>
					                	<div class="d-flex justify-content-start img-box scroll-custom">
						                	<div class="d-flex studioimgdiv"><img id="studioimg" src="/resources/images/춘식이스프링다이어리.jpg" alt=""></div>
						                	<div class="d-flex studioimgdiv"><img id="studioimg" src="/resources/images/춘식이스프링다이어리1.jpg" alt=""></div>
						                	<div class="d-flex studioimgdiv"><img id="studioimg"  src="/resources/images/춘식이스프링다이어리2.jpg" alt=""></div>
						                	<div class="d-flex studioimgdiv"><img id="studioimg" src="/resources/images/춘식이스프링다이어리2.jpg" alt=""></div>
					                	</div>
					                </div>
					             </div>
								</form>				
							</div>
						</div>
					</div>
				</div>
			</div>

			
			</div>	
		</div>
	</div>
	
	<!-- ***** StoreCreate Modal Start ***** -->
	<div class="modal fade" id="store-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-container" role="document" >
			<div class="modal-content">
			</div>
		</div>
  	</div>
	<!-- ***** StoreCreate Modal End ***** -->
	
	
	<!-- 멤버십 모달 -->
	<!-- <button type="button" class="btn btn-primary" data-toggle="modal" data-target=".bd-example-modal-lg">Large modal</button> -->

	<div class="modal fade bd-example-modal-lg " tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="subModal">
	  <div class="modal-dialog modal-lg fixed-bottom">
	    <div class="modal-content Membershipdiv" >
	      <form action="/profiles/{url}" method="post">
		      <br>
		      	<h4 class="membershipSub">구독 안내</h4>
		      <br>
		      <div class="Subdiv">
				<div class="s s1"></div>
				<div class="s "><strong class="s2">${getMembership.price} 원</strong>/월</div>
				<div class="s s3">${getMembership.content}</div>
		      </div>
		      <br>
		      <p class="desc">크리에이터 구독은 매달 정기결제를 통해<br>크리에이터의 새로운 상품을 만나볼 수 있는 구매 방식입니다</p>
		      <div class="Subjoin">
		      	<c:if test="${empty sessionScope.user.id}">
		      		<h6><input type="button" value="크리에이터 구독하기" class="subjoin" onclick="showLoginAlertSub()"></h6>
		      	</c:if>
		      	<c:if test="${!empty sessionScope.user.id}">
		      		<c:set var="now" value="<%=new java.util.Date()%>" />
		      		
		      		<h6><input type="button" value="크리에이터 구독하기" class="subjoin" onclick="testpay('${getspsubid}','${sessionScope.user.id}')"></h6>
		      		<%-- <h6><input type="button" value="멤버십 가입하기" class="subjoin" onclick="testpay('${getspsubid}','${sessionScope.user.id}','10002-951-321321','<fmt:formatDate value="${now}" pattern="yyyy-MM-dd"/>')"></h6> --%>
		      		
		      	</c:if>
		      </div>
	      </form>
	    </div>
	  </div>
	</div>


	
	<!-- 이미지 업로드 모달  -->
		<div class="modal" id="modal">
			
			<form class="mcontent" action="/users/profile-img" method="post" enctype="multipart/form-data">
				<p class="modalclose">&times;</p>
					<div class="image-upload" id="image-upload">
			            <div class="fileContainer">
			                <input type="hidden" name="_method" value="PUT"/>
			            	<input id="folder" type="hidden" name="folder" value=""/>
			                <div class="fileInput">
			                    <p>FILE NAME: </p>
			                    <p id="fileName"></p>
			                </div>
			                <div class="buttonContainer button">
			                    <label class="submitButton" for="chooseFile">업로드</label>
			                </div>
			                <input type="file" id="chooseFile" name="chooseFile" accept="image/*" required>
			            </div>
			        </div>
			        <!-- <div class="image-show" id="image-show"></div> -->
			        <div class="uploadbtn">
			        	<input type="submit" value="프로필 사진 수정" id="uploadbtn">
			        </div>
		
			</form>
	
		</div>
		
		<!-- 구독 취소 모달  -->
		<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		         <!--  <span aria-hidden="true">&times;</span> -->
		        </button>
		      </div>
		      <div class="modal-body">
		      
		        ${profile.getName()} 구독을 취소하시겠습니까? 
		     
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>		        
		       	<form action="/profiles/${profile.url}" method="post">
		       		<input type="hidden" name="_method" value="delete">
		       		<input type="hidden" name="type" value="unSub">
		        	<input type="submit" class="btn cancel" value="구독취소">
				</form>		        
		      </div>
		    </div>
		  </div>
		</div>

	
		<div class="modal fade" id="ExampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <!-- <span aria-hidden="true">&times;</span> -->
		        </button>
		      </div>
		      <div class="modal-body">
		
		        ${profile.getName()} 팔로우를 취소하시겠습니까? 
		
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>		        
		        <form action="/profiles/${profile.url}" method="post" >
		        	<input type="hidden" name="_method" value="delete">
		        	<input type="hidden" name="type" value="unFollow"> 
		        	<input type="submit" class="btn cancel" value="팔로우 취소">
	        	</form>
		      </div>
		    </div>
		  </div>
		</div>		


<input type="hidden" id="sessionId" name="id" value="${user_id}">
</main>
<script src="/resources/js/profile.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
