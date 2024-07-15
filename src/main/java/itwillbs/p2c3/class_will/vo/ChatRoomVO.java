package itwillbs.p2c3.class_will.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChatRoomVO {
	
	private int chat_room_code;
	private String member_email1;
	private String member_email2;
	private String status;
}
