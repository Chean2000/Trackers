<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />


<!-- ***** Page Content Starts ***** -->
<main id="user-modify" class="my-info user-modify broad">
    <section class="section">
    	<div class="page-title">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-heading">
                        <h2>회원정보 수정</h2>
                    </div>
                </div>
            </div>
        </div>
		<div class="container">
			<div id="modify-input-container" class="d-flex flex-column">
				<form action="/users" method="post" onsubmit="return modify_chk('user', 2);">
					<input type="hidden" name="_method" value="put">
					<div class="form-group name">		<!-- 이름(닉네임) -->
						<div class="input-group">
							<p>이름</p>
							<input type="text" class="form-control" name="name" value="${user.name}" placeholder="닉네임" onkeyup="name_len();" maxlength="8" required oninput="remove(3 ,this);">
						</div>
						<p></p>
					</div>
					<div class="form-group">		<!-- 핸드폰번호 -->
						<div class="input-group">
							<p>핸드폰 번호</p>
							<input type="text" class="form-control" name="tel" value="${user.tel}" placeholder="핸드폰 번호" maxlength="13" oninput="tel_hyphen(this);" required>
						</div>
					</div>
					<div class="form-group">		<!-- 프로필 url -->
						<div class="input-group">
							<p>개인 프로필 URL</p>
							<input type="text" class="base-url" value="/profiles/" disabled>
							<input type="text" class="form-control" name="url" placeholder="프로필 URL" value="${user.url}" onkeyup="chk_reset('url')" oninput="remove(3, this)" required>
							<button type="button" class="btn btn-chk" onclick="url_chk('${user.url}', 2, 'modify')">Check</button>
						</div>
						<p></p>
					</div>
					<div class="form-group">		<!-- sns 링크 -->
						<div class="input-group">
							<p>SNS</p>
		              		<span class="input-group-addon"><i class="fa fa-instagram"></i></span>
							<input type="text" class="form-control" name="instagram" value="${user.instagram}" placeholder="Instagram URL" oninput="remove(1, this); at(this);">
						</div>
						<div class="input-group">
		              		<span class="input-group-addon"><i class="fa fa-youtube-play"></i></span>
							<input type="text" class="form-control" name="youtube" value="${user.youtube}" placeholder="YouTube URL" oninput="remove(1, this); at(this);">
						</div>
					</div>
					
					<div class="form-group">
						<input type="submit" class="btn btn-block btn-lg" value="수정하기">
					</div> 
				</form>
				
				<form action="/users" method="post" class="remove-container" onsubmit="return user_remove();">
					<input type="hidden" name="_method" value="delete">
					<input type="submit" class="user-remove" value="회원탈퇴">
				</form>
			</div>
		</div>
    </section>
</main>
<!-- ***** Page Content Ends ***** -->

<script>
	function user_remove(){
		return confirm("정말 탈퇴하시겠습니까?")
	}
</script>
 
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

   
