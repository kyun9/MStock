<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="vo.UserVO,vo.BoardVO"%>
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
				
							<div>
								<h3 >게시글 작성</h3>
								<hr>
								<form method="post" action="/mstock/board/content/edit">
								<%
									BoardVO one = (BoardVO) request.getAttribute("listone");
									String action= request.getParameter("action");
									if(action.equals("insert")){
								%>
									<input type="hidden" name="action" value="insert">
									<input type="hidden" name="writer" value="<%= request.getAttribute("U_Id")%>">
									
									<div class="form-group row text-center">
									    <label for="title" class="col-sm-2 col-form-label">제목</label>
									    <div class="col-sm-10">
									      <input type="text" id="title" class="form-control" name="title" style="border:1px solid #ccc;" placeholder="제목을 입력하세요">
									    </div>
									 </div>
									 <div class="form-group row text-center">
									    <label for="content" class="col-sm-2 col-form-label">내용</label>
									    <div class="col-sm-10">
									      <textarea class="form-control" id="content" name="content" style="height:400px; border:1px solid #ccc;"></textarea>
									    </div>
									 </div>
									
								<%}else if(action.equals("update")){ %>
								 
									<input type="hidden" name="action" value="update">
									<input type="hidden" name="bid" value="<%= one.getBid() %>">
									<input type="hidden" name="writer" value="<%= request.getAttribute("U_Id")%>">
									
									<div class="form-group row text-center">
									    <label for="title" class="col-sm-2 col-form-label">제목</label>
									    <div class="col-sm-10">
									      <input type="text" class="form-control" id="title" name="title" style="border:1px solid #ccc;" value='<%= one.getTitle() %>'>
									    </div>
									 </div>
									 <div class="form-group row text-center">
									    <label for="content" class="col-sm-2 col-form-label">내용</label>
									    <div class="col-sm-10">
									      <textarea class="form-control" id="content" name="content" style="width:100%;
									       height:400px; border:1px solid #ccc;"><%= one.getContent() %></textarea>
									    </div>
									 </div>
									 
									 <script>
										var content = $("#content").text();
										if(content == 'null'){
											$("#content").text("");
										};
									</script>
									
								<%} %>
								<br>
									<div class="text-center">
										<button type="submit" class="btn btn-primary">저장</button>
										<button type="button" class="btn btn-secondary" onclick="back(); return false;">취소</button>
									</div>			
								</form>
								
							</div>
							
				

	<script>
		function back(){
			location.href="<%=request.getHeader("referer") %>";
		}
	</script>
	
	<script>
    $(document).ready(function(){
        $("#btnSave").click(function(){
            //var title = document.form1.title.value; ==> name속성으로 처리할 경우
            //var content = document.form1.content.value;
            //var writer = document.form1.writer.value;
            var title = $("#title").val();
            var content = $("#content").val();
            var writer = $("#writer").val();
            if(title == ""){
                alert("제목을 입력하세요");
                document.form1.title.focus();
                return;
            }
            if(content == ""){
                alert("내용을 입력하세요");
                document.form1.content.focus();
                return;
            }
            if(writer == ""){
                alert("이름을 입력하세요");
                document.form1.writer.focus();
                return;
            }
            // 폼에 입력한 데이터를 서버로 전송
            document.form1.submit();
        });
    });
</script>


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
</body>
</html>
