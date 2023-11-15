<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 

<!-- tag js -->
<script src="/resources/js/tag-modal.js"></script>

<script>

function getTagModal(page) {
	
	$.ajax({
		type: 'get',
		url: '/store/tag',
		contentType: "application/text; charset=UTF-8",
		datatype: 'json',
		data: {
			page: page
		},
		success: function(data) {					
			
			// JSON 객체별로 쪼개기
			let JSONdata = JSON.parse(data);
			let list = JSON.parse(JSONdata.list);	// 상품 리스트
			let paging = JSON.parse(JSONdata.paging);

			let tagArr = list.content;
			//console.log(productArr.length);
			
			let box = document.getElementById("tag-box");
			let parent = box.parentElement;
			let pagination = document.getElementById('tag-pagination-container');
			
			$(box).hide();
			$(pagination).hide();

			
			if(tagArr.length > 0) {
				$('.new-box').remove();
				$('.new-li').remove();				

				for(let i = 0; i < tagArr.length; i++) {
					let tag = tagArr[i];
					
					let newBox = document.createElement('div');
					newBox.innerHTML = box.innerHTML;
					newBox.classList.add('new-box');
					newBox.classList.add('tag-info');
					
					let thumbnail = $(newBox).find('.thumb img');
					thumbnail.attr('src', tag.thumbnail)
					
					let tag_name = $(newBox).find('.tag-name');
					tag_name.text(tag.p_name);
					
					let tag_store_name = $(newBox).find('.tag-store-name');
					tag_store_name.text(tag.store_name);
					
					let tag_btn = $(newBox).find('.tag-btn');
					tag_btn.on('click', function(){
						getTag(tag.bak_p_id, tag.p_name);
					});

					parent.insertBefore(newBox, pagination);
				}

				
							
				// 페이징 처리		
				if(list.totalPages > 1) {
					
					$(pagination).show();
					
					let ul = document.querySelector('.tag-pagination ul');
					let page = document.querySelector('.tag-pagination #page');
					let prev = document.querySelector('.tag-pagination #prev');
					let next = document.querySelector('.tag-pagination #next');
					
					if(list.number-1 >= 0) {
						$(prev).show();
						$(prev).on('click', function() {
							getTagModal((list.number-1));
						});
					} else {
						$(prev).hide();
					}
					
					if(list.number+1 < list.totalPages) {
						$(next).show();
						$(next).on('click', function() {
							getTagModal((list.number+1));
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
							getTagModal(p-1);
						});
						
						$(newPage).text(p);
						
						newPageLi.appendChild(newPage);
						ul.insertBefore(newPageLi, next.parentElement);
					}
				}
				
				
			} else {
				
				// 구매 내역이 없는 경우
				let noItem = document.createElement('div');
				noItem.innerHTML = '<h5>태그 가능한 상품이 없습니다</h5>';
				parent.appendChild(noItem);
			}
			
			
	
			$("#store").addClass("active").addClass("show");
			$("#feed").removeClass("active").removeClass("show");
			$("#notice").removeClass("active").removeClass("show");
			
		},
		error: function(message) { 
			alert('통신 에러 발생');
		}
		
	})
}
	
$(()=> {	
	getTagModal(0);
});


</script>




<div id="tag-modal">
	<div class="modal-header">
		<h6 class="tag-products">태그 가능한 상품</h6>
	</div>
	 
	<div class="modal-body">
		
		<div class="tag-info" id="tag-box">
			<div class="thumb">
				<img alt="상품 썸네일">
			</div>

			<div class="d-flex flex-column justify-content-center product-info">
				<h5 class="tag-name"></h5>
				<h6 class="tag-store-name"></h6>
			</div>

			<div class="d-flex justify-content-center">
				<button type="button" class="tag-btn">태그하기</button>
			</div>
		</div>
		
		<div id="tag-pagination-container" class="pagination-container">
			<div class="tag-pagination pagination">
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
	 
	<div class="modal-footer">
	</div>
</div>
	   