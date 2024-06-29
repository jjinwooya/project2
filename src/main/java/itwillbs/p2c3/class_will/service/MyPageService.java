package itwillbs.p2c3.class_will.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

	//멤버이미지 수정
	public int updateMemberImg(MemberVO member) {
		
		return myPageMapper.updateMemberImg(member);
	}
	
	
	//멤버가 작성한 리뷰들 가지고 오기 (리스트임)
	public List<Map<String, String>> getMemberReviews(int member_code) {
		return  myPageMapper.selectMemberReview(member_code);
	}
	
	//멤버가 작성한 특성리뷰 1개 가지고 오기
	public Map<String, String> getReviewByCode(String reviewCode) {
		
		return myPageMapper.selectReviewByCode(reviewCode);
	}
	//리뷰 수정하는 거임.
	public int updateReview(Map<String, String> formData) {
		
		return myPageMapper.updateReview(formData);
	}
	//리부 삭제하는 거임
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

	

	
}
