<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>MStock</title>
<!-- plugins:css -->
<link rel="stylesheet"
	href="/mstock/resources/vendors/iconfonts/mdi/css/materialdesignicons.css">
<!-- endinject -->
<!-- vendor css for this page -->
<!-- End vendor css for this page -->
<!-- inject:css -->
<link rel="stylesheet" href="/mstock/resources/css/shared/style.css">
<!-- endinject -->
<!-- Layout style -->
<link rel="stylesheet" href="/mstock/resources/css/demo_1/style.css">
<!-- Layout style -->
<link rel="shortcut icon" href="/mstock/resources/images/favicon.ico" />
</head>
<body class="header-fixed">
	<!-- partial:partials/header.jsp -->
	<%@ include file="./partials/header.jsp"%>
	<!-- partial -->
	<div class="page-body">
		<!-- partial:partials/sidebar.jsp -->
		<%@ include file="./partials/sidebar.jsp"%>
		<!-- partial -->
		<!-- content viewport start -->
		<div class="page-content-wrapper">
			<div class="page-content-wrapper-inner">
				<div class="content-viewport">
					<div class="row" style="height: 700px">
						<div class="jumbotron container h-75 d-inline-block  text-center">
							<h1 class="display-4">My Page</h1>
							<p class="lead">${user.nickname}님의개인정보를 수정할 수 있습니다</p>
							<hr class="my-4">

							<c:choose>
								<c:when test="${user.status eq 'naver'}">
									<div
										class="w-100 p-3 h-75 d-inline-block p-3 mb-2 bg-white rounded-lg text-center">
										<h2 class="align-middle">Naver 로그인은 정보 수정이 불가능 합니다</h2>
									</div>
								</c:when>
								<c:otherwise>

									<div class="text-center w-auto p-3">
										<form action="/mstock/mypage" method="post">

											<div class="form-group row">
												<label for="staticID" class="col-sm-2 col-form-label">아이디</label>
												<div class="col-sm-10">
													<input type="text" readonly class="form-control-plaintext"
														id="staticID" value="${user.id}">
												</div>
											</div>

											<div class="form-group row">
												<label for="staticNickname" class="col-sm-2 col-form-label">닉네임</label>
												<div class="col-sm-10">
													<input type="text" readonly class="form-control-plaintext"
														id="staticNickname" value="${user.nickname}">
												</div>
											</div>

											<div class="form-group row">
												<label for="staticEmail" class="col-sm-2 col-form-label">이메일</label>
												<div class="col-sm-10">
													<input type="text" readonly class="form-control-plaintext"
														id="staticEmail" value="${user.email}">
												</div>
											</div>

											<div class="form-group row">
												<label for="inputPassword" class="col-sm-2 col-form-label">비밀번호</label>
												<div class="col-sm-10">
													<input type="password" class="form-control"
														id="inputPassword" name="password" placeholder="Password">
												</div>
											</div>

											<div class="form-group row">
												<label for="inputPasswordRe" class="col-sm-2 col-form-label">비밀번호
													확인</label>
												<div class="col-sm-10">
													<input type="password" class="form-control"
														id="inputPasswordRe" placeholder="Password">
												</div>
											</div>

											<div class="form-label-group">
												<p id="checkpassword"></p>
											</div>

											<button type="submit" class="btn btn-secondary">수정하기</button>
											<button type="button" class="btn btn-secondary">취소하기</button>

										</form>
									</div>

								</c:otherwise>
							</c:choose>



						</div>
					</div>
				</div>
			</div>
			<!-- content viewport ends -->
			<!-- partial:partials/footer.jsp -->
			<%@ include file="./partials/footer.jsp"%>
			<!-- partial -->
		</div>
		<!-- page content ends -->
	</div>
	<!--page body ends -->
	<!-- SCRIPT LOADING START FORM HERE /////////////-->
	<!-- plugins:js -->
	<script src="/mstock/resources/vendors/js/core.js"></script>
	<!-- endinject -->
	<!-- Vendor Js For This Page Ends-->
	<script src="/mstock/resources/vendors/apexcharts/apexcharts.min.js"></script>
	<script src="/mstock/resources/vendors/chartjs/Chart.min.js"></script>
	<script src="/mstock/resources/js/charts/chartjs.addon.js"></script>
	<!-- Vendor Js For This Page Ends-->
	<!-- build:js -->
	<script src="/mstock/resources/js/template.js"></script>
	<script src="/mstock/resources/js/dashboard.js"></script>
	<!-- endbuild -->

	<!-- jQuery -->
	<script src="http://code.jquery.com/jquery-2.1.3.min.js"></script>
	<script>
		/* 비밀번호 확인 */
		/*
		$(function() {
			$('#inputPasswordRe').on(
					"blur",
					function() {
						if ($('#inputPasswordRe').val().length < 8
								|| $('#inputPassword').val() < 8) {
							$('#checkpassword').text("비밀번호를 8자 이상 입력해주세요").css(
									"color", "red");
						} else {
							if ($('#inputPasswordRe').val() != $(
									'#inputPassword').val()) {
								$('#checkpassword').text("비밀번호가 다릅니다").css(
										"color", "red");
							} else {
								$('#checkpassword').text("비밀번호가 같습니다").css(
										"color", "blue");
							}
						}
					});
		});
		*/
	</script>
</body>
</html>
