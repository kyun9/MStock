package service;

import java.io.*;
import java.net.*;

import org.json.simple.*;
import org.springframework.stereotype.*;

import vo.*;

@Service
public class NaverLoginService {

	public UserVO getProfile(String access_token) {
		String token = access_token;// 네이버 로그인 접근 토큰;
		String header = "Bearer " + token; // Bearer 다음에 공백 추가
		try {
			String apiURL = "https://openapi.naver.com/v1/nid/me";
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("Authorization", header);
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if (responseCode == 200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // 에러 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer response = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				response.append(inputLine);
			}
			br.close();
			
			//Json parse
			UserVO vo = new UserVO();
			
			Object obj = JSONValue.parse(response.toString());
			JSONObject jsonObj = (JSONObject)obj;
			String message = (String)jsonObj.get("message");
			if(message.equals("success")) {
				System.out.println("success naver login");
				JSONObject jsonObjRes = (JSONObject)jsonObj.get("response");
				vo.setId(jsonObjRes.get("id").toString());
				vo.setNickname(jsonObjRes.get("nickname").toString());
				vo.setEmail(jsonObjRes.get("email").toString());
				vo.setPassword(jsonObjRes.get("id").toString());
				return vo;
			} else {
				System.out.println("fail naver login");
			}
			
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	

}
