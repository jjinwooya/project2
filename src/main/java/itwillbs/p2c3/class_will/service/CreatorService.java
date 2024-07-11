package itwillbs.p2c3.class_will.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

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

	// 클래스 수정
	public void createrClassModifyPro(Map<String, Object> map, List<CurriVO> params) {
		creatorMapper.createrClassUpdate(map);
//		System.out.println(">>>>>>>>params: " + params);
		int class_code = Integer.parseInt((String)map.get("class_code"));
		creatorMapper.creatorCurriDelete(class_code);
		creatorMapper.creatorCurriUpdate(params, class_code);
	}
	
	// 클래스 상세
	public Map<String, Object> getClassDetail(int class_code) {
		return creatorMapper.getClassDetail(class_code);
	}
	
	// 클래스 일정 등록
	public int insertClassPlan(Map<String, Object> map, List<ClassTimeVO> classTime) {
		return creatorMapper.insertClassPlan(map, classTime);
	}
	
	// 커리큘럼 가져오기
	public List<Map<String, String>> getCurriList(int classCode) {
		return creatorMapper.getCurriList(classCode);
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
	
	// 클래스 이미지 파일 삭제
	public int removeClassFile(Map<String, Object> map) {
		return creatorMapper.removeClassFile(map);
	}

	//==================================================================================================
	// 전체 후기 정보 가져오기
	public List<Map<String, Object>> getReviewInfo(MemberVO member){
		return creatorMapper.getReviewInfo(member);
	}

	// 후기에 따른 클래스 정보 가져오기
	public List<Map<String, Object>> getClassByReview(MemberVO member){
		return creatorMapper.getClassByReview(member);
	}
	
	// 클래스에 따른 후기
	public List<Map<String, Object>> getReviewByClass(int classCode, int member_code){
		return creatorMapper.getReviewByClass(classCode, member_code);
	}

	// 타입에 따른 후기
	public List<Map<String, Object>> getReviewByType(int classCode, String type, int member_code){
		return creatorMapper.getReviewByType(classCode, type, member_code);
	}

	// 리뷰코드에 따른 리뷰
	public Map<String, Object> getReviewByReviewCode(int review_code){
		return creatorMapper.getReviewByReviewCode(review_code);
	}

	// 리뷰코드에 따른 답변
	public Map<String, Object> getReplyByReviewCode(int review_code){
		return creatorMapper.getReplyByReviewCode(review_code);
	}

	// 리뷰답변 저장 
	public void insertReviewReply(int reviewCode, String reviewReply, String reviewStatus) {
		if(reviewStatus.equals("N")) {
			creatorMapper.insertReviewReply(reviewCode, reviewReply);
			creatorMapper.changeReviewStatus(reviewCode);
		} else {
			creatorMapper.updateReviewReply(reviewCode, reviewReply);
		}
	}
	
	// 리뷰 답변 삭제
	public void deleteReviewReply(int reviewCode) {
		creatorMapper.deleteReviewReply(reviewCode);
		creatorMapper.changeReviewStatus(reviewCode);
	}
	//==================================================================================================
	
	// 문의사항 클래스정보 가져오기
	public List<Map<String, Object>> getInquiryClassInfo(MemberVO member){
		return creatorMapper.getInquiryClassInfo(member);
	}

	// 문의에 따른 클래스 정보 가져오기
	public List<Map<String, Object>> getClassByInquiry(MemberVO member){
		return creatorMapper.getClassByInquiry(member);
	}
	
	// 클래스에 따른 문의
	public List<Map<String, Object>> getInquiryByClass(int classCode, int member_code){
		return creatorMapper.getInquiryByClass(classCode, member_code);
	}

	// 타입에 따른 문의
	public List<Map<String, Object>> getInquiryByType(int classCode, String type, int member_code){
		return creatorMapper.getInquiryByType(classCode, type, member_code);
	}

	// 문의코드에 따른 리뷰
	public Map<String, Object> getInquiryByInquiryCode(int inquiryCode){
		return creatorMapper.getInquiryByInquiryCode(inquiryCode);
	}

	// 문의코드에 따른 답변
	public Map<String, Object> getReplyByInquiryCode(int inquiryCode){
		return creatorMapper.getReplyByInquiryCode(inquiryCode);
	}

	// 문의답변 저장 
	public void insertInquiryReply(int inquiryCode, String inquiryReply, String InquiryStatus) {
		if(InquiryStatus.equals("N")) {
			creatorMapper.insertInquiryReply(inquiryCode, inquiryReply);
			creatorMapper.changeInquiryStatus(inquiryCode);
		} else {
			creatorMapper.updateReviewReply(inquiryCode, inquiryReply);
		}
	}
	
	// 문의 답변 삭제
	public void deleteInquiryReply(int inquiryCode) {
		creatorMapper.deleteInquiryReply(inquiryCode);
		creatorMapper.changeInquiryStatus(inquiryCode);
	}
	
	//==================================================================================================

	// 분석페이지의 클래스 리스트
	public List<Map<String, Object>> getAnalyzeClassInfo(MemberVO member){
		return creatorMapper.getAnalyzeClassInfo(member);
	}

	// 분석결과 가져오기
	public Map<String, Object> getAnalyzeList(MemberVO member) {
		Map<String, Object> map = new HashedMap<String, Object>();
		Map<String, Object> analyzeList = creatorMapper.getAnalyzeList(member);
		Map<String, Object> analyzeReviewList = creatorMapper.getAnalyzeReviewList(member);
		map.put("analyzeList", analyzeList);
		map.put("analyzeReviewList", analyzeReviewList);
		
		return map;
	}
	
	// 전체 값에 대한 그래프 데이터
	public List<Map<String, Object>> getGraphDataList(MemberVO member){
		return creatorMapper.getGraphDataList(member);
	}
	
	// 클래스에 따른 차트 데이터
	public List<Map<String, Object>> getChartDataByClass(int classCode, MemberVO member) {
		return creatorMapper.getChartDataByClass(classCode, member);
	}

	//==================================================================================================

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
		if(settlementDate == null) {
			creatorMapper.insertSettlement(member, total_sum);
		} else {
			creatorMapper.updateSettlement(member, total_sum);
		}
	}

	public void depositSettlement(MemberVO member, int total_sum) {
		
	}	
	
	
	
	

}
