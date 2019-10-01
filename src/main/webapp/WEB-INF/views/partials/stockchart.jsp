<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- chart.js 주식 차트 -->
<script>
$(document).ready(function() {     
    $("#reloadChart").click(function(){
    	console.log("reload");
        $("#myChart").load(window.location.href+"#myChart");
        $("#reloadStockInfo").load(window.location.href+"#reloadStockInfo");
    	console.log("reload a");
    });
	$.getJSON('/mstock/resources/json/<%=request.getParameter("code")%>.json', function(data) {
					console.log(data[data.length-1].Stockinfo[0])
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
									
									
									$(".main_stock_box1_title1").text('A'+data[data.length-1].JongCd+" "+data[data.length-1].Stockinfo[0]);
									$("#1").text(data[data.length-1].Stockinfo[1]);
									
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
	
					<%-- 	$.ajax({
							url: "/mstock/stock",
							type: "POST",
							data: <%=request.getParameter("code")%>,
							contentType: "application/json; charset=utf-8;",
							dataType: "json",
							success: function(data){
									console("connect /mstock/stock")
									$(".main_stock_box1_title1").text('A'+data.jongCode);
									$(".main_stock_box1_title1 span").text(data.jongName);
									$(".CurJuka").text(data.currentJuka);
									
									if(data.preparateYCode=="1"||data.preparateYCode=="2"){
										$(".up").text("▲"+data.preparateY + '('+data.dungRakrate+')');
									}
									else if(data.preparateYCode=="3"){
										$(".bohab").text("─"+data.preparateY + '('+data.dungRakrate+')');
									}
									else if(data.preparateYCode=="4"||data.preparateYCode=="5"){
										$(".down").text("▼"+data.preparateY + '('+data.dungRakrate+')');
									}
									
									$("#5").text(data.transcate);
									$("#6").text(data.transcateM);
									$("#7").text(data.timePrice);
									$("#8").text(data.limitPrice);
									$("#9").text(data.highPrice);
									$("#10").text(data.lowerPrice);
									$("#11").text(data.lowPrice);
									$("#12").text(data.facePrice);
									
							}
						}) --%>
	
	
			});
</script>
