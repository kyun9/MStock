<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html class="h-100" lang="en">


<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1">

<title>Login</title>

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

.login-input .form-group {
	margin-bottom: 30px;
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

.form-control:focus {
  box-shadow: none; }
</style>

<body>

	<div class="login-form-bg h-100">
		<div class="container h-100" style="margin-top:100px">
			<div class="row justify-content-center h-100">
				<div class="col-xl-6">
					<div class="form-input-content">
						<div class="card login-form mb-0">
							<div class="card-body pt-5">
								<div class="text-center" style="width:100%">
									<a href="index.html">
										<img class="logo" src="/mstock/resources/images/logo.svg" alt="">
									</a>
								</div>

								<form class="mt-5 mb-5 login-input">
									<div class="form-group">
										<input type="text" class="form-control" placeholder="아이디">
									</div>
									<div class="form-group">
										<input type="password" class="form-control"
											placeholder="비밀번호">
									</div>
									<button class="btn login-form__btn submit w-100">로그인</button>
								</form>
								<p class="mt-5 login-form__footer">
									계정이 없으신가요? 지금 <a href="page-register.html"
										class="text-primary">회원가입</a> 하세요
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>