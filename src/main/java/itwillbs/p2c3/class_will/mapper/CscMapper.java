package itwillbs.p2c3.class_will.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import itwillbs.p2c3.class_will.vo.MemberVO;

@Mapper
public interface CscMapper {
	
	Map<String, String> selectBoardDetail(Map<String, Object> params);
	
	Integer searchPaging(@Param("code") int code,@Param("searchType") String searchType);
	
	List<Map<String, String>> selectBoardCategoryHide(String code);

	int selectBoardCountHide(String type);

	Map<String, String> selectEventDetail(int event_code);

	Map<String, Object> selectInviteFriendInfo(int member_code);

	boolean insertInviteCode(@Param("member_code") int member_code,@Param("invite_code") String invite_code);

	Map<String, Object> selectInviteMail(@Param("invite_code") String invite_code,@Param("friend_email") String friend_email);

	void insertInviteMailInfo(@Param("invite_code") String invite_code,@Param("friend_email") String friend_email);

	void updateInviteMailInfo(@Param("invite_code") String invite_code,@Param("friend_email") String friend_email);

	Map<String, Object> selectInviteFriendInfoByCode(String invite_code);

	void updateFriendCode(@Param("invite_code") String invite_code,@Param("friend_code") int friend_code);

	void updateMemberCredit(int member_code);

	MemberVO selectMemberByCode(MemberVO friend);
	
}
