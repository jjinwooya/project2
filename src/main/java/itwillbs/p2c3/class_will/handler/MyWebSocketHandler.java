<<<<<<< HEAD
package itwillbs.p2c3.class_will.handler;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;

import itwillbs.p2c3.class_will.service.ChatService;
import itwillbs.p2c3.class_will.service.MemberService;
import itwillbs.p2c3.class_will.vo.ChatMessageVO;
import itwillbs.p2c3.class_will.vo.ChatRoomVO;
import itwillbs.p2c3.class_will.vo.MemberVO;

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
   // --------------------------------------------------------------------------------------
   @Autowired
   private MemberService memberService;
   
   @Autowired
   private ChatService chatService;
   // --------------------------------------------------------------------------------------
   @Override
   public void afterConnectionEstablished(WebSocketSession session) throws Exception {
      // 최조로 웹소켓 연결 시 WebSocket 객체가 생성되며, 이 때 자동으로 호출되는 메서드
      System.out.println("웹소켓 연결됨(afterConnectionEstablished)");
      
      // Map 객체(users)에 클라이언트 정보 저장
      users.put(session.getId(), session);
      System.out.println("클라이언트 목록(" + users.keySet().size() + "명) : " + users);
      
      // HttpSession 객체의 정보 확인을 위해 WebSocketSession 객체의 getAttributes() 메서드 호출
      System.out.println("세션(HttpSession) 아이디 : " + session.getAttributes().get("sId"));
      
      // Map 객체(userSession)에 사용자 정보 저장
      userSessions.put(session.getAttributes().get("sId").toString(), session.getId());
      System.out.println("사용자 목록(" + userSessions.keySet().size() + "명) : " + userSessions);
      
   }
   
   @Override
   protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
      System.out.println("수신된 메세지 : " + message.getPayload());
      
      // 수신된 메세지 변환
      ChatMessageVO chatMessage = gson.fromJson(message.getPayload(), ChatMessageVO.class);
      System.out.println("chatMessage : " + chatMessage);
      System.out.println("메세지 수신 시각 : " + getLocalDateTimeForNow());
      // ---------------------------------------------------------------------------------
      String sender_email = session.getAttributes().get("sId").toString();
      String receiver_email = chatMessage.getReceiver_email();
      System.out.println("송신자 : " + sender_email + ", 수신자 : " + receiver_email);
      
      // ChatMessage2 객체에 송신자 설정(HttpSession 객체의 세션 아이디 활용)
      chatMessage.setSender_email(sender_email);
      // ---------------------------------------------------------------------------------
      // 수신된 메세지 타입 판별
      if(chatMessage.getType().equals(ChatMessageVO.TYPE_INIT)) { // 채팅 페이지 초기 진입 메세지
         // DB로부터 기존 채팅방 목록(= 자신의 아이디가 포함된 채팅방) 조회 후 목록 전송
         // ChatService - getRoomList() 메서드 호출
         // => 파라미터 : 자신의 아이디(sender_id)   리턴타입 : List<ChatRoom>(roomList)
         List<Map<String, Object>> roomList = chatService.getRoomList(sender_email);
         // 조회 결과를 JSON 형식으로 변환하여 메세지로 설정
         chatMessage.setMessage(gson.toJson(roomList));
         // 메세지 타입을 전체 목록 표시를 위한 SHOW_LIST 로 설정
//         chatMessage.setType(ChatMessage2.TYPE_SHOW_LIST); // INIT 타입 그대로 사용
         // 메세지 전송을 위해 sendMessage() 메서드 호출
         // => 송신자에게 보내기 위해 파라미터 중 isToSender 파라미터 값을 true 로 전달)
         sendMessage(session, chatMessage, true);
      } else if(chatMessage.getType().equals(ChatMessageVO.TYPE_INIT_COMPLETE)) { // 채팅페이지
         // 초기화 완료 메세지에 수신자 포함 여부 판별
         if(!receiver_email.equals("")) {
            System.out.println("수신자 있음!");
            
            // 메세지를 수신할 상대방 확인
            // 1) userSession 객체에 상대방 존재 여부 확인(= 현재 접속 여부 확인)
            //    => Map 객체의 containsKey() 메서드를 통해 HttpSession 아이디(키) 탐색
            boolean isConnectUser = userSessions.get(receiver_email) == null ? false : true;
            System.out.println("현재 접속 여부 : " + userSessions.get(receiver_email));
            boolean isExistUser = false;
            
            if(!isConnectUser) { // 현재 접속중인 상대방이 아닐 경우
               // MemberService - getMemberId() 메서드 호출하여 DB 에서 상대방 아이디 검색
               // => 파라미터 : 수신자 아이디   리턴타입 : String
               isExistUser = memberService.getMemberEmail(receiver_email) == null ? false : true;
               System.out.println("아이디 DB 존재 여부 : " + isExistUser);
               
               if(!isExistUser) { // DB에도 상대방이 존재하지 않을 경우
                  // 메세지 송신자에게 오류 메세지 전송 후 메서드 종료
                  ChatMessageVO errorMessage = new ChatMessageVO(ChatMessageVO.TYPE_ERROR, sender_email, receiver_email, "", "사용자가 존재하지 않습니다", "" );
                  sendMessage(session, errorMessage, true);
                  return;
               }
            }
            // ---------------------------------------------------------------------------------------------------------------
            // 상대방이 존재할 경우 채팅창 표시(신규 or 기존)
            // 상대방과 기존 채팅 내역 존재 여부 확인
//            if(isConnectUser || !isConnectUser && isExistUser) {} // 사용자 존재할 경우(생략)
            // => 위의 사용자 판별 과정에서 모두 처리 후 오류일 때 return 문 사용했기 때문
            
            ChatRoomVO chatRoom = chatService.getChatRoom(sender_email, receiver_email);
            
            // 기존 채팅방 존재 여부 판별
            if(chatRoom == null) {
               System.out.println("채팅방 없음! - 새로운 채팅방 생성 필요!");
               
               // 1. 새 채팅방의 방번호(room_id) 생성 => UUID 클래스 활용
               chatMessage.setRoom_id(UUID.randomUUID().toString());
               
               // 2. ChatService - addChatRoom() 메서드 호출하여 새 채팅방 정보 DB에 저장
               // => 파라미터 : List<ChatRoom> 타입
               // => 1개 방 정보(룸아이디, 제목, 사용자아이디, 상태)를 갖는 
               //    ChatRoom 객체를 송신자와 수신자 각각 생성하여 List 객체에 추가
               List<ChatRoomVO> chatRoomList = new ArrayList<ChatRoomVO>();
               
               // ChatRoom 객체에 데이터 저장 시 sender_id만 활용하므로 receiver_id는 "" 전달
               chatRoomList.add(new ChatRoomVO(chatMessage.getChat_room_code(), receiver_email + " 님과의 대화", sender_email, "", null));
               chatRoomList.add(new ChatRoomVO(chatMessage.getChat_room_code(), sender_email + " 님과의 대화", receiver_email, "", null));
               chatService.addChatRoom(chatRoomList);
               
               // 채팅 메세지 항목 중 채팅방 제목을 메세지 항목에 설정
               // => 리스트의 0번 인덱스에 저장된 ChatRoom 객체 활용
               chatMessage.setMessage(chatRoomList.get(0).getTitle());
               // 송신자 화면에 새 채팅방 목록 추가를 위한 타입 지정
               chatMessage.setType(ChatMessageVO.TYPE_ADD_LIST);
               // 송신자에게 메세지 전송
               sendMessage(session, chatMessage, true);
               
            } else {
               System.out.println("채팅방 있음! - 새로운 채팅방 생성 불필요!");
               
            }
                  
               
            
         // ---------------------------------------------------------------------------------------------------------------
            
         } else {
            System.out.println("수신자 없음!");
            
         }
         
      }
      
   }
   // ====================================================================================
   // 현재 시스템 시각 정보를 "yyyy-MM-dd hh:mm:ss" 형식의 문자열로 리턴하는 메서드 정의
   private String getLocalDateTimeForNow() {
      DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss");
      return LocalDateTime.now().format(dtf);
   }
   
   // ====================================================================================
   // 각 웹소켓 세션(사용자)들에게 메세지를 전송하는 메서드 정의
   public void sendMessage(
         WebSocketSession session, ChatMessageVO chatMessage, boolean isToSender) throws Exception {
      // 클라이언트 목록이 저장된 Map 객체(users)에 저장되어 있는 모든 세션에게 수신된 메세지 전송
      // => Map 객체의 WebSocketSession 객체를 반복문을 통해 얻기 위해
      //    Map 객체의 values() 메서드 호출하면 Map 객체의 모든 WebSocketSession 객체를 얻을 수 있으며
      //    각각의 WebSocketSession 객체의 sendMessage() 메서드 호출하여 각 세션에 메세지 전송 가능
//         System.out.println(users.values());
      // WebSocketSession 객체의 sendMessage() 메서드를 호출하여 메세지 전송
      if(isToSender) { // 송신자에게 전송하는 메세지
         session.sendMessage(new TextMessage(gson.toJson(chatMessage)));
      } else { // 수신자에게 전송하는 메세지
         for(WebSocketSession ws : users.values()) {
            
         }
      }
   }
   
   // ====================================================================================
   // WebSocketSession 객체에서 HttpSession 객체에 저장된 세션 아이디를 문자열로 리턴하는 메서드 정의
   public String getSessionId(WebSocketSession session) {
      MemberVO member = (MemberVO)session.getAttributes().get("member");
      return member.getMember_email();
   }
   
   @Override
   public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
      System.out.println("웹소켓 연결 해제됨(afterConnectionClosed)");
      
      // 웹소켓 연결 해제 시 호출되는 메서드에서는
      // 클라이언트 정보 저장된 Map 객체(users) 내에서 종료 요청이 발생한 웹소켓 세션 객체 제거
      // => Map 객체의 remove() 메서드 호출하여 전달받은 세션 객체의 세션 아이디를 키로 지정
      users.remove(session.getId());
      System.out.println("클라이언트 목록(" + users.keySet().size() + "명) : " + users);
      
      // 사용자 정보 저장된 Map 객체(userSessions) 내에서 
      // 종료 요청이 발생한 웹소켓의 세션 아이디 제거(HttpSession 의 세션 아이디는 유지)
      userSessions.put(getSessionId(session), "");
      System.out.println("사용자 목록(" + userSessions.keySet().size() + "명) : " + userSessions);
   }
   
   @Override
   public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
      System.out.println("웹소켓 전송 오류 발생(handleTransportError)");
   }
   
}










