
/*  날짜 변환 함수  */
function convertDate(milliSecond) {
	let data = new Date(milliSecond);
	
	let year = data.getFullYear();
	let month = data.getMonth() + 1;
	let date = data.getDate();
	let hour = data.getHours();
	let minute = data.getMinutes();
	let second = data.getSeconds();
	
	let result = year + '-' +
		(month < 10 ? '0'+month : month) + '-' +
		(date < 10 ? '0'+date : date) + ' '+
		(hour < 10 ? '0'+hour : hour) + ':' +
		(minute < 10 ? '0'+minute : minute) + ':' +
		(second < 10 ? '0'+second : second);
		
	return result;
}





/* 탭 - 피드 선택하면 피드 정보 가져오기    */
function getUserPostList(page) {
	
	let pathname = window.location.pathname;
	let url = pathname.substring(pathname.indexOf("profiles")+9);
	if(url.indexOf("/") > 0) {	
		url = url.substring(0, url.indexOf("/"));
	}
	
	$.ajax({
		type: 'get',
		url: '/profiles/'+url+'/posts',
		contentType: "application/text; charset=UTF-8",
		datatype: 'json',
		data: {
			page: page,
		},
		success: function(data) {					
			
			// JSON 객체별로 쪼개기
			let JSONdata = JSON.parse(data);
			let list = JSON.parse(JSONdata.list);	// 포스트 리스트
			let paging = JSON.parse(JSONdata.paging);
			let imgs = JSON.parse(JSONdata.imgs);
			let comments = JSON.parse(JSONdata.comments);
			// 안에있는 리스트도 따로 해줘야하나...
			
			
			let postArr = list.content;
			
			let box = document.getElementById("post-box");
			let parent = box.parentElement;
			let pagination = document.getElementById('feed-pagination-container');
			
			$(box).hide();
			$(pagination).hide();

			
			if(postArr.length > 0) {
				$('.new-box').remove();
				$('.new-li').remove();				

				for(let i = 0; i < postArr.length; i++) {
					let post = postArr[i];
					
					let newBox = document.createElement('section');
					newBox.innerHTML = box.innerHTML;
					newBox.classList.add('post');
					newBox.classList.add('new-box');
					
					// 전체 onclick 부여
					let post_onclick = $(newBox).find('.post-onclick');
					$(post_onclick).on('click', function() {
						 location.href='/community/posts/'+post.postId;
					});
					
					let profile_img = $(newBox).find('.author img');
					profile_img.attr('src', post.profile_img)
					
					let name = $(newBox).find('.author.name');
					name.text(post.name);
					
					let delFrm = $(newBox).find('.delFrm');
					delFrm.attr('action', '/community/posts/'+post.postId);
					$(delFrm).hide();
					
					// 로그인된 id가 같을 때만 삭제버튼 띄워주기
					let current_id = '${sessionScope.user.id}';
					if(current_id == post.id) {
						$(delFrm).show();
					} else {						
						$(delFrm).hide();
					}
					
					let published = $(newBox).find('.published');
					published.text(convertDate(post.creDate));
					
					
					// 이미지가 있을 경우에만 띄워주기
					let img_container = $(newBox).find('.img-container');
					img_container.hide();
					
					let imgList;
					for(let key in imgs) {
						if(key == post.postId) {
							imgList = imgs[key];
						}
					}
					
					if(imgList != null && imgList.length > 0) {
						let img_card = $(img_container).find('#card');
						img_card.hide();
						
						if(imgList.length == 1) {
							img_container.addClass('one');
						}
						else if(imgList.length == 2) {
							img_container.addClass('two');
						}
						else if(imgList.length == 3) {
							img_container.addClass('three');
						}
						else if(imgList.length == 4) {
							img_container.addClass('four');
						}
						
						for(let j = 0; j < imgList.length; j++) {
							let img = imgList[j];
							
							let newCard = document.createElement('div');
							newCard.innerHTML = img_card.html();
							newCard.classList.add('img-card');
							
							let inner_img = $(newCard).find('img');
							inner_img.attr('src', img.img);
							$(inner_img).on('click', function() {
								showImageModal(event, img.img);
							});
							
							img_container.append(newCard);
						}
						
						img_container.show();
						img_container.css('display', 'grid');
					}
					

					// 본문
					let content = $(newBox).find('.post-content-inner');
					content.text(post.content);
					
					
					// 좋아요 버튼 onclick
					let t_count_container = $(newBox).find('.like-count');
					$(t_count_container).on('click', function() {
					    
					    var likeCount = parseInt($(this).parent().find(".like-count-number").text().trim());
					    likeCount++;
					    $(this).parent().find(".like-count-number").text(likeCount);
				    });
					
					
					// 댓글 개수에 따라 onclick 다르게 부여
					let c_count_container = $(newBox).find('.comment-count');
					let c_count = post.c_count;
					
					if(c_count > 3) {
						$(c_count_container).on('click', function() {
							location.href='/community/posts/'+post.postId;
						});
					} else {
						$(c_count_container).on('click', function() {
							showCommentInput(this);
						});
					}
					
					$(newBox).find('.comment-count-number').text(post.c_count);
					$(newBox).find('.like-count-number').text(post.t_count);
					
					
					// 태그 있을 경우에만 태그아이콘 및 상품명 표시
					let tag = $(newBox).find('.tag');
					tag.hide();
					
					if(post.pid != null && post.pid > 0) {
						$(tag).find('.tag-product').text(post.p_name);
						$(tag).on('click', function() {
							location.href='/store/products/'+post.pid;
						});					
						tag.show();
					} 
					
					
					// 댓글 표시
					
					let comment_container = $(newBox).find('.comment-list');
					let comment_button = $(newBox).find('.comment-button');
					comment_container.hide();
					comment_button.hide();
					
					let commentList;
					for(let key in comments) {
						if(key == post.postId) {
							commentList = comments[key];
						}
					}
					
					
					if(commentList != null && commentList.length > 0) {
						
						let comment_li = $(comment_container).find('#li');
						comment_li.hide();
						
						for(let j = 0; j < commentList.length; j++) {
							let comment = commentList[j];
							
							
							let newLi = document.createElement('li');
							newLi.innerHTML = comment_li.html();
							//newLi.classList.add('img-card');
							
							$(newLi).find('.comment-name').text(comment.name);
							$(newLi).find('.comment-date').text(convertDate(comment.creDate));
							$(newLi).find('.comment-content').text(comment.content);
							
							
							// 로그인된 id가 같을 때만 삭제버튼 띄워주기
							let delCommentFrm = $(newLi).find('.deleteComment');
							delCommentFrm.attr('action', '');
							// 나중에 action 추가
							$(delCommentFrm).hide();
					
							let current_id = '${sessionScope.user.id}';
							if(current_id == comment.id) {
								$(delCommentFrm).show();
							} else {						
								$(delCommentFrm).hide();
							}
							
							
							comment_container.append(newLi);
						}
						
						comment_container.show();
						comment_button.show();
					}
					
					
					
					// 댓글 입력창 (댓글 존재 여부와 상관없이 필요)
					let insertcomment = $(newBox).find('#insertcomment');
					insertcomment.attr('action', '/community/posts/'+(post.postId)+'/comments');
					
					let comment_hidden_postId = $(newBox).find('.comment-postId');
					comment_hidden_postId.val(post.postId);
					
					// 댓글 입력창 - 로그인 된 경우에만 띄워줌
					let comment_login = $(newBox).find('.comment-login');
					let comment_logout = $(newBox).find('.comment-logout');
					
					if(current_id != null && current_id.length > 0) {
						comment_login.show();
						comment_login.css('display', 'flex');
						comment_login.css('width', '100%');
						comment_logout.hide();
					} else {
						comment_login.hide();
						comment_logout.show();
					}	

					
					parent.insertBefore(newBox, pagination);
				}

				
							
				// 페이징 처리	
				
				if(list.totalPages > 1) {
					
					
					$(pagination).show();
					
					
					let ul = document.querySelector('.feed-pagination ul');
					let page = document.querySelector('.feed-pagination #page');
					let prev = document.querySelector('.feed-pagination #prev');
					let next = document.querySelector('.feed-pagination #next');
					
					if(list.number-1 >= 0) {
						$(prev).show();
						$(prev).on('click', function() {
							getUserPostList((list.number-1));
						});
					} else {
						$(prev).hide();
					}
					
					if(list.number+1 < list.totalPages) {
						$(next).show();
						$(next).on('click', function() {
							getUserPostList((list.number+1));
						});
					} else {
						$(next).hide();
					}

					
					for(let p = paging.startPage; p <= paging.endPage; p++) {
						let newPage = document.createElement('a');
						let newPageLi = document.createElement('li');
						newPageLi.classList.add('new-li');
						if(p == paging.nowPage) {
							newPageLi.classList.add('active');
						}

						$(newPage).on('click', function() {
							getUserPostList(p-1);
						});
						
						$(newPage).text(p);
						
						newPageLi.appendChild(newPage);
						ul.insertBefore(newPageLi, next.parentElement);
					}
				}
				
				
			} else {
				
				// 작성한 포스트가 없는 경우
				$('.no-post').html('<h5>작성한 포스트가 없습니다</h5>');
				
			}
			
			
	
			$("#feed").addClass("active").addClass("show");
			$("#store").removeClass("active").removeClass("show");
			$("#notice").removeClass("active").removeClass("show");
			
		},
		error: function(message) { }
		
	})
	
} 





