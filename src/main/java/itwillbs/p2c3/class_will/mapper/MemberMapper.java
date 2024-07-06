package itwillbs.p2c3.class_will.mapper;

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

	// 로그인 시 뱅크 토큰 조회
	Map<String, String> selectBankInfo(int member_code);

	// 전화번호 인증 시 기존 회원 여부 조회
	String selectMemberTel(String member_tel);


	
	
	
	
}
