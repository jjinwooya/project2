package itwillbs.p2c3.class_will.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import itwillbs.p2c3.class_will.mapper.CscMapper;
import itwillbs.p2c3.class_will.vo.MemberVO;

@Service
public class CscService {
	
	@Autowired
	private CscMapper cscMapper;

	public Map<String, String> getBoardDetail(Map<String, Object> params) {
		return cscMapper.selectBoardDetail(params);
	}

	public Integer getPagingNum(int code, String searchType) {
		return cscMapper.searchPaging(code, searchType);
	}

	public List<Map<String, String>> getBoardCategoryHide(String code) {
		return cscMapper.selectBoardCategoryHide(code);
	}

	public int getBoardCountHide(String type) {
		return cscMapper.selectBoardCountHide(type);
	}

	public Map<String, String> getEventDetail(int event_code) {
		return cscMapper.selectEventDetail(event_code);
	}

	public Map<String, Object> getInviteFriendInfo(int member_code) {
		return cscMapper.selectInviteFriendInfo(member_code);
	}

	public boolean insertInviteCode(int member_code, String invite_code) {
		return cscMapper.insertInviteCode(member_code, invite_code);
	}

	public Map<String, Object> getInviteMailInfo(String invite_code, String friend_email) {
		return cscMapper.selectInviteMail(invite_code, friend_email);
	}

	public void insertInviteMailInfo(String invite_code, String friend_email) {
		cscMapper.insertInviteMailInfo(invite_code, friend_email);
	}

	public void updateInviteMailInfo(String invite_code, String friend_email) {
		cscMapper.updateInviteMailInfo(invite_code, friend_email);
	}

	public Map<String, Object> getInviteFriendInfoByCode(String invite_code) {
		return cscMapper.selectInviteFriendInfoByCode(invite_code);
	}


	public void updateFriendCode(String invite_code, int friend_code) {
		cscMapper.updateFriendCode(invite_code, friend_code);
		
	}

	public void updateMemberCredit(int member_code) {
		cscMapper.updateMemberCredit(member_code);
	}

	public MemberVO selectMemberByCode(MemberVO friend) {
		return cscMapper.selectMemberByCode(friend);
	}

	public void updatePointMember(int event_point, int member_code) {
		cscMapper.updatePointMember(event_point, member_code);
	}

	public boolean getEventLogs(int event_code, int member_code) {
		return cscMapper.selectEventLogs(event_code, member_code) > 0 ? false : true;
	}

	public void insertEventLogs(int event_code, int member_code) {
		cscMapper.insertEventLogs(event_code, member_code);
	}

}
