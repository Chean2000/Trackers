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
		<h4 class="font-weight-bold">Store Create</h4>
	</div>
	<div class="d-flex flex-column text-center">
		<form action="/store/creators" method="post" onsubmit="return store_create_chk();">
			<div class="form-group">		<!-- 스토어 이름 -->
				<div class="input-group necessary">
					<input type="text" class="form-control" name="storeName" placeholder="스토어 이름" onkeyup="chk_reset('store')" required>
					<button type="button" class="btn btn-chk" onclick="store_chk('', 'user')">Check</button>
				</div>
				<p></p>
			</div>
			<div class="form-group">		<!-- url주소 재확인 OR 변경 -->
				<div class="input-group necessary">
					<input type="text" class="base-url" value="/profiles/" disabled>
					<input type="text" class="form-control" name="url" value="${user.url}" placeholder="프로필 URL" onkeyup="chk_reset('url')" oninput="remove(3, this);" required>
					<button type="button" class="btn btn-chk" onclick="url_chk('${user.url}', 1, 'user')">Check</button>
				</div>
				<p></p>
			</div>
			<div class="form-group">		<!-- 폰번호 재확인 -->
				<div class="input-group necessary">
					<input type="text" class="form-control" name="tel" value="${user.tel}" placeholder="핸드폰 번호 재확인" maxlength="13" oninput="tel_hyphen(this);" required>
				</div>
			</div>
			<div class="form-group">		<!-- 계좌번호 -->
				<div class="input-group necessary">
					<select name="bank" class="form-control bank">
		           		<option selected>우리은행</option>
		           		<option>국민은행</option>
		           		<option>신한은행</option>
		           	</select>
					<input type="text" class="form-control" name="account" placeholder="계좌 번호 (- 제외)" oninput="remove(4, this);" required>
				</div>
			</div>
			<div class="form-group">
				<input type="submit" class="btn btn-block btn-lg" value="Create">
			</div>            
		</form>
	</div>
</div>

<script>
	

</script>