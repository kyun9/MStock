package handler;

import java.util.*;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.socket.*;
import org.springframework.web.socket.handler.*;

import vo.*;

class ChatMem{
	String id;
	WebSocketSession session;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public WebSocketSession getSession() {
		return session;
	}
	public void setSession(WebSocketSession session) {
		this.session = session;
	}
}
@SessionAttributes("codeValue")
public class EchoHandler extends TextWebSocketHandler {
	
	private Map<String, List<ChatMem>> EachSessionList = new HashMap<String, List<ChatMem>>();

	// 클라이언트와 연결 이후에 실행되는 메서드
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		Map<String,String> map = getInfo(session);
		ChatMem mem = new ChatMem();
		String code =map.get("code");
		String senderNickName = map.get("id");
		List<ChatMem> MemList = EachSessionList.get(code);
		if(MemList!=null) {
			mem.setId(senderNickName);
			mem.setSession(session);
			MemList.add(mem);
		}
		else {
			MemList = new ArrayList<ChatMem>();
			mem.setId(senderNickName);
			mem.setSession(session);
			MemList.add(mem);
		}
		EachSessionList.put(code, MemList);
		System.out.println(senderNickName);
		System.out.println("{} 연결됨" + senderNickName);
	}

	// 클라이언트가 서버로 메시지를 전송했을 때 실행되는 메서드
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		Map<String,String> map = getInfo(session);
		String code =map.get("code");
		String senderNickName = map.get("id");
		List<ChatMem> MemList = EachSessionList.get(code);
		
		System.out.println(("{}로 부터 {} 받음 " + senderNickName + message.getPayload()));
		for (ChatMem mem : MemList) {
			mem.getSession().sendMessage(new TextMessage(senderNickName + " : " + message.getPayload()));
		}
	}

	private Map<String,String> getInfo(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		UserVO loginUser = (UserVO) httpSession.get("user");
		String code = (String) httpSession.get("codeValue");
		System.out.println("httpSession code " + code);
		Map<String, String> map = new HashMap<>();
		if (loginUser.getNickname() == null) {
			map.put("id", "비회원"+session.getId());
		} else {
			map.put("id", loginUser.getNickname());
		}
		map.put("code", code);
		return map;
	}

	// 클라이언트와 연결을 끊었을 때 실행되는 메소드
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		Map<String,String> map = getInfo(session);
		String code =map.get("code");
		String senderNickName = map.get("id");
		List<ChatMem> MemList = EachSessionList.get(code);
		
		for (ChatMem mem : MemList) {
			if(mem.getId().equals(senderNickName)) {
				MemList.remove(mem);
				break;
			}
		}
		EachSessionList.put(code, MemList);
		System.out.println(("{} 연결 끊김" + senderNickName));
	}
}