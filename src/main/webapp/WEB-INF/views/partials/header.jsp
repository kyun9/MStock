<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<nav class="t-header"  style="background-color:#575DFA" >
	<div class="t-header-brand-wrapper" style="border-bottom: 5px solid #fff;">
		<a href="/mstock"> <img class="logo"
			src="/mstock/resources/images/logo.svg"> <img
			class="logo-mini" src="/mstock/resources/images/logo_mini.svg">
		</a>
	</div>
	<div class="t-header-content-wrapper">
		<div class="t-header-content">
			<button
				class="t-header-toggler t-header-mobile-toggler d-block d-lg-none">
				<i class="mdi mdi-menu"></i>
			</button>
			<form action="/mstock/search" method="POST" class="t-header-search-box">
				<div class="input-group">
					<input type="text" class="form-control" id="inlineFormInputGroup"
						placeholder="Search" name="word" autocomplete="off">
					<button class="btn btn-primary" type="submit">
						<i class="mdi mdi-arrow-right-thick"></i>
					</button>
				</div>
			</form>
			
			<c:choose>
				<c:when test="${user.u_id eq ''}">
					<ul class="nav ml-auto">
						<li class="nav-item display-income"><a
							class="nav-link active" href="/mstock/login" style ="color:white">로그인</a></li>
						<li class="nav-item display-income"><a class="nav-link"
							href="/mstock/register" style ="color:white">회원가입</a></li>
					</ul>
				</c:when>
				<c:otherwise>
					<ul class="nav ml-auto">					
						<li class="nav-item display-income"><a class="nav-link active" href="/mstock/mypage" style ="color:white">마이페이지</a></li>
						<li class="nav-item display-income"><a class="nav-link active" href="/mstock/logout" style ="color:white">로그아웃</a></li>
					</ul>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</nav>