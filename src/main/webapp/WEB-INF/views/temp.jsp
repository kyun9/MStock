<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/mstock/resources/vendors/apexcharts/apexcharts.min.js"></script>
<script src="/mstock/resources/vendors/chartjs/Chart.min.js"></script>
<script src="/mstock/resources/js/charts/chartjs.addon.js"></script>
<link rel="shortcut icon" href="/mstock/resources/images/favicon.ico" />
</head>
<body>
	<h1>Hi</h1>
	<div class="col-md-6 mt-3 col-xl-5">
		<canvas id="north-america-chart"></canvas>
		<div id="north-america-legend"></div>
	</div>

	<!-- 감정분석 JSON 읽기 -->
	<script src="http://code.jquery.com/jquery-2.1.3.min.js"></script>

	<!-- 차트 그리기 -->
	<script>
		var drawChart = function(pos, neg) {
			if ($("#north-america-chart").length) {
				var areaData = {
					labels : [ "pos", "neg" ],
					datasets : [ {
						data : [ pos, neg ],
						backgroundColor : [ "#ff944d", "#8caaff" ],
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
										+ '"></div><p class="mb-0">보유 Credit</p></div>');
						text.push('<p class="mb-0" id="chart_credit">pos</p>');
						text.push('</div>');
						text
								.push('<div class="d-flex justify-content-between mx-4 mx-xl-5 mt-3"><div class="d-flex align-items-center"><div class="mr-3" style="width:20px; height:20px; border-radius: 50%; background-color: '
										+ chart.data.datasets[0].backgroundColor[1]
										+ '"></div><p class="mb-0">보유 주식</p></div>');
						text
								.push('<p class="mb-0" id="chart_stock_value">neg</p>');
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

		var code = '000660';
		var jsonLocation = '/mstock/resources/rdata/json/emotion000660.json';
		$.getJSON(jsonLocation, function(data) {
			$.each(data, function(n, arr) {
				//alert(name);
				$.each(arr, function(m, company) {
					console.log(company.code);
					console.log(company.pos);
					console.log(company.neg);
					if (code == company.code) {
						drawChart(company.pos, company.neg);
					}
				});
			});
		});
	</script>

</body>
</html>