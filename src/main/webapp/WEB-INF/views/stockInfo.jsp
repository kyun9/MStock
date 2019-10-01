<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="vo.StockInfoVO, vo.CompanyVO, vo.UserVO, vo.AccountVO"%>

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
<!-- chatting.js -->
<script src = "/mstock/resources/js/chatting.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.3.0/Chart.bundle.min.js"></script>
<script src="http://code.jquery.com/jquery-2.1.3.min.js"></script>
</head>
<body class="header-fixed">
	<%
		StockInfoVO stock = (StockInfoVO) request.getAttribute("info");
		CompanyVO company=(CompanyVO)request.getAttribute("comInfo");
		UserVO user = (UserVO)request.getAttribute("user");
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
							<!-- chart.js 주식차트 / 차트부분 파일 분리(./partials/stockchart.jsp)-->
							<div>
								<canvas id="myChart" style="border: 1px solid #000000;"></canvas>
								<%@ include file="./partials/stockchart.jsp"%>
								<button id="reloadChart">새로고침</button>
							</div>
							
							<div class="data-lists" id="stockTable">
								<dl>
									<dt>
										<span></span>주가정보
									</dt>
									<dd>
										<div class="main_stock_box1">
											<ul>
												<li>
													<div class="main_stock_box1_title">
														<ul>
															<li class="main_stock_box1_title1"></li>
															<li class="main_stock_box1_title2"><span
																class="CurJuka">현재가</span><span id="1"></span></li>
														</ul>
														<ul>
															<li class="main_stock_box1_contn"><span
																class="title">전일대비</span> <span> 
																 <span class="up" id="2"> </span> 
																  <span class="bohab" id="3">  </span>
																  <span class="down" id="4"> </span>
															</span></li>
															<li class="main_stock_box1_contn"><span
																class="title">거래량</span> <span id="5"></span>
															</li>
															<li class="main_stock_box1_contn"><span
																class="title">거래대금</span> <span id="6"></span>
															</li>
														</ul>
													</div>
												</li>
											</ul>
										</div>
										<div class="main_stock_box2">
											<table id="stockInfo">
												<tr>
													<th>시가</th>
													<td id ="7"></td>
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
											</table>
										</div>
									</dd>
								</dl>
							</div>
							<!-- 매수하기 기능 -->
							<!-- Button trigger modal -->
							<%	if(session.getAttribute("user")!=null &&request.getAttribute("accountInfo") != null){
									AccountVO account = (AccountVO) request.getAttribute("accountInfo");
							%>
							<script>
								alert("<%=user.getId()%>")
							</script>
							<button type="button" class="btn btn-primary" data-toggle="modal"
								data-target="#exampleModalCenter">종목 매수하기</button>
							<!-- Modal -->
							<div class="modal fade" id="exampleModalCenter" tabindex="-1"
								role="dialog" aria-labelledby="exampleModalCenterTitle"
								aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered" role="document">
									<div class="modal-content">
									<!-- Form  -->
										<form method="post" action="/mstock/stockinfo">
										<input type="hidden"  name="company_id" value= <%= stock.getJongCd() %>>
										<input type="hidden"  name="price" id="price" >
										<input type = "hidden" name="account_id" value=<%=account.getAccount_id() %>>
											<div class="modal-header">
												<h5 class="modal-title" id="exampleModalCenterTitle">종목 매수하기</h5>
												<button type="button" class="close" data-dismiss="modal"
													aria-label="Close">
													<span aria-hidden="true">&times;</span>
												</button>
											</div>
											<div class="modal-body">
												종목 코드 : <%= stock.getJongCd() %><br>
												종목명 : <%=company.getName()%><br>
												구매 개수 : <input id ="a" type="number"  name="quantity" value=1 min=1><br>
												현재 가격 : <span id="b" style="font-weight:bold"><%=stock.getStockinfo()[1]%></span><br>
												나의 보유 자산 : <span id="c"><%=account.getCredit()  %></span><span>Credit</span>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-secondary"
													data-dismiss="modal">Close</button>
												<button type="submit" onclick="return check();" class="btn btn-primary">매수하기</button>
											</div>
										</form>
										<!--Close  Form  -->
									</div>
								</div>
							</div>
							<%} %>
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
										val=val.replace(',','');
							 			$("#b").text(val);
							 			$("#price").val(val);
										 $("#a").bind('keyup mouseup', function () {
									 		  var current =  $("#c").text();
									          var count = $("#a").val();
									          var result = count * val;
									          if(result>current){
											        $("#b").text("보유 크레딧을 초과하였습니다.");
											        $("#b").css("color","red");
									          }
									          else{
									        	  $("#b").css("color","black");
									        	  $("#price").val(result);
										        $("#b").text(result);
									          }
									          
									      });  
							 </script>
							<!-- 매수기능 끝  -->
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
			<!-- chat -->
			
			<div class="col-md-10" style="border: 1px solid black ">
                <div class="panel panel-info">
                    <div class="panel-heading">
                        채팅
                    </div>
                    <div class="panel-body">
                        <ul class="media-list">

                            <li class="media">

                                <div class="media-body">

                                    <div class="media">
                                        <div class="media-body " id="message"  style="overflow:auto; width:500px; height:150px;">
                                        </div> 
                                    </div>

                                </div>
                            </li>
                            
                        </ul>
                    </div>
                    <div class="panel-footer">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Enter Message"  id="messageinput" />
                            <span class="input-group-btn">
                                <button class="btn btn-info" type="button" onclick="send();">SEND</button>
                            </span>
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
	<script src="/mstock/resources/js/charts/chartjs.addon.js"></script>
	<!-- Vendor Js For This Page Ends-->
	<!-- build:js -->
	<script src="/mstock/resources/js/template.js"></script>
	<script src="/mstock/resources/js/dashboard.js"></script>
	<!-- endbuild -->
</body>
</html>