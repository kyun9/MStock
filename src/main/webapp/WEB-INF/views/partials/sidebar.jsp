<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="sidebar" style="background-color:#EAEAEA">
	<c:choose>
		<c:when test="${user.u_id eq ''}">
			<div class="user-profile">
				<div class="display-avatar animated-avatar">
					<img class="profile-img img-lg rounded-circle" src="/mstock/resources/images/profile/user.png">
				</div>
				<div class="info-wrapper">
					<p class="user-name"></p>
					<p class="display-income">로그인후 이용할 수 있습니다.</p>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<div class="user-profile">
				<div class="display-avatar animated-avatar">
					<img class="profile-img img-lg rounded-circle" src="/mstock/resources/images/profile/${user.img}">
				</div>
				<div class="info-wrapper">
					<p class="user-name h2">${user.nickname}</p>
					<a href="/mstock/mypage"><p class="display-income">마이페이지</p></a>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
  
	<ul class="navigation-menu">
		<li class="nav-category-divider" >main</li>
		<li><a href="/mstock/property"> <span class="link-title">내 자산</span><i class="mdi mdi-gauge link-icon"></i></a></li>
		<li><a href="#sample-pages" data-toggle="collapse" aria-expanded="false"> <span class="link-title">종목</span> <i class="mdi mdi-flask link-icon"></i></a>
			<ul class="collapse navigation-submenu" id="sample-pages">
				<li><a href="/mstock/stockinfo?code=006400" target="_blank">삼성SDI</a></li>
				<li><a href="/mstock/stockinfo?code=000660" target="_blank">SK하이닉스</a></li>
				<li><a href="/mstock/stockinfo?code=012330" target="_blank">현대모비스</a></li>
				<li><a href="/mstock/stockinfo?code=035420" target="_blank">네이버</a></li>
				<li><a href="/mstock/stockinfo?code=066570" target="_blank">LG전자</a></li>
				<li><a href="/mstock/stockinfo?code=068270" target="_blank">셀트리온</a></li>
				<li><a href="/mstock/stockinfo?code=090430" target="_blank">아모레퍼시픽</a></li>
				<li><a href="/mstock/stockinfo?code=004170" target="_blank">신세계</a></li>
				<li><a href="/mstock/stockinfo?code=055550" target="_blank">신한은행</a></li>
				<li><a href="/mstock/stockinfo?code=035720" target="_blank">카카오</a></li>
				<li><a href="/mstock/stockinfo?code=010950" target="_blank">S-Oil</a></li>
				<li><a href="/mstock/stockinfo?code=161890" target="_blank">한국콜마</a></li>
			</ul></li>
		<li><a href="pages/forms/form-elements.html"> <span
				class="link-title">게시판</span> <i
				class="mdi mdi-clipboard-outline link-icon"></i>
		</a></li>
		<li><a href="/mstock/rank"> <span
				class="link-title">랭킹</span> <i
				class="mdi mdi-chart-donut link-icon"></i>
		</a></li>
		
		<li class="nav-category-divider">DOCS</li>
		<li><a href="docs/docs.html"> <span class="link-title">파산 신청</span>
				<i class="mdi mdi-asterisk link-icon"></i>
		</a></li>
	</ul>

</div>