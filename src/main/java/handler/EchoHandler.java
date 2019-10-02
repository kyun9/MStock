package handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import vo.UserVO;

public class EchoHandler extends TextWebSocketHandler {
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	Map<String, WebSocketSession> userSessions = new HashMap<String, WebSocketSession>();

	// 클라이언트와 연결 이후에 실행되는 메서드
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessionList.add(session);
		String senderNickName = getNickName(session);
		System.out.println(senderNickName);
		userSessions.put(senderNickName, session);
		System.out.println("{} 연결됨" + senderNickName);
	}

	// 클라이언트가 서버로 메시지를 전송했을 때 실행되는 메서드
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String senderNickName = getNickName(session);
		System.out.println(("{}로 부터 {} 받음 " + senderNickName + message.getPayload()));
		for (WebSocketSession sess : sessionList) {
			sess.sendMessage(new TextMessage(senderNickName + " : " + message.getPayload()));
		}
	}

	private String getNickName(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		UserVO loginUser = (UserVO) httpSession.get("user");
		if (loginUser.getNickname() == null) {
			return "비회원"+session.getId();
		} else {
			return loginUser.getNickname();
		}
	}

	// 클라이언트와 연결을 끊었을 때 실행되는 메소드
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		String senderNickName = getNickName(session);
		sessionList.remove(session);
		userSessions.remove(senderNickName);
		System.out.println(("{} 연결 끊김" + senderNickName));
	}
}