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
					<div class="row" style="height:1000px">
						<div class="jumbotron container h-75 d-inline-block">
							<h1 class="display-4">History</h1>
							<p class="lead">${user.nickname}님의 매도 및 매수 내역을 확인할 수 있습니다</p>
							<hr class="my-4">
							
							<!-- Table -->
							<div class="w-100 p-3 h-75 d-inline-block">
								<table class="table">
									<thead>
										<tr>
											<th scope="col">상태</th>
											<th scope="col">종목번호</th>
											<th scope="col">종목명</th>
											<th scope="col">가격</th>
											<th scope="col">수량</th>
											<th scope="col">날짜</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="list" items="${historyList}">
											<tr>
												<td>${list.status}</td>
												<td>${list.company_id}</td>
												<td>Name</td>
												<td>${list.price}</td>
												<td>${list.quantity}</td>
												<td>${list.datetime}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>

							<!-- Paging -->
							<hr class="my-4">
							<div>
								<ul class="pagination justify-content-center">
									<c:if test="${pagination.curPage ne 1}">
										<li class="page-item"><a class="page-link" href="#"
											aria-label="Previous"
											onClick="paging('${pagination.prevPage}')"> <span
												aria-hidden="true">&laquo;</span> <span class="sr-only">Previous</span>
										</a></li>
									</c:if>
									<c:forEach var="pageNum" begin="${pagination.startPage}"
										end="${pagination.endPage}">
										<c:choose>
											<c:when test="${pageNum eq pagination.curPage}">
												<li class="page-item" style="font-weight: bold;"><a
													class="page-link" href="#" onclick="paging('${pageNum}')">${pageNum}</a></li>
											</c:when>
											<c:otherwise>
												<li class="page-item"><a class="page-link" href="#"
													onclick="paging('${pageNum}')">${pageNum}</a></li>
											</c:otherwise>
										</c:choose>
									</c:forEach>
									<c:if test="${pagination.curPage ne pagination.pageCnt}">
										<li class="page-item"><a class="page-link" href="#"
											aria-label="Next" onClick="paging('${pagination.nextPage }')">
												<span aria-hidden="true">&raquo;</span> <span
												class="sr-only">Next</span>
										</a></li>
									</c:if>
								</ul>
							</div>

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

	<script>
		function paging(page) {
			location.href = "/mstock/history?page=" + page;
		}
		$(function() {

		});
	</script>

</body>
</html>
