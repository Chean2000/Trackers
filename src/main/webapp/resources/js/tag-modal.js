// 포스트 작성 시 태그모달에서 값 가져오기

function getTag(p_id, p_name) {

	$('.co #tag').val(p_id);
	$('#modal').modal('hide');
	
	$('.tag-preview').text('태그- '+p_name);
	$('.tag-delete').addClass('active');

}


// 포스트 작성 시 등록했던 태그 삭제
function deleteTag() {

	$('.tag-delete').removeClass('active');
	$('.tag-preview').text('');
	$('.co #tag').val('');

}




// 상품상세에서 태그 모아보기 버튼 클릭시 커뮤니티로 이동하여 목록 출력
function getTagList(p_id) {

	location.href='/community/posts?page=0&type=tag&pid='+p_id;

}





	