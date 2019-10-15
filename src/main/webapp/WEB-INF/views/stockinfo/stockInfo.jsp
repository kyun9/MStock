<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="vo.StockInfoVO, vo.CompanyVO, vo.UserVO, vo.AccountVO, java.util.HashMap"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- <script type="text/javascript" src="resources/js/common.js"></script> -->
<link rel="stylesheet" type="text/css"
	href="resources/css/stockinfo.css" />
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


<!-- bootstrap -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<!-- chatting.js -->
<script src="/mstock/resources/js/chatting.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.3.0/Chart.bundle.min.js"></script>
<script src="http://asp1.krx.co.kr/inc/js/asp_chart.js"></script>

<style type="text/css">
	.fixed-footer {
		position:fixed; 
		left:0px; 
		bottom:0px; 
		height:60px; 
		width:100%; 
		background:#fff;
		z-index:3;
	}
</style>

</head>
<body class="header-fixed">
	<%
		StockInfoVO stock = (StockInfoVO) request.getAttribute("info");
		CompanyVO company=(CompanyVO)request.getAttribute("comInfo");
		UserVO user = (UserVO)request.getAttribute("user");
	%>

	<!-- partial:partials/header.jsp -->
	<%@ include file="../partials/header.jsp"%>
	<!-- partial -->
	<div class="page-body">
		<!-- partial:partials/sidebar.jsp -->
		<%@ include file="../partials/sidebar.jsp"%>
		<!-- partial -->
		<div class="page-content-wrapper">
			<div class="page-content-wrapper-inner">
				<div class="content-viewport">
					<div class="row">

						<div class="col-12">

							<div class="jumbotron"
								style="background-image: url(/mstock/resources/images/main3.jpg); background-repeat: no-repeat; background-size: 100%;">
								<div class="w-50 p-3"
									style="background-color: #fff; opacity: 0.7; margin-bottom: 50px;">
									<h1 class="display-4" style="margin-bottom:20px;"><%=company.getName()%> (<%= stock.getJongCd()%>)</h1>
									<p class="h5"><span><span class="time_img"></span>
										  	<span id="time0"></span>기준 (<%=stock.getJanggubun()%>)</span></p>
								</div>
							</div>
							
							


							<div class="text-center">
								<div class="row">
									<!-- chart.js 주식차트 / 차트부분 파일 분리(./partials/stockchart.jsp)-->
									<div class="w-100 p-3"
										style="border: 1px solid #ccc; float: none; margin: 0 auto">
										<canvas id="myChart"></canvas>
										<%@ include file="../partials/stockchart.jsp"%>
										<span>※30초간격 실시간 자동갱신※</span>
										<button id="reloadInfo">새로고침</button>
									</div>
								</div>
								
								<hr>

									<div class="card">
										
										<div class="card-body">
												<table class="table">
													<tr>
														<th>현재가</th>
														<td id="1"></td>
														<th colspan="2">전일대비</th>
														<td>
										    				<span class="up" id="2"></span> 
													        <span class="bohab" id="3"></span> 
												        	<span class="down" id="4"></span>
									    				</td>
													</tr>
													<tr>
														<th>시가</th>
														<td id="7"></td>
														<th colspan="2">상한가</th>
														<td id="8"></td>
													</tr>
													<tr>
														<th>고가</th>
														<td id="9"></td>
														<th colspan="2">하한가</th>
														<td id="10"></td>
													</tr>
													<tr>
														<th>저가</th>
														<td id="11"></td>
														<th colspan="2">액면가</th>
														<td id="12"></td>
													</tr>
													<tr>
														<th>거래량</th>
														<td id="5"></td>
														<th colspan="2">거래대금</th>
														<td id="6"></td>
													</tr>
												</table>
										
											</div>
										</div>
							
								<hr>
								
								<!-- 회귀분석 -->
								<div>
									<span id="regressionTime" style="font-weight: bold;"></span><br>
									<span id="regressionVal"></span><br>
									 <span id="regressionPer"></span>
								</div>
								
								<hr>


								
								
								<div class="card">
									<div class="card-body">
									<table class="table">
										<tr>
											<th>일자</th>
											<th>종가</th>
											<th>전일대비</th>
											<th>시가</th>
											<th>고가</th>
											<th>저가</th>
											<th>거래량</th>
											<th>거래대금</th>
										</tr>
										<%
											if (stock.getDailystock_length() > 0) {
										%>
										<%
											for (int j = 0; j < stock.getDailystock_length(); j++) {
										%>
										<tr>
											<td><%=stock.getDailystock()[j][0]%></td>
											<td><%=stock.getDailystock()[j][1]%></td>
											<td>
												<%
													if (stock.getDailystock()[j][8].equals("1") || stock.getDailystock()[j][8].equals("2")) {
												%> <span class="up"> ▲ <%
 	}
 %>
											</span> <%
 	if (stock.getDailystock()[j][8].equals("3")) {
 %> <span class="bohab"> ─ <%
 	}
 %>
											</span> <%
 	if (stock.getDailystock()[j][8].equals("4") || stock.getDailystock()[j][8].equals("5")) {
 %> <span class="down"> ▼ <%
 	}
 %>
											</span> <%=stock.getDailystock()[j][2]%></td>
											<td><%=stock.getDailystock()[j][3]%></td>
											<td><%=stock.getDailystock()[j][4]%></td>
											<td><%=stock.getDailystock()[j][5]%></td>
											<td><%=stock.getDailystock()[j][6]%></td>
											<td><%=stock.getDailystock()[j][7]%></td>
										</tr>
										<%
											}
										%>
										<%
											} else {
										%>
										<tr>
											<td colspan="8">데이터가 없습니다.</td>
										</tr>
										<%
											}
										%>
									</table>
									</div>
								</div>
								
								
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<hr>

			<!-- 데이터 랩 -->
			
			
				<div class="row text-center" style="margin-left:auto; margin-right:auto;">
					<!-- 워드클라우드 -->
					
					<div class="col-12 col-md-7">
						<div class="card">
							<div class="card-header">
								<p class="h6">실시간 뉴스 기반 워드클라우드</p>
							</div>
							<div class="card-body">
								<img src="/mstock/resources/rdata/<%=company.getWcimg()%>" width="100%">
							</div>
						</div>
					</div>
	
					<!-- 감정분석 -->
					<div class="col-12 col-md-5">
					<div class="card">
						<div class="card-header">
							<p class="h6">실시간 뉴스 기반 감정 분석</p>
						</div>
						<div class="card-body">
						<canvas id="north-america-chart"></canvas>
						<div id="north-america-legend"></div>
						</div>
						
					</div>
					</div>
					
				</div>
			
			<hr>

			<!-- Article List -->
			<div class="card">
			<div class="card-header text-center">
				<!-- <p class="h6">실시간 증시 뉴스</p> -->
			</div>
			<div class="card-body">
				<table id="article" style="border: 1px solid #ccc; width: 100%">
				<thead>
					<tr class="text-right">
						<th>제목</th>
						<th>언론사</th>
						<th>시간</th>
					</tr>
				</thead>
				<tbody id="appendArticle">
				</tbody>
			</table>
			
			<%@ include file="../partials/newsArticle.jsp"%>

			<div class="modal fade" id="newsInfo" tabindex="-1" role="dialog"
				aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered" role="document">
					<div class="modal-content">
						<!-- Form  -->
						<div class="modal-header">
							<h5 class="modal-title" id="NewsTitle"></h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body" id="NewsContent"></div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary"
								data-dismiss="modal">Close</button>
						</div>
						<!--Close  Form  -->
					</div>
				</div>
			</div>
			
			</div>
			</div>
			
			<!-- end Article LIst -->
			
			<hr>

			<!-- chat -->
			<div class="card">
				<div class="card-header">
				</div>
				
				<div class="card-body" style="border: 1px solid #ccc; width:100%">
				<div class="panel panel-info">
					<div class="panel-heading">
					<p class="h5" style="margin-top:20px; margin-left:20px;"><%=company.getName()%> 채팅방</p>
					</div>
					<div class="panel-body">
						<ul class="media-list">

							<li class="media">

								<div class="media-body">

									<div class="media">
										<div class="media-body " id="message"
											style="overflow: auto; width: 500px; height: 200px;"></div>
									</div>

								</div>
							</li>

						</ul>
					</div>
					<div class="panel-footer">
						<div class="input-group">
							<input type="text" class="form-control"
								placeholder="Enter Message" id="messageinput" /> <span
								class="input-group-btn">
								<button class="btn btn-info" type="button" onclick="send();">SEND</button>
							</span>
						</div>
					</div>
				</div>
				
				</div>
				
			</div>
			<!-- chat end -->
			
			<!-- fixed footer -->
			<div class="fixed-footer">
				<div class="text-center">
					<!-- 매수하기 기능 -->
					<!-- Button trigger modal -->
					<button type="button" class="btn btn-danger btn-lg btn-block"
						data-toggle="modal" data-target="#exampleModalCenter"><%=company.getName()%> 매수하기</button>
				</div>
			</div>

			<!-- Modal -->
			
			<% AccountVO account = (AccountVO) request.getAttribute("accountInfo"); %>
			<div class="modal fade" id="exampleModalCenter" tabindex="-1"
				role="dialog" aria-labelledby="exampleModalCenterTitle"
				aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered" role="document">
					<div class="modal-content">
						<!-- Form  -->
						<form method="post" action="/mstock/stockinfo">
							<input type="hidden" name="company_id"
								value=<%= stock.getJongCd() %>> <input
								type="hidden" name="price" id="price"> <input
								type="hidden" name="account_id"
								value=<%=account.getAccount_id() %>>
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalCenterTitle">종목
									매수하기</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								종목 코드 :
								<%= stock.getJongCd() %><br> 종목명 :
								<%=company.getName()%><br> 구매 개수 : <input id="a"
									type="number" name="quantity" value=1 min=1><br>
								현재 가격 : <span id="b" style="font-weight: bold"></span><br>
								나의 보유 자산 : <span id="c"><%=account.getCredit()  %></span><span>Credit</span>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-dismiss="modal">Close</button>
								<button type="submit" onclick="return check();"
									class="btn btn-primary">매수하기</button>
							</div>
						</form>
						<!--Close  Form  -->
					</div>
				</div>
			</div>
			
			<script>
				function check(){
					 var my =  $("#c").text();
					 var count = $("#a").val();
			          var result = count * val;
					 if(my<result){
						 alert("크레딧이 부족합니다.");
						 return false;
					 }
					 else{
						 alert("구매하였습니다.");
					 }
				}
		
					var val =  "<%=stock.getStockinfo()[1]%>";
			val = val.replace(',', '');
			$("#b").text(val);
			$("#price").val(val);
			$("#a").bind('keyup mouseup', function() {
				var current = $("#c").text();
				var count = $("#a").val();
				var result = count * val;
				if (result > current) {
					$("#b").text("보유 크레딧을 초과하였습니다.");
					$("#b").css("color", "red");
				} else {
					$("#b").css("color", "black");
					$("#price").val(result);
					$("#b").text(result);
				}

			});
		</script>
		
		
			<!-- 매수기능 끝  -->
			
			
			<!-- content viewport ends -->
			<!-- partial:partials/footer.jsp -->
			<%@ include file="../partials/footer.jsp"%>
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
	<script src="/mstock/resources/js/charts/chartjs.addon.js"></script>
	<!-- Vendor Js For This Page Ends-->
	<!-- build:js -->
	<script src="/mstock/resources/js/template.js"></script>
	<!-- endbuild -->

	<!-- 차트 그리기 -->
	<script>
		var drawChart = function(pos, neg) {
			if ($("#north-america-chart").length) {
				var areaData = {
					labels : [ "pos", "neg" ],
					datasets : [ {
						data : [ pos, neg ],
						backgroundColor : [ "#66a3ff", "#ff6666" ],
						borderColor : "rgba(0,0,0,0)"
					} ]
				};

				var areaOptions = {
					responsive : true,
					maintainAspectRatio : true,
					segmentShowStroke : false,
					cutoutPercentage : 20,
					elements : {
						arc : {
							borderWidth : 4
						}
					},
					legend : {
						display : false
					},
					tooltips : {
						enabled : true
					},
					legendCallback : function(chart) {
						var text = [];
						text.push('<div class="report-chart">');
						text
								.push('<div class="d-flex justify-content-between mx-4 mx-xl-5 mt-3"><div class="d-flex align-items-center"><div class="mr-3" style="width:20px; height:20px; border-radius: 50%; background-color: '
										+ chart.data.datasets[0].backgroundColor[0]
										+ '"></div><p class="mb-0">긍정</p></div>');
						text.push('<p class="mb-0" id="chart_credit">'+pos+'%</p>');
						text.push('</div>');
						text
								.push('<div class="d-flex justify-content-between mx-4 mx-xl-5 mt-3"><div class="d-flex align-items-center"><div class="mr-3" style="width:20px; height:20px; border-radius: 50%; background-color: '
										+ chart.data.datasets[0].backgroundColor[1]
										+ '"></div><p class="mb-0">부정</p></div>');
						text
								.push('<p class="mb-0" id="chart_stock_value">'+neg+'%</p>');
						text.push('</div>');
						text.push('</div>');
						return text.join("");
					},
				}

				var northAmericaChartCanvas = $("#north-america-chart").get(0)
						.getContext("2d");
				var northAmericaChart = new Chart(northAmericaChartCanvas, {
					type : 'pie',
					data : areaData,
					options : areaOptions,

				});
				document.getElementById('north-america-legend').innerHTML = northAmericaChart
						.generateLegend();
			}
		}

		var code = '<%=company.getName()%>';
		var jsonLocation = '/mstock/resources/rdata/emotion' + code + '.json';
		//alert(code);
		//alert(jsonLocation);
		$.getJSON(jsonLocation, function(data) {
			$.each(data, function(n, arr) {
				$.each(arr, function(m, company) {
					if (code == company.code) {
						drawChart(company.pos, company.neg);
						$("#regressionTime").text(
								company.time + " 기준")
						$("#regressionVal").text("10분 뒤의 현재가 예측 결과 :  " + company.predictValue)
						$("#regressionPer").text(
								"예측 정확도 " + company.predictPercent + "%")
					}
				});
			});
		});
	</script>

</body>
</html>