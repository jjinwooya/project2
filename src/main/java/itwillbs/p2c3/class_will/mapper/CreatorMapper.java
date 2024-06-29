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
	
	// 클래스 상세정보
	Map<String, Object> getClassDetail(int class_code);
	
	// 커리큘럼 등록
	void creatorCurriInsert(@Param("params") List<CurriVO> params);
	
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
	
	List<Map<String, String>> getHide();
	
	// 클래스 정보 가져오기
	List<Map<String, Object>> getClassInfo(MemberVO member);

	// 등록완료된 클래스 정보 가져오기
	List<Map<String, Object>> getCertifiedClassInfo(MemberVO member);

	// 문의사항 클래스 정보 가져오기
	List<Map<String, Object>> getinquiryClassInfo(MemberVO member);
	
	// 상태에 따른 클래스 리스트
	List<Map<String, Object>> getClassStatusInfo(@Param("status") int status,@Param("member") MemberVO member);
	
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
