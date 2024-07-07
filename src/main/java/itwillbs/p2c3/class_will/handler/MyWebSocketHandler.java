package itwillbs.p2c3.class_will.handler;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;

import itwillbs.p2c3.class_will.vo.ChatMessageVO;

public class MyWebSocketHandler extends TextWebSocketHandler {
	
	// 클라이언트 정보 저장을 위한 Map 객체 생성
	private Map<String, WebSocketSession> users = new ConcurrentHashMap<String, WebSocketSession>();
	// --------------------------------------------------------------------------------------
	// 접속한 사용자의 HttpSession 객체의 세션 아이디와 WebSocketSession 아이디를 관리할 객체 생성
	// 사용자마다 갱신될 가능성이 있는 WebSocketSession 객체를 HttpSession 객체의 sId 에 연결하여
	// WebSocketSession 객체가 갱신되더라도 갱신된 정보를 세션 아이디를 통해 구별
	private Map<String, String> userSessions = new ConcurrentHashMap<String, String>();
	// => userSession 의 key 에 해당하는 value - users 의 key 와 연결됨
	//    users 의 key 에 해당하는 value 접근 시 해당 사용자의 WebSocketSession 객체에 접근하게됨
	// --------------------------------------------------------------------------------------
	private Gson gson = new Gson();
	
	
	// ====================================================================================
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// 최초로 웹소켓 연결 시 WebSocket 객체가 생성되며, 이 때 자동으로 호출되는 메서드
		System.out.println("++++++++++++++++웹소켓 연결됨(afterConnectionEstablished)");
		
		// Map 객체(users)에 클라이언트 정보 저장
		users.put(session.getId(), session);
		System.out.println("클라이언트 목록(" + users.keySet().size() + "명) : " + users);
		
		// HttpSession 객체의 정보 확인을 위해 WebSocketSession 객체의 getAttributes() 메서드 호출
		System.out.println("세션(HttpSession) 아이디 : " + session.getAttributes().get("sId"));
		
		// Map 객체(userSession)에 사용자 정보 저장
		userSessions.put(session.getAttributes().get("sId").toString(), session.getId());
		System.out.println("사용자 목록(" + userSessions.keySet().size() + "명) : " + userSessions);

	}
	
	// ====================================================================================
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("메세지 수신됨(handleTextMessage)");
		
		System.out.println("수신된 메세지 : " + message.getPayload());

	}
	
	// ====================================================================================
	// 각 웹소켓 세션(사용자)들에게 메세지를 전송하는 메서드 정의
	public void sendMessage(WebSocketSession session, ChatMessageVO chatMessage) {
		// 클라이언트 목록이 저장된 Map 객체(users)에 저장되어 있는 모든 세션에게 수신된 메세지 전송
		// => Map 객체의 WebSocketSession 객체를 반복문을 통해 얻기 위해
		//    Map 객체의 values() 메서드 호출하면 Map 객체의 모든 WebSocketSession 객체를 얻을 수 있으며
		//    각각의 WebSocketSession 객체의 sendMessage() 메서드 호출하여 각 세션에 메세지 전송 가능
//		System.out.println(users.values());
		for(WebSocketSession ws : users.values()) {
			// WebSocketSession 객체의 sendMessage() 메서드를 호출하여 메세지 전송
			// 단, 클라이언트 목록의 세션 아이디와 메세지 송신한 세션 아이디가 다를 경우에만 전송
			if(!ws.getId().equals(session.getId())) {
//				ws.sendMessage(new TextMessage(message.getPayload()));
				
				// 메세지 타입 판별하여 "ENTER, "LEAVE" 일 경우 메세지 설정
				if(chatMessage.getType().equals(ChatMessageVO.TYPE_ENTER)) {
					// "[아이디]님이 입장하셨습니다." 를 메세지로 설정 => ChatMessageVO 객체에 저장
					chatMessage.setMsg(">> " + chatMessage.getSender_id() + " 님이 입장하셨습니다 <<");
				} else if(chatMessage.getType().equals(ChatMessageVO.TYPE_LEAVE)) {
					// "[아이디]님이 퇴장하셨습니다." 를 메세지로 설정 => ChatMessageVO 객체에 저장
					chatMessage.setMsg(">> " + chatMessage.getSender_id() + " 님이 퇴장하셨습니다 <<");
				}
				
				// WebSocketSession 객체의 send() 메서드 호출하여 메세지 전송
				// => ChatMessageVO 객체를 JSON 문자열 형식으로 변환 후 전송
				//    (Gson 객체의 toJson() 메서드 활용)
				try {
					ws.sendMessage(new TextMessage(gson.toJson(chatMessage)));
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	// ====================================================================================
	// WebSocketSession 객체에서 HttpSession 객체에 저장된 세션 아이디를 문자열로 리턴하는 메서드 정의
	public String getSessionId(WebSocketSession session) {
		return session.getAttributes().get("sId").toString();
	}
	
	// ====================================================================================
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("-------------------웹소켓 연결 해제됨(afterConnectionClosed)");
		
		// 웹소켓 연결 해제 시 호출되는 메서드에서는
		// 클라이언트 정보 저장된 Map 객체(users) 내에서 종료 요청이 발생한 웹소켓 세션 객체 제거
		// => Map 객체의 remove() 메서드 호출하여 전달받은 세션 객체의 세션 아이디를 키로 지정
		users.remove(session.getId());
		System.out.println("클라이언트 목록(" + users.keySet().size() + "명) : " + users);
		
		
		userSessions.put(getSessionId(session), "");
		System.out.println("사용자 목록(" + userSessions.keySet().size() + "명) : " + userSessions);
		
//		System.out.println("퇴장 회원 아이디 : " + session.getAttributes().get("sId"));
//		System.out.println("퇴장 사유 : " + status.getReason() + ", " + status.getCode());
		
		// ChatMessageVO 객체를 생성하여 회원의 퇴장 정보 설정하기
		// => ChatMessageVO 객체의 type 은 LEAVE, sender_id 는 세션 아이디로 설정
		ChatMessageVO chatMessage = new ChatMessageVO();
		chatMessage.setType(ChatMessageVO.TYPE_LEAVE); // 퇴장 정보 설정
		chatMessage.setSender_id(getSessionId(session));
		
		// sendMessage() 메서드 호출하여 퇴장 정보 전송
		sendMessage(session, chatMessage);
	}

	// ====================================================================================
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		System.out.println("웹소켓 전송 오류 발생(handleTransportError)");
	}
	
	
	
	
}
