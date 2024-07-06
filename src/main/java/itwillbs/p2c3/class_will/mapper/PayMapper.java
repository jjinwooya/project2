package itwillbs.p2c3.class_will.mapper;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;

import itwillbs.p2c3.class_will.vo.MemberVO;

@Mapper
public interface PayMapper {
	
	//adminAccessToken 찾기
	Object selectAdminToken();
	
	//adminAccessToken 등록
	void insertAdminToken(Map adminToken);
	
	//adminAccessToken 갱신
	void updateAdminToken(Map adminToken);
	
	//class info 가져오기
	Map<String, Object> selectClassInfo(Map<String, Object> map);
	
	//class schedule 정보 가져오기
	List<Map<String, Object>> selectSchedule(int i);
	
	
	//date로 클래스 스케쥴 타임 가져오기
	List<Map<String, Object>> selectScheduleTime(@Param("date")String date,
												 @Param("class_code")int parsedClass_code);
	
	//고객정보 가져오기
	Map<String, Object> selectMemberInfo(MemberVO member);
	
	//pay관련 모든 정보 가져오기
	Map<String, String> selectPayInfo(Map<String, String> map);
	
	//크레딧 조회
	Map<String, String> selectCredit(Map<String, String> map);
	
	//pay에 저장할 정보 가져오기
	Map<String, Object> selectObjects(Map<String, Object> map);
	
	//성공한 결제 정보 등록
	@Options(useGeneratedKeys = true, keyProperty = "pay_code")
	void registPaySuccessInfo(Map<String, Object> map);
	
	//member table의 member_credit 처리
	void updateCredit(Map<String, Object> map);
	
	//class_schedule 테이블의 class_remain_headcount 처리
	void updateHeadcount(Map<String, Object> map);
	
	//결제에 성공한 paySuccessInfo 가져오기
	Map<String, String> selectSuccessPayInfo(Map<String, String> map);

	//access_token 등록
	void registAccessToken(Map map);

	List<Map<String, Integer>> selectPackageInfoList();
	
	//fintech_use_num 업데이트
	void updateFintechUseNum(Map<String, String> fintech);
	
	//member_credit 업데이트 후 조회
	void updateWillpay(Map<String, Object> map);

	int selectWillpay(Map<String, Object> map);
	
	//환불 금액 결정
	int selectRefundAmt(Map<String, Object> map);
	
	//결제 성공 List 가져오기
	List<Map<String, String>> selectPayInfoList(Map<String, Object> memberCode);
	
	//결제 상태 갱신
	void updatePayStatus(Map<String, Object> map);
	
	//인원수 상태 갱신
	void resetHeadcount(Map<String, Object> map);
	
	//윌페이 충전(출금결제) 성공 등록
	void registWithdrawInfo(Map<String, Object> withdrawParameter);
	
	//윌페이 충전 정보 가져오기
	Map<String, Object> selectWithdrawInfo(BigInteger will_pay_code);
	
	//윌페이 충전 성공한 목록 가져오기
	List<Map<String, Object>> selectWillpayChargeList(int member_code);
	
	//willpay 환불약관 검사
	int selectWillpayDate(Map<String, Object> map);

	void updateWillpayStatus(Map<String, Object> map);
	
	
	

	
}
