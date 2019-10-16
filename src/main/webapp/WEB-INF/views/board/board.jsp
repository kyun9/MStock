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
				<div class="content-viewport" style="width:900px; margin:0 auto;">
				
				<h2 style="text-align:center; margin : 30px; font-weight:bold;">게시판</h2>
				
					<div class="row">
						
						<div id="boardList" class="table">
			
			<%
				ArrayList<BoardVO> list = (ArrayList<BoardVO>) request.getAttribute("list");
				if (!list.isEmpty()) {
			%>
			<div>
			<table class="table-info">
 				<colgroup>
					<col width="20%" />
					<col width="30%" />
					<col width="20%" />
					<col width="20%" />
					<col width="10%" />
				</colgroup>

				<thead>
					<tr style="text-align:center">
						<th >번호</th>
						<th >제목</th>
						<th >작성자</th>
						<th >작성일</th>
						<th >조회수</th>
					</tr>
				</thead>

				<tbody>
					<%
						for (BoardVO vo : list) {
					%>
					<tr class="table-info table-hover">
						<td class="t_info"><%=vo.getBid()%></td>
						<td class="title">
						<a href='/mstock/board/content?bid=<%=vo.getBid()%>&action=read'>
						<%=vo.getTitle()%></a></td>
						<td class="t_info">
						<a href='/mstock/board?page=1&action=listwriter&writer=<%=vo.getWriter()%>'>
						<%=vo.getWriter()%></a></td>
						<td class="t_info"><%=vo.getWritedate()%></td>
						<td class="t_info"><%=vo.getCnt()%></td>
					</tr>

					<%
						}
					%>
				</tbody>
			
			</table>	
			</div>
					<div class="page" style="font-size:20px; text-align:center !important; margin:30px; padding: 0 auto !important;">
	
	<c:if test="${pagination.curRange ne 1 }">
			<a class="page-num" style="margin:10px" onClick="fn_paging(1)">처음</a>
		</c:if>
		<c:if test="${pagination.curPage ne 1}">
			<a class="page-num" style="margin:10px" onClick="fn_paging('${pagination.prevPage }')">이전</a>
		</c:if>
			<c:forEach var="pageNum" begin="${pagination.startPage }"
         end="${pagination.endPage }">
         <c:choose>
            <c:when test="${pageNum eq  pagination.curPage}">
               <span style="font-weight: bold;"><a style="color:black !important; margin:10px;" class="page-num" href="#"
                  onClick="fn_paging(${pageNum })">${pageNum }</a></span>
            </c:when>
            <c:otherwise>
               <a class="page-num" style="color:black !important; margin:10px;"href="#" onClick="fn_paging(${pageNum })">${pageNum }</a>
            </c:otherwise>
         </c:choose>
      </c:forEach>
       <c:if test="${pagination.curPage ne pagination.pageCnt && pagination.pageCnt > 0}">
			<a class="page-num" onClick="fn_paging('${pagination.nextPage }')">다음</a>
			</c:if>
	<c:if test="${pagination.curRange ne pagination.rangeCnt && pagination.rangeCnt > 0}">
			<a class="page-num" onClick="fn_paging('${pagination.pageCnt }')">끝</a>
	</c:if>
	</div>
		
			<div style="width:330px; margin:0 auto; height:50px;">
				<form method="get" action="/mstock/board">
				<input type="hidden" name="page" value="1">
					<span class="select">
						<select name="searchType" id="cty" class="custom-select"
						style="width:90px; border-color:#bebebe;">
							<option value="title">제목</option>
							<option value="bid">글번호</option>
							<option value="writer">작성자</option>
						</select>
					</span>
					<input type="hidden" name="action" value="search">
					 <span class="search"><input type="text" name="key" 
					 style="width:150px; margin:auto; padding:5px;
					 border:1px solid; border-color:#bebebe; border-radius:5px"/></span>
					<span class="btn" style="padding:5px"><button type="submit" id="search" 
					class="rounded border-secondary" style="width:60px; height:30px;
					background-color: #c0c0ff; color: white;">검색</button></span>
				</form>
			</div>

			<div style="float:right;">
				<a href="/mstock" class="color">홈으로</a>
				<a href="/mstock/board/content/edit?action=insert">게시물작성</a>
			</div>
			
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
 function fn_paging(cv){   
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
