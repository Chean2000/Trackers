<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- https://www.tutorialrepublic.com/snippets/preview.php?topic=bootstrap&file=flat-modal-login-form-with-icons -->
<!-- https://www.codehim.com/bootstrap/bootstrap-4-modal-popup-login-form/ -->

<div class="modal-header border-bottom-0">
	<button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="chk_reset('close');">
		<span aria-hidden="true">&times;</span>
	</button>
</div>
<div class="modal-body">
	<div class="form-title text-center">
		<h4 class="font-weight-bold">Sign Up</h4>
	</div>
	<div class="d-flex flex-column text-center">
		<form action="/users" method="post" onsubmit="return sign_chk();">
			<input id="path" type="hidden" name="path" value="">
			<div class="form-group">		<!-- 아이디(이메일) -->
				<div class="input-group necessary">
					<input type="email" class="form-control" name="email" placeholder="이메일" onkeyup="chk_reset('email')" oninput="remove(2, this)" required>
					<button type="button" class="btn btn-chk" onclick="email_chk()">Check</button>
				</div>
				<p></p>
			</div>
			<div class="form-group">		<!-- 비밀번호 -->
				<div class="input-group necessary">
					<input type="password" class="form-control" name="password" placeholder="비밀번호" required onkeyup="pwd_chk();" oninput="pwd_validation('modal', this);">
				</div>
				<p></p>
			</div>
			<div class="form-group">		<!-- 비밀번호 확인 -->
				<div class="input-group necessary">
					<input type="password" class="form-control" placeholder="비밀번호 확인" required onkeyup="pwd_chk();" oninput="remove(1, this)">
				</div>
				<p></p>
			</div>
			<div class="form-group name">		<!-- 이름(닉네임) -->
				<div class="input-group necessary">
					<input type="text" class="form-control" name="name" placeholder="닉네임" maxlength="8" required onkeyup="name_len();"  oninput="remove(3, this)">
				</div>
				<p></p>
			</div>
			<div class="form-group">		<!-- 핸드폰번호 -->
				<div class="input-group necessary">
					<input type="text" class="form-control" name="tel" placeholder="핸드폰 번호" maxlength="13" oninput="tel_hyphen(this);" required>
				</div>
			</div>
			<div class="form-group">		<!-- 프로필 url -->
				<div class="input-group necessary">
					<input type="text" class="base-url" value="/profiles/" disabled>
					<input type="text" class="form-control" name="url" placeholder="프로필 URL" onkeyup="chk_reset('url')" oninput="remove(3, this)" required>
					<button type="button" class="btn btn-chk" onclick="url_chk('', 5, 'user');">Check</button>
				</div>
				<p>개인 프로필 화면의 URL로 사용됩니다.</p>
				<p></p>
			</div>
			<div class="form-group">		<!-- sns 링크 -->
				<div class="input-group un-necessary">
              		<span class="input-group-addon"><i class="fa fa-instagram"></i></span>
					<input type="text" class="form-control" name="instagram" placeholder="Instagram URL" oninput="remove(1, this); at(this);">
				</div>
				<div class="input-group un-necessary">
              		<span class="input-group-addon"><i class="fa fa-youtube-play"></i></span>
					<input type="text" class="form-control" name="youtube" placeholder="YouTube URL" oninput="remove(1, this); at(this);">
				</div>
			</div>
			<div class="form-group">
				<input type="submit" class="btn btn-block btn-lg" value="Sign Up">
			</div>            
		</form>
	</div>
</div>