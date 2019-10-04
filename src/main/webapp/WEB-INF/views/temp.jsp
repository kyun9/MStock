<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Hi</h1>
	<!-- 감정분석 JSON 읽기 -->
	<script src="http://code.jquery.com/jquery-2.1.3.min.js"></script>
	<script>
		var jsonLocation = '/mstock/resources/rdata/json/emotion000660.json';
		$.getJSON(jsonLocation, function(data) {
			$.each(data, function(n, arr) {
				//alert(name);
				$.each(arr, function(m, company){
					console.log(company.code);
					console.log(company.pos);
					console.log(company.neg);
				});
			});
		});
	</script>
</body>
</html>