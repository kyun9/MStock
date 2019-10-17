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
					
					<div class="jumbotron container text-center">
						<h1 class="display-4">Board</h1>
						<!-- <i class="fas fa-crown"></i> -->
						<p class="lead">자유 게시판</p>
						<hr class="my-4">
					</div>

<div class="container">

	<div class="w-80 p-3 mx-auto">
	<%
		BoardVO one = (BoardVO) request.getAttribute("listone");
		int uid = (Integer)request.getAttribute("U_Id");
		if (request.getAttribute("listone") != null) {
	%>
	<form method="get" action="/mstock/board/content/edit">
			<div style="margin-bottom:20px;">
				<h3><%= one.getTitle() %></h3>
				
				<hr>
				<div class="list_btn">
				<p><span class="writer h6"><%= one.getWriter() %> </span>&nbsp;<span style="color:#ccc;"><%= one.getWritedate() %></span> 
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
			
			<div class="view_bottom">
				<p id="content"><%= one.getContent() %><p>
				<script>
					var content = $("#content").text();
					if(content == 'null'){
						$("#content").text("");
					};
				</script>
			</div>
			
			<input type="hidden" name="action" value="update"> 
			<input type="hidden" name="bid" value="<%= one.getBid() %>"> 
			<input type="hidden" name="title" value="<%= one.getTitle() %>"> 
			<input type="hidden" name="content" value="<%= one.getContent() %>"> 
			</form>
	
	<%
		}
	%>
		<div style="height:100px"></div>
		<h5 align="left">댓글</h5>	
		<hr>
		
		<div>
		<%
			if(request.getAttribute("comlist")!=null){
		    ArrayList<CommentsVO> comlist = (ArrayList<CommentsVO>)request.getAttribute("comlist");
		    for(CommentsVO cvo: comlist){
		%>
			<div id="content<%=cvo.getCid()%>" style="display:block;">
				<div>
					<span class="writer h6"><%= cvo.getWriter() %></span>&nbsp; <span style="color:#ccc;"><%= cvo.getWritedate() %></span>  
					<%
						if(cvo.getWriter()==uid){
					%>
					<span style="float:right">
						<a href="#" onclick="updatecom('<%= cvo.getCid() %>')">수정</a>
						<a href="#" onclick="deletecom('<%= one.getBid() %>','<%= cvo.getCid() %>')">삭제</a>
					</span>
					<%
						}
					%>
				</div>
				<p style="font-size:15px; margin-bottom:10px; margin-top:10px;
				white-space: pre-wrap; word-wrap: break-word;"><span><%= cvo.getContent() %></span></p>
			</div>
			<div id="updatecom<%=cvo.getCid()%>" style="display:none;">
				<form method="post" action="/mstock/comment">
					<input type="hidden" name="action" value="update">
					<input type="hidden" id="bid" name="bid" value='<%=one.getBid()%>'>
					<input type="hidden" id="cid" name="cid" value='<%=cvo.getCid()%>'>
					<input type="hidden" id="writer" name="writer" value='<%= uid %>'>
					
					<div class="form-group">
					    <input type="text" class="form-control" name="content" id="content" style="display: inline; width:83%; outline: 0; border:1px solid #ccc;" value=<%= cvo.getContent() %>>
					    <input type="button" class="btn btn-secondary" style="float: right; width:7%; height:35px;"  
						name="button" value="취소" onclick="updatecancle('<%= cvo.getCid() %>')">
						<input type="submit" class="btn btn-primary" style="float: right; width:7%; height:35px; margin-right:10px;"  
						name="submit" value="수정">
				  	</div>
								
				</form>
			</div>
			<hr>
			<%
		    	}
			%>
		<%
			}
		%>
	</div>
	
	<!-- 댓글 입력 창 -->
	<div style="margin-bottom:20px;">
		<form method="post" action="/mstock/comment" style="border-top:1px;">
			<input type="hidden" name="action" value="insert">
			<input type="hidden" id="bid" name="bid"  value='<%=one.getBid()%>'>
			<input type="hidden" id="writer" name="writer" value='<%= uid %>'>
			<div class="form-group">
			    <input type="text" class="form-control" name="content" id="content" style="display: inline; width:83%; outline: 0; border:1px solid #ccc;" placeholder="댓글을 입력해주세요">
			    <input type="submit" class="btn btn-primary" style="float: right; width:15%; height:35px;"  
				name="submit" value="등록">
		  	</div>

		</form>
	</div>
		
	
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
