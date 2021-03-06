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

<!-- Table Style -->
<link rel="stylesheet" type="text/css" href="resources/css/table.css" />

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
					<div class="row">

						<div class="jumbotron container text-center">
							<h1 class="display-4">Ranking</h1>
							<!-- <i class="fas fa-crown"></i> -->
							<p class="lead">모든 유저의 랭킹 정보를 확인할 수 있습니다</p>
							<hr class="my-4">
						</div>
						
						<div class="container text-center">
						
							<div class="w-100 p-3 h-75 d-inline-block" style="margin-bottom:20px">
								<table class="table table-bordered text-center">
										<tr>
											<th scope="col">순위</th>
											<th scope="col">닉네임</th>
											<th scope="col">자산</th>
											<th scope="col">등급</th>
										</tr>
									<tbody>
										<c:forEach var="list" items="${rankList}">
											<tr>
												<td>${list.rank_id}</td>
												<td>${list.nickname}</td>
												<td>${list.property}</td>
												<td>${list.grade}</td>
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
			location.href = "/mstock/rank?page=" + page;
		}
	
		$(function() {

			//세 자리마다 Comma 찍는 func
			function numberWithCommas(x) {
				return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			}
			
			$("tr > td:nth-child(3)").each(function(){
				var text = $(this).text();
				$(this).text(numberWithCommas(text)+"원");
			});
		});
	</script>
</body>
</html>
