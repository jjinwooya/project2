package itwillbs.p2c3.class_will.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import itwillbs.p2c3.class_will.vo.MemberVO;

@Mapper
public interface ChatMapper {

	MemberVO selectMemberInfo(int member_code);

	List<Map<String, Object>> selectRoomList(String member_email);



	
	
	
	
	

}
