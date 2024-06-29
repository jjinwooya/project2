package itwillbs.p2c3.class_will.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import itwillbs.p2c3.class_will.vo.MemberVO;

@Mapper
public interface MemberMapper {
	
	// 회원가입
	int insertMember(MemberVO member);
	
	
	// 로그인
	MemberVO selectMember(MemberVO member);

	// 비밀번호 변경
	boolean updatePassword(MemberVO member);

	// 휴면 해제하기
	boolean updateMemberStatus(MemberVO member);

	// 
	Map<String, String> selectBankInfo(int member_code);


	
	
	
	
}
