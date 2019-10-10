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
								<div class="w-50 p-3" style="background-color: #fff; opacity: 0.5; margin-bottom: 100px;">
									<h1 class="display-4">MStock</h1>
									<p class="lead">모의 주식 서비스 & 실시간 데이터 분석</p>
								</div>
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
								<div class="card text-center shadow p-3 mb-5 bg-white rounded" style="width: 18rem;">
									<div class="card-body">
										<h2 class="card-title"><a href="/mstock/stockinfo?code=<%=list.get(i).getCompany_id() %>"><%=list.get(i).getName() %></a></h2>
										<p class="card-text">종목 코드 <%=list.get(i).getCompany_id() %></p>
										<p class="card-text">현재 주가 <%=list.get(i).getCurJuka() %></p>
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
