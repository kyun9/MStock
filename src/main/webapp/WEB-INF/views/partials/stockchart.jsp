<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- chart.js 주식 차트 -->
<script>
		$(document).ready(function() {
				$.getJSON('/mstock/resources/json/<%=request.getParameter("code")%>.json', function(data) {
												var d = new Date();
												var date = new Array();
												var curjuka = new Array();
												var today = d.getFullYear()
														+ "-"
														+ ('0' + (d.getMonth() + 1))
																.slice(-2)
														+ "-" + d.getDate();

												console.log("success");
												$
														.each(
																data,
																function(key,
																		value) {
																	date
																			.push(value.gettime
																					.replace(
																							/\//gi,
																							'-'));
																	curjuka
																			.push(Number(value.Stockinfo[1]
																					.replace(
																							/,/gi,
																							'')));
																});
												console.log(typeof (curjuka));
												console.log(curjuka);
												console
														.log(typeof (curjuka[1]));
												console.log(typeof (date));
												console.log(date);
												console.log(typeof (date[1]));
												console.log(today);

												var ctx = document
														.getElementById('myChart');

												var myChart = new Chart(
														ctx,
														{
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
																//ì êµµê¸°
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
																			min : today
																					+ " 09:00:00",
																			max : today
																					+ " 16:00:00",
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