/* 탭 - 스토어 선택하면 스토어 정보 가져오기 */
function getCreatorProductList(page, sort) {

	let pathname = window.location.pathname;
	let url = pathname.substring(pathname.indexOf("profiles")+9);
	if(url.indexOf("/") > 0) {	
		url = url.substring(0, url.indexOf("/"));
		
	}
	
	// sort 값 구해서 넣어주기
	let sortSelect = document.getElementsByName('sortSelect')[0];	
	sort = sortSelect.options[sortSelect.selectedIndex].value;
	
	
	
	$.ajax({
		type: 'get',
		url: '/profiles/'+url+'/products',
		contentType: "application/text; charset=UTF-8",
		datatype: 'json',
		data: {
			page: page,
			sort: sort
		},
		success: function(data) {					
			
			// JSON 객체별로 쪼개기
			let JSONdata = JSON.parse(data);
			let list = JSON.parse(JSONdata.list);	// 상품 리스트
			let paging = JSON.parse(JSONdata.paging);
			
			
			let productArr = list.content;
			
			let box = document.getElementById("product-box");
			let parent = box.parentElement;
			let pagination = document.getElementById('store-pagination-container');
			
			$(box).hide();
			$(pagination).hide();

			
			if(productArr.length > 0) {
				$('.new-box').remove();
				$('.new-li').remove();				

				for(let i = 0; i < productArr.length; i++) {
					let product = productArr[i];
					
					let newBox = document.createElement('div');
					newBox.innerHTML = box.innerHTML;
					newBox.classList.add('col-lg-4');
					newBox.classList.add('new-box');
					
					let item = $(newBox).find('.item');
					item.on('click', function(){
						location.href='/store/products/'+product.pid;
					});
					
					let cart = $(newBox).find('.hover-content li.has-id');
					cart.on('click', function() {
						preventDefaultGoCart(event, product.pid);
					});
					
					let thumbnail = $(newBox).find('img');
					thumbnail.attr('src', product.thumbnail)
					
					let p_name = $(newBox).find('.p_name');
					p_name.text(product.pname);
					
					$(newBox).find('.cost').text(numberWithCommas(product.price)+'원');
					$(newBox).find('.price').text(numberWithCommas(product.salePrice)+'원');
					
					if(product.sale <= 0) {
						$(newBox).find('.cost').hide();
					} 
					
					$(newBox).find('.star span').css('width', product.rating);

					parent.insertBefore(newBox, pagination);
				}

				
							
				// 페이징 처리		
				if(list.totalPages > 1) {
					
					$(pagination).show();
					
					let ul = document.querySelector('.store-pagination ul');
					let page = document.querySelector('.store-pagination #page');
					let prev = document.querySelector('.store-pagination #prev');
					let next = document.querySelector('.store-pagination #next');
					
					if(list.number-1 >= 0) {
						$(prev).show();
						$(prev).on('click', function() {
							getCreatorProductList((list.number-1), paging.sort);
						});
					} else {
						$(prev).hide();
					}
					
					if(list.number+1 < list.totalPages) {
						$(next).show();
						$(next).on('click', function() {
							getCreatorProductList((list.number+1), paging.sort);
						});
					} else {
						$(next).hide();
					}

					
					for(let p = paging.startPage; p <= paging.endPage; p++) {
						let newPage = document.createElement('a');
						let newPageLi = document.createElement('li');
						newPageLi.classList.add('new-li');
						if(p == paging.nowPage) {
							newPageLi.classList.add('active');
						}

						$(newPage).on('click', function() {
							getCreatorProductList(p-1, paging.sort);
						});
						
						$(newPage).text(p);
						
						newPageLi.appendChild(newPage);
						ul.insertBefore(newPageLi, next.parentElement);
					}
				}
				
				
			} else {
				
				// 판매자 등록은 되어있는데 상품은 없는 경우
				$('.no-item').html('<h5>등록된 상품이 없습니다</h5>');
			}
			
			
	
			$("#store").addClass("active").addClass("show");
			$("#feed").removeClass("active").removeClass("show");
			$("#notice").removeClass("active").removeClass("show");
			
		},
		error: function(message) { }
		
	})
}
	
$(()=> {
	
	getUserPostList(0);
	
});

