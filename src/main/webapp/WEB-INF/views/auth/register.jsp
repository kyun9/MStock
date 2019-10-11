<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html class="h-100" lang="en">


<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1">

<title>Register</title>

<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-2.1.3.min.js"></script>

</head>


<style>
.login-form__btn {
	background: #455F98;
	color: #fff;
	padding: 13px 40px;
	font-size: 14px;
}

.login-form__btn.submit {
	padding: 15px 40px;
	background: #7571f9;
	font-size: 15px;
}

.login-form a {
	color: #596A81;
	text-decoration: none;
}

.login-input .form-group label {
	color: #505F76;
	font-size: 15px;
}

.login-input .form-group .form-control {
	background: transparent;
	border: 0;
	border-radius: 0;
	border-bottom: 1px solid #f5f5f5;
	padding-left: 0;
	color: #7A88A1;
}

.form-label-group p{
	font-size: 12px;
}

.form-control:focus {
	box-shadow: none;
}
</style>
<body>

	<c:if test="${!empty msg}">
		<script>
			alert("${msg}");
		</script>
		<c:if test="${result eq 'success'}">
			<script>
			location.href = "/mstock/login";
			</script>
		</c:if>
	</c:if>
	<div class="login-form-bg h-100">
		<div class="container h-100" style="margin-top: 100px">
			<div class="row justify-content-center h-100">
				<div class="col-xl-6">
					<div class="form-input-content">
						<div class="card login-form mb-0">
							<div class="card-body pt-5">
								<div class="text-center" style="width: 100%">
									<a class="text-center" href="/mstock"> <img class="logo"
										src="/mstock/resources/images/logo.svg" alt="logo">
									</a>
								</div>
								<form class="mt-5 mb-5 login-input" action="/mstock/register"
									method="post">
									
									<div class="form-group input-group mb-3">
										<input id="id" name="id" type="text" class="form-control" placeholder="아이디" required>
										<div class="input-group-append">
    										<button class="btn btn-outline-secondary" type="button" id="checkIdBtn">확인</button>
 										 </div>
									</div>
									
									<div class="form-label-group">
										<p id="checkId"></p>
									</div>
									
									<div class="form-group">
										<input id="password" name="password" type="password" class="form-control"
											placeholder="비밀번호" required>
									</div>
									<div class="form-group">
										<input id="repassword" type="password" class="form-control"
											placeholder="비밀번호 확인" required>
									</div>

									<div class="form-label-group">
										<p id="checkpassword"></p>
									</div>
									
									<div class="form-group input-group mb-3">
										<input id="nickname" name="nickname" type="text" class="form-control" placeholder="닉네임"  required>
										<div class="input-group-append">
    										<button class="btn btn-outline-secondary" type="button" id="checkNicknameBtn">확인</button>
 										 </div>
									</div>
									
									<div class="form-label-group">
										<p id="checkNickname"></p>
									</div>
									
									<div class="form-group input-group mb-3">
										<input id="email" name="email" type="text" class="form-control" placeholder="이메일" required>
										<div class="input-group-append">
    										<button class="btn btn-outline-secondary" type="button" id="checkEmailBtn">확인</button>
 										 </div>
									</div>
									
									<div class="form-label-group">
										<p id="checkEmail"></p>
									</div>

									<button type="submit" id="registerBtn" class="btn login-form__btn submit w-100" disabled>회원가입</button>
								</form>
								<p class="mt-5 login-form__footer">
									이미 계정이 있으신가요? 그렇다면 <a href="/mstock/login" class="text-primary">로그인</a>
									하세요
								</p>

							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script src="/mstock/resources/js/registerConfirm.js"></script>

</body>
</html>