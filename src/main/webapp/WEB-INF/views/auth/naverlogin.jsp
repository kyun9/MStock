<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.security.SecureRandom"%>
<%@ page import="java.math.BigInteger"%>
<%@ page import="java.util.Properties"%>
<%@ page import="java.io.InputStream"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-2.1.3.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		Properties properties = new Properties();
		String path = "/config/config.properties";
		
		InputStream inputStream = getClass().getClassLoader().getResourceAsStream(path);
		properties.load(inputStream);
		
		String clientId = properties.getProperty("naver.client_id");//애플리케이션 클라이언트 아이디값";
		String callbackURL = properties.getProperty("naver.callback_url"); //애플리케이션 콜백 URL;
		
		String redirectURI = URLEncoder.encode(callbackURL, "UTF-8");
		SecureRandom random = new SecureRandom();
		String state = new BigInteger(130, random).toString();
		String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
		apiURL += "&client_id=" + clientId;
		apiURL += "&redirect_uri=" + redirectURI;
		apiURL += "&state=" + state;
		session.setAttribute("state", state);
		//System.out.println(apiURL);
	%> 
	<script>
	$(function(){
		location.href = "<%=apiURL%>";
	});
	</script>
</body>
</html>