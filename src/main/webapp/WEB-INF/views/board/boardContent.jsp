<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="vo.BoardVO, vo.CommentsVO, java.util.ArrayList"%>
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
				<div class="content-viewport">
					<div class="row">
<div id="wrap" style="width:900px; margin:30px auto;">

	<div id="content">
	<%
		BoardVO one = (BoardVO) request.getAttribute("listone");
		int uid = (Integer)request.getAttribute("U_Id");
		if (request.getAttribute("listone") != null) {
	%>
	<form method="get" action="/mstock/board/content/edit">
			<div class="view_top">
				<h3><%= one.getTitle() %></h3>
				<hr color="#aaa" style="height:2px">
				<div class="list_btn">
				<p><span style="font-weight: bold;"><%= one.getWriter() %></span> / <%= one.getWritedate() %>
				<span style="float:right">
				<a href="/mstock/board?page=1">목록</a>
 				<% if(one.getWriter()==uid){ %> 
 				<a href="/mstock/board/content/edit?action=update&bid=<%= one.getBid() %>">수정</a>
 				<a href="/mstock/board/content?action=delete&bid=<%= one.getBid() %>">삭제</a>
 				<%} %>
 				</span>
				</p>
				</div>
			</div>
			<br><br>
			
			<div class="view_bottom">
				<pre><%= one.getContent() %></pre>
			</div>
			
			<input type="hidden" name="action" value="update"> 
			<input type="hidden" name="bid" value="<%= one.getBid() %>"> 
			<input type="hidden" name="title" value="<%= one.getTitle() %>"> 
			<input type="hidden" name="content" value="<%= one.getContent() %>"> 
			</form>
		</div>
	<%
		}
	%>
		<br>
		<br>
		<br>
		<br>
		<br>
		<h5 align="center">댓글</h5>	
		<hr color="#aaa">
	<div>
		<%
			if(request.getAttribute("comlist")!=null){
		    ArrayList<CommentsVO> comlist = (ArrayList<CommentsVO>)request.getAttribute("comlist");
		    for(CommentsVO cvo: comlist){
		%>
			<div id="content<%=cvo.getCid()%>" style="display:block;">
				<div>
				<%= cvo.getWriter() %> &nbsp;|&nbsp; <%= cvo.getWritedate() %>  
				<%
					if(cvo.getWriter()==uid){
				%>
				<span>
				<button style="border:0; outline:0; background-color: rgba(255, 255, 255, 0);
				 color:#adadad" onclick="updatecom('<%= cvo.getCid() %>')">
				 수정</button>
				</span>
				&nbsp;|&nbsp;
				<span>
				<button style="border:0; outline:0; background-color: rgba(255, 255, 255, 0);
				 color:#adadad;" onclick="deletecom('<%= one.getBid() %>','<%= cvo.getCid() %>')">
				 삭제</button>
				</span>
				<%
					}
				%>
				</div>
				<pre style="font-size:15px; margin-bottom:10px; margin-top:10px;
				white-space: pre-wrap; word-wrap: break-word;"><span><%= cvo.getContent() %></span></pre>
			</div>
			<div id="updatecom<%=cvo.getCid()%>" style="display:none;">
				<form method="post" action="/mstock/comment">
				<div class="row">
				<div class="col-md-10">
					<input type="hidden" name="action" value="update">
					<input id="bid" name="bid" type="hidden" value='<%=one.getBid()%>'>
					<input id="cid" name="cid" type="hidden" value='<%=cvo.getCid()%>'>
					<input id="writer" name="writer" type="hidden" value='<%= uid %>'>
					<span style="margin:auto;">
					<textarea id="content" name="content" rows="2" cols="50" style="margin:0 auto;
					 height:100px; width:100%; border:1px solid #ccc;"><%= cvo.getContent() %></textarea></span>
				</div>
				<div class="col-md-2">
					<span>
					<button style="border:0; outline:0; float:right;
				 	background-color: #fff; color: #9999fa; padding:10px;" type="button"
				 	onclick="updatecancle('<%= cvo.getCid() %>')">수정취소</button><br><br>
					<input style="border:0; outline:0; background-color: #c0c0ff; width:100%;
					 color: white;  padding:10px;" type="submit" name="submit" value="수정">
					</span>
				</div>
				</div>
					<br>				
				</form>
			</div>
			<hr style="border: dotted 1px #bdbdbd;">
			<%
		    	}
			%>
		<%
			}
		%>
	</div>
	<br>
	<div>
		<form method="post" action="/mstock/comment" style="border-top:1px;">
			<input type="hidden" name="action" value="insert">
			<input id="bid" name="bid" type="hidden" value='<%=one.getBid()%>'>
			<input id="writer" name="writer" type="hidden" value='<%= uid %>'>
			<span><textarea id="content" name="content" rows="2" cols="50" 
			style="width:80%; outline: 0; border:1px solid #ccc; margin:auto;" 
			placeholder="댓글을 입력해주세요." onkeydown="resize(this)" onkeyup="resize(this)"></textarea></span>
			<span><input style="float: right; width:15%; border:0; outline:0; 
			background-color: #c0c0ff; color: white;  padding:10px;" type="submit" 
			name="submit" value="등록"></span>
			<br><br><br>
		</form>
	</div>
	
	

	</div><!-- content End -->
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
	
	<script>
	function deletecom(cv1,cv2){
		location.href = '/mstock/comment?action=delete&bid='+cv1+'&cid='+cv2;
	}
	function updatecom(cv){
		document.getElementById("content"+cv).style.display='none';
		document.getElementById("updatecom"+cv).style.display='block';
	}
	function updatecancle(cv){
		document.getElementById("content"+cv).style.display='block';
		document.getElementById("updatecom"+cv).style.display='none';
	}
	function resize(obj) {
		  obj.style.height = "1px";
		  obj.style.height = (12+obj.scrollHeight)+"px";
	}
	</script>

</body>
</html>
