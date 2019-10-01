<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- chart.js 주식 차트 -->
<script>
$(document).ready(function(){
    $("#reloadChart").click(function(){
        $("#myChart").load(window.location.href+"#myChart");
    });
});
$(document).ready(function() {     
	$.getJSON('/mstock/resources/json/<%=request.getParameter("code")%>.json', function(data) {
									var d = new Date();
									var day = d.getDate();
									var month = (1 + d.getMonth());
									month = month >= 10 ? month : '0' + month;
									day = day >= 10 ? day : '0' + day;
									/* 오늘 yyyy-mm-dd  */
									var today = d.getFullYear()+ "-"+ month+ "-" + day;
									
									console.log("success");

									var date = new Array();
									var curjuka = new Array();
									
									$.each(data,function(key,value) {
														date.push(value.gettime.replace(/\//gi,'-'));
														curjuka.push(Number(value.Stockinfo[1].replace(/,/gi,'')));
													});
									
									
									
									var minTime=today+" 09:00:00";
									var maxTime = today+" 16:00:00";
									var ctx = document.getElementById('myChart');
									var myChart = new Chart(ctx,{
												type : 'line',
												data : {
													labels : date,
													datasets : [ {
														data : curjuka,
														backgroundColor : 'transparent',
														borderColor : "#000000",
														lineTension : 0,
														pointRadius : 0,
														pointHitRadius : 5,
														borderWidth : 0.5
													//선굵기
													} ]
												},
												options : {
													legend : {
														display : false
													},
													scales : {
														xAxes : [ {
															type : 'time',
															time : {
																min : minTime,
																max :maxTime,
																unit : 'hour',
																unitStepSize : 1,
																displayFormats : {
																	'hour' : 'H:mm'
																}
															}
														} ]
													}
												}
											});
								});
	
	
	
	
			});
</script>
