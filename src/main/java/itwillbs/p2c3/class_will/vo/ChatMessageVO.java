package itwillbs.p2c3.class_will.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// 웹소켓 채팅 메시지를 자동으로 파싱하기 위한 클래스 정의

@Data
@NoArgsConstructor
@AllArgsConstructor

public class ChatMessageVO {
	
	private String type;
	private int sender_member_code;
	private int receiver_member_code;
	private String chat_room_code;
	private String message;
	private String send_time; // 메세지 전송 시각
	// ----------------------------------------
	private String sender_email;
	private String receiver_email;
	
	// type 변수에 사용될 값을 상수로 생성
	public static final String TYPE_INIT = "INIT"; 
	public static final String TYPE_INIT_COMPLETE = "INIT_COMPLETE"; 
	public static final String TYPE_ADD_LIST = "ADD_LIST"; 
	public static final String TYPE_START = "START";
	public static final String TYPE_ERROR = "ERROR";
	public static final String TYPE_ENTER = "ENTER"; 
	public static final String TYPE_TALK = "TALK"; 
	public static final String TYPE_LEAVE = "LEAVE"; 
	
}
