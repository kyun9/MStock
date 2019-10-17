<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="vo.BoardVO, java.util.ArrayList"%>
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

<!-- Table Style -->
<link rel="stylesheet" type="text/css" href="resources/css/table.css" />

<!-- JQuery -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

</head>
<body class="header-fixed">
	<c:if test="${!empty msg}">
		<script>
			alert("${msg}");
		</script>
	</c:if>
	<!-- partial:partials/header.jsp -->
	<%@ include file="../partials/header.jsp"%>
	<!-- partial -->
	<div class="page-body">
		<!-- partial:partials/sidebar.jsp -->
		<%@ include file="../partials/sidebar.jsp"%>
		<!-- partial -->
		<!-- content viewport start -->
		<div class="page-content-wrapper">
			<div class="page-content-wrapper-inner">
				<div class="content-viewport">
					<div class="row">
					
						<div class="jumbotron container text-center">
							<h1 class="display-4">Board</h1>
							<!-- <i class="fas fa-crown"></i> -->
							<p class="lead">자유 게시판</p>
							<hr class="my-4">
						</div>
					
						
						<div class="container text-center">
			
							<%
								ArrayList<BoardVO> list = (ArrayList<BoardVO>) request.getAttribute("list");
								if (!list.isEmpty()) {
							%>
						
							<!-- table -->
							<div style="margin-bottom:20px;">
							<table class="table">
								<tr>
									<th >번호</th>
									<th >제목</th>
									<th >작성자</th>
									<th >작성일</th>
									<th >조회수</th>
								</tr>	
								<tbody>
									<%
										for (BoardVO vo : list) {
									%>
									<tr>
										<td><%=vo.getBid()%></td>
										<td>
											<a href='/mstock/board/content?bid=<%=vo.getBid()%>&action=read'><%=vo.getTitle()%></a>
										</td>
										<td class="writer">
											<%-- <a href='/mstock/board?page=1&action=listwriter&writer=<%=vo.getWriter()%>'><%=vo.getWriter()%></a> --%>
											<%=vo.getWriter()%>
										</td>
										<td><%=vo.getWritedate()%></td>
										<td><%=vo.getCnt()%></td>
									</tr>
				
									<%
										}
									%>
								</tbody>						
							</table>	
						</div>
						
						<script>
							$(function(){
								$(".writer").each(function(){
									var dom = $(this);
									$.ajax({
										url: "/mstock/board/nickname",
										type: "POST",
										data: $(this).text(),
										contentType: "application/json; charset=utf-8;",
										dataType: "json",
										success: function(data){
											dom.text(data.nickname);
										},
										error:function(request,status,error){
											alert(error);
										}
									});
									
								});
							});
						</script>
						
						<!-- Paging -->
						<div>
							<ul class="pagination justify-content-center">
								<c:if test="${pagination.curPage ne 1}">
									<li class="page-item"><a class="page-link" href="#"
										aria-label="Previous"
										onClick="paging('${pagination.prevPage}')"> <span
											aria-hidden="true">&laquo;</span> <span class="sr-only">Previous</span>
									</a></li>
								</c:if>
								<c:forEach var="pageNum" begin="${pagination.startPage}"
									end="${pagination.endPage}">
									<c:choose>
										<c:when test="${pageNum eq pagination.curPage}">
											<li class="page-item" style="font-weight: bold;"><a
												class="page-link" href="#" onclick="paging('${pageNum}')">${pageNum}</a></li>
										</c:when>
										<c:otherwise>
											<li class="page-item"><a class="page-link" href="#"
												onclick="paging('${pageNum}')">${pageNum}</a></li>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								<c:if test="${pagination.curPage ne pagination.pageCnt}">
									<li class="page-item"><a class="page-link" href="#"
										aria-label="Next" onClick="paging('${pagination.nextPage }')">
											<span aria-hidden="true">&raquo;</span> <span
											class="sr-only">Next</span>
									</a></li>
								</c:if>
							</ul>
						</div>
						
						<div class="text-right">
							<button id="writeBtn" class="btn btn-primary">작성하기</button>
						</div>
						
						<script>
							$("#writeBtn").on("click", function(){
								location.href = "/mstock/board/content/edit?action=insert";
							});
						</script>
						
						<!-- Search -->
						<hr class="my-4">
						<div style="position:absolute; left:25%">
						<form method="get" action="/mstock/board">
							<div class="form-row align-items-center">
								<input type="hidden" name="page" value="1">
								<input type="hidden" name="action" value="search">
								<div class="col-auto my-1">	
									<select name="searchType" id="cty" class="custom-select"
									style="width:90px; height:40px; border-color:#bebebe;">
										<option value="title">제목</option>
										<option value="bid">글번호</option>
										<option value="writer">작성자</option>
									</select>							
								</div>
								<div class="col-auto my-1">	
									<input type="text" class="form-control" name="key" style="width:300px; height:40px; margin:auto; border:1px solid; border-color:#bebebe; border-radius:5px"/>
								</div>
								<div class="col-auto my-1">	
									<button type="submit" id="search" class="btn btn-light" style="width:90px; border-color:#bebebe;">검색</button>
								</div>
							</div>
						</form>
						</div>
						
						<div style="margin-bottom:200px;"></div>
					

			<%
				} else {
					if(request.getParameter("action")!=null){
			%>
			<script>
				alert("찾는 내용이 없습니다.");
				document.location.href="/mstock/board?page=1";
			</script>
			<%
					}else{
			%>
			<div style="text-align:center;">
				<h2>게시판에 글이 없습니다.</h2><br>
				<h3>게시판에 첫 게시글을 써주세요.</h3><br>
				<a href="/mstock/board/content/edit?action=insert">게시물작성</a>
			</div>
			<%
					}
				}
			%>
		</div>						
						
					</div>
				</div>
			</div>
			<!-- content viewport ends -->
			<!-- partial:partials/footer.jsp -->
			<%@ include file="../partials/footer.jsp"%>
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
	
	<!-- page move script -->
	<script>	
function getParameterByName(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}
 function paging(cv){   
		var searching  = getParameterByName("action");
		var searchType  = getParameterByName("searchType");
		var writer  = getParameterByName("writer");
		var key  = getParameterByName("key");
 		 if(searching.match("search")){
				location.href = '/mstock/board?page='+cv+'&searchType='+searchType
						+'&action=search&key='+key;
		}else if(searching.match("listwriter")){
			location.href = '/mstock/board?page='+cv+'&action=listwriter&writer='+writer;
		}else{
		   location.href = '/mstock/board?page='+cv;
		} 
	} 
</script>
</body>
</html>
