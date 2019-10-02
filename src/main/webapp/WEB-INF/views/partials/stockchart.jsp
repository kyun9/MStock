<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- chart.js 주식 차트 -->
<script>
var drawingStockInfo = function(){$.getJSON('/mstock/resources/json/<%=request.getParameter("code")%>.json', function(data) {
				/* chart */
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
					var minJuka = Number(data[data.length-1].Stockinfo[9].replace(/,/gi,''));
					var maxJuka = Number(data[data.length-1].Stockinfo[8].replace(/,/gi,''));
					var stepJuka =(maxJuka-minJuka)/10;
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
										} ],
										yAxes : [ {
											 display: true,
					                         ticks: {
					                        	stepSize: stepJuka,
												min : minJuka,
												max :maxJuka,
					                          }
										}]
									}
								}
							});
					
					/* stock 랜더링 */
					
					$("#time0").text(data[data.length-1].gettime);
					$(".main_stock_box1_title1").text('A'+data[data.length-1].JongCd+" "+data[data.length-1].Stockinfo[0]);
					$("#1").text(data[data.length-1].Stockinfo[1]);
					var modalCurjuka=(data[data.length-1].Stockinfo[1]).replace(',','');
					$("#b").text(modalCurjuka);
					
					if(data[data.length-1].Stockinfo[2]=="1"||data[data.length-1].Stockinfo[2]=="2"){
						$("#2").text("▲"+data[data.length-1].Stockinfo[3] + '('+data[data.length-1].DungRakrate_str+')');
					}
					else if(data[data.length-1].Stockinfo[2]=="3"){
						$("#3").text("─"+data[data.length-1].Stockinfo[3] + '('+data[data.length-1].dungRakrate+')');
					}
					else if(data[data.length-1].Stockinfo[2]=="4"||data[data.length-1].Stockinfo[2]=="5"){
						$("#4").text("▼"+data[data.length-1].Stockinfo[3] + '('+data[data.length-1].DungRakrate_str+')');
					}
					
					$("#5").text(data[data.length-1].Stockinfo[5]);
					$("#6").text(data[data.length-1].Stockinfo[6]);
					$("#7").text(data[data.length-1].Stockinfo[7]);
					$("#8").text(data[data.length-1].Stockinfo[12]);
					$("#9").text(data[data.length-1].Stockinfo[8]);
					$("#10").text(data[data.length-1].Stockinfo[13]);
					$("#11").text(data[data.length-1].Stockinfo[9]);
					$("#12").text(data[data.length-1].Stockinfo[16]); 
				});
};
	/* 30초마다 자동 reload */
	var reloadTimer = setInterval(function() {
		drawingStockInfo();
	}, 30000);
	
	
	$(document).ready(function() {
		/* 새로 고침 버튼 누르시 */
		$("#reloadInfo").click(function() {
			drawingStockInfo();
		});
		drawingStockInfo();
		reloadTimer;
	});
</script>
