package itwillbs.p2c3.class_will.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import itwillbs.p2c3.class_will.mapper.AdminMapper;
import itwillbs.p2c3.class_will.mapper.MyPageMapper;
import itwillbs.p2c3.class_will.vo.MemberVO;

@Service
public class MyPageService {
	@Autowired
	private MyPageMapper myPageMapper;

	@Autowired
	private AdminMapper adminMapper;

	public Map<String, String> getMemberInfo(Map<String, Object> params) {
		return adminMapper.selectMemberInfo(params);
	}

	// 멤버이미지 수정
	public int updateMemberImg(MemberVO member) {

		return myPageMapper.updateMemberImg(member);
	}

	// 멤버가 작성한 리뷰들 가지고 오기 (리스트임)
	public List<Map<String, String>> getMemberReviews(int member_code, int startRow2, int listLimit2) {
		return myPageMapper.selectMemberReview(member_code, startRow2, listLimit2);
	}

	// 멤버가 작성한 특성리뷰 1개 가지고 오기
	public Map<String, String> getReviewByCode(String reviewCode) {

		return myPageMapper.selectReviewByCode(reviewCode);
	}

	// 리뷰 수정하는 거임.
	public int updateReview(Map<String, String> formData) {

		return myPageMapper.updateReview(formData);
	}

	// 리부 삭제하는 거임
	public int deleteReview(String class_review_code) {

		return myPageMapper.deleteReview(class_review_code);
	}

	public int updateMemberInfo(MemberVO member) {

		return myPageMapper.updateMember(member);
	}

	public boolean nicknameDuplicate(String member_nickname) {

		int count = myPageMapper.countNickname(member_nickname);
		return count > 0;

	}

	public void updateNomal(String member_code) {
		myPageMapper.updateMemberNormal(member_code);
	}

	public MemberVO selectMemberInfo(int member_code) {
		return myPageMapper.selectMember(member_code);

	}

	// 멤버가 관심있는 클래스
	public List<Map<String, String>> getMemberLike(int member_code, int startRow, int listLimit) {

		return myPageMapper.selectLike(member_code, startRow, listLimit);
	}

	// 리뷰를 작성할 수 있는 클래스(결제하고 수료일까지 지난 상태임)
	public List<Map<String, String>> getPossibleReview(int member_code, int startRow, int listLimit) {

		return myPageMapper.selectPossibleReview(member_code, startRow, listLimit);
	}

	// 리뷰 등록
	public int insertReview(Map<String, String> formData) {

		return myPageMapper.insertReview(formData);
	}

	public int withdrawMember(MemberVO member) {
		// TODO Auto-generated method stub
		return myPageMapper.MemberWithdraw(member);
	}

	public List<Map<String, String>> getMemberMaster(int member_code2) {

		return myPageMapper.selectMemberMaster(member_code2);
	}

	public int getMemberLike(int member_code) {
		return myPageMapper.countLikes(member_code);
	}

	public int getMemberPoss(int member_code) {
		// TODO Auto-generated method stub
		return myPageMapper.countPoss(member_code);
	}

	public int getMemberReviewCount(int member_code) {

		return myPageMapper.countReview(member_code);
	}

	public Map<String, String> getMemberDate(int member_code2) {

		return myPageMapper.calDate(member_code2);
	}

	public Map<String, String> getMemberMoney(int member_code2) {
		return myPageMapper.countMoney(member_code2);
	}

	public List<Map<String, String>> getPayData(String year, String month, String member_code) {

		return myPageMapper.findMoney(year, month, member_code);
	}

	public int getMemberInquiryCount(int member_code) {

		return myPageMapper.countInquiry(member_code);
	}

	public List<Map<String, String>> getMemberInquiry(int member_code, int startRow, int listLimit) {
		// TODO Auto-generated method stub
		return myPageMapper.selectMemberInquiry(member_code, startRow, listLimit);
	}

	public int deleteInquiry(String class_inquiry_code) {
		// TODO Auto-generated method stub
		return myPageMapper.deleteInquiry(class_inquiry_code);
	}

	public Map<String, String> getInquiryByCode(String class_inquiry_code) {
		// TODO Auto-generated method stub
		return myPageMapper.selectInquiry(class_inquiry_code);
	}

	public int updateInquiry(Map<String, String> formData) {
		// TODO Auto-generated method stub
		return myPageMapper.updateInquiry(formData);
	}

	@Transactional
	public void deleteMemberData(int member_code) {
		// 2건을 한큐에 처리
		myPageMapper.deleteMemberCode(member_code);
		myPageMapper.deleteMemberCode2(member_code);
	}

}
