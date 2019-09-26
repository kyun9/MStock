<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="vo.CompanyVO, java.util.ArrayList"%>
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
					<div class="row">  
						<div class="col-12">
							<div class="jumbotron" style="background-image: url(/mstock/resources/images/main3.jpg); background-repeat: no-repeat; background-size:100%;">
								<h1 class="display-4">청소년을 위한 모의주식 MStock!!</h1>
								<p class="lead">MStock는 ------- 장려하는 서비스입니다.</p>
								<hr class="my-4">
								<p> 여러분의 주식 역량을 넓혀 나가세요.</p><br>
								<a class="btn btn-primary btn-lg" href="/mstock/login" role="button">로그인 바로가기</a>
							</div>
							<!-- 기업 정보 출력// 한줄에 4개 내용 출력  -->  
							<% ArrayList<CompanyVO> list = (ArrayList<CompanyVO>) request.getAttribute("companyInfo");
								if(!list.isEmpty()){
									int t =0;
									int size = list.size()/4;
									System.out.println(size);
									while(t< size){ 
							%>
							<div class="card-deck">
								<% int val=4*t;
								for(int i=val;i<val+4;i++){ %>
								<div class="card text-center" style="width: 18rem;">
									<div class="card-body">
										<h5 class="card-title"><%=list.get(i).getName() %></h5>
										<p class="card-text">종목 코드<%=list.get(i).getCompany_id() %></p>
										<p class="card-text">현재 주가<%=list.get(i).getCurJuka() %></p>
										<a href="/mstock/stockinfo?code=<%=list.get(i).getCompany_id() %>" class="btn btn-primary">종목 상세보기</a>
									</div>
								</div>
								<%} %>
							</div>
							<%
							t++;
							}} 
							%>
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
</body>
</html>
