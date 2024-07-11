package itwillbs.p2c3.class_will.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import itwillbs.p2c3.class_will.mapper.MainMapper;
import itwillbs.p2c3.class_will.vo.MemberVO;
import kotlin.collections.ArrayDeque;

@Service
public class MainService {
	
	@Autowired
	private MainMapper mainMapper;

	public Map<String, List<Map<String, Object>>> selectFieldCate() {
		
		Map<String, List<Map<String, Object>>> feildCateList = new HashMap<String, List<Map<String,Object>>>();
		List<Map<String, Object>> bigCategory = mainMapper.selectBigCategory();
		List<Map<String, Object>> smallCategory = mainMapper.selectSmallCategory();
		feildCateList.put("bigCategory", bigCategory);
		feildCateList.put("smallCategory", smallCategory);
		
		return feildCateList;
	}

	public List<Map<String, Object>> selectLocalCate() {
		
		return mainMapper.selectLocalCate();
	}
	
	
	@Transactional
	public List<Map<String, String>> retrieveKeyword(String keyword, String searchDateTime) {
		
		if(mainMapper.insertKeyword(keyword, searchDateTime)) {
			System.out.println("checkKeyword - insertKeyword 성공");
		}
		
		List<Map<String, String>> searchClassList = mainMapper.selectKeyword(keyword);
		
		return searchClassList;
	}
	
	
	
	
	@Transactional
	public void insertVisitIp(String ip, String visitDate) {
		
		Map<String, String> visit_logs = mainMapper.selectVisitIp(ip, visitDate);
		Map<String, Object> dbVisitDate = mainMapper.selectToday(visitDate);
		System.out.println(">>>>>>>>>>>>>>> visit_logs : " + visit_logs);
		System.out.println(">>>>>>>>>>>>>>> dbVisitDate : " + dbVisitDate);
		
		// visit_logs에 오늘 날짜와 방문한 IP가 일치하는 항목이 없다면 날짜와 IP 추가 
		if(visit_logs == null) {
			mainMapper.insertVisitIp(ip, visitDate);
			System.out.println(" [ " + visitDate + " ] 오늘의 방문자수 +1");
			
			// daily_visit 에 방문한 오늘 날짜(visitDate)가 없으면 오늘 날짜와 카운트 1 추가
			if(dbVisitDate == null) {
				mainMapper.insertDailyVisit(visitDate); 
				System.out.println("mainMapper.insertDailyVisit() 실행");
				
			} else if(dbVisitDate.get("visit_date").equals(visitDate)) { 
				// => daily_visit 에 방문한 오늘 날짜(visitDate)가 있으면 오늘 날짜에 카운트 +1 업데이트
				mainMapper.updateDailyVisit(dbVisitDate);
				System.out.println("mainMapper.updateDailyVisit() 실행");
			}
			
			
		} else {
		
			System.out.println("[ " + ip + " ] : [ " + visitDate + "] 기존 방문자");
		}
		
	}
	
	public List<Map<String, Object>> selectTop10() {
		return  mainMapper.selectTop10Class();
	}
	
	public List<Map<String, Object>> selectNewClass() {
		return mainMapper.selectNewClass();
	}

	public List<Map<String, Object>> selectLikeClass(MemberVO sMember) {
		return mainMapper.selectLikeClass(sMember);
	}

	public List<String> selectRecommend() {
		return mainMapper.selectRecommend();
	}

	
	
	
	
		

	
	
	
	
	
}
