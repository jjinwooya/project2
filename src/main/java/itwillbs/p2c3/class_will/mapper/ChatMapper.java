package itwillbs.p2c3.class_will.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import itwillbs.p2c3.class_will.vo.ChatMessageVO;
import itwillbs.p2c3.class_will.vo.ChatRoomVO;
import itwillbs.p2c3.class_will.vo.MemberVO;

@Mapper
public interface ChatMapper {

	MemberVO selectMemberInfo(int member_code);

	List<Map<String, Object>> selectRoomList(String member_email);

	void insertChatRoom(ChatRoomVO newChatRoom);

	void insertChatMessage(ChatMessageVO chatMessage);

	String selectMemberEmail(String member_email);

	ChatRoomVO selectChatRoom(@Param("sender_email") String sender_email, @Param("receiver_email") String receiver_email);

	void insertChatRoom(@Param("sender_email") String sender_email, @Param("receiver_email") String receiver_email);



	
	
	
	
	

}
