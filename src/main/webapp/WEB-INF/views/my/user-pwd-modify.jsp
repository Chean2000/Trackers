<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
      

    

<!-- ***** Page Content Starts ***** -->
<main id="user-pwd-modify" class="my-info user-modify broad">
    <section class="section">
    	<div class="page-title">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-heading">
                        <h2>비밀번호 수정</h2>
                    </div>
                </div>
            </div>
        </div>
		<div class="container">
			<div id="modify-input-container" class="d-flex flex-column">
				<form action="/users/pwd" method="post" onsubmit="return change_pwd_chk();">
					<input type="hidden" name="_method" value="put">
					<!-- 비밀번호 변경 -->
					<div class="form-group">		<!-- 기존 비밀번호 -->
						<div class="input-group">
							<p>기존 비밀번호</p>
							<input type="password" class="form-control" name="old_password" placeholder="8자리 이상" required oninput="remove(1, this);">
						</div>
						<p></p>
					</div>
					
					<div class="form-group">		<!-- 신규 비밀번호 -->
						<div class="input-group">
							<p>신규 비밀번호</p>
							<input type="password" class="form-control" name="password" placeholder="8자리 이상" required oninput="pwd_validation('modify-input-container', this);">
						</div>
						<p></p>
					</div>
					
					<div class="form-group">		<!-- 신규 비밀번호 확인 -->
						<div class="input-group">
							<p>신규 비밀번호 확인</p>
							<input type="password" class="form-control" placeholder="8자리 이상" oninput="remove(1, this);" required>
						</div>
						<p></p>
					</div>
					
					<div class="form-group">
						<input type="submit" class="btn btn-block btn-lg" value="수정하기">
					</div>
				</form>
			</div>
		</div>
    </section>
</main>
<!-- ***** Page Content Ends ***** -->


 
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

   
