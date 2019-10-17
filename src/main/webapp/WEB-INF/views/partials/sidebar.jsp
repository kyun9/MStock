<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="sidebar" style="background-color:#e6e6e6">
	<c:choose>
		<c:when test="${user.u_id eq ''}">
			<div class="user-profile">
				<div class="display-avatar animated-avatar">
					<img class="profile-img img-lg rounded-circle" src="/mstock/resources/images/profile/user.png">
				</div>
				<div class="info-wrapper">
					<p class="user-name"></p>
					<p class="display-income">로그인 후 이용할 수 있습니다.</p>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<div class="user-profile">
				<div class="display-avatar animated-avatar">
				<c:choose>
					<c:when test="${empty user.img}">
						<img class="profile-img img-lg rounded-circle" src="/mstock/resources/images/profile/user.png">
					</c:when>
					<c:otherwise>
						<img class="profile-img img-lg rounded-circle" src="/mstock/resources/images/profile/${user.img}">
					</c:otherwise>
				</c:choose>
				</div>
				<div class="info-wrapper">
					<p class="user-name h2">${user.nickname}</p>
					<p id="total-price" class="display-income">0</p>
				</div>
			</div>
			
			<script src="http://code.jquery.com/jquery-latest.min.js"></script>
			<script>
				function numberWithCommas(x) {
				    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				}
				
				/* $.ajax({
					url: "/mstock/partial/account",
					type: "POST",
					data: String(${user.u_id}),
					contentType: "application/json; charset=utf-8;",
					dataType: "json",
					success: function(data){
						if(data.result == 'success'){
							alert("account suc");
						} else {
							alert("account fai");
						}
					},
					error:function(request,status,error){
						console("sidebar account error");
					}
				}); */
				
				
				$.ajax({
					url: "/mstock/partial/price",
					type: "POST",
					data: String(${user.u_id}),
					contentType: "application/json; charset=utf-8;",
					dataType: "json",
					success: function(data){
						if(data.result == 'success'){
							$("#total-price").text(numberWithCommas(data.price));	
						} else {
							$("#total-price").text(0);
						}
					},
					error:function(request,status,error){
						console.log("sidebar price error");
					}
				});
			</script>
			
		</c:otherwise>
	</c:choose>
  
	<ul class="navigation-menu">
		<li class="nav-category-divider" >MENU</li>
		
		<li><a href="#sample-pages" data-toggle="collapse" aria-expanded="false"> <span class="link-title">종목</span> <i class="mdi mdi-trending-up link-icon"></i><i class="fas fa-chart-line"></i></a>
			<ul class="collapse navigation-submenu" id="sample-pages">
				<li><a href="/mstock/stockinfo?code=006400">삼성SDI</a></li>
				<li><a href="/mstock/stockinfo?code=000660">SK하이닉스</a></li>
				<li><a href="/mstock/stockinfo?code=012330">현대모비스</a></li>
				<li><a href="/mstock/stockinfo?code=035420">Naver</a></li>
				<li><a href="/mstock/stockinfo?code=066570">LG전자</a></li>
				<li><a href="/mstock/stockinfo?code=068270">셀트리온</a></li>
				<li><a href="/mstock/stockinfo?code=090430">아모레퍼시픽</a></li>
				<li><a href="/mstock/stockinfo?code=004170">신세계</a></li>
				<li><a href="/mstock/stockinfo?code=055550">신한은행</a></li>
				<li><a href="/mstock/stockinfo?code=035720">카카오</a></li>
				<li><a href="/mstock/stockinfo?code=010950">S-Oil</a></li>
				<li><a href="/mstock/stockinfo?code=161890">한국콜마</a></li>
			</ul></li>
		<li><a href="/mstock/property"> <span class="link-title">내 자산</span><i class="mdi mdi-account link-icon"></i></a></li>
		<li><a href="/mstock/history"> <span class="link-title">히스토리</span><i class="mdi mdi-layers link-icon"></i></a></li>
		<li><a href="/mstock/board?page=1"> <span
				class="link-title">게시판</span> <i
				class="mdi mdi-clipboard-outline link-icon"></i>
		</a></li>
		<li><a href="/mstock/rank"> <span
				class="link-title">랭킹</span> <i
				class="mdi mdi-numeric-1-box-outline link-icon"></i>
		</a></li>
		
		<!-- <li class="nav-category-divider">DOCS</li> -->
		<li><a href="/mstock/bankrupty"> <span class="link-title">파산 신청</span>
				<i class="mdi mdi-asterisk link-icon"></i>
		</a></li>
	</ul>

</div>