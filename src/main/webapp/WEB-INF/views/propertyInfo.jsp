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
					<div class="row">
						<!-- 내용 -->
						<c:choose>
							<c:when test="${account eq 'fail'}">
								<div class="jumbotron container">
									<h1 class="display-4">안녕하세요, ${user.id}님</h1>
									<hr class="my-4">
									<p class="lead">아직 계좌가 없습니다.</p>
									<p class="lead">계좌를 생성하고 모의 주식을 즐겨보세요.</p>
									<p class="lead">계좌를 생성하면 100만 크레딧이 즉시 지급됩니다.</p>
									<a class="btn btn-primary btn-lg" href="/mstock/account/insert" role="button">계좌 생성</a>
								</div>	
							</c:when>
							<c:otherwise>
								<div class="jumbotron container">
									<h1 class="display-4">안녕하세요, ${user.id}님</h1>
									<hr class="my-4">
									 
								 <div class="row">
						            <div class="col-md-12 grid-margin stretch-card">
						              <div class="card position-relative">
						                <div class="card-body">
						                  
						                  <div class="row">
						                    <div class="col-md-12 col-xl-3 d-flex flex-column justify-content-center">
						                      <div class="ml-xl-4 text-center">
						                        <p class="h1">총 자산</p>
						                        <p class="h2" id="total_property"></p>
						                        <p class="h2">${propertyVO.profit_rate}%</p>
						                      </div>  
						                    </div>
						                    <div class="col-md-12 col-xl-9">
						                      <div class="row">
						                        <div class="col-md-6 mt-3 col-xl-5">
						                          <canvas id="north-america-chart"></canvas>
						                          <div id="north-america-legend"></div>
						                        </div>
						                        <div class="col-md-6 col-xl-7">
						                          <div class="table-responsive mb-3 mb-md-0">
						                          
						                          <div class="card">
                <div class="card-body">
                  <p class="card-title">Cash deposits</p>
                  
                  <div id="cash-deposits-chart-legend" class="d-flex justify-content-center pt-3"></div>
                  <canvas id="cash-deposits-chart"></canvas>
                </div>
              </div>
						                          
						                          </div>    
						                        </div>
						                      </div>
						                    </div>
						                  </div>
						                </div>
						              </div>
						            </div>
						          </div>
						          
						          
						          <hr class="my-4">
						          <div class="row">
            <div class="col-md-12 grid-margin stretch-card">
              <div class="card">
                <div class="card-body">
                  <p class="card-title mb-0">Top Products</p>
                  <div class="table-responsive">
                    <table class="table table-hover">
                      <thead>
                        <tr>
                          <th>User</th>
                          <th>Product</th>
                          <th>Sale</th>
                          <th>Status</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr>
                          <td>Jacob</td>
                          <td>Photoshop</td>
                          <td class="text-danger"> 28.76% <i class="ti-arrow-down"></i></td>
                          <td><label class="badge badge-danger">Pending</label></td>
                        </tr>
                        <tr>
                          <td>Messsy</td>
                          <td>Flash</td>
                          <td class="text-danger"> 21.06% <i class="ti-arrow-down"></i></td>
                          <td><label class="badge badge-warning">In progress</label></td>
                        </tr>
                        <tr>
                          <td>John</td>
                          <td>Premier</td>
                          <td class="text-danger"> 35.00% <i class="ti-arrow-down"></i></td>
                          <td><label class="badge badge-info">Fixed</label></td>
                        </tr>
                        <tr>
                          <td>Peter</td>
                          <td>After effects</td>
                          <td class="text-success"> 82.00% <i class="ti-arrow-up"></i></td>
                          <td><label class="badge badge-success">Completed</label></td>
                        </tr>
                        <tr>
                          <td>Dave</td>
                          <td>53275535</td>
                          <td class="text-success"> 98.05% <i class="ti-arrow-up"></i></td>
                          <td><label class="badge badge-warning">In progress</label></td>
                        </tr>
                        <tr>
                          <td>Messsy</td>
                          <td>Flash</td>
                          <td class="text-danger"> 21.06% <i class="ti-arrow-down"></i></td>
                          <td><label class="badge badge-info">Fixed</label></td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>

          </div>
									 
								</div>
								
								
							</c:otherwise>
						</c:choose>
						
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
	if ($("#north-america-chart").length) {
	      var areaData = {
	        labels: ["Credit", "Stock"],
	        datasets: [{
	            data: [${propertyVO.credit}, ${propertyVO.stock_value}],
	            backgroundColor: ["#71c016", "#8caaff"],
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
	            text.push('<div class="d-flex justify-content-between mx-4 mx-xl-5 mt-3"><div class="d-flex align-items-center"><div class="mr-3" style="width:20px; height:20px; border-radius: 50%; background-color: ' + chart.data.datasets[0].backgroundColor[0] + '"></div><p class="mb-0">보유 Credit</p></div>');
	            text.push('<p class="mb-0" id="chart_credit">${propertyVO.credit}</p>');
	            text.push('</div>');
	            text.push('<div class="d-flex justify-content-between mx-4 mx-xl-5 mt-3"><div class="d-flex align-items-center"><div class="mr-3" style="width:20px; height:20px; border-radius: 50%; background-color: ' + chart.data.datasets[0].backgroundColor[1] + '"></div><p class="mb-0">보유 주식</p></div>');
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
	if ($('#cash-deposits-chart').length) {
	      var cashDepositsCanvas = $("#cash-deposits-chart").get(0).getContext("2d");
	      var data = {
	        labels: ["0", "1", "2", "3", "4", "5", "6", "7", "8"],
	        datasets: [
	          {
	            label: 'Returns',
	            data: [27, 35, 30, 40, 52, 48, 54, 46, 70],
	            borderColor: [
	              '#ff4747'
	            ],
	            borderWidth: 2,
	            fill: false,
	            pointBackgroundColor: "#fff"
	          },
	          {
	            label: 'Sales',
	            data: [29, 40, 37, 48, 64, 58, 70, 57, 80],
	            borderColor: [
	              '#4d83ff'
	            ],
	            borderWidth: 2,
	            fill: false,
	            pointBackgroundColor: "#fff"
	          },
	          {
	            label: 'Loss',
	            data: [90, 62, 80, 63, 72, 62, 40, 50, 38],
	            borderColor: [
	              '#ffc100'
	            ],
	            borderWidth: 2,
	            fill: false,
	            pointBackgroundColor: "#fff"
	          }
	        ]
	      };
	      var options = {
	        scales: {
	          yAxes: [{
	            display: true,
	            gridLines: {
	              drawBorder: false,
	              lineWidth: 1,
	              color: "#e9e9e9",
	              zeroLineColor: "#e9e9e9",
	            },
	            ticks: {
	              min: 0,
	              max: 100,
	              stepSize: 20,
	              fontColor: "#6c7383",
	              fontSize: 16,
	              fontStyle: 300,
	              padding: 15
	            }
	          }],
	          xAxes: [{
	            display: true,
	            gridLines: {
	              drawBorder: false,
	              lineWidth: 1,
	              color: "#e9e9e9",
	            },
	            ticks : {
	              fontColor: "#6c7383",
	              fontSize: 16,
	              fontStyle: 300,
	              padding: 15
	            }
	          }]
	        },
	        legend: {
	          display: false
	        },
	        legendCallback: function(chart) {
	          var text = [];
	          text.push('<ul class="dashboard-chart-legend">');
	          for(var i=0; i < chart.data.datasets.length; i++) {
	            text.push('<li><span style="background-color: ' + chart.data.datasets[i].borderColor[0] + ' "></span>');
	            if (chart.data.datasets[i].label) {
	              text.push(chart.data.datasets[i].label);
	            }
	          }
	          text.push('</ul>');
	          return text.join("");
	        },
	        elements: {
	          point: {
	            radius: 3
	          },
	          line :{
	            tension: 0
	          }
	        },
	        stepsize: 1,
	        layout : {
	          padding : {
	            top: 0,
	            bottom : -10,
	            left : -10,
	            right: 0
	          }
	        }
	      };
	      var cashDeposits = new Chart(cashDepositsCanvas, {
	        type: 'line',
	        data: data,
	        options: options
	      });
	      document.getElementById('cash-deposits-chart-legend').innerHTML = cashDeposits.generateLegend();
	    }
	</script>
	
	<script>
		$(document).ready(function() {
			function numberWithCommas(x) {
			    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			}
			
			$("#total_property").html(numberWithCommas(${propertyVO.credit + propertyVO.stock_value})+"원");
			$("#chart_credit").html(numberWithCommas(${propertyVO.credit})+"원");
			$("#chart_stock_value").html(numberWithCommas(${propertyVO.stock_value})+"원");
		});
	</script>
	
</body>
</html>
