<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="vo.StockInfoVO"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://asp1.krx.co.kr/inc/js/asp_chart.js"></script>
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
</head>
<body class="header-fixed">
	<%
		StockInfoVO stock = (StockInfoVO) request.getAttribute("info");
	%>
	<!-- partial:partials/header.jsp -->
	<%@ include file="./partials/header.jsp"%>
	<!-- partial -->
	<div class="page-body">
		<!-- partial:partials/sidebar.jsp -->
		<%@ include file="./partials/sidebar.jsp"%>
		<!-- partial -->
		<div class="page-content-wrapper">
			<div class="page-content-wrapper-inner">
				<div class="content-viewport">
					<div class="row">
						<div class="header-wrap">
							실시간 시세<span><span class="time_img"></span><%=stock.getGettime()%>
								기준(<%=stock.getJanggubun()%>)</span>
						</div>
						<div class="body-wrap">
							<!-- <div id="gpDisp"></div> -->
							<div class="data-lists">
								<dl>
									<dt>
										<span></span>주가정보
									</dt>
									<dd>
										<div class="main_stock_box1">
											<ul>
												<li>
													<div class="main_stock_box1_title">
														<%
															if (!stock.getStockinfo()[0].equals("")) {
														%>
														<ul>
															<li class="main_stock_box1_title1">A<%=stock.getJongCd()%><span><%=stock.getStockinfo()[0]%></span></li>
															<li class="main_stock_box1_title2"><span
																class="CurJuka">현재가</span><%=stock.getStockinfo()[1]%></li>
														</ul>
														<ul>
															<li class="main_stock_box1_contn"><span
																class="title">전일대비</span> <span> <%
 	if (stock.getStockinfo()[2].equals("1") || stock.getStockinfo()[2].equals("2")) {
 %> <span class="up"> ▲ </span> <%
 	}
 %> <%
 	if (stock.getStockinfo()[2].equals("3")) {
 %> <span class="bohab"> ─ </span> <%
 	}
 %> <%
 	if (stock.getStockinfo()[2].equals("4") || stock.getStockinfo()[2].equals("5")) {
 %> <span class="down"> ▼ </span> <%
 	}
 %> <%=stock.getStockinfo()[3]%>(<%=stock.getDungRakrate_str()%>%)
															</span></li>
															<li class="main_stock_box1_contn"><span
																class="title">거래량</span> <span><%=stock.getStockinfo()[5]%></span>
															</li>
															<li class="main_stock_box1_contn"><span
																class="title">거래대금</span> <span><%=stock.getStockinfo()[6]%></span>
															</li>
														</ul>
														<%
															}
														%>
													</div>
												</li>
											</ul>
										</div>
										<div class="main_stock_box2">
											<table id="stockInfo">
												<tr>
													<th>시가</th>
													<td><%=stock.getStockinfo()[7]%></td>
													<th colspan="2">상한가</th>
													<td><%=stock.getStockinfo()[12]%></td>
												</tr>
												<tr>
													<th>고가</th>
													<td><%=stock.getStockinfo()[8]%></td>
													<th colspan="2">하한가</th>
													<td><%=stock.getStockinfo()[13]%></td>
												</tr>
												<tr>
													<th>저가</th>
													<td><%=stock.getStockinfo()[9]%></td>
													<th colspan="2">액면가</th>
													<td><%=stock.getStockinfo()[16]%></td>
												</tr>
											</table>
										</div>
									</dd>
								</dl>
							</div>

							<div class="tab_content">
								<table id="tradedPrice_day">
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