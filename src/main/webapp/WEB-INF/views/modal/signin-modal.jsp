<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!-- https://www.tutorialrepublic.com/snippets/preview.php?topic=bootstrap&file=flat-modal-login-form-with-icons -->
<!-- https://www.codehim.com/bootstrap/bootstrap-4-modal-popup-login-form/ -->

<div class="modal-header border-bottom-0">
	<button type="button" class="close" data-dismiss="modal" aria-label="Close">
		<span aria-hidden="true">&times;</span>
	</button>
</div>
<div class="modal-body">
	<div class="form-title text-center">
		<h4 class="font-weight-bold">Sign In</h4>
	</div>
	<div class="d-flex flex-column text-center">
 		<form action="/users/signin" method="post" onsubmit="return login();">
 			<input id="path" type="hidden" name="path" value="">
			<div class="form-group">		<!-- 아이디(이메일) -->
				<div class="input-group">		
					<span class="input-group-addon"><i class="fa fa-user"></i></span>
					<input id="email" type="email" class="form-control" name="email" placeholder="UserEmail" required oninput="remove(2, this)">
				</div>
			</div>
			<div class="form-group">		<!-- 패스워드 -->
				<div class="input-group">
					<span class="input-group-addon"><i class="fa fa-lock"></i></span>
					<input id="password" type="password" class="form-control" name="password" placeholder="Password" required oninput="remove(1, this)">
				</div>
			</div>
			<div class="form-group">
				<button type="submit" class="btn btn-block btn-lg">Sign In</button>
			</div>
			<p class="hint-text"><a href="#">Forgot Password?</a></p>
		</form>
          
          <!-- <div class="text-center text-muted delimiter">or use a social network</div>
          <div class="d-flex justify-content-center social-buttons">
            <button type="button" class="btn btn-secondary btn-round" data-toggle="tooltip" data-placement="top" title="Twitter">
              <i class="fab fa-twitter"></i>
            </button>
            <button type="button" class="btn btn-secondary btn-round" data-toggle="tooltip" data-placement="top" title="Facebook">
              <i class="fab fa-facebook"></i>
            </button>
            <button type="button" class="btn btn-secondary btn-round" data-toggle="tooltip" data-placement="top" title="Linkedin">
              <i class="fab fa-linkedin"></i>
            </button>
          </div> -->
	</div>
	<div class="modal-footer">Don't have an account? <a href="#" onclick="changeSignupModal()">Create one</a></div>
</div>
      