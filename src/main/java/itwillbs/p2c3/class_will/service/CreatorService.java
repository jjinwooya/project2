package itwillbs.p2c3.class_will.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;

import itwillbs.p2c3.class_will.mapper.CreatorMapper;
import itwillbs.p2c3.class_will.vo.ClassTimeVO;
import itwillbs.p2c3.class_will.vo.CurriVO;
import itwillbs.p2c3.class_will.vo.MemberVO;

@Service
public class CreatorService {
	@Autowired
	private CreatorMapper creatorMapper;
	
	// 크리에이터 자격부여
	public void updateMemberType(MemberVO member) {
		creatorMapper.updateMemberType(member);
	}

	// 클래스 등록
	public void createrClassRegPro(Map<String, Object> map, List<CurriVO> params) {
		creatorMapper.createrClassRegPro(map);
		System.out.println(">>>>>>>>params: " + params);
		creatorMapper.creatorCurriInsert(params);
	}
	
	// 클래스 상세
	public Map<String, Object> getClassDetail(int class_code) {
		return creatorMapper.getClassDetail(class_code);
	}
	
	// 클래스 일정 등록
	public int insertClassPlan(Map<String, Object> map, List<ClassTimeVO> classTime) {
		return creatorMapper.insertClassPlan(map, classTime);
	}
	
	// 클래스 일정 가져오기
	public List<Map<String, Object>> getSchedule(int classCode) {
		return creatorMapper.getSchedule(classCode);
	}

	// 클래스 종료된 일정 가져오기
	public List<Map<String, Object>> getEndedSchedule(int classCode) {
		return creatorMapper.getEndedSchedule(classCode);
	}

	// 클래스 일정 삭제
	public int deleteSchedule(int classScheduleCode) {
		if(creatorMapper.checkSchedule(classScheduleCode) == null) { // null이면 삭제 안됨
			return 0;
		} else { // check 해본 값이 null이 아니면 삭제가능
			creatorMapper.deleteSchedule(classScheduleCode);
			return 1;
		}
	}

	// 클래스 일정 전체 삭제
	public int deleteAllSchedule(int classCode) {
		if(creatorMapper.checkAllSchedule(classCode) == null) { // null이면 삭제 안됨
			return 0;
		} else { // check 해본 값이 null이 아니면 삭제가능
			creatorMapper.deleteAllSchedule(classCode);
			return 1;
		}
	}
 
	// 카테고리 대분류 가져오기
	public List<Map<String, String>> getCategory(){
		return creatorMapper.getCategory();
	}
	 
	// 카테고리 상세
	public List<Map<String, Object>> getCategoryDetail(String big_category) {
		return creatorMapper.getCategoryDetail(big_category);
	}
	 
	// 해쉬태그 가져오기 
	public List<Map<String, String>> getHashtag(){
		return creatorMapper.getHashtag();
	}

	// 공개여부 가져오기
	public List<Map<String, String>> getHide(){
		return creatorMapper.getHide();
	}

	// 등록상태 가져오기
	public List<Map<String, String>> getStatusList(){
		return creatorMapper.getStatusList();
	}
	
	// 클래스정보 가져오기
	public List<Map<String, Object>> getClassInfo(MemberVO member){
		return creatorMapper.getClassInfo(member);
	}

	// 상태에 따른 클래스정보 가져오기
	public List<Map<String, Object>> getClassStatusInfo(int status, MemberVO member){
		return creatorMapper.getClassStatusInfo(status, member);
	}

	// 등록완료된 클래스정보 가져오기
	public List<Map<String, Object>> getCertifiedClassInfo(MemberVO member){
		return creatorMapper.getCertifiedClassInfo(member);
	}

	// 문의사항 클래스정보 가져오기
	public List<Map<String, Object>> getinquiryClassInfo(MemberVO member){
		return creatorMapper.getinquiryClassInfo(member);
	}
	
	// 누적 정산금 가져오기
	public Map<String, String> getSumSettlement(MemberVO member, String settlementDate) {
		return creatorMapper.getSumSettlement(member, settlementDate);
	}

	// 한달 정산금 가져오기
	public Map<String, Object> getMonthSettlement(String monthPicker, MemberVO member) {
		return creatorMapper.getMonthSettlement(monthPicker, member);
	}

	// 정산 날짜 가져오기
	public String getsettlementDate(MemberVO member) {
		return creatorMapper.getsettlementDate(member);
	}

	// 정산하기
	public void settlementPro(MemberVO member, int total_sum) {
		String settlementDate = creatorMapper.checkSettlement(member);
		if(!settlementDate.equals("0")) {
			creatorMapper.insertSettlement(member, total_sum);
		} else {
			creatorMapper.updateSettlement(member, total_sum);
		}
	}
	
	
	
	

}
