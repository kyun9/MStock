<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-2.1.3.min.js"></script>
<script src = "/mstock/resources/js/chatting.js"></script>
<title>웹 소켓 통신</title>
</head>
<body>
	<div>
		<input type="text" id="messageinput">
	</div>

	<div>
		<button onclick="openSocket();">Open</button>
		<button onclick="send();">Send</button>
		<button onclick="closeSocket();">close</button>
	</div>

	<div id="message"></div>
</body>
</html>