=======
//package itwillbs.p2c3.class_will.handler;
//
//import java.time.LocalDateTime;
//import java.time.format.DateTimeFormatter;
//import java.util.ArrayList;
//import java.util.List;
//import java.util.Map;
//import java.util.UUID;
//import java.util.concurrent.ConcurrentHashMap;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.web.socket.CloseStatus;
//import org.springframework.web.socket.TextMessage;
//import org.springframework.web.socket.WebSocketSession;
//import org.springframework.web.socket.handler.TextWebSocketHandler;
//
//import com.google.gson.Gson;
//
//import itwillbs.p2c3.class_will.service.ChatService;
//import itwillbs.p2c3.class_will.service.MemberService;
//import itwillbs.p2c3.class_will.vo.ChatMessageVO;
//import itwillbs.p2c3.class_will.vo.ChatRoomVO;
//import itwillbs.p2c3.class_will.vo.MemberVO;
//
//public class MyWebSocketHandler extends TextWebSocketHandler {
//	// 클라이언트 정보 저장을 위한 Map 객체 생성
//	private Map<String, WebSocketSession> users = new ConcurrentHashMap<String, WebSocketSession>();
//	// --------------------------------------------------------------------------------------
//	// 접속한 사용자의 HttpSession 객체의 세션 아이디와 WebSocketSession 아이디를 관리할 객체 생성
//	// 사용자마다 갱신될 가능성이 있는 WebSocketSession 객체를 HttpSession 객체의 sId 에 연결하여
//	// WebSocketSession 객체가 갱신되더라도 갱신된 정보를 세션 아이디를 통해 구별
//	private Map<String, String> userSessions = new ConcurrentHashMap<String, String>();
//	// => userSession 의 key 에 해당하는 value - users 의 key 와 연결됨
//	//    users 의 key 에 해당하는 value 접근 시 해당 사용자의 WebSocketSession 객체에 접근하게됨
//	// --------------------------------------------------------------------------------------
//	private Gson gson = new Gson();
//	// --------------------------------------------------------------------------------------
//	@Autowired
//	private MemberService memberService;
//	
//	@Autowired
//	private ChatService chatService;
//	// --------------------------------------------------------------------------------------
//	@Override
//	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
//		// 최초로 웹소켓 연결 시 WebSocket 객체가 생성되며, 이 때 자동으로 호출되는 메서드
//		System.out.println("웹소켓 연결됨(afterConnectionEstablished)");
//		
//		// Map 객체(users)에 클라이언트 정보 저장
//		users.put(session.getId(), session);
//		System.out.println("클라이언트 목록(" + users.keySet().size() + "명) : " + users);
//		
//		// HttpSession 객체의 정보 확인을 위해 WebSocketSession 객체의 getAttributes() 메서드 호출
//		System.out.println("세션(HttpSession) 아이디 : " + session.getAttributes().get("sId"));
//		
//		MemberVO member = (MemberVO)session.getAttributes().get("member");
//		
//		// Map 객체(userSession)에 사용자 정보 저장
//		userSessions.put(member.getMember_email(), session.getId());
//		System.out.println("사용자 목록(" + userSessions.keySet().size() + "명) : " + userSessions);
//		
//	}
//	
//	@Override
//	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
//		System.out.println("수신된 메세지 : " + message.getPayload());
//		
//		// 수신된 메세지 변환
//		ChatMessageVO chatMessage = gson.fromJson(message.getPayload(), ChatMessageVO.class);
//		System.out.println("chatMessage : " + chatMessage);
//		System.out.println("메세지 수신 시각 : " + getLocalDateTimeForNow());
//		// ---------------------------------------------------------------------------------
//		MemberVO member = (MemberVO)session.getAttributes().get("member");
//		String sender_email = member.getMember_email();
//		String receiver_email = chatMessage.getReceiver_email();
//		System.out.println("송신자 : " + sender_email + ", 수신자 : " + receiver_email);
//		
//		// ChatMessage2 객체에 송신자 설정(HttpSession 객체의 세션 아이디 활용)
//		chatMessage.setSender_email(sender_email);
//		// ---------------------------------------------------------------------------------
//		// 수신된 메세지 타입 판별
//		if(chatMessage.getType().equals(ChatMessageVO.TYPE_INIT)) { // 채팅 페이지 초기 진입 메세지
//			// DB로부터 기존 채팅방 목록(= 자신의 아이디가 포함된 채팅방) 조회 후 목록 전송
//			// ChatService - getRoomList() 메서드 호출
//			// => 파라미터 : 자신의 아이디(sender_id)   리턴타입 : List<ChatRoom>(roomList)
//			List<Map<String, Object>> roomList = chatService.getRoomList(sender_email);
//			// 조회 결과를 JSON 형식으로 변환하여 메세지로 설정
//			chatMessage.setMessage(gson.toJson(roomList));
//			// 메세지 타입을 전체 목록 표시를 위한 SHOW_LIST 로 설정
////			chatMessage.setType(ChatMessage2.TYPE_SHOW_LIST); // INIT 타입 그대로 사용
//			// 메세지 전송을 위해 sendMessage() 메서드 호출
//			// => 송신자에게 보내기 위해 파라미터 중 isToSender 파라미터 값을 true 로 전달)
//			sendMessage(session, chatMessage, true);
//		} else if(chatMessage.getType().equals(ChatMessageVO.TYPE_INIT_COMPLETE)) { // 채팅페이지
//			// 초기화 완료 메세지에 수신자 포함 여부 판별
//			if(!receiver_email.equals("")) {
//				System.out.println("수신자 있음!");
//				
//				// 메세지를 수신할 상대방 확인
//				// 1) userSession 객체에 상대방 존재 여부 확인(= 현재 접속 여부 확인)
//				//    => Map 객체의 containsKey() 메서드를 통해 HttpSession 아이디(키) 탐색
//				boolean isConnectUser = userSessions.get(receiver_email) == null ? false : true;
//				System.out.println("현재 접속 여부 : " + userSessions.get(receiver_email));
//				boolean isExistUser = false;
//				
//				if(!isConnectUser) { // 현재 접속중인 상대방이 아닐 경우
//					// MemberService - getMemberId() 메서드 호출하여 DB 에서 상대방 아이디 검색
//					// => 파라미터 : 수신자 아이디   리턴타입 : String
//					isExistUser = memberService.getMemberEmail(receiver_email) == null ? false : true;
//					System.out.println("아이디 DB 존재 여부 : " + isExistUser);
//					
//					if(!isExistUser) { // DB에도 상대방이 존재하지 않을 경우
//						// 메세지 송신자에게 오류 메세지 전송 후 메서드 종료
//						ChatMessageVO errorMessage = new ChatMessageVO(ChatMessageVO.TYPE_ERROR, sender_email, receiver_email, "", "사용자가 존재하지 않습니다", "" );
//						sendMessage(session, errorMessage, true);
//						return;
//					}
//				}
//				// ---------------------------------------------------------------------------------------------------------------
//				// 상대방이 존재할 경우 채팅창 표시(신규 or 기존)
//				// 상대방과 기존 채팅 내역 존재 여부 확인
////				if(isConnectUser || !isConnectUser && isExistUser) {} // 사용자 존재할 경우(생략)
//				// => 위의 사용자 판별 과정에서 모두 처리 후 오류일 때 return 문 사용했기 때문
//				
//				ChatRoomVO chatRoom = chatService.getChatRoom(sender_email, receiver_email);
//				
//				// 기존 채팅방 존재 여부 판별
//				if(chatRoom == null) {
//					System.out.println("채팅방 없음! - 새로운 채팅방 생성 필요!");
//					
//					// 1. 새 채팅방의 방번호(room_id) 생성 => UUID 클래스 활용
//					chatMessage.setRoom_id(UUID.randomUUID().toString());
//					
//					// 2. ChatService - addChatRoom() 메서드 호출하여 새 채팅방 정보 DB에 저장
//					// => 파라미터 : List<ChatRoom> 타입
//					// => 1개 방 정보(룸아이디, 제목, 사용자아이디, 상태)를 갖는 
//					//    ChatRoom 객체를 송신자와 수신자 각각 생성하여 List 객체에 추가
//					List<ChatRoomVO> chatRoomList = new ArrayList<ChatRoomVO>();
//					
//					// ChatRoom 객체에 데이터 저장 시 sender_id만 활용하므로 receiver_id는 "" 전달
//					chatRoomList.add(new ChatRoomVO(chatMessage.getChat_room_code(), receiver_email + " 님과의 대화", sender_email, "", null));
//					chatRoomList.add(new ChatRoomVO(chatMessage.getChat_room_code(), sender_email + " 님과의 대화", receiver_email, "", null));
//					chatService.addChatRoom(chatRoomList);
//					
//					// 채팅 메세지 항목 중 채팅방 제목을 메세지 항목에 설정
//					// => 리스트의 0번 인덱스에 저장된 ChatRoom 객체 활용
//					chatMessage.setMessage(chatRoomList.get(0).getTitle());
//					// 송신자 화면에 새 채팅방 목록 추가를 위한 타입 지정
//					chatMessage.setType(ChatMessageVO.TYPE_ADD_LIST);
//					// 송신자에게 메세지 전송
//					sendMessage(session, chatMessage, true);
//					
//				} else {
//					System.out.println("채팅방 있음! - 새로운 채팅방 생성 불필요!");
//					
//				}
//						
//					
//				
//			// ---------------------------------------------------------------------------------------------------------------
//				
//			} else {
//				System.out.println("수신자 없음!");
//				
//			}
//			
//		}
//		
//	}
//	// ====================================================================================
//	// 현재 시스템 시각 정보를 "yyyy-MM-dd hh:mm:ss" 형식의 문자열로 리턴하는 메서드 정의
//	private String getLocalDateTimeForNow() {
//		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss");
//		return LocalDateTime.now().format(dtf);
//	}
//	
//	// ====================================================================================
//	// 각 웹소켓 세션(사용자)들에게 메세지를 전송하는 메서드 정의
//	public void sendMessage(
//			WebSocketSession session, ChatMessageVO chatMessage, boolean isToSender) throws Exception {
//		// 클라이언트 목록이 저장된 Map 객체(users)에 저장되어 있는 모든 세션에게 수신된 메세지 전송
//		// => Map 객체의 WebSocketSession 객체를 반복문을 통해 얻기 위해
//		//    Map 객체의 values() 메서드 호출하면 Map 객체의 모든 WebSocketSession 객체를 얻을 수 있으며
//		//    각각의 WebSocketSession 객체의 sendMessage() 메서드 호출하여 각 세션에 메세지 전송 가능
////			System.out.println(users.values());
//		// WebSocketSession 객체의 sendMessage() 메서드를 호출하여 메세지 전송
//		if(isToSender) { // 송신자에게 전송하는 메세지
//			session.sendMessage(new TextMessage(gson.toJson(chatMessage)));
//		} else { // 수신자에게 전송하는 메세지
//			for(WebSocketSession ws : users.values()) {
//				
//			}
//		}
//	}
//	
//	// ====================================================================================
//	// WebSocketSession 객체에서 HttpSession 객체에 저장된 세션 아이디를 문자열로 리턴하는 메서드 정의
//	public String getSessionId(WebSocketSession session) {
//		MemberVO member = (MemberVO)session.getAttributes().get("member");
//		return member.getMember_email();
//	}
//	
//	@Override
//	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
//		System.out.println("웹소켓 연결 해제됨(afterConnectionClosed)");
//		
//		// 웹소켓 연결 해제 시 호출되는 메서드에서는
//		// 클라이언트 정보 저장된 Map 객체(users) 내에서 종료 요청이 발생한 웹소켓 세션 객체 제거
//		// => Map 객체의 remove() 메서드 호출하여 전달받은 세션 객체의 세션 아이디를 키로 지정
//		users.remove(session.getId());
//		System.out.println("클라이언트 목록(" + users.keySet().size() + "명) : " + users);
//		
//		// 사용자 정보 저장된 Map 객체(userSessions) 내에서 
//		// 종료 요청이 발생한 웹소켓의 세션 아이디 제거(HttpSession 의 세션 아이디는 유지)
//		userSessions.put(getSessionId(session), "");
//		System.out.println("사용자 목록(" + userSessions.keySet().size() + "명) : " + userSessions);
//	}
//	
//	@Override
//	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
//		System.out.println("웹소켓 전송 오류 발생(handleTransportError)");
//	}
//	
//}
//
//
//
//
//
//
//
//
//
//
>>>>>>> branch 'main' of https://github.com/hawt34/class3_project_T2_2.git
