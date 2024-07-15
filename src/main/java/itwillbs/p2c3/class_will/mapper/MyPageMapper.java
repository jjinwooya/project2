package itwillbs.p2c3.class_will.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import itwillbs.p2c3.class_will.vo.MemberVO;

@Mapper
public interface MyPageMapper {

	int updateMemberImg(MemberVO member);

	List<Map<String, String>> selectMemberReview(@Param("member_code")int member_code, @Param("startRow2")int startRow2 , @Param("listLimit2")int listLimit2);

	Map<String, String> selectReviewByCode(String reviewCode);

	int updateReview(Map<String, String> formData);

	int deleteReview(String class_review_code);

	int updateMember(MemberVO member);

	int countNickname(String member_nickname);

	void updateMemberNormal(String member_Code);

	MemberVO selectMember(int member_code);

	List<Map<String, String>> selectLike(@Param("member_code")int member_code, @Param("startRow")int startRow, @Param("listLimit")int listLimit);
	

	List<Map<String, String>> selectPossibleReview(@Param("member_code")int member_code,@Param("startRow")int startRow,  @Param("listLimit")int listLimit);

	int insertReview(Map<String, String> formData);

	int MemberWithdraw(MemberVO member);

	List<Map<String, String>> selectMemberMaster(int member_code2);

	int countLikes(int member_code);

	int countPoss(int member_code);

	int countReview(int member_code);

	Map<String, String> calDate(int member_code2);

	Map<String, String> countMoney(int member_code2);

	List<Map<String, String>> findMoney(@Param("year")String year,@Param("month") String month,@Param("member_code")String member_code);

	int countInquiry(int member_code);

	List<Map<String, String>> selectMemberInquiry(@Param("member_code")int member_code,@Param("startRow")int startRow,  @Param("listLimit")int listLimit);

	int deleteInquiry(String class_inquiry_code);

	Map<String, String> selectInquiry(String class_inquiry_code);

	int updateInquiry(Map<String, String> formData);
	
	

	void deleteMemberCode(int member_code);

	void deleteMemberCode2(int member_code);
	
}
