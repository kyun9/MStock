$(document).ready(function(){

	/*
	 * 탭이동 설정
	 * stockInfo.jsp
	 * */
	$(".tab_content").hide();
	$("ul.tabs li:first").addClass("active").show();
	$(".tab_content:first").show();

	$("ul.tabs li").click(function() {

		$("ul.tabs li").removeClass("active");
		$(this).addClass("active");
		$(".tab_content").hide();

		var activeTab = $(this).find("a").attr("href");
		$(activeTab).fadeIn();
		return false;
	});
	
	/*
	 *차트 
	 * */
	onChart(680, 205, '035420');
});