package itwillbs.p2c3.class_will.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import itwillbs.p2c3.class_will.vo.ClassTimeVO;
import itwillbs.p2c3.class_will.vo.CurriVO;
import itwillbs.p2c3.class_will.vo.MemberVO;

@Mapper
public interface CreatorMapper {
	
	// 크리에이터 자격 부여
	void updateMemberType(MemberVO member);

	// 클래스 등록
	void createrClassRegPro(Map<String, Object> map);

	// 클래스 삭제
	void createrClassDelete(Map<String, Object> map);
	
	// 클래스 상세정보
	Map<String, Object> getClassDetail(int class_code);
	
	// 커리큘럼 등록
	void creatorCurriInsert(@Param("params") List<CurriVO> params);

	// 커리큘럼 삭제
	void creatorCurriDelete(int class_code);

	// 커리큘럼 등록
	void creatorCurriUpdate(@Param("params") List<CurriVO> params, @Param("class_code") int class_code);

	
	// 클래스일정 등록
	int insertClassPlan(@Param("map") Map<String, Object> map
				 	  , @Param("classTimeList") List<ClassTimeVO> classTimeList);
	
	// 클래스 일정 가져오기
	List<Map<String, Object>> getSchedule(int classCode);

	// 클래스 종료된 일정 가져오기
	List<Map<String, Object>> getEndedSchedule(int classCode);
	
	// 클래스 일정에 참여자 있는지 확인
	Map<String, Object> checkSchedule(int classScheduleCode);

	// 클래스의 모든 일정에 참여자 있는지 확인
	Map<String, Object> checkAllSchedule(int classCode);

	// 클래스 일정 삭제
	int deleteSchedule(int classScheduleCode);

	// 클래스 전체 일정 삭제
	int deleteAllSchedule(int classCode);
	
	// 카테고리 대분류
	List<Map<String, String>> getCategory();
	
	// 카테고리 상세
	List<Map<String, Object>> getCategoryDetail(String big_category);

	// 해쉬태그
	List<Map<String, String>> getHashtag();

	// 등록상태
	List<Map<String, String>> getStatusList();
	
	// 숨김여부
	List<Map<String, String>> getHide();
	
	// 클래스 정보 가져오기
	List<Map<String, Object>> getClassInfo(MemberVO member);

	// 등록완료된 클래스 정보 가져오기
	List<Map<String, Object>> getCertifiedClassInfo(MemberVO member);

	// 상태에 따른 클래스 리스트
	List<Map<String, Object>> getClassStatusInfo(@Param("status") int status,@Param("member") MemberVO member);
	
	// 클래스 이미지 파일 삭제
	int removeClassFile(Map<String, Object> map);
	
	//=====================================================================================================
	
	// 전체 후기 정보 가져오기
	List<Map<String, Object>> getReviewInfo(MemberVO member);
	
	// 후기에 따른 클래스 정보
	List<Map<String, Object>> getClassByReview(MemberVO member);
	
	// 클래스에 따른 후기
	List<Map<String, Object>> getReviewByClass(@Param("classCode") int classCode, @Param("member_code") int member_code);
	
	// 타입에 따른 후기
	List<Map<String, Object>> getReviewByType(@Param("classCode") int classCode, @Param("type") String type, @Param("member_code") int member_code);
	
	// 리뷰코드에 따른 리뷰
	Map<String, Object> getReviewByReviewCode(int review_code);

	// 리뷰코드에 따른 답변
	Map<String, Object> getReplyByReviewCode(int review_code);
	
	// 리뷰status 변환
	void changeReviewStatus(int reviewCode);
	
	// 리뷰답변 저장
	void insertReviewReply(@Param("reviewCode") int reviewCode
						 , @Param("reviewReply") String reviewReply);

	// 리뷰답변 수정
	void updateReviewReply(@Param("reviewCode") int reviewCode
						 , @Param("reviewReply") String reviewReply);

	// 리뷰답변 삭제
	void deleteReviewReply(@Param("reviewCode") int reviewCode);

	//=====================================================================================================
	
	// 문의사항 클래스 정보 가져오기
	List<Map<String, Object>> getInquiryClassInfo(MemberVO member);
	
	// 문의에 따른 클래스 정보
	List<Map<String, Object>> getClassByInquiry(MemberVO member);
	
	// 클래스에 따른 문의
	List<Map<String, Object>> getInquiryByClass(@Param("classCode") int classCode, @Param("member_code") int member_code);
	
	// 타입에 따른 문의
	List<Map<String, Object>> getInquiryByType(@Param("classCode") int classCode, @Param("type") String type, @Param("member_code") int member_code);
	
	// 문의코드에 따른 리뷰
	Map<String, Object> getInquiryByInquiryCode(int inquiry_code);

	// 문의코드에 따른 답변
	Map<String, Object> getReplyByInquiryCode(int inquiry_code);
	
	// 문의status 변환
	void changeInquiryStatus(int inquiryCode);
	
	// 문의답변 저장
	void insertInquiryReply(@Param("inquiryCode") int inquiryCode
						 , @Param("inquiryReply") String inquiryReply);

	// 문의답변 수정
	void updateInquiryReply(@Param("inquiryCode") int inquiryCode
						 , @Param("inquiryReply") String inquiryReply);

	// 문의답변 삭제
	void deleteInquiryReply(@Param("inquiryCode") int inquiryCode);

	
	//=====================================================================================================
	
	// 분석 클래스정보 가져오기
	List<Map<String, Object>> getAnalyzeClassInfo(MemberVO member);
	
	// 분석결과 가져오기
	Map<String, Object> getAnalyzeList(MemberVO member);

	// 리뷰분석결과 가져오기
	Map<String, Object> getAnalyzeReviewList(MemberVO member);
	
	// 전체 값에 대한 그래프 데이터
	List<Map<String, Object>> getGraphDataList(MemberVO member);
	
	
	//=====================================================================================================

	// 누적 정산금 가져오기
	Map<String, String> getSumSettlement(@Param("member")MemberVO member, @Param("settlementDate") String settlementDate);
	
	// 정산 날짜 가져오기
	String getsettlementDate(MemberVO member);
	
	// 한달 정산금 가져오기
	Map<String, Object> getMonthSettlement(@Param("monthPicker") String monthPicker, @Param("member") MemberVO member);

	// settlement 데이터 확인
	String checkSettlement(MemberVO member);
	
	// settlement 데이터 삽입
	void insertSettlement (@Param("member")MemberVO member, @Param("total_sum")int total_sum);

	// settlement 데이터 업데이트
	void updateSettlement (@Param("member")MemberVO member, @Param("total_sum")int total_sum);
	
}
