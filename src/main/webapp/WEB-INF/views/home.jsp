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

<style type="text/css">
.video-container {
	position:relative;
	padding-bottom:56.25%;
	height:0;
	overflow:hidden;
}

.video-container iframe, video-container object, video-container embed {
	position:absolute;
	top:0;
	left:0;
	width:100%;
	height:100%;
}

.content {
	position:absolute;
	top: 50%;
	height: 240px;
	/* background-color: #fff;
	opacity:0.75; */
}

.content p {
	color: #fff;
	text-shadow: 4px 2px 2px gray;
	/* text-shadow: 6px 2px 2px gray; */
}
</style>

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
							<c:if test="${!empty search}">
								<script>
									alert("${search}");
								</script>
							</c:if>
							
							 <div class="video-container" style="margin-bottom:50px">
							 	<iframe class="video" frameborder="0" src="https://youtube.com/embed/mXo0fG2hWAM?autoplay=1&mute=1&loop=1&controls=0&showinfo=0&rel=0&autohide=1&playlist=mXo0fG2hWAM" allow="autoplay; encrypted-media" allowfullscreen style="pointer-events: none; width: 100%; height: 100%;  opacity: 0.7;"></iframe>
							 	
							 	<div class="content text-center w-100 p-3" style="/* background-color:#fff; opacity:0.75;*/ display:table-cell; vertical-align:middle">
							 		<p class="h1" style="margin-bottom:30px;">나만의 Stock-Learning 플랫폼</p>
							 		<p class="h3">당신의 호기심과 가능성이 실현되는 곳</p>
							 		<p class="h3">부자가 되는 시작, MStock</p>
								</div>
								
							 </div>
							 
							 <!--
							<div class="jumbotron" style="background-image: url(/mstock/resources/images/main3.jpg); background-repeat: no-repeat; background-size:100%;">
								<div class="w-50 p-3" style="background-color: #fff; opacity: 0.5; margin-bottom: 100px;">
									<h1 class="display-4">MStock</h1>
									<p class="lead">모의 주식 서비스 & 실시간 데이터 분석</p>
								</div>
							</div>
							--> 
							
							
							<!-- 기업 정보 출력// 한줄에 4개 내용 출력  -->
							<div style="margin-bottom:20px;">
								<h3>종목 리스트</h3>
							</div>
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
	
	<!-- Video -->
	<!-- Scripts -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="/mstock/resources/js/yt-video-background.min.js" charset="utf-8"></script>
	<script type="text/javascript">
		$('.video-background').youtubeBackground({
			videoId: 'mXo0fG2hWAM',
			backgroundColor: '#212121',
			backgroundImage: 'https://i.ytimg.com/vi/ITpIv6Efz8Y/maxresdefault.jpg', // For mobile devices
			opacity: 0.6
		});
	</script>
	
	<!-- 2019/10/17에 처리할 것 -->
	<!-- 
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
		$(function(){
			$.ajax({
				url: "/mstock/partial/price",
				type: "POST",
				data: ${user.u_id},
				contentType: "application/json; charset=utf-8;",
				dataType: "json",
				success: function(data){
					$("#total-price").text(data.price);
				},
				error:function(request,status,error){
					alert(error);
				}
			});
		});
	</script>
	 -->
	
</body>
</html>
