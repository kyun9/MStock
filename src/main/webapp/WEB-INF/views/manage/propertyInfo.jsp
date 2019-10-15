<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

</head>
<body class="header-fixed">

	<!-- partial:partials/header.jsp -->
	<%@ include file="../partials/header.jsp"%>
	<!-- partial -->
	<div class="page-body">
		<!-- partial:partials/sidebar.jsp -->
		<%@ include file="../partials/sidebar.jsp"%>
		<!-- partial -->
		<!-- content viewport start -->
		<div class="page-content-wrapper">
			<div class="page-content-wrapper-inner">
				<div class="content-viewport">
					<div class="row">
						<!-- 내용 -->
						<c:choose>
							<c:when test="${account eq 'fail'}">
								<div class="jumbotron container text-center">
									<h1 class="display-4">Property Management</h1>
									<p class="lead">${user.nickname}님의 자산 관리 페이지입니다</p>
									<hr class="my-4">
									<p class="lead">계좌가 아직 없습니다</p>
									<p class="lead">계좌를 생성하고 모의 주식을 즐겨보세요</p>
									<p class="lead">계좌 생성시 1,000만 크레딧이 즉시 지급됩니다</p>
									<br>
									<a class="btn btn-primary btn-lg" href="/mstock/account/insert"
										role="button">계좌 생성</a>
								</div>
							</c:when>
							<c:otherwise>
								<div class="jumbotron container text-center">
									<h1 class="display-4">Property Management</h1>
									<p class="lead">${user.nickname}님의 자산 관리 페이지입니다</p>
									<hr class="my-4">

									<div class="row">
										<div class="card container">
										
											<hr class="my-4">
											<div class="row align-items-center">
											
												<div class="col-6 col-md-4">
													
													<table class="table table-bordered">
														<tbody>
															<tr>
																<th>총 자산</th>
																<td id="total_property"></td>
															</tr>
															<tr>
																<th>매입 금액</th>
																<td id="price_value"></td>
															</tr>
															<tr>
																<th>평가 금액</th>
																<td id="stock_value"></td>
															</tr>
															<tr>
																<th>평가 손익</th>
																<td id="profit_rate"></td>
															</tr>
														</tbody>
													</table>
												</div>

												<div class="col-6 col-md-4">
													<canvas id="north-america-chart"></canvas>
													<div id="north-america-legend"></div>
												</div>

												<div class="col-6 col-md-4">			
													
													<div style="margin-bottom:20px">
														<p class="h6">등급  [${propertyVO.grade}]</p>
													</div>
																						
													<div>
														<c:choose>
															<c:when test="${propertyVO.grade eq '브론즈'}">
																<img src="/mstock/resources/images/grade/grade-bronze.svg" width="150">
															</c:when>
															<c:when test="${propertyVO.grade eq '실버'}">
																<img src="/mstock/resources/images/grade/grade-silver.svg" width="150">
															</c:when>
															<c:when test="${propertyVO.grade eq '골드'}">
																<img src="/mstock/resources/images/grade/grade-gold.svg" width="150">
															</c:when>
															<c:when test="${propertyVO.grade eq '플래티넘'}">
																<img src="/mstock/resources/images/grade/grade-platinum.svg" width="150">
															</c:when>
															<c:when test="${propertyVO.grade eq '다이아'}">
																<img src="/mstock/resources/images/grade/grade-diamond.svg" width="150">
															</c:when>
															<c:when test="${propertyVO.grade eq '마스터'}">
																<img src="/mstock/resources/images/grade/grade-master.svg" width="150">
															</c:when>
															<c:when test="${propertyVO.grade eq '킹'}">
																<img src="/mstock/resources/images/grade/grade-king.svg" width="150">
															</c:when>
														</c:choose>
													</div>

												</div>

											</div>
											<hr class="my-4">


										</div>
									</div>
								</div>

								<hr class="my-4">
								<div class="row container text-center">
									<div class="col-md-12 grid-margin stretch-card">
										<div class="card">
										
											<c:choose>
												<c:when test="${fn:length(myStockList) > 0}">
													<div class="card-body">
														<!-- <p class="card-title mb-0">Top Products</p> -->
														<div class="table-responsive text-center">
															<table class="table table-hover">
																<thead>
																	<tr>
																		<th>종목코드</th>
																		<th>종목명</th>
																		<th>현재가</th>
																		<th>전일대비</th>
																		<th>등락률</th>
																		<th>구매가</th>
																		<th>수량</th>
																		<th>손익</th>
																		<th>수익률</th>
																		<th>매도</th>
																	</tr>
																</thead>
																<tbody id="myStockInfo">
																	<c:forEach var="list" items="${myStockList}">
																		<tr>
																			<td>${list.company_id}</td>
																			<td>${list.name}</td>
																			<td>${list.curjuka}</td>
																			<td>${list.debi}</td>
																			<td>${list.dongrak}</td>
																			<td>${list.price}</td>
																			<td>${list.quantity}</td>
																			<td>${list.profit}</td>
																			<td>${list.profit_rate}</td>
																			<td><button type="button"
																					class="btn btn-danger btn-sm" data-toggle="modal"
																					data-target="#modal">매도</button></td>
																		</tr>
																	</c:forEach>
																</tbody>
															</table>
		
														</div>
													</div>
												</c:when>
											</c:choose>
											
										</div>
									</div>
									

								</div>

								<hr class="my-4">



								<!-- Modal -->
								<div class="modal fade" id="modal" tabindex="-1" role="dialog"
									aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
									<div class="modal-dialog modal-dialog-centered" role="document">

										<form action="/mstock/property/sell" method="POST">
											<div class="modal-content">
												<div class="modal-header">
													<h4 class="modal-title" id="exampleModalCenterTitle">매도</h4>
													<button type="button" class="close" data-dismiss="modal"
														aria-label="Close">
														<span aria-hidden="true">&times;</span>
													</button>
												</div>
												<div class="modal-body">
													<table
														class="table table-hover text-center shadow p-3 mb-5 bg-white rounded">
														<thead>
															<tr>
																<th>선택</th>
																<th>종목코드</th>
																<th>종목명</th>
																<th>구매가</th>
																<th>수량</th>
																<th>구매날짜</th>
															</tr>
														</thead>
														<tbody id="modal-tbody">
														</tbody>
													</table>

													<div class="form-group">
														<label for="inputCurJuka">현재 가격</label> <input
															class="form-control" id="inputCurJuka" readonly>
													</div>

													<div class="form-group">
														<label for="inputQuantity">매도 수량</label> <input
															type="number" class="form-control" id="inputQuantity"
															name="quantity" placeholder="매도할 수량을 입력하세요" min="0"
															required>
													</div>

													<div class="form-group">
														<label for="inputTotalValue">총 판매 가격</label> <input
															class="form-control" id="inputTotalValue"
															placeholder="총 판매 가격" readonly>
													</div>

													<div class="form-group">
														<label for="inputProfitRate">수익률</label> <input
															class="form-control" id="inputProfitRate"
															placeholder="수익률" readonly>
													</div>


													<input type="hidden" id="list_id" name="list_id" value="0"></input>
													<input type="hidden" id="account_id" name="account_id" value="0"></input> 
													<input type="hidden" id="company_id" name="company_id" value="0"></input>
													<input type="hidden" id="price" name="price" value="0"></input>

												</div>
												<div class="modal-footer">
													<button type="button" class="btn btn-secondary"
														data-dismiss="modal">취소</button>
													<button type="submit" class="btn btn-danger">매도</button>
												</div>
											</div>
										</form>
									</div>
								</div>



							</c:otherwise>
						</c:choose>

					</div>
				</div>
			</div>
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
	<script src="/mstock/resources/vendors/chartjs/Chart.min.js"></script>
	<script src="/mstock/resources/js/charts/chartjs.addon.js"></script>
	<!-- Vendor Js For This Page Ends-->
	<!-- build:js -->
	<script src="/mstock/resources/js/template.js"></script>
	<script src="/mstock/resources/js/dashboard.js"></script>
	<!-- endbuild -->

	<script>
		if ($("#north-america-chart").length)
{
	      var areaData = {
	        labels: ["Credit", "Stock"],
	        datasets: [{
	            data: [${propertyVO.credit}, ${propertyVO.stock_value}],
	            backgroundColor: ["#cccccc", "#575dfa"],
	            borderColor: "rgba(0,0,0,0)"
	          }]
	      };
	      
	      var areaOptions = {
	        responsive: true,
	        maintainAspectRatio: true,
	        segmentShowStroke: false,
	        cutoutPercentage: 20,
	        elements: {
	          arc: {
	              borderWidth: 4
	          }
	        },      
	        legend: {
	          display: false
	        },
	        tooltips: {
	          enabled: true
	        },
	        legendCallback: function(chart) { 
	          var text = [];
	          text.push('<div class="report-chart">');
	            text.push('<div class="d-flex justify-content-between mx-4 mx-xl-5 mt-3"><div class="d-flex align-items-center"><div class="mr-3" style="width:20px; height:20px; border-radius: 50%; background-color: ' + chart.data.datasets[0].backgroundColor[0] + '"></div><p class="mb-0">크레딧</p></div>');
	            text.push('<p class="mb-0" id="chart_credit">${propertyVO.credit}</p>');
	            text.push('</div>');
	            text.push('<div class="d-flex justify-content-between mx-4 mx-xl-5 mt-3"><div class="d-flex align-items-center"><div class="mr-3" style="width:20px; height:20px; border-radius: 50%; background-color: ' + chart.data.datasets[0].backgroundColor[1] + '"></div><p class="mb-0">주식</p></div>');
	            text.push('<p class="mb-0" id="chart_stock_value">${propertyVO.stock_value}</p>');
	            text.push('</div>');
	          text.push('</div>');
	          return text.join("");
	        },
	      }
	      
	      var northAmericaChartCanvas = $("#north-america-chart").get(0).getContext("2d");
	      var northAmericaChart = new Chart(northAmericaChartCanvas, {
	        type: 'pie',
	        data: areaData,
	        options: areaOptions,
	        
	      });
	      document.getElementById('north-america-legend').innerHTML = northAmericaChart.generateLegend();
	    }
	</script>

	<script>
		$(function() {
			
			//세 자리마다 Comma 찍는 func
			function numberWithCommas(x) {
			    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			}
			
			//Comma 제거 func
			function removeCommas(x) {
				return parseFloat(x.replace(/,/gi, ""));
			}
			
			//특수문자 제거 func
			function removeSpecial(x) {
				return x.toString().replace(/[▲▼]/gi, "");
			}
			
			//부호 제거 func
			function removeSign(x) {
				return x.toString().replace(/-/gi, "");
			}
			
			//
			
			//보유 주식 테이블에 대한 func
			function updateTable(){
				$("tr > td:nth-child(3)").each(function(i){
					var curjuka = $(this).text();
					$(this).text(numberWithCommas(curjuka));
				});
				
				$("tr > td:nth-child(4)").each(function(i){
					var debi = $(this).text();
					$(this).text(removeSign(debi));
					debi = removeSpecial(debi);
					debi = removeCommas(debi);
					//alert(debi);
					$(this).addClass(debi >= 0 ? "text-primary" : "text-danger");
				});
				
				$("tr > td:nth-child(5)").each(function(i){
					var dongrak = $(this).text();
					$(this).text(dongrak + "%");
					$(this).addClass(dongrak >= 0 ? "text-primary" : "text-danger");
				});
				
				$("tr > td:nth-child(6)").each(function(i){
					var price = $(this).text();
					$(this).text(numberWithCommas(price));
				});
				
				$("tr > td:nth-child(8)").each(function(i){
					var profit = $(this).text();
					$(this).text(numberWithCommas(profit)).addClass(profit >= 0 ? "text-primary" : "text-danger");
				});
				
				$("tr > td:nth-child(9)").each(function(i){
					var price_rate = $(this).text()*1;
					$(this).text(price_rate.toFixed(1)+"%").addClass(price_rate >= 0 ? "text-primary" : "text-danger");
				});
				
				$("tr > td:nth-child(10)").each(function(i){
					$(this).on("click", function(){
						var company_id = "";
						var company_name = "";
						var curJuka = "";
						var price ="";
						var account_id = ${accountVO.account_id}
						$("#myStockInfo > tr >td:nth-child(1)").each(function(idx){
							if(i==idx){
								company_id = $(this).text();
								$("#company_id").val(company_id);
							}
						});
						$("#myStockInfo > tr >td:nth-child(2)").each(function(idx){
							if(i==idx){
								company_name = $(this).text();
								//alert(company_name);
							}
						});
						$("#myStockInfo > tr >td:nth-child(3)").each(function(idx){
							if(i==idx)
								curJuka = $(this).text();
						});
						
						$.ajax({
							url: "/mstock/property/modal",
							type: "POST",
							data: {"company_id": company_id, "account_id": account_id},
							async: false,
							success: function(data){
								var html = "";
								for(var i in data.purchaseList){
									html += "<input type='hidden' value='"+data.purchaseList[i].list_id+"'></input>"
									html += "<tr>";
									html += "<td><input type='radio' name='select' value='"+i+"' required></input></td>";
									html += "<td>"+data.purchaseList[i].company_id+"</td>";
									html += "<td>"+company_name+"</td>";
									html += "<td>"+numberWithCommas(data.purchaseList[i].price/data.purchaseList[i].quantity)+"</td>";
									html += "<td>"+data.purchaseList[i].quantity+"</td>";
									html += "<td>"+data.purchaseList[i].datetime+"</td>";
									html += "</tr>";
								}
								
								$("#modal-tbody").html(html);
							},
							error: function(){
								alert("Error");
							}
						});
						
						$("#inputQuantity").val("");
						$("#inputQuantity").removeAttr("max");
						$("#inputCurJuka").val(curJuka);
						$("#inputTotalValue").val("");
						$("#inputProfitRate").val("");
						$("#list_id").val("");
						
						/* 매도 Modal에 대한 처리 */
						$("input:radio[name=select]").on("change", function(){
							$("#inputProfitRate").removeClass("text-primary");
							$("#inputProfitRate").removeClass("text-danger");
							
							/* 선택한 radio의 quantity, price 읽기 */
							var idx = Number($(this).val());
							var quantity = 0;
							$("#modal-tbody > tr > td:nth-child(5)").each(function(i){
								if(idx == i){
									quantity = $(this).text();
									$("#inputQuantity").val(quantity);
									$("#inputQuantity").attr("max", quantity);
								}
							});
							
							var price = 0;
							$("#modal-tbody > tr > td:nth-child(4)").each(function(i){
								if(idx == i){
									price = $(this).text();
									$("#price").val(removeCommas(price));
								}
							});
							
							/* list_id set */
							$("#modal-tbody > input:hidden").each(function(i){
								if(idx==i){
									$("#list_id").val($(this).val());
								}
							});
							
							/* account_id set */
							$("#account_id").val(${accountVO.account_id});
							
							/* price set */
							//$("#price").val(price*1);
							
							function updateInfo(){
								var totalValue = removeCommas(curJuka) * Number($("#inputQuantity").val());
								$("#inputTotalValue").val(numberWithCommas(totalValue));
								
								var profitRate = (removeCommas(curJuka) - removeCommas(price)) / removeCommas(price) * 100;
								$("#inputProfitRate").val(profitRate.toFixed(1) + "%").addClass(profitRate > 0 ? "text-primary" : "text-danger");
							}
							
							$("#inputQuantity").on("change", function(){
								quantity = $("#inputQuantity").attr("max");
								//alert("총 주식 양* : " + quantity);
								//alert("현 주식 양* : " + $(this).val());
								 if($(this).val()*1 > quantity*1){
									 //console.log("총 주식 양 : " + quantity);
									 //console.log("현 주식 양 : " + $(this).val());
									alert("보유한 주식보다 많을 수 없습니다");
									$(this).val(quantity);
								}
								updateInfo();
							});
							
							updateInfo();
						});
						
						
					});
				});
			}
			
			updateTable();
			
			/* 보유 자산 정보에 대한 처리 */
			$("#total_property").html(numberWithCommas(${propertyVO.credit + propertyVO.stock_value}));
			/* $("#profit_rate").html(${propertyVO.profit_rate}.toFixed(1)+"%"); */
			$("#chart_credit").html(numberWithCommas(${propertyVO.credit}));
			$("#chart_stock_value").html(numberWithCommas(${propertyVO.stock_value}));
			$("#stock_value").html(numberWithCommas(${propertyVO.stock_value}));
			$("#price_value").html(numberWithCommas(${propertyVO.price_value}));
			$("#profit_rate").html(${propertyVO.price_value} != 0 ? ((${propertyVO.stock_value}-${propertyVO.price_value}) / ${propertyVO.price_value} * 100).toFixed(1) +"%" : 0.0 + "%");
		});
		
	</script>

</body>
</html>